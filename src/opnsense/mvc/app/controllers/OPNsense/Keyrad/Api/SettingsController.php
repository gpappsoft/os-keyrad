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
 * Handles the general (Keycloak/RADIUS) settings of the keyrad model.
 * @package OPNsense\Keyrad\Api
 */
class SettingsController extends ApiMutableModelControllerBase
{
    protected static $internalModelName = 'keyrad';
    protected static $internalModelClass = 'OPNsense\Keyrad\Keyrad';

    /**
     * Only expose the general node to the settings form, the clients and
     * mappings grids are served by their own controllers.
     */
    public function getAction()
    {
        $data = parent::getAction();
        return [
            'keyrad' => [
                'general' => $data['keyrad']['general']
            ]
        ];
    }
}
