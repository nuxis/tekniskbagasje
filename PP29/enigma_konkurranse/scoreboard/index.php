<?php
require_once '../../config.php';

$data = $sql->query("SELECT u.id,u.name,SUM(s.user_points) AS points FROM solves s JOIN users u ON u.id=s.user_id WHERE user_points > 0 GROUP BY user_id ORDER BY points DESC");
include_once 'top.php';
$i=0;
foreach($data as $row) {
    $i++;
    echo "<tr>";
    echo "<th scope='row' class='text-center'>".$i."</th>\n";
    echo "<td>" . $row['name']. "</td>\n";
    echo "<td>" . $row['points']. "</td>\n";
    echo "</tr>\n\n";
}

include_once 'bottom.php';
/* 
<tr>
						<th scope="row" class="text-center">1</th>
						<td>
							<a href="/users/8">
								lassenilssen

								
							</a>
						</td>
						<td>10</td>
					</tr>

*/
