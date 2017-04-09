{strip}
    {if isset($class)}
        {assign var=class value="modal-footer {$class}"}
    {else}
        {assign var=class value="modal-footer"}
    {/if}
    <div
        {include file="general-attrs.tpl"}
        {include file="aria-attrs.tpl"}
    >
{/strip}
