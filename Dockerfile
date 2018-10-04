#FROM microsoft/dotnet-buildtools-prereqs:image-builder-nanoserver-20180906092312
FROM microsoft/dotnet-framework:4.7.1

ENV devops_url https://dev.azure.com/{your_organization}/_admin/_AgentPool
ENV devops_token myToken
ENV devops_pool default
ENV devops_agentName myAgent

#ADD "https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=15#" "/vsc.exe"
#RUN "/vsc.exe install --all -q"
ADD "https://vstsagentpackage.azureedge.net/agent/2.140.0/vsts-agent-win-x64-2.140.0.zip" "/vsts-agent.zip"
ADD "https://aka.ms/vs/15/release/vs_buildtools.exe" "C:\TEMP\vs_buildtools.exe"
ADD "https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe" "c:\TEMP\docker.exe"
ADD "agent.bat" "/agent/agent.bat"

RUN powershell -Command Get-Module Expand-Archive ; \
powershell -Command Expand-Archive -Path C:\vsts-agent.zip c:\Agent ; \
del C:\vsts-agent.zip ; \
C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath C:\BuildTools --all --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 --remove Microsoft.VisualStudio.Component.Windows81SDK || IF "%ERRORLEVEL%"=="3010" EXIT 0 ; \
c:\TEMP\docker.exe install --quiet
ENTRYPOINT "c:\agent\agent.bat"
