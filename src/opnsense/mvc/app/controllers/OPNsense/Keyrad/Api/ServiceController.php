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

use OPNsense\Base\ApiMutableServiceControllerBase;

/**
 * Start/stop/restart/reconfigure/status for the keyrad daemon.
 * @package OPNsense\Keyrad\Api
 */
class ServiceController extends ApiMutableServiceControllerBase
{
    protected static $internalServiceClass = '\OPNsense\Keyrad\Keyrad';
    protected static $internalServiceEnabled = 'general.enabled';
    protected static $internalServiceTemplate = 'OPNsense/Keyrad';
    protected static $internalServiceName = 'keyrad';
}
