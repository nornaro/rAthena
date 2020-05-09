$i = 0
$itemID1 =@()
$itemDef1 =@()
Get-Content item_db.sql | findstr REPLACE | ForEach-Object {
	$item = $_.Split(",|(")
	if ($item[4] -eq "4") {	
		while ($item[1] -ne $i){
			$itemID1+=0
			$itemDef1+= 0
			$i++
		}
		$itemID1+=$item[1]
		$itemDef1+= $item[9]
	}
}
$out = ""
Get-Content item_db_re.sql | findstr REPLACE | ForEach-Object { 
	$item = $_.Split(",|(")
	if ($item[4] -eq "4") {
		if ($itemID1[$item[1]] -ne "0") {
			$item[9] = $itemDef1[$item[1]]
		} else{
			if ($item[9] -ne "NULL") {
				$item[9] = [int]([int]$item[9]/7)
			}
		}
		$out += $item[0]+"("
		for($j=1; $j -lt $item.Count-1; $j++){
			$out += $item[$j]+","
		}
		$out += $item[$item.Count-1]+"		
"
	}
}
$out | Out-File -FilePath .\item_db_cust.sql
