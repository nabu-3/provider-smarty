{assign var=final_class value="btn btn-default"}
{if (isset($class) && strlen($class)>0) || (isset($type) && strlen($type) > 0) || (isset($size) && strlen($size) > 0)}
    {if isset($class) && strlen($class)>0}
        {assign var=final_class value=$class}
    {elseif isset($type) && strlen($type)>0}
        {assign var=final_class value="btn btn-{$type}"}
    {/if}
    {if !isset($class) && isset($size) && strlen($size)>0}
        {assign var=final_class value="{$final_class} btn-{$size}"}
    {/if}
{/if}
<button type="button" class="{$final_class}" data-toggle="modal" data-target="{if isset($target)}#{$target}{else}#modal_dialog{/if}"{if isset($action) && strlen($action)>0} data-action="{$action}"{/if}{if isset($apply) && strlen($apply)>0} data-apply="{$apply}"{/if}>{$anchor_text}</button>
