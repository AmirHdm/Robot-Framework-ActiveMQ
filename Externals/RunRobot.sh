# shellcheck disable=SC2164
cd /d/RobotFramework/AdvancedRF/Pro1/TestSuites
robot --outputdir /d/RobotFramework/AdvancedRF/Pro1/Reports TestSuite.robot
echo "TestSuite Execution is done"
html_file="D:\RobotFramework\AdvancedRF\Pro1\Reports\report.html"
# shellcheck disable=SC2034
URL="http://admin:admin@127.0.0.1:8161/admin/queues.jsp"
# shellcheck disable=SC2092
# shellcheck disable=SC2006
`chrome  $URL`
`chrome --new-tab "file:${html_file}"`


# shellcheck disable=SC2092
# shellcheck disable=SC2006



