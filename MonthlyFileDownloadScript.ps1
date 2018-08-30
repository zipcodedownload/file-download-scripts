# README
#
# Use this script to run automate your monthly file download from zipcodedownload.com
# You can use Task Scheduler tool (built into Microsoft Windows) to run this script after 5th business working day (by 7th of every month) to get the updated monthly file
# Refer the url https://zipcodedownload.com/FTPLink to get more details on automating the file download
# For any queries feel free to reach us at support@zipcodedownload.com
#
# NOTE: Make sure you're using the latest version of Windows PowerShell to run this script
# NOTE: The supported "$format" in which you can download your data varies with products. Please refer your product page's "Sample Data" section to know the supported format for your subscription.
#


$product = "z5c6combined" #your product name in quotes, here
$format = "csv" #your desired format in quotes, here
$userName = "UserName@mail.com" #set your username in quotes, here
$password = "password" #set your password in quotes, here

$updateFor = "$((Get-Culture).DateTimeFormat.GetAbbreviatedMonthName((Get-Date).Month).ToLower())$((Get-Date).Year)"

$fileName = "$($updateFor)_$($product)_$($format).zip"

$url = "https://zipcodedownload.com/Account/Download/?file=$($fileName)&username=$($userName)&password=$($password)"

$output = "$($ENV:UserProfile)\Downloads\MonthlyDownload.zip" #set your output file name with full path in quotes, here
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
