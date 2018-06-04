<?php

/*  Copyright 2009-2011 Rafael Gutierrez Martinez
 *  Copyright 2012-2013 Welma WEB MKT LABS, S.L.
 *  Copyright 2014-2016 Where Ideas Simply Come True, S.L.
 *  Copyright 2017 nabu-3 Group
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

/**
 * This Smarty tag is implemented using the Compile model of native sysplugins of Smarty due to their advanced
 * behaviors are not possible to make with public Smarty Plugins engine.
 * For that, is compounded of a set of classes Smarty_Internal_Compile_Nabu_Role, Smarty_Internal_Compile_Nabu_Role_Else
 * and Smarty_Internal_Compile_NabuRoleclose.
 * To work we need to include this file in CSmartyHTTPRender class file.
 * @author Rafael Gutierrez <rgutierrez@nabu-3.com>
 * @since 0.0.1
 * @version 0.0.9
 */
class Smarty_Internal_Compile_Nabu_Role extends Smarty_Internal_CompileBase
{
    /**
     * Counter to grant that nested calls to {nabu_role} does not have conflicts with local variables.
     * @var int
     */
    static private $counter = 0;

    public $optional_attributes = array('is');

    public function compile($args, Smarty_Internal_TemplateCompilerBase $compiler, $parameter)
    {
        $_attr = $this->getAttributes($compiler, $args);
        $this->openTag($compiler, 'nabu_role');
        $compiler->nocache = $compiler->nocache | $compiler->tag_nocache;

        $varname = "\$_smarty_tpl->tpl_vars['nb_role']->value";
        $condition = 'false';

        if (array_key_exists('is', $_attr)) {
            $condition = "nb_checkTreePath($varname, 'key') && "
                       . "is_string(${varname}['key']) && "
                       . "${varname}['key']=== $_attr[is]"
            ;
        }

        return "<?php if ($condition) {?>";
    }
}

class Smarty_Internal_Compile_Nabu_Role_Else extends Smarty_Internal_CompileBase
{
    public $optional_attributes = array('is');

    public function compile($args, Smarty_Internal_TemplateCompilerBase $compiler, $parameter)
    {
        $_attr = $this->getAttributes($compiler, $args);

        $this->closeTag($compiler, array('nabu_role'));
        $this->openTag($compiler, 'nabu_role_else');
        $compiler->nocache = $compiler->nocache | $compiler->tag_nocache;

        $varname = "\$_smarty_tpl->tpl_vars['nb_role']->value";
        $condition = 'false';

        if (array_key_exists('is', $_attr)) {
            $condition = "nb_checkTreePath($varname, 'key') && "
                       . "is_string(${varname}['key']) && "
                       . "${varname}['key']=== $_attr[is]"
            ;
        }

        return '<?php } else' . ($condition !== 'false' ? "if ($condition)" : ''). ' {?>';
    }
}

class Smarty_Internal_Compile_Nabu_Roleclose extends Smarty_Internal_CompileBase
{
    public function compile($args, Smarty_Internal_TemplateCompilerBase $compiler, $parameter)
    {
        $this->closeTag($compiler, array('nabu_role', 'nabu_role_else'));
        return '<?php }?>';
    }
}
