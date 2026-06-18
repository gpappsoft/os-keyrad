<?php

/*
 * Copyright (C) 2026 Marco Moenig <marco@sec73.io>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

namespace OPNsense\Keyrad\Api;

use OPNsense\Base\ApiMutableModelControllerBase;

/**
 * Grid CRUD for the scope/group/role to RADIUS attribute mappings.
 * @package OPNsense\Keyrad\Api
 */
class MappingsController extends ApiMutableModelControllerBase
{
    protected static $internalModelName = 'keyrad';
    protected static $internalModelClass = 'OPNsense\Keyrad\Keyrad';

    public function searchItemAction()
    {
        return $this->searchBase(
            'mappings.mapping',
            ['enabled', 'scope', 'vendor', 'attribute', 'value', 'value_type', 'description'],
            'scope'
        );
    }

    public function getItemAction($uuid = null)
    {
        return $this->getBase('mapping', 'mappings.mapping', $uuid);
    }

    public function addItemAction()
    {
        return $this->addBase('mapping', 'mappings.mapping');
    }

    public function setItemAction($uuid)
    {
        return $this->setBase('mapping', 'mappings.mapping', $uuid);
    }

    public function delItemAction($uuid)
    {
        return $this->delBase('mappings.mapping', $uuid);
    }

    public function toggleItemAction($uuid, $enabled = null)
    {
        return $this->toggleBase('mappings.mapping', $uuid, $enabled);
    }
}
