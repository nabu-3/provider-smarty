{assign var=aria_hidden value="true"}
{strip}<div class="modal fade" tabindex="-1" role="dialog"
    {if isset($backdrop) && is_string($backdrop) && strlen($backdrop)>0} data-backdrop="{$backdrop|escape:"html"}"{/if}
    {include file="general-attrs.tpl"}
    {include file="aria-attrs.tpl"}
>{/strip}
    <div class="modal-dialog{if isset($size) && strlen($size)>0} modal-{$size}{/if}" role="document">
        <div{if isset($content_id) && is_string($content_id) && strlen($content_id)>0} id="{$content_id}"{/if} class="modal-content">
