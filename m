Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E527502C4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 11:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGLJUJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 05:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLJUH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 05:20:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4672127;
        Wed, 12 Jul 2023 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689153607; x=1720689607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=esGd9bGvTi2HuuqLQEOQHK/SE87rTPZMdDXEalm/hpM=;
  b=fRVo63oDiGhf+u+jmOWIYF/FOEu4Hwy3OFdbvCnxIG0qz05txIatSAve
   uDPv6kkJ8YHAzR0j3GApGxPCC7hkidWSElGl8fWlSeUPCIQkej9aeJlq6
   aUSNYeXMdHDGxMQwViJcu95QMLb8yGRfsdJfy9pGLBhte3A3+P8XTtRd4
   3jgCIq1VsuJZ6FmUib27BoAYkHoYBiVWZJudhABki3ECAYpNnNyo1nTU+
   Uxo+7SjgWxn8WWvD8TtUiLJHThGDz1nIclb5u7ll6r6O6VTBdfypT7YEF
   3Ssi2fOJJFf5aXEZ0nMuYVw+slg5NoB+lCcTBdVhHAvGUoKyyJyFqL0oM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="368376701"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="368376701"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 02:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786967665"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="786967665"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2023 02:20:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 02:20:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 02:20:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 02:20:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYUzeCzfX6dgLCVLKxGB0ffWpLQcznyIhdZsHFFSmu6LI0nIza3XZWKowCv2gt8r1D3U5XL5muASdHeUW8uEGvNMyUoEcS/0KIT92M7SFqNzXZK0b7bdz7G2viMRn0SHP6CtPM6LbkecEkH+c9B1HRkPZ4176hUSirJ1TAJ4d0tU4nR3kq2pd/cMo+3ohmrQLNZCwYw/ZbdOV1nocZR0cTzkKvzaSeHecGWaabVzMqD9rtU70Wid4A6jSmdYRBlIxx2rJPTomGBasEFtHukGP2nQ17c1XY1Jog5G9U4BpTK4Qp88qBVJeLbbPDOB6Eudm/7pjCmYj1hboBwYVs0Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esGd9bGvTi2HuuqLQEOQHK/SE87rTPZMdDXEalm/hpM=;
 b=Qm8MMmxla5A6GJelBqmYvxWKtyS1Klga7hNyt5H7b8JBATSdWT11mN1dYMeDvvchh17W2wdWwLejbECa/dghK+VU+5gwluATbyxM9CZTmjsBJkB5wXvI75QdmtpTNwAyvzHqUdY6aBVYt5aV42Ap5J60+B1D15nunWJZx7xlTyeIYDRRUpXkTeJQ+kp+VKZfwv7twjuDPzVCsfIHM11gIbmaGdSyklwre6imPHMZSHTEwk7elEHbHiDc+y/OHcBf2IcsJYRifoe8MvwIFZsO7PBK29z40o9fHJ3tZvHLi8eXNbQi6ghWf0xfgwATTH6jtYclr1nkRL/yDgiwCNnz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SA2PR11MB5068.namprd11.prod.outlook.com (2603:10b6:806:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:19:53 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:19:53 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Jiri Pirko <jiri@resnulli.us>, "vadfed@meta.com" <vadfed@meta.com>,
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
Thread-Index: AQHZpc/u2XBvfmJQckCFu+3HjTH4RK+edcOAgAF/xCCAACKYgIASxLqggAAmaYCAAXNRwIAAGjOAgAAtYHCAAF7igIAA2ZKg
Date:   Wed, 12 Jul 2023 09:19:53 +0000
Message-ID: <DM6PR11MB465701C009D1DC2972F900F29B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
        <ZJq3a6rl6dnPMV17@nanopsycho>
        <DM6PR11MB4657084DDD7554663F86C1C19B24A@DM6PR11MB4657.namprd11.prod.outlook.com>
        <ZJwWXZmZe4lQ04iK@nanopsycho>
        <DM6PR11MB4657751607C36FC711271D639B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
        <ZKv1FRTXWLnLGRRS@nanopsycho>
        <DM6PR11MB46575D14FFE115546FDC9DEB9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
        <ZK1CizcqjqO1L/RQ@nanopsycho>
        <DM6PR11MB4657067EE043F4DBB9D8B03B9B31A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <20230711131443.2a4af476@kernel.org>
In-Reply-To: <20230711131443.2a4af476@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SA2PR11MB5068:EE_
x-ms-office365-filtering-correlation-id: 889b3cc2-3985-4a06-29d9-08db82b92705
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EolpuoR9huxbuOAHM0ee1DtVs1rJOLSDPgWabC9KeHci7u4K/VtTzoxM6EEEUvUc1iFH12NGg7Bebna6J8S0wiqWgUG74fwH8sVa4NZ9BNWuZqXY3DP+zAppL2TiogUk25XPN4lzIyKeoDPOvPZdN1G09fBqSWDIjvcefslywb6cZGg9LYknTndjvesiesBiI1wrWhjYS691FQgNBJ71JhUL23pfUROO+L5nCLCk3okB2DjgtdI/8aXNjtHP5W3a+dOgnNoBAfd7qjQB7AB634YXRQ/TqMjOd1lv7pXQ1lTjPwG2jaziKWJqTZ/8cdoxDMjFwfrZZMT2/vmmby9adrgJNnG5HajZ1zrLAng2FvgEKWAcRDZ8Bt5gpUHLQnQcRpAntnwzUM5WUjlEyxQokJOgKZ52FqT5wCUt6FamzatCMCgpe5WSoY7zPDuO8xOuslcFOuoHfAOOZQBTk/0BWjAFVgsvoZUGGCu8eAuekUf2KQBeCin86CnI3kfjokWueUgmWq2Lk6N/lPEqmIGnr49Bsp6S6sJFsUas+zOjD4ve+0o7shDgXnjZ7htJdI8TJlRPwBtKKIDFCOWjjTvfy+Wm2pJAoQnLJCxW0ELaQsNdCLk8yZWe/aa2g3I/qntU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(7696005)(186003)(82960400001)(122000001)(54906003)(55016003)(86362001)(71200400001)(478600001)(4744005)(6506007)(26005)(9686003)(52536014)(7406005)(7416002)(38070700005)(316002)(8936002)(8676002)(41300700001)(5660300002)(83380400001)(33656002)(66476007)(66446008)(66556008)(64756008)(66946007)(6916009)(4326008)(38100700002)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vhJEQqmjUeV6oHqTHymoa/i+qaH02xAgjN2iku4WbRU9sm+VuLn2T2MKJYf0?=
 =?us-ascii?Q?JQY4EaP6J7iU7uGOrI3ZX+eeFOWuPAOF/enXu5IAdmxpY+4B4rNgDMp7bKyv?=
 =?us-ascii?Q?W/fKDkS7SPp+hWzU13LLOTahm6RhBhfNzuvZMgP+dPOY//QLqZ/mTycpfN5W?=
 =?us-ascii?Q?eGVXf5FNnNYd9da/5Rf7RAgzvN5mWCz9JsN9+s91s7FgKET3difhz4OIMwfL?=
 =?us-ascii?Q?t05Yikg9/NJhMefFFjicomXgBZZ3tcBzG7kkY52G1KuFMOnJYm5FThHnmOyK?=
 =?us-ascii?Q?aDceL1Q+RJqx/EkyRPyJ7wo91fcYIOMP+B1/eXyJDrkReV6AwDRROI16q67P?=
 =?us-ascii?Q?+y+5m3OaR00MS+b2+cBHKOFUb1XleW8SspgGMtNduwpIfaMESld9US6IGMXI?=
 =?us-ascii?Q?Vl1g6dxz5+cYKaJoMCz7R0UDW9+gpEQGInhCLynfx2ES8jH68xdGFWheOAza?=
 =?us-ascii?Q?3pTUExBhCCrbrOStA2640ylhYpAgMT4JzgHu0DAm22BHgEAC2S4octM5PAcw?=
 =?us-ascii?Q?AhhPSXU9oTulrPHFdcfo4AygPEp2qMY3bvrdSn6/Dce27vkGYRQG5G0HbkJe?=
 =?us-ascii?Q?kb19dQRahtFLW9OTfcdXdUcxgd8IY4fXBS9uwvscZcaSIgk1fkW7ZwJivBGi?=
 =?us-ascii?Q?cfTEH/ScHji/a+WX7EARGvbRYdfilRHH3V2CqUea21/l8iBvW1hY7ML91YET?=
 =?us-ascii?Q?VDZnd/bMuG7niNLG5abs9aXL86CEHmwYVU/DurGUHJRheb46jtR0LJjANnwp?=
 =?us-ascii?Q?doht+VWYFxBsEwPAtWMyI2WLy2IGtMhecQruxsTGcjTQxdhEfVL+jvjvEoE8?=
 =?us-ascii?Q?HfxNDpLHrORvLkkfmaRUDiFM3gDMn3hG2fegS2+O4GOFEXh7PFXgTSqh/Uqv?=
 =?us-ascii?Q?mEclhxcaOcKCW8U6Re/jzATvkFGDvPXBn2JmWjLp0d/UI8lUuOQxq7dbFDZz?=
 =?us-ascii?Q?mRpnSRhouZiGGlhsZ/xSdyRmq1XjyovizGm1n4RvCOx1laF77WRY9IXEFiZP?=
 =?us-ascii?Q?xxsSC8iKneH+vNVJrB28Gdg5O/VdbLIwgK6IVnsZiO8y/Cd9po/Y8K8t3QNl?=
 =?us-ascii?Q?xqneAP6vh5n7fjX0b4+JnHHqHPu43XhRw9w2HdaDgDuQj7kuE0NDHgNnml77?=
 =?us-ascii?Q?1ZWjG04qvc4nwCSsvXMhKBmjf5/N7wvzjN2p8fD2VEuEAoZjqIgK/aEcrLK+?=
 =?us-ascii?Q?odwGbH8WS+kGI3HQ4dFr2niRMhMCHm1o4lEFejmXZqTPKxG9WZ/ZFWdF0os8?=
 =?us-ascii?Q?gw4R81FMCTdBBK35X1Gum14lLoHlbhEJKf2yQJ2Jz5B4l73RfaMwxoGU0O5N?=
 =?us-ascii?Q?+GGHv97itu9g2MqYHxB1rf5Hed61R9R4n/SpaIxmLjFsvrCRk3v1jmrEKnYI?=
 =?us-ascii?Q?vIVWmi26IXT02z0x2EL+DoQsTpt0Kkw88zxFAT8r5JrHSbRtxifzDxdteGwP?=
 =?us-ascii?Q?0p72+5jM5BBkIrI+9HWlWA7H7kA3oydJHAfDy+dcTVrtio0rIdi0fXEGJifJ?=
 =?us-ascii?Q?uFt2z73kuYXPEQwHwCUFJXMHb5QsBde0nZsKhJbdwaMkyj6mKyvhLRnn3e/r?=
 =?us-ascii?Q?mwBoM53+Ueo59qPTuZus2y5i7PxM7o9UOdackmUU73zvnh2aTSzB7LTlVBb7?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889b3cc2-3985-4a06-29d9-08db82b92705
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 09:19:53.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8g3Bg/+DhyBHzG8jsJs7h1wKukyslvp0da0kGbhFR20Lgf0QIopyIdc6DTo7a3PMMhoOrzzgI2pOQlHcTHw1JERj/BRRUJsnnVWCYcTa910=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5068
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Tuesday, July 11, 2023 10:15 PM
>
>On Tue, 11 Jul 2023 17:17:51 +0000 Kubalewski, Arkadiusz wrote:
>> >I think better to add the check to pin-register so future synce pin
>> >users don't have similar weird ideas. Could you please add this check?
>>
>> Don't think it is way to go, and I don't think there is anything good
>> with preventing device drivers from labeling their pins the way they
>>want.
>
>We had a long argument about how label should have a clearly defined
>meaning. We're not going to rehash it on every revision. What did I miss :=
|

Well, as I understand we are discussing if dpll subsystem shall prevent
labeling the SyncE type pins. I have labeled them in ice explicitly with
the name of a pci device they belong to.

You haven't miss much, mostly the problem is described in this thread.

Thank you!
Arkadiusz
