Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589F174D23A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGJJv2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjGJJuY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 05:50:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E8C10CA;
        Mon, 10 Jul 2023 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688982355; x=1720518355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d7exP4plSIxF5xH78Efzg3zwyfsggIgaiFqM7HOOUxc=;
  b=fbdV+zhfXF3nQ4p5r4f1UefLBKZJWyyNRNs/OdgE+WKwGFLqRglWid/y
   OalPugNy2P0/pZNzRUFA5unlu6wl7o++odWI9zgkSyftqnoFeZtjxsEfj
   aaStX+kA5BQdkmi0QSaGK4vZDeWEJPORb7WmtfQjq7cBdAcknlZvOD3Vv
   JkoJye0U5xBSVpLLnp8pbzLV/drSRLtcr8KC5Ojrp15Z9IkjPLf8c/dYk
   wwuMJhzrHfIKez+NazVqxO6oUxALCVl1lj32kd3kEaMXIpkgcRjf9YhHV
   ge/NwBPxXAtme5MuiSxrgmk8xZhRMYV41T1zzBRny4ul9q3uUUFSUSZ59
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427994079"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427994079"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="670886326"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="670886326"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2023 02:45:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 02:45:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 02:45:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 02:45:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 02:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdlwYf/Eai3PL2hJSwVq4P1iiLeEAvA50tMHJTOQf+HmOU0YOyORkDH+u0Lg6T+7S8m9lTUmOaYcu53kVVxOBLNbYf5+aNNKR7nax1jOpdvC14hNOIHgwrR3jiAeW3Lqzj82hfnBi9MK970BoDR9MLE8xHAiQwJP8juYt8o6yyO/ZVd1o2REDhy47KS160/1KRHaVJdwRNgqUe7NP+87LOPFSv8wWFc0H2VtBSxYK1tj3A7KX7Rn6DYUTI20UeDL7+DFtlETm+s0TgUV/uAvISA+ZtoRxWomTSBmT1vRbUVnHzNk63legb9zOV1DPmuitOgzMO1zi9Yxz/kV5vpZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QzlNQM7etd2Vc4zuNBZetsVI5/8fGZG2jbTmNkIu/U=;
 b=b/3WqiBztK0ZnAT/AMwrLxoDSvnfAOGCJtUESiRzyC4eQ+cc0wH/vdJ25ylt72ZuIE29WFykYRliXavIJ7KFUYKUbKbVgYOMMD06hiaAOduaixwhIFapMEyHdBhv9HWpBjMrvzfZutLYgYvfQPUqSxQsZQZ7kOSd2KVNB9mgCWdLjgPZ8tLPukooSb1U9TQ1XeC5k7B8kAT6uJf6jOa95GQuysIKTIXq6lCC8KYGfiN/9iFrK73j/IAhGkV05taqmGilmC+YIKVna5zbyf24Lps/jv5qbZzyEQ7lPu+4MSnvRq185Y7NTMlXCleGFC4HiK3g7lOUnNRaGnA2DjYQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 09:45:46 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:45:46 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "jiri@resnulli.us" <jiri@resnulli.us>,
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
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: RE: [RFC PATCH v9 01/10] dpll: documentation on DPLL subsystem
 interface
Thread-Topic: [RFC PATCH v9 01/10] dpll: documentation on DPLL subsystem
 interface
Thread-Index: AQHZpc/1HqWZmXZSIkW1j8k3PlGshq+gvrKAgBIcCpA=
Date:   Mon, 10 Jul 2023 09:45:45 +0000
Message-ID: <DM6PR11MB4657FEDD367D6E9A9E0D3A209B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
        <20230623123820.42850-2-arkadiusz.kubalewski@intel.com>
 <20230628141153.15709d97@kernel.org>
In-Reply-To: <20230628141153.15709d97@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB5325:EE_
x-ms-office365-filtering-correlation-id: 4cbf8185-f044-4651-4323-08db812a6f5a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K71Uyy6qrJlKqdwUMmegyMz45iVMPCB2ABwy3l2G/hu4fvQHOoymSyWBA0d9QcavQy+jh2GJIbk4KaXiFXe4g2sTRkXHhuuTvMoQW85AEy9XoEjxlrzPMGgCgYcmurKS/ZqA+ed8IJcugn+9FRpQauLwhUUtj3+FIFXut5jH/iwEGgWwbGUEhBKOYI7Tp7GaHXPJ6lCphcg6rG3kNEMyYkPgta2KGK7urH/T8A1lDR7uuek2UatYu2vUid00Tp4vXXQ7DbvoBD2jRtCs7SqjxsgW4qN8slKutB86veYq9P+6t2/wDC55WKRTW/pnslzer+eHXzlZ/IJisQacK2Ve6MRlBNH8kljgJNLj8+i2v7VoC7qJ68kDVek5/HV4XHOr+Sfyk7xzx0tcDjVEbL/fWVN5k4hXaypiVL/58tMKoqbDrgHy/3lIGgBIpEajKLppnOjaa6qY3DULXJSITtSrcgPbKqQDmQkze+QJDcaKkZ+bgIouf9R0ypu3SOXQ46MxyZhHbEIJmB6s0QGsxiIbyLyQ5NcgwpX8BMaa/CSdTY/5xnC+1gDZmjEROC4cjY49M0qLi7p0H9xlM5aNWLgZj+4QsLlS9XeQoJkNjI8y/KbbXV+/2dsEup/3i3eVHt0D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(9686003)(26005)(6506007)(83380400001)(41300700001)(4744005)(4326008)(64756008)(66446008)(66476007)(2906002)(66556008)(52536014)(316002)(7416002)(5660300002)(7406005)(8936002)(8676002)(6916009)(478600001)(66946007)(7696005)(76116006)(71200400001)(54906003)(55016003)(33656002)(122000001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sPILxzvz1I1aS9pj43WQ6OpB5vdpUjvIzbivY639JtBwrTH1PuY8uu1J6mX5?=
 =?us-ascii?Q?f+jSaFbik4pRe8QmHPRSdzsHdGB+tSceQeuMXxGR57zOJPT+rtB0IRQX1mYx?=
 =?us-ascii?Q?IAGTbsmU3M82R+vO+p9vFtJk0gf8Z2hrAaWBJq1SL+owPCc+q5wxfUFGVFv1?=
 =?us-ascii?Q?+WhVQE6ZmE9zg8oeZIt0+H3/lQEAD7oSd/a8D1sByIjkWxfgm3YbJDaa9bRs?=
 =?us-ascii?Q?aCmbS8XS4kxOPjpSa9C0I3g62+cpgLToXkqm3X/0L8kmpoYlLElP9tWVIB3F?=
 =?us-ascii?Q?aZB2QkR8xL9JXK/+evY374V9hLjl6hT+ai1pJnfORr6omaRGBQZiIjUkvEpo?=
 =?us-ascii?Q?nIXAANd9Vin3ucSNz9wO7IhUOxI3WofYJqM0/oBn7EZH/+85G0aZOMRQfCUc?=
 =?us-ascii?Q?h/lZHX5s4hBplbmhraLvhGzjUfSvkv3Ta4UljxCL4wTQ/nivdg1hDLlbSjFE?=
 =?us-ascii?Q?0q5xq9x2psQpbhh/t2WnfdmmiRwXvudu6HAesaEHFJ+5n4j2d4tQ2IO3JeAG?=
 =?us-ascii?Q?I22IkHDwkUwz/O0dOakMQ1hzXqcnBKK08sBypc26lOiV8d2Kfh6w7OvdXNZZ?=
 =?us-ascii?Q?K0d//8wf3xrWD3D4cGilvxuICRwrQa5vF8pZ9kgbWRumRvJSdnA9T8xafY9g?=
 =?us-ascii?Q?LDKgSgkVl7B9L8PkpkG3QU6MZy8CLmAWNKpTSDYb7iq7RBnnM7i8WQKRBjx2?=
 =?us-ascii?Q?ZOSR1zdr9sKpkzld3Rke7Qbx4juh2gL+f3UjwUa8Xd8SMKk3XIMP6dgpq0q8?=
 =?us-ascii?Q?KulIn2tDVPJedoYgLQZL06oRHbjYZufZ7gGyrmqEMj6uinJgeBU0uOmyTzHC?=
 =?us-ascii?Q?zsOVJbKglWhu4mIn+4gBO+fLPyGg+tQRHNePKckJSskMmto6hGfvk9oZtfO8?=
 =?us-ascii?Q?V+qLlWs0n1e6HQNWPiXrXo1hs2TO00LZSKw9QTefCNRIujQRgHsyjn4mzW8O?=
 =?us-ascii?Q?cSjVz+UJj3s1PCmX9rYNjUJFxdoLTSIBv9t84/syUs9tNB62UCjK5WeF85B/?=
 =?us-ascii?Q?LhEX4mBbIOgWSo9rn/VPRhmL8Oe1ZhXZ7y39f6g3jTOuZmmHoJ4TIxUP89+c?=
 =?us-ascii?Q?iIFlB+cubICAUu3GTRo93sSIfyUvq9lkgF4Lklbc/sYq7PJ4Ppad+fe/FFLi?=
 =?us-ascii?Q?cdlz4Y2e92cYzB7MXV0zIMlPN+9E7TvIBvNsPwgJ2SEr91yrkVz7rPoEaPKq?=
 =?us-ascii?Q?o/96yoQ3yCmKlFNrko15jWNOLJeu5K8dremEHJnoTbtv4EXLZk+AWqdw9qSk?=
 =?us-ascii?Q?rYNqe6kxglfWjzrclPHrg+6aGbN9mJrZxBLUgil/MoswfCtw3X4XaqhsDx2I?=
 =?us-ascii?Q?h9CPAk3vQIDq7JL0k643wmeh59J3lXjY4hNPoOXSnuaLqrKWURHBL8b4S7hL?=
 =?us-ascii?Q?cb5EX+Zi3gpECNIxFWrOvnmIRdv1Qxa4jX0jnnuMt44gx9cbcl7W2EDIeivK?=
 =?us-ascii?Q?YVo+zA/LjItoDA15mSRdiqY9uk9a0XDl5hRwUifZimZ3T5UQw9R/t1t0Fykn?=
 =?us-ascii?Q?hW5JE+6lMofIhD0C1nWOsTJXkoITlDMkGzJNfsDmnRjRhSwAyvV0YQcozfq4?=
 =?us-ascii?Q?9HZA23sgeWm5rUcgZqAD69Fuy1jpXDjVrCDtCIKNqtDmTkTTiub84BnR5grU?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbf8185-f044-4651-4323-08db812a6f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 09:45:45.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkOiiQcixzjzFIGen4Equ4WAy+nUhiXiQy0Bx4OFjlNjt9r0zDYgx37nBlb/dr17ZoyaOKfI78WdL/uZRSzdmHGaq5QJi5dza9oxolOdyhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, June 28, 2023 11:12 PM
>
>On Fri, 23 Jun 2023 14:38:11 +0200 Arkadiusz Kubalewski wrote:
>> +    'pin-parent': [{'pin-id': 2, 'pin-state': 'connected'},
>> +                   {'pin-id': 3, 'pin-state': 'disconnected'},
>> +                   {'id': 0, 'pin-direction': 'input'},
>> +                   {'id': 1, 'pin-direction': 'input'}],
>
>This bit of documentation is out of date now, right?

True, fixed for v10.

Thank you!
Arkadiusz
