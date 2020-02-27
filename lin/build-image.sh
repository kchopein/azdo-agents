docker build -t alexdegrootnl/azdo-agent-lin:latest -t alexdegrootnl/azdo-agent-lin:202002192050 .



docker run -e AZP_URL=https://dev.azure.com/raet/ -e AZP_TOKEN="jbzzbktrawy75fge34xeitbfbum6v3n7by5xuliapcde4swecnpq" -e AZP_POOL="TeamManaged - Expense Management" -e AZP_AGENT_NAME=testagent dockeragent:latest