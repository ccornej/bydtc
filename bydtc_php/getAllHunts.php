<?php
 
$dbhostname = 'mysql1.cs.clemson.edu';
 
$dbusername = 'bydtc_bv08';
 
$dbpassword = 'asdf1234';
 
$conn = mysql_connect($dbhostname, $dbusername, $dbpassword);
 
if(!$conn)
{
 
  die('Could not connect: ' . mysql_error());
 
}
//echo ('connected');

//echo 'MySQL Connected successfully'."<BR>";
mysql_select_db("bydtc_0bhv") or die(mysql_error());

$result = mysql_query("SELECT * FROM Hunts");
 
if (!$result) {
    echo 'Could not run query: ' . mysql_error();
    exit;
}
$rows = array();
while($r = mysql_fetch_assoc($result)){
	$rows[] = $r;
}
print json_encode($rows);
mysql_close($conn);

