{if isset($horizontal)}
    {assign var=variant value=horizontal}
    {assign var=rel value="/:/"|preg_split:$horizontal}
{elseif isset($inline)}
    {assign var=variant value=inline}
    {assign var=rel value=false}
{elseif isset($form_variant)}
    {assign var=variant value=$form_variant}
    {assign var=rel value=$form_rel}
{else}
    {assign var=variant value=vertical}
    {assign var=rel value=false}
{/if}
{if isset($label)}
    {if !isset($sr_only) || $variant!==vertical}{assign var=sr_only value=false}{/if}
{else}
    {assign var=label value=false}
    {assign var=sr_only value=false}
{/if}
{if !isset($field)}{assign var=field value=false}{/if}
{if !isset($name)}{assign var=name value=$field}{/if}
{assign var=label_class value=''}
{assign var=div_class value=''}
{if $variant===horizontal}
    {if count($rel)===2}
        {assign var=label_class value="col-sm-{$rel.0} control-label"}
        {assign var=div_class value="col-sm-{$rel.1}"}
    {elseif count($rel)===1}
        {assign var=label_class value="col-sm-{$rel.0} control-label"}
        {assign var=div_class value="col-sm-{12-$rel.1}"}
    {else}
        {assign var=label_class value="col-sm-4 control-label"}
        {assign var=div_class value="col-sm-8"}
    {/if}
{else}
    {if $sr_only}{assign var=label_class value="{$label_class} sr-only"}{/if}
{/if}
{assign var=value value=false}
{if isset($from) && $from!==null}
    {if is_array($from) && is_string($field) && array_key_exists($field, $from)}
        {assign var=value value=$from[$field]}
    {elseif is_string($from)}
        {assign var=value value=$from}
    {/if}
{/if}
<div class="form-group{if isset($class)} {$class}{/if}">
    {if is_string($label)}<label{if isset($id)} for="{$id}"{/if}{if strlen($label_class)>0} class="{$label_class|trim}"{/if}>{$label}</label>{/if}
    {if $variant===horizontal}<div{if strlen($div_class)>0} class="{$div_class}"{/if}>{/if}
        {if isset($multilang) && is_array($multilang)}
            {foreach from=$multilang key=index item=translation}
                {assign var=value value=false}
                {if isset($from) && $from!==null}
                    {if is_array($from)}
                        {if is_string($field)}
                            {if array_key_exists('translations', $from) &&
                                is_array($from.translations) &&
                                array_key_exists($translation.id, $from.translations) &&
                                array_key_exists($field, $from.translations[$translation.id])}
                                {assign var=value value=$from.translations[$translation.id][$field]}
                            {/if}
                        {/if}
                    {/if}
                {/if}
                <div class="input-group" lang="{$translation.default_country_code}">
                    <p class="form-control-static">{$value}</p>
                    <span class="input-group-addon">{if array_key_exists('flag_url', $translation) && strlen($translation.flag_url)>0}<img class="flag" src="{$translation.flag_url}" alt="{$translation.default_country_code}" title="{$translation.name}">{else}<i class="fa fa-flag"></i>{$translation.default_country_code}{/if}</span>
                </div>
            {/foreach}
        {else}
            <p class="form-control-static">{$value}</p>
        {/if}
    {if $variant===horizontal}</div>{/if}
</div>
