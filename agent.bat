@echo off
c:\Agent\config.cmd --unattended --url %devops_url% --auth pat --token %devops_token% --pool %devops_pool% --agent %devops_agentName% --acceptTeeEula ; \
c:\Agent\run.cmd ; \
