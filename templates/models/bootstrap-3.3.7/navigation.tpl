{if isset($sitemap) && count($sitemap)>0}
    <ul class="nav{if !isset($type) || $type===navbar} navbar-nav{elseif $type===pill} nav-pills{elseif $type===tab} nav-tabs{/if}{if isset($position) && $position===stacked} nav-stacked{/if}{if isset($justified) && $justified} nav-justified{/if}{if isset($class) && is_string($class) && strlen($class)>0} {$class}{/if}">
        {foreach from=$sitemap item=node}
            {assign var=class value=''}
            {if $node.breadcrumb}{assign var=class value=active}{/if}
            {if strlen($node.css_class) > 0}{assign var=class value="{$class} {$node.css_class}"}{/if}
            <li{if strlen($class)>0} class="{$class|trim}"{/if}><a href="{if array_key_exists('final_url', $node.translation)}{$node.translation.final_url}{else}#{/if}"{if is_string($node.translation.title)} title="{$node.translation.title}"{/if}>{if is_string($node.icon) && strlen($node.icon)>0}<i class="{$node.icon}"></i>{/if}{if is_string($node.translation.content) && strlen($node.translation.content)>0}{$node.translation.content}{/if}</a></li>
        {/foreach}
    </ul>
{/if}
