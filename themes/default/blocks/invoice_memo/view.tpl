{ $block->display("core:top_clean") }

{ $method->exe("invoice_memo","view") } { if ($method->result == FALSE) } { $block->display("core:method_error") } {else}

{literal}
	<script src="themes/{/literal}{$THEME_NAME}{literal}/view.js"></script>
    <script language="JavaScript"> 
        var module 		= 'invoice_memo';
    	var locations 	= '{/literal}{$VAR.module_id}{literal}';		
		var id 			= '{/literal}{$VAR.id}{literal}';
		var ids 		= '{/literal}{$VAR.ids}{literal}';    	 
		var array_id    = id.split(",");
		var array_ids   = ids.split(",");		
		var num=0;
		if(array_id.length > 2) {				 
			document.location = '?_page='+module+':view&id='+array_id[0]+'&ids='+id;				 		
		}else if (array_ids.length > 2) {
			document.write(view_nav_top(array_ids,id,ids));
		}
		
    	// Mass update, view, and delete controller
    	function delete_record(id,ids)
    	{				
    		temp = window.confirm("{/literal}{translate}alert_delete{/translate}{literal}");
    		if(temp == false) return;
    		
    		var replace_id = id + ",";
    		ids = ids.replace(replace_id, '');		
    		if(ids == '') {
    			var url = '?_page=core:search&module=' + module + '&do[]=' + module + ':delete&delete_id=' + id + COOKIE_URL;
    			window.location = url;
    			return;
    		} else {
    			var page = 'view&id=' +ids;
    		}		
    		
    		var doit = 'delete';
    		var url = '?_page='+ module +':'+ page +'&do[]=' + module + ':' + doit + '&delete_id=' + id + COOKIE_URL;
    		window.location = url;	
    	}
    //  END -->
    </script>
{/literal}

<!-- Loop through each record -->
{foreach from=$invoice_memo item=invoice_memo} <a name="{$invoice_memo.id}"></a>

<!-- Display the field validation -->
{if $form_validation}
   { $block->display("core:alert_fields") }
{/if}

<!-- Display each record -->
<form name="invoice_memo_view" method="post" action="">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_background" align="center">
    <tr>
    <td>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr valign="top">
          <td width="65%" class="table_heading">
            <center>
              {translate module=invoice_memo}title_view{/translate}
            </center>
          </td>
        </tr>
        <tr valign="top">
          <td width="65%" class="row1">
              <table width="100%" border="0" cellspacing="3" cellpadding="1" class="row1">
                <tr valign="top"> 
                  <td width="35%"> 
                    {translate module=invoice_memo}
                    field_date_orig 
                    {/translate}
                  </td>
                  <td width="65%"> 
                    {$list->date_time($invoice_memo.date_orig)}
                  </td>
                </tr>
                <tr valign="top"> 
                  <td width="35%"> 
                    {translate module=invoice_memo}
                    field_account_id 
                    {/translate}
                  </td>
                  <td width="65%"> 
                    {if $invoice_memo.account_id == '0'}
                    {translate module=invoice_memo}
                    system 
                    {/translate}
                    {else}
                    {html_select_account name="invoice_memo_account_id" default=$invoice_memo.account_id}
                    {/if}
                  </td>
                </tr>
                <tr valign="top"> 
                  <td width="35%"> 
                    {translate module=invoice_memo}
                    field_type 
                    {/translate}
                  </td>
                  <td width="65%">  
				  	{translate module=invoice_memo}{$invoice_memo.type}{/translate}
                  </td>
                </tr>
                <tr valign="top"> 
                  <td width="35%"> 
                    {translate module=invoice_memo}
                    field_memo 
                    {/translate}
                  </td>
                  <td width="65%"> 
                    {$invoice_memo.memo|nl2br}
                  </td>
                </tr>
                <tr class="row1" valign="middle" align="left"> 
                  <td width="35%"></td>
                  <td width="65%"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td>&nbsp; </td>
                        <td align="right"> 
                          <input type="button" name="delete" value="{translate}delete{/translate}" class="form_button" onClick="delete_record('{$invoice_memo.id}','{$VAR.id}');">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
    
  <center>
    <input type="hidden" name="_page" value="invoice_memo:view">
    <input type="hidden" name="invoice_memo_id" value="{$invoice_memo.id}">
    <input type="hidden" name="do[]" value="invoice_memo:update">
    <input type="hidden" name="id" value="{$VAR.id}">
  </center>
</form>
  
{/foreach}
<center>
  <a href="?_page=invoice_memo:add&invoice_memo_invoice_id={$invoice_memo.invoice_id}&_escape=1&_escape_next=1"> 
  {translate module=invoice_memo}
  title_add 
  {/translate}
  </a> 
  {/if}
</center>
