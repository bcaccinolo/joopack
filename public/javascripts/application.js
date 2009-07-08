// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function disable_end_date(obj, exp_id) {

  if(obj.checked == true) {
    $$('#exp_'+ exp_id +'.exp select#experience_end_month').first().disabled = "disabled";
    $$('#exp_'+ exp_id +'.exp select#experience_end_year').first().disabled = "disabled";
  } else {
    $$('#exp_'+ exp_id +'.exp select#experience_end_month').first().disabled = false;
    $$('#exp_'+ exp_id +'.exp select#experience_end_year').first().disabled = false;
  }
}


function disable_end_date_new_form(obj) {

  if(obj.checked == true) {
  	$$('#exp_list select#experience_end_month').first().disabled = "disabled";
	$$('#exp_list select#experience_end_year').first().disabled = "disabled"; 	
  } else {
  	$$('#exp_list select#experience_end_month').first().disabled = false;
	$$('#exp_list select#experience_end_year').first().disabled = false;
  }
}


function toggle_details(checkbox, block_id) {
  if(checkbox.checked) {
    $(block_id).show();
  } else {
    $(block_id).hide();
  }
}

