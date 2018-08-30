# README
#
# Use this script to run automate your quarterly file download from zipcodedownload.com
# You can use Task Scheduler tool (built into Microsoft Windows) to run this script after 5th business working day (by 7th of the month) to get the updated quarterly file
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
$purchaseDate = "01/15/2018"

$pDt = [DateTime]$purchaseDate #set the subscription's purchase/renewal date, here
$output = "$($ENV:UserProfile)\Downloads\MonthlyDownload.zip" #set your output file name with full path in quotes, here
$start_time = Get-Date

if( ([math]::Abs(($pDt.Month - $start_time.Month) + (12 * ($pDt.Year - $start_time.Year)))) %3 -ne 0)
{ 
    "data update not available in this month for your subscription"
    exit 
}

$updateFor = "$((Get-Culture).DateTimeFormat.GetAbbreviatedMonthName((Get-Date).Month).ToLower())$((Get-Date).Year)"

$fileName = "$($updateFor)_$($product)_$($format).zip"

$url = "https://zipcodedownload.com/Account/Download/?file=$($fileName)&username=$($userName)&password=$($password)"

Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
