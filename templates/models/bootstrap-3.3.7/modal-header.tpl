<div class="modal-header" {include file="general-attrs.tpl"} {include file="aria-attrs.tpl"}>
    {if isset($dismiss) && $dismiss===true}<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>{/if}
    <h4 class="modal-title" {if isset($aria_label_id)} id="{$aria_label_id}"{/if}>
