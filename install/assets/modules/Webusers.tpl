/**
 * Webusers
 *
 * 
 *
 * @category	module
 * @internal	@modx_category admin
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 */
if(!defined('MODX_BASE_PATH')){die('What are you doing? Get out of here!');}
global $manager_theme;
$webuserstable = $modx->getFullTableName('web_users');
$webuserattribstable = $modx->getFullTableName('web_user_attributes');

$result = $modx->db->query( 'SELECT '.$webuserattribstable.'.id, '.$webuserstable.'.id, '.$webuserattribstable.'.fullname, '.$webuserattribstable.'.email, '.$webuserattribstable.'.photo, '.$webuserattribstable.'.mobilephone, '.$webuserattribstable.'.phone,  '.$webuserattribstable.'.gender, '.$webuserattribstable.'.country, '.$webuserattribstable.'.street, '.$webuserattribstable.'.city, '.$webuserattribstable.'.state, '.$webuserattribstable.'.zip, '.$webuserattribstable.'.blocked, '.$webuserstable.'.username FROM '.$webuserattribstable.' 
    INNER JOIN '.$webuserstable.'
    ON '.$webuserattribstable.'.id='.$webuserstable.'.id
    ORDER BY '.$webuserattribstable.'.id DESC ' );

while( $row = $modx->db->getRow( $result ) ) {   
	if ($row['blocked'] == 0) {
	$isblocked = 'no';
	}
	else {
	$isblocked = 'yes';
	}
   $WebUser .= '<tr><td width="5%"><span class="label label-info">' . $row['id'] . '</span> </td>
   <td><a href="index.php?a=88&id=' . $row['id'] . ' "><b>' . $row['username']. '</b></a></td>  
   <td>' . $row['fullname']. '</td>
<td>' . $row['email'] . '  </td>
<td>' . $isblocked . '  </td>
<td class="text-right" style="text-align: right;">
<a class="btn btn-success btn-xs btn-action" href="index.php?a=88&id=' . $row['id'] . ' "><i class="fa fa-pencil-square-o"></i></a>
<a class="btn btn-danger btn-xs btn-action" href="index.php?a=90&id=' . $row['id'] . ' "><i class="fa fa-trash"></i></a>   
</td>
</tr>';
	
}
$ModuleOutput = '
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="media/script/jquery/jquery.min.js"></script>
<script src="media/script/bootstrap/js/bootstrap.min.js"></script>
<script src="media/script/bootgrid/jquery.bootgrid.min.js"></script>
<script src="media/script/bootgrid/jquery.bootgrid.fa.min.js"></script>
<link rel="stylesheet" type="text/css" href="media/style/common/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="media/style/common/font-awesome/css/font-awesome.min.css" />
<link rel="stylesheet" href="media/script/bootgrid/jquery.bootgrid.min.css" />
<link rel="stylesheet" href="media/style/'.$manager_theme.'/style.css" />
<script>
jQuery(document).ready(function ($) {
  $("#users-grid").bootgrid({
    selection: true,
    multiSelect: true,
    rowSelect: true,
    keepSelection: true,
    formatters: {
        "link": function(column, row)
        {
            return "<a href=\"index.php?a=88&id=" + row.id + "\">" + row.name + "</a>";
        },
		 "commands": function(column, row)
        {
            return "<a class=\"btn btn-sm btn-default command-edit\" data-row-id=\"" + row.id + "\" href=\"index.php?a=88&id=" + row.id + "\"><span class=\"fa fa-pencil\"></span></a> " + 
                "<a class=\"btn btn-sm btn-default command-delete\" data-row-id=\"" + row.id + "\" href=\"index.php?a=90&id=" + row.id +  "\"><span class=\"fa fa-trash-o\"></span></a> ";
        }
    },
	    url: "/api/data/basic",
    selection: true,
    multiSelect: true,
    formatters: {
        "link": function(column, row)
        {
            return "<a href=\"#\">" + column.id + ": " + row.id + "</a>";
        }
    }
}).on("selected.rs.jquery.bootgrid", function(e, rows)
{
    var rowIds = [];
    for (var i = 0; i < rows.length; i++)
    {
        rowIds.push(rows[i].id);
    }
    alert("Select: " + rowIds.join(","))
.end().find("#remove").on("click", function(e)
    {
    var rowIds = [];
    for (var i = 0; i < rows.length; i++)
    {
        rowIds.push(rows[i].id);
		$("#users-grid").bootgrid("remove", rowIds);
    }
        
    });
	
    });
	
});

</script>

</head>
<body>
<style>
#users-grid-header li {list-style-type: none; list-style-image:none;}
#popupModal2 {z-index:3000}
 .modal .modal-dialog { width: 80%; height: 80%;}
 .modal .modal-body p { margin-bottom: 50px }
html, body {
    height: 100%;
    margin: 0;         /* Reset default margin on the body element */
}
iframe {
    display: block;       /* iframes are inline by default */
    background: #000;
    border: none;         /* Reset default border */
    width: 100%;
    height: 900px;
}
</style>
                    <div class="container-fluid">
					<h1 class="pagetitle">
  <span class="pagetitle-icon">
    <i class="fa fa-users"></i>
  </span>
  <span class="pagetitle-text">
    Webusers Manager
  </span>
</h1>
<div class="section">
<div class="sectionBody">
	<div class="actionButtons">
		<li><a href="index.php?a=87">New Web User</a></li>
		
		<a class="ext-ico" href="#" title="Edit in new window" onclick="window.open(\'index.php?a=87\',\'gener\',\'width=800,height=600,top=\'+((screen.height-600)/2)+\',left=\'+((screen.width-800)/2)+\',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no\')"> <small><i class="fa fa-user-plus" aria-hidden="true"></i></small></a>
		<li><a id="remove" href="#">Delete selected</a></li>
		<li><a href="javascript:location.reload();" title="Reload list"><i class="fa fa-refresh"></i></a></li>
		

</div>
	<table id="users-grid" class="table table-hover table-bordered table-striped table-webusers">
		<thead><tr>
			<th data-identifier="true" data-column-id="id" data-type="numeric">ID</th>
            <th data-formatter="link" data-column-id="name" data-visibleInSelection="false">name</th>
            <th data-column-id="fullname" data-order="desc">fullname</th>
			<th data-column-id="email">email</th>
			<th data-column-id="blocked">blocked</th>
			<th data-column-id="commands" data-formatter="commands" data-sortable="false">action</th> 
		</tr></thead>
			<tbody>'.$WebUser.'</tbody></table>

					 
					  </div>
					   </div>
					   <script>
			
$(".bootpopup").click(function(){
    var frametarget = $(this).attr("href");
  var targetmodal = $(this).attr("target");
  if (targetmodal == undefined) {
    targetmodal = "#popupModal";
  } else { 
    targetmodal = "#"+targetmodal;
  }
  if ($(this).attr("title") != undefined) {
    $(targetmodal+ " .modal-header h3").html($(this).attr("title"));
    $(targetmodal+" .modal-header").show();
  } else {
     $(targetmodal+" .modal-header h3").html("");
    $(targetmodal+" .modal-header").hide();
  }  
    $(targetmodal).on("show", function () {
        $("iframe").attr("src", frametarget );   
	});
    $(targetmodal).modal({show:true});
  return false;
    
});
</script>
</body>
</html>';

//end module
$output = $ModuleOutput;
return $output;
