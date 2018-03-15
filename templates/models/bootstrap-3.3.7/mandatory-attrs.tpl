{strip}
    {if isset($mandatory) && $mandatory===true} data-form-mandatory="true"{/if}
    {if isset($rule) && in_array($rule, array('filled', 'regex', 'uri', 'same', 'checked', 'unchecked'))} data-form-rule="{$rule}"{/if}
    {if isset($rule) && $rule==='regex' && isset($rule_param) && strlen($rule_param)>0} data-form-rule-param="{$rule_param}"{/if}
{/strip}
