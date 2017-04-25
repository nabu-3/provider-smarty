{if isset($collapsable) && is_string($collapsable) && strlen($collapsable)>0}
    {assign var=nav_collapsable value=$collapsable scope=parent}
{else}
    {assign var=nav_collapsable value=false scope=parent}
{/if}
<nav class="navbar{if isset($inverse) && $inverse} navbar-inverse{/if}{if isset($fixed)} navbar-fixed-{$fixed}{/if}{if isset($default)} navbar-default{/if}">
    <div class="{if isset($container) && $container==='fluid'}container-fluid{else}container{/if}">
        {if isset($header) && $header}
            <div class="navbar-header">
                {if $nav_collapsable}
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#{$collapsable}" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                {/if}
                {if isset($brand) && is_array($brand)}
                    {strip}
                        {if !isset($brand_name)}
                            {assign var=brand_name value=false}
                            {if isset($brand.translation)}
                                {if isset($brand.translation.content) && strlen($brand.translation.content)>0}
                                    {assign var=brand_name value=$brand.translation.content}
                                {elseif isset($brand.translation.name) && strlen($brand.translation.name)>0}
                                    {assign var=brand_name value=$brand.translation.name}
                                {elseif isset($brand.translation.title) && strlen($brand.translation.title)>0}
                                    {assign var=brand_name value=$brand.translation.title}
                                {/if}
                            {/if}
                        {/if}
                        {if !isset($brand_title)}
                            {assign var=brand_title value=false}
                            {if isset($brand.translation) && isset($brand.translation.title) && strlen($brand.translation.title)>0}
                                {assign var=brand_title value=$brand.translation.title}
                            {/if}
                        {/if}
                        {if !isset($brand_image)}
                            {assign var=brand_image value=false}
                            {if isset($brand.translation) && isset($brand.translation.image) && strlen($brand.translation.image)}
                                {assign var=brand_image value=$brand.translation.image}
                            {/if}
                        {/if}
                        <a class="navbar-brand"
                           href="{if isset($brand.translation.final_url)}{$brand.translation.final_url}{else}#{/if}"
                           {if $brand_title} title="{$brand_title|escape:html}"{/if}
                        >
                            {if $brand_image}
                                <img src="{$brand_image}"
                                     {if isset($brand_name)} alt="{$brand_name|escape:html}"{/if}
                                >
                            {/if}
                            {if $brand_name}
                                {if $brand_image}
                                    <span class="sr-only">{$brand_name}</span>
                                {else}
                                    {$brand_name}
                                {/if}
                            {/if}
                        </a>
                    {/strip}
                {/if}
            </div>
        {/if}
        {if $nav_collapsable}
            <div id="{$collapsable}" class="collapse navbar-collapse">
        {/if}
