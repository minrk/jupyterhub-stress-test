import os
import sys

c.JupyterHub.authenticator_class = "dummy"
c.JupyterHub.spawner_class = "simple"

c.Spawner.cmd = [sys.executable, "-m", "jupyterhub.tests.mocksu"]

c.JupyterHub.services = [
	{
		"name": "stress-test",
		"admin": True,
		"api_token": os.environ["JUPYTERHUB_API_TOKEN"],
	},
]

# use postgres
c.JupyterHub.db_url = "postgresql://jupyterhub:x@127.0.0.1/"
