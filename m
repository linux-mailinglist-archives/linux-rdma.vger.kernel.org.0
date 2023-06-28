Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83EF740CD6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjF1J2w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 05:28:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:19995 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237920AbjF1JPm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jun 2023 05:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687943742; x=1719479742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zGo6j1Zg2/vkHtrbu8uAR8xVSYic7pFmytR6gMagQGM=;
  b=eRjNTvZZmAmpF41b4WGP+IA7L7dd4ubaxLKTpl0VNKifQQpezlZscLH8
   guEUmItQs6kjYi20Cvv20jY+Drx2R2JCBDn0WG1r2fgX/5jONrPVzgSw7
   ZAREOczi5tKhUCwJlghXMNT6E0np6SfcKMzUEOdD/MetKD2LlOsp0QhT2
   owqGl7iAdgzYAEmQuMYHXZks+vdJY4fyTvYJ+eUxPnMmnQw4uJZYH2ye1
   qgxAZCwElUHtoBxNFS003d0rbZKPTY/BsG9nHIZAh+QC+jr3RLMtLB0Kn
   bzEqewRW2CYbq8BzIQpR1WkRU5/AC6oduyKj6JGCNdRm792OedznThr60
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="341379607"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="341379607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 02:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="710971407"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="710971407"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2023 02:15:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 02:15:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 02:15:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 02:15:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 02:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJiD/q8Fe/XIpMMcz7qkHbAz3fbSCEvcWw/JamETCOB+HXfrWt0wJzmkPU41+mQN6a3joLZZ5/TP09hRbrZJqcbvgs/EJLT9Kw+OU/N3JYAN1R3YAtoEQsVrE807KTe0l5nTQitU1JIx15F72cNU2zG3nyYGWUSz+vVW1rBtVynYrF/BzzERTY45bGUcPzx5HAiGrRGycXeGgmuTt8oSx20F1LVXnOSZUHcyYySxHb2dGwU5UVdDb4yeuzri7a/zVd5p4CADV/GsTH4YQ6pIMBgcxocI82jnUiCU7S4EEnG3OCxI89CJolZ5BsVBD9gf0/kOge4nG0Kqd4tFiKOsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgOurj5+aTMeAmDeix1JNt75UujjRu+WygDDB2rbzbE=;
 b=kMCVAzlMyCF/lafXh4O/4IZI2mOL66BSg3p4jroJ7TzpDdqnGRNVWaxtpTrBS3uuU50FvI+QmUVpzjYT1YIT0XrDJSZ07lZdCT6Xk32zGdoscGD/T8+aYI8EH3lJDvdyLI2XY3UtQVkOohMozPeItX6879WPt8zBxtSGE+pLmOBxD+t6RjEu7Sb5PIcpqqC3L+ZropXxMQz2pVWAaFaywZNwjPARU8RubwvxunMptPOJCX8mHMXfd3p2QSIg4yxUaz+wiKVx71EmAO/gqD/IxQulj1vizHgvoTK4qDIYV0CEgcWzPLacLjcz9JLPQmNRk1hlX03Sk4SOX8PzdlvfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 09:15:12 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 09:15:12 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "vadfed@fb.com" <vadfed@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "M, Saeed" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sj@kernel.org" <sj@kernel.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jacek.lawrynowicz@linux.intel.com" 
        <jacek.lawrynowicz@linux.intel.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux@zary.sk" <linux@zary.sk>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Olech, Milena" <milena.olech@intel.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "idosch@nvidia.com" <idosch@nvidia.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "phil@nwl.cc" <phil@nwl.cc>,
        "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [RFC PATCH v9 00/10] Create common DPLL configuration API
Thread-Topic: [RFC PATCH v9 00/10] Create common DPLL configuration API
Thread-Index: AQHZpc/u2XBvfmJQckCFu+3HjTH4RK+edcOAgAF/xCA=
Date:   Wed, 28 Jun 2023 09:15:11 +0000
Message-ID: <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJq3a6rl6dnPMV17@nanopsycho>
In-Reply-To: <ZJq3a6rl6dnPMV17@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH7PR11MB8502:EE_
x-ms-office365-filtering-correlation-id: 2f64758c-0008-4d6a-f708-08db77b82d42
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LsrazfpqoYtbsf1IvgTgHKN9cGOhhRqSL0WJBiqZNF/pxenpawVEkRjxH3yOvPUxL6p6G7Xw8oxqvHq83NSOV+zZxxPTh6xkays0aEb8SoyYau9nwHK5eTkjZFy/5nKZclYJWWbgHyEiopiuXVkXpsg95xz84TQkid7AYktuLkmlwwYzKqkaxtj4wmuJGtzH4ROttR6KTkFljU6+H0rjeyHJs5OqUInK93dztPqhNh7XSna6Dijcnvf4d8KKgd/0ejyEbbbRH5fvPI2jO8V2xAUHSs4ps/XgdAYETRdUCT9BS1G1m/7aKVjIF8YYJqGkjqOERAjGH0ayPQr6HZxHKuaGWZwBoZyguMhUtY/+FFahNK6wkAiKfJeCMOEYRd7sKgucUxOL32kcP0T8PywJXDfKMW9f05EB7wf0dEakW0gzohSH+OC8RZi1HTpe7gb5FDsrTUpe9Pv/yOjw+tzPbZsEH/wG09xJS/AQfovBW/7ZZ6Gpk/pRRVXwFcEjcWaoCE2a8/b6tN6ZfGZWUs1hbLsaaNqC44Gq+BbX9Tyi/HKkVIMtzzD59YMxLE/O52mCsUtVv/MTfT0Ye+q0PM4TL71ZYf94/+YurcZ31eRy19U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(26005)(33656002)(76116006)(6916009)(5660300002)(7416002)(52536014)(7406005)(64756008)(66446008)(4326008)(86362001)(8936002)(66946007)(66556008)(66476007)(38070700005)(41300700001)(122000001)(38100700002)(82960400001)(316002)(55016003)(9686003)(8676002)(966005)(4744005)(186003)(6506007)(71200400001)(2906002)(54906003)(478600001)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q+d9f2eMdKorVZmWcY0vCht/moNEFpGykjyatBm408O7UxP1G2DdMKkRVtIO?=
 =?us-ascii?Q?Qp/bx8ydXErl3fzjMgbuVTQ4Icc6hVwxnpX8rhkV8h+SWUMlOqYZROjrcAU0?=
 =?us-ascii?Q?LPyTcpZXHm0i8TvLwZ4detLBpolcBG6Dy5JseoWizV9xoKJEgAyFG5YX34Fa?=
 =?us-ascii?Q?cQ55+3AuqUVKwa7aKGs4GBqDeRC4/Ll0GfCrEitvbLL7/2lMyCBDvopjrPQD?=
 =?us-ascii?Q?QhkJZUVWMXdGre3uk0x54hCN8EWi/OAG715Bo1QOwpkrSVyEl6R/ih01RNRw?=
 =?us-ascii?Q?tFw0oFH8pCLIXNr7bb8sHpSyQiCx4UlfWmGCKapPZ6zQPgGJnG/gCFn8Qgzn?=
 =?us-ascii?Q?IUS/3XwLoe6Kx6EHE+9y7CunMheDVRMgUEJ3Gw2MrHG8MzrlqK/ADptF970X?=
 =?us-ascii?Q?JUNh8Vho7KjN1Cdugh7T+Uagr6T3XZQ1LxDDpDfI5do1UE1FjkK79PZWi21b?=
 =?us-ascii?Q?pSM7VtHzLMsTsOloU4LTcaVAtukbwfzP3nc4RMbobhTWO6VbS9Rvrcu5ZuX4?=
 =?us-ascii?Q?twYAa1X9JI1u8mvCEJW6Z3iOgpCRs9m3BHJ7kDK0KVeR6uyZZrYMlDVxA3FE?=
 =?us-ascii?Q?PHRRZaIN6EPbdWjfsT+e9J8JRNyH6pjvl2431ByFqUeeVI75lPR5DPgCXdRn?=
 =?us-ascii?Q?OlSJJ05N+mbHbnqncckQn9YweKztyX2l234E57BgZPI3JoXaV8MN4C9FYOPy?=
 =?us-ascii?Q?YWtnoLPLua7wOAoD/7G6xQaF56Z88GPeq4/h6IjpZmyaEVZo0LdDalIwhVlL?=
 =?us-ascii?Q?5rrSrexrYnJy2/KXaXVJtI290mo8FwN+XQom/ImZkjoGGJbyq3dSo4WRHlIF?=
 =?us-ascii?Q?OQvs/haXcixtplZzdnS+fK18tuMyUeiNvxda+LLfH0CnTzj6MI4satmP18Vo?=
 =?us-ascii?Q?/x5TUjoNJX712XEBryRegqhID4yyV9SWpmk2/LO/FO0z1ujs1RQVy6lTIhvw?=
 =?us-ascii?Q?GNN8Oyt67lz3RQmyJ12PU1U/sR2+nTq0eGPow3oXC6ZahfT6FxtmcZuNKZ35?=
 =?us-ascii?Q?CguHF9wYfgRLR9owHe28VrkLMEMw0Kqj+4P7kNKqYxL10OLc6phuwkWBcX++?=
 =?us-ascii?Q?fF2qMr8sOzgXMlUICNm81H+7SoG3LZZz+O4tAoKGeQF1NxcZCHtZz6WxVaPk?=
 =?us-ascii?Q?tFtNxLn5YHmfW+KlqmgAIQ9lnt4koGIzzbiRc3nbLmmfzgTGqYjkJd4NepVu?=
 =?us-ascii?Q?/XoX6aS2yFLBz8GOn/4xQ3Wxq6OLyvkXGp6UiAArNR13oIWIZVrXJzfiH0lk?=
 =?us-ascii?Q?dnNp4lZ51qKtU0Nl9NUnHVlA/oQDqbHa1jHoNtCgh1coXMfclFyYBEGoQTBW?=
 =?us-ascii?Q?tHYx5WPuwb7rn8N6vXI6aPPQ5icOQRMqnWb+UeevO7LR5m2uStemeJEtgg9q?=
 =?us-ascii?Q?tspjVAg7gUAhQ9x3063dq3hXmiXSujqy8oGDL5T5ImVbeYDByCQFnIH7d0Qv?=
 =?us-ascii?Q?zJrKp8wkA1TfBwPbC+5WCm9Bdqwnc3hMah3cKxs0w13ckwDEQxmRXLnnZpei?=
 =?us-ascii?Q?rAmlZgJ1jYu279thK3zFAQO89kbUOsSxqJ+QFvdILE64twBqekVgsOlx6vmB?=
 =?us-ascii?Q?lPzCndKH84nISAVmrDhpOffeioGRl83lPjk9qswy1EOgT+YaS9Kn/Xt6wwbb?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f64758c-0008-4d6a-f708-08db77b82d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 09:15:12.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNuuXf4XohYc2wAOA8ZMD0AA1DitCxba4ux5OIYMhz+nTDElZ5Y0tHrFAcGAvdzmSh0pddrIq2ug3Qputp3DsfdRwxZCfO4K/5ocqQl3uN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8502
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, June 27, 2023 12:18 PM
>
>Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>
>>v8 -> v9:
>
>Could you please address all the unresolved issues from v8 and send v10?
>I'm not reviewing this one.
>
>Thanks!

Sure, will do, but first missing to-do/discuss list:
1) remove mode_set as not used by any driver
2) remove "no-added-value" static functions descriptions in
   dpll_core/dpll_netlink
3) merge patches [ 03/10, 04/10, 05/10 ] into patches that are compiling
   after each patch apply
4) remove function return values descriptions/lists
5) Fix patch [05/10]:
   - status Supported
   - additional maintainers
   - remove callback:
     int (*source_pin_idx_get)(...) from `struct dpll_device_ops`
6) Fix patch [08/10]: rethink ice mutex locking scheme
7) Fix patch [09/10]: multiple comments on
https://lore.kernel.org/netdev/ZIQu+%2Fo4J0ZBspVg@nanopsycho/#t
8) add PPS DPLL phase offset to the netlink get-device API

Thank you!
Arkadiusz
