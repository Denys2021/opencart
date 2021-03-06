<?php 
	echo '<div class="home-boxed-newsletter row">';	
		echo '<div class="col-md-5 col-sm-12">';
			echo '<div class="title">'.$module['content']['title'].'</div>';
			echo '<div class="description">'.$module['content']['text'].'</div>';
		echo '</div>';
		
		echo '<div class="col-md-7 col-sm-12">';
			echo '<div class="clearfix newsletter-content" style="clear: both" id="newsletter' . $id .'">';
		          echo '<input type="text" class="email" placeholder="' . $module['content']['input_placeholder'] . '" />';
		          echo '<a class="subscribe">' . $module['content']['subscribe_text'] . '</a>';
		     echo '</div>';
	     echo '</div>';
     echo '</div>'; ?>

<script type="text/javascript">
$(document).ready(function() {
	function Unsubscribe() {
		$.post('<?php echo $module['content']['unsubscribe_url']; ?>', 
			{ 
				email: $('#newsletter<?php echo $id; ?> .email').val() 
			}, function (e) {
				$('#newsletter<?php echo $id; ?> .email').val('');
				alert(e.message);
			}
		, 'json');
	}
	
	function Subscribe() {
		$.post('<?php echo $module['content']['subscribe_url']; ?>', 
			{ 
				email: $('#newsletter<?php echo $id; ?> .email').val() 
			}, function (e) {
				if(e.error === 1) {
					var r = confirm(e.message);
					if (r == true) {
					    $.post('<?php echo $module['content']['unsubscribe_url']; ?>', { 
					    	email: $('#newsletter<?php echo $id; ?> .email').val() 
					    }, function (e) {
					    	$('#newsletter<?php echo $id; ?> .email').val('');
					    	alert(e.message);
					    }, 'json');
					}
				} else {
					$('#newsletter<?php echo $id; ?> .email').val('');
					alert(e.message);
				}
			}
		, 'json');
	}
	
	$('#newsletter<?php echo $id; ?> .subscribe').click(Subscribe);
	$('#newsletter<?php echo $id; ?> .unsubscribe').click(Unsubscribe);
	$('#newsletter<?php echo $id; ?> .email').keypress(function (e) {
	    if (e.which == 13) {
	        Subscribe();
	    }
	});
});
</script>