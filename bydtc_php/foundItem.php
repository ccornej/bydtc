<?php
 
$dbhostname = 'mysql1.cs.clemson.edu';
 
$dbusername = 'bydtc_bv08';
 
$dbpassword = 'asdf1234';
 
$conn = mysql_connect($dbhostname, $dbusername, $dbpassword);
 
if(!$conn)
{
 
  die('Could not connect: ' . mysql_error());
 
}
echo ('connected');

if (isset ($_GET["attendeeId"], $_GET["huntId"]))
{
		$attendeeId = intval($_GET["attendeeId"]);
		$huntId = intval($_GET["huntId"]);
}
$errorCount = 0;
if(empty($attendeeId))
{
    echo('Attendee ID empty');
    $errorCount++;
}
if(empty($huntId))
{
	echo('Hunt ID empty');
	$errorCount++;
}
if($errorCount == 0)
{
echo ('no errors');
//echo 'MySQL Connected successfully'."<BR>";
mysql_select_db("bydtc_0bhv") or die(mysql_error());

$result = mysql_query("INSERT INTO AttendeeHunts (attendId, huntId)
 VALUES('$attendeeId', '$huntId')");
 
if (!$result) {
    echo 'Could not run query: ' . mysql_error();
    exit;
}
mysql_close($conn);
}
else
{
mysql_close($conn);

}
