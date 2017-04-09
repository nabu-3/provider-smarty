{strip}
    <button type="{if isset($type)}{$type}{else}button{/if}"
            {include file="general-attrs.tpl"}
            {include file="aria-attrs.tpl"}
            {if isset($command)} name="{$command}"{/if}
            {if isset($formfollow) && ($formfollow==='visible' || $formfollow==='active')} data-form-follow="{$formfollow}"{/if}
    >
        {if isset($anchor_img)}<img src="{$anchor_img}"{if isset($anchor_img_title)} title="{$anchor_img_title|escape:html}"{/if}{if isset($anchor_img_alt)} alt="{$anchor_img_alt|escape:html}"{/if}>{/if}
        {if isset($anchor_icon)}<i class="{$anchor_icon}"></i>{/if}
        {if isset($anchor_text)}{$anchor_text}{/if}
    </button>
{/strip}
