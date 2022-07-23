from .helpers import version_to_string
from .node_runtime import NodeRuntime
from .server_resource_interface import ServerResourceInterface
from .server_resource_interface import ServerStatus
from hashlib import md5
from LSP.plugin.core.typing import Dict, Optional
from os import makedirs
from os import path
from os import remove
from sublime_lib import ResourcePath
import shutil

__all__ = ['ServerNpmResource']


class ServerNpmResource(ServerResourceInterface):
    """
    An implementation of :class:`lsp_utils.ServerResourceInterface` implementing server management for
    node-based severs. Handles installation and updates of the server in package storage.
    """

    @classmethod
    def create(cls, options: Dict) -> 'ServerNpmResource':
        package_name = options['package_name']
        server_directory = options['server_directory']
        server_binary_path = options['server_binary_path']
        package_storage = options['package_storage']
        storage_path = options['storage_path']
        minimum_node_version = options['minimum_node_version']
        skip_npm_install = options['skip_npm_install']
        node_runtime = NodeRuntime.get(package_name, storage_path, minimum_node_version)
        if not node_runtime:
            raise Exception('Failed resolving the Node Runtime. Please see Sublime Text console for more information')
        return ServerNpmResource(
            package_name, server_directory, server_binary_path, package_storage, node_runtime, skip_npm_install)

    def __init__(self, package_name: str, server_directory: str, server_binary_path: str,
                 package_storage: str, node_runtime: NodeRuntime, skip_npm_install: bool) -> None:
        if not package_name or not server_directory or not server_binary_path or not node_runtime:
            raise Exception('ServerNpmResource could not initialize due to wrong input')
        self._status = ServerStatus.UNINITIALIZED
        self._package_name = package_name
        self._server_src = 'Packages/{}/{}/'.format(self._package_name, server_directory)
        node_version = version_to_string(node_runtime.resolve_version())
        self._server_dest = path.join(package_storage, node_version, server_directory)
        self._binary_path = path.join(package_storage, node_version, server_binary_path)
        self._installation_marker_file = path.join(package_storage, node_version, '.installing')
        self._node_runtime = node_runtime
        self._skip_npm_install = skip_npm_install

    @property
    def server_directory_path(self) -> str:
        return self._server_dest

    @property
    def node_bin(self) -> str:
        node_bin = self._node_runtime.node_bin()
        if node_bin is None:
            raise Exception('Failed to resolve path to the Node.js runtime')
        return node_bin

    @property
    def node_env(self) -> Optional[Dict[str, str]]:
        return self._node_runtime.node_env()

    # --- ServerResourceInterface -------------------------------------------------------------------------------------

    @property
    def binary_path(self) -> str:
        return self._binary_path

    def get_status(self) -> int:
        return self._status

    def needs_installation(self) -> bool:
        installed = False
        if self._skip_npm_install or path.isdir(path.join(self._server_dest, 'node_modules')):
            # Server already installed. Check if version has changed or last installation did not complete.
            src_package_json = ResourcePath(self._server_src, 'package.json')
            if not src_package_json.exists():
                raise Exception('Missing required "package.json" in {}'.format(self._server_src))
            src_hash = md5(src_package_json.read_bytes()).hexdigest()
            try:
                with open(path.join(self._server_dest, 'package.json'), 'rb') as file:
                    dst_hash = md5(file.read()).hexdigest()
                if src_hash == dst_hash and not path.isfile(self._installation_marker_file):
                    installed = True
            except FileNotFoundError:
                # Needs to be re-installed.
                pass
        if installed:
            self._status = ServerStatus.READY
            return False
        return True

    def install_or_update(self) -> None:
        try:
            makedirs(path.dirname(self._installation_marker_file), exist_ok=True)
            open(self._installation_marker_file, 'a').close()
            if path.isdir(self._server_dest):
                shutil.rmtree(self._server_dest)
            ResourcePath(self._server_src).copytree(self._server_dest, exist_ok=True)
            if not self._skip_npm_install:
                dependencies_installed = path.isdir(path.join(self._server_dest, 'node_modules'))
                if not dependencies_installed:
                    self._node_runtime.npm_install(self._server_dest)
            remove(self._installation_marker_file)
        except Exception as error:
            self._status = ServerStatus.ERROR
            raise Exception('Error installing the server:\n{}'.format(error))
        self._status = ServerStatus.READY
