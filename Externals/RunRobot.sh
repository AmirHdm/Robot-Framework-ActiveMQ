# shellcheck disable=SC2164
cd /d/RobotFramework/AdvancedRF/Pro1/TestSuites
robot --outputdir /d/RobotFramework/AdvancedRF/Pro1/Reports TestSuite.robot
echo "TestSuite Execution is done"
html_file="D:\RobotFramework\AdvancedRF\Pro1\Reports\report.html"
chrome "file:${html_file}"

