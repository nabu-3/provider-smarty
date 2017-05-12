{if isset($from)}
    {if is_array($from) && isset($field) && is_string($field) && array_key_exists($field, $from)}
        {assign var=value value=$from[$field]}
    {elseif is_string($from)}
        {assign var=value value=$from}
    {/if}
{/if}
<input type="hidden"{if isset($name)} name="{$name}"{/if}{if isset($value)} value="{$value|escape:html}"{/if}>
