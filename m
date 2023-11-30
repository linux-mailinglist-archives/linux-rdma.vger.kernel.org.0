Return-Path: <linux-rdma+bounces-170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3A7FF3E2
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8CC281999
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2D537F9;
	Thu, 30 Nov 2023 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afZE8j4G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34DA1B3;
	Thu, 30 Nov 2023 07:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701359215; x=1732895215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9yWrbTXSi3YNhBKWTgSfii1fJ76DTSWoZ6PcmCowedY=;
  b=afZE8j4GwdfnpPm5UdP8UYw414ylqg0ss5o0eGQPA1obVxI9brjVsMJ8
   Ts9GGecv8mhCT1N1+wYoAxO8If5osYuctRyAb4mjTII2vc1khmkViue+W
   qaDZU9W9woq50HjseWiXY+9r9cWWzMLPuDSesKdbSoVW3m9QqrBb6wbq+
   ZmEeQLhHes/RSbNs5O09+CIIDEqPYJlfB9aZgHOv485/3Y46wihEEGpup
   yNdX7pCu3ekWB9bNA8S3Bqcg9GdVgijP5J3cmv5xhi5ltK+Ggi9WzzZB6
   V6Antu9Vi7G3P3IlD3l7pyC2E8IAg+R7S0pvsu8gXCe+7dfOPHTzNORHJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="223379"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="223379"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 07:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887276826"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="887276826"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 07:46:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 07:46:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 07:46:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 07:46:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 07:46:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3kaz8UzttVdyf5NfFCjgJfBBA2BLOsv6BKEkGXTmNF7shPHYmohSd5JqaonllHZsfj888tP3jH76iZ6XbY3G4s5l8+6qTVEwe3TbLJaCyEQac7G1HLWTDRj5ZVEVpy9DmwGgLew40OGRJiyEolGEY0W1JlPe7mb5kjl+xpL6V6+kMgnFNll5Xb8zwsPtAhrI9ytctMmr79ffEFV2/fHR5B89udXbyuJr1E5H1qpTCxGZFjP/pbqbS2jm/2kcG1gMRDPM6QcO2RKRVZo+8HgAmw9gnBFddKb0i6CNqhV77HVDFQFyUimSveXwAImfGtMJZl2tuxk2R/3g7tddXTPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqVI1P9W6bkLIbAVGsgwjNphD0uKG2YEVvgAUgdoIpc=;
 b=J3uXZ2JXN+1+3e2eDIDPgWFyEs8g7TZtLT8360zIbBQsrfk4s3ObZftgqviRw10jaPKS0NNz82YHmr5FzfihdysblTuUwnfRdNRvQZoWqQdtNDVfuzCZkPDtCE6/S8CVWmXUbt3MXgFQPyqUH+Pe+yF1bwR5ms0OuK5Nj+GNx4dVC1igJGVanvQcWO2emhUGxc68C1eoJsl4Zq09kwZ0qFs2DmD7XvgKdqkiatmqE2ekC+A/C0LmngwH4Rt3wEbwGRFxr1w8C2E0s7RQNsGV6uAd70yIUK3yEXk+wVsZuqrTkPmQ0/cTfSfBLoPnDPINUeu0f1jMuuUZkAAWofMuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by BN0PR11MB5711.namprd11.prod.outlook.com (2603:10b6:408:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 15:46:36 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5%7]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 15:46:35 +0000
From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
To: "Li, Shifeng" <lishifeng@sangfor.com.cn>, "Ismail, Mustafa"
	<mustafa.ismail@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "gustavoars@kernel.org" <gustavoars@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Ding, Hui"
	<dinghui@sangfor.com.cn>, "lishifeng1992@126.com" <lishifeng1992@126.com>,
	"Li, Shifeng" <lishifeng@sangfor.com.cn>
Subject: RE: [PATCH v2] RDMA/irdma: Avoid free the non-cqp_request scratch
Thread-Topic: [PATCH v2] RDMA/irdma: Avoid free the non-cqp_request scratch
Thread-Index: AQHaI2VMij7Wu/sLOUSI2c9e66wXdLCTAQ6A
Date: Thu, 30 Nov 2023 15:46:35 +0000
Message-ID: <MWHPR11MB00298A90BFA2BCF9E7180BF1E982A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20231130081415.891006-1-lishifeng@sangfor.com.cn>
In-Reply-To: <20231130081415.891006-1-lishifeng@sangfor.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|BN0PR11MB5711:EE_
x-ms-office365-filtering-correlation-id: 4b3b28a2-9a6c-4f16-d52e-08dbf1bb88c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eClehoS3D7G0W199yRPJFaRgyE6kywSy5q4CAxdC6MOJ20I9L1HrLmDopFc3IE/DVj0sFIYL+Tl5YNEwWebx2txjvT3MVDp62wGlH6eVTGzFLCTV5BDVHV2uZFUcfyeWpCM9wTRGsnteWigYg2dVpZicFuYj3jS8l9x3USslHs+TiTBAcV3Du5lRfvNQ++YKPmkDthRk3DS5k6R/SWOEoCDOXCJ2iVguQj3njvi4dm9ckkqqtGSMdWPlBH6DbRzoiMSG5pmqvm63KcOUp6JzoJ6tqhlcDfzdB8R5tL4NpMgjB7r5S/ekbbmCmTJebqIfLsmF2Dgg7cHAw+SnoLfixNBc3dFHVya19RbUWEn2+3uolHR4als2fJNGyUXM2wjjJTAsFoDG3xg+i1jmM32kKQaNcT5HSoafi2SrlF/phzUFagYBDIBoUoJ96QjeFxuxsLEA69qZidNn6di2LSnmNVlBa7WQQck+HvPDVoAPc1/5Cg7OINRHod/8tqRC1zF5m+K8HPtFps6wpirbdTG+YEky2jRwcerPTDKPpqArYCkYKS2O3NoqoMjphs2j+6s2XPk82/CD756sR9AnD8v0uLFqmWrGRmjVdCVXh4JdNFTdwMB3eM/1/RdVepQcKMz+MyqfZUiXy8VIFuL/zMbFeB3YnSGCjksUoBwn1V1l5os=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(6506007)(71200400001)(478600001)(86362001)(4326008)(8676002)(8936002)(7696005)(52536014)(64756008)(316002)(54906003)(66556008)(66446008)(110136005)(66476007)(66946007)(76116006)(26005)(55016003)(33656002)(82960400001)(83380400001)(9686003)(122000001)(38100700002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6uuBtuRaOf/t3W2wEVusvKc6xy7CD8QDWYQ2NP7ryUMKl3FcNmawyGiKWD69?=
 =?us-ascii?Q?McyFSbfNb4YM08bx83s2Xdvg8p8RouU0LhoEnAPmXRhKZ5oYES79gt6mc8Zs?=
 =?us-ascii?Q?P69eph2Sf1dj1poTrV0KrHCehodhMqCjDO5WrNqEUJZjrtXt6CNQUrebqJAR?=
 =?us-ascii?Q?b0LoklEoqept4qVNmEHpyrFw7zTFMX9taY578nldxQGLPUmYhG6LkAH7VI72?=
 =?us-ascii?Q?oPJADho8m6XCE7uLJhyr3GGwSzRIDKlZ2TDdUYO/HnKYMPPJ1uyhsRhyQ/iS?=
 =?us-ascii?Q?th2JmIVqJplX15rtNsDWJxClPl1g0nOSeTCXmtrNvsnFzmQwwqg34VBUmwM1?=
 =?us-ascii?Q?4U1wUtNJskBgr62HCX8PUEjQLb0SzjfZaZ5H9s5V18suoOuVs1TnSzjfLoK9?=
 =?us-ascii?Q?lJvNQ1bmLV64KEAqCRvafVUSUN4p85YLnTa5C6ZK92kQ6RHR3MLI+wmC3Bnn?=
 =?us-ascii?Q?kJXXnh6n6TD8ZQc88T39Kv6ktkRSHRNM0DIqAOXDbKYjjz1FZ0GUlAOj2O/I?=
 =?us-ascii?Q?S4Me8La24/HjZJ175zbaEAQEEbeabNeV85ru+BDALI9wtmREhOkru8ElnuTd?=
 =?us-ascii?Q?pmodXko1d5RLfnc+aS+JTQ0s2zGgKerzGdbz9hCmcuo+4SP6TbLXt73ys8qu?=
 =?us-ascii?Q?QAOUNrX4i5jBj20GH6794/Ba/4edpO/NFhc3+kty8ppZ5kAya05MGoQVYz38?=
 =?us-ascii?Q?c3D38MjgM69Wl2vEnFQvH9MADGihRoxjbtoZvFOG/dG8F+LZgNYkC6kelkVK?=
 =?us-ascii?Q?YLUdXWMSuLsZmfkqLCqg/bYZpSku/07il8YXNPJcP9lOxgMcqg4k5WjCjcUo?=
 =?us-ascii?Q?iH9RewBcQJqgtLneQN0bux7OgUyPJjb5W4XNIAtBcCM72Q6ctWr2nW2EnicP?=
 =?us-ascii?Q?jH/hnp1Uambu2pvRFnhPCxaUODSTcko9SYa0iri6fJJKwIZgb56+pbMjQazw?=
 =?us-ascii?Q?fPtQhOBGhUDN+jTTbPJq+VVW6AcoRHgpkxGFKmZfmrBF2Aat2zUFFOYx0i40?=
 =?us-ascii?Q?5HkyrdxWkcncs5IujGrGokHceHu31CHGZYBdcY3PCR2ot/sf8qQhggIefZ9i?=
 =?us-ascii?Q?evTFykLJQbFQNWrsg4Idut2ps8QxaEgEu9JSM/+2beSfI246Xds147bh2LHW?=
 =?us-ascii?Q?GswSooXkMTuzhq3NKEPQghL+NScz0O//pFSiXlNGFKK8Dx92l++OA6C4gIjb?=
 =?us-ascii?Q?S76DrVIvsRhjx2p/lOq6xpD58BmkEMsrO9OgWpwHAHo8SOACqzU8dr9ymeyJ?=
 =?us-ascii?Q?uHOD4QBuE9qXmgE8PTj95cYKCIdwUbEeLyaOD/+dcbNh0M80PudbBQp8Y6Gz?=
 =?us-ascii?Q?Tyc5VO0M29bOt+UIlsTzMxtKo9aJn6namcM6WjlgFi1orV6lzHmtnPoklVfb?=
 =?us-ascii?Q?cqJZ4g1TF4tvfKV4JvdXEnpKerkFz7sPZ4Djhkiz8V3em10jx18ycfddIdwS?=
 =?us-ascii?Q?AiCGEGvHu866Y2VrwRBtwb6j/5Wo9YIvzrc7w4oObMLXMq1veYZtSK2xlGyd?=
 =?us-ascii?Q?v5MFhovlRG7qA3CCMOMe9puC2Kqv6ieGBDzAw6JpW45LasGGWOl/RuBaY1kF?=
 =?us-ascii?Q?rz9qHv6sYSvREwiqy5xJSz8Ls2SqzfeLaOfZpZqH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3b28a2-9a6c-4f16-d52e-08dbf1bb88c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 15:46:35.8876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOFbFz00A/Isjot3+6NoqJ6JGJbnadJWaMGqMZJVVyeLPJ88frc0uCFK7asd1+uxnPk8wnU9ZyZ27TazAGfk5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5711
X-OriginatorOrg: intel.com

> Subject: [PATCH v2] RDMA/irdma: Avoid free the non-cqp_request scratch
>=20
> When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as a
> cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when removi=
ng the
> irdma driver or unplugging its aux device, cqp.sc_cqp will be dereference=
d as
> wrong struct in irdma_free_pending_cqp_request().
>=20
> crash> bt 3669
> PID: 3669   TASK: ffff88aef892c000  CPU: 28  COMMAND: "kworker/28:0"
>  #0 [fffffe0000549e38] crash_nmi_callback at ffffffff810e3a34
>  #1 [fffffe0000549e40] nmi_handle at ffffffff810788b2
>  #2 [fffffe0000549ea0] default_do_nmi at ffffffff8107938f
>  #3 [fffffe0000549eb8] do_nmi at ffffffff81079582
>  #4 [fffffe0000549ef0] end_repeat_nmi at ffffffff82e016b4
>     [exception RIP: native_queued_spin_lock_slowpath+1291]
>     RIP: ffffffff8127e72b  RSP: ffff88aa841ef778  RFLAGS: 00000046
>     RAX: 0000000000000000  RBX: ffff88b01f849700  RCX: ffffffff8127e47e
>     RDX: 0000000000000000  RSI: 0000000000000004  RDI: ffffffff83857ec0
>     RBP: ffff88afe3e4efc8   R8: ffffed15fc7c9dfa   R9: ffffed15fc7c9dfa
>     R10: 0000000000000001  R11: ffffed15fc7c9df9  R12: 0000000000740000
>     R13: ffff88b01f849708  R14: 0000000000000003  R15: ffffed1603f092e1
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
> --- <NMI exception stack> ---
>  #5 [ffff88aa841ef778] native_queued_spin_lock_slowpath at ffffffff8127e7=
2b
>  #6 [ffff88aa841ef7b0] _raw_spin_lock_irqsave at ffffffff82c22aa4
>  #7 [ffff88aa841ef7c8] __wake_up_common_lock at ffffffff81257363
>  #8 [ffff88aa841ef888] irdma_free_pending_cqp_request at ffffffffa0ba12cc
> [irdma]
>  #9 [ffff88aa841ef958] irdma_cleanup_pending_cqp_op at ffffffffa0ba1469 [=
irdma]
>  #10 [ffff88aa841ef9c0] irdma_ctrl_deinit_hw at ffffffffa0b2989f [irdma]
>  #11 [ffff88aa841efa28] irdma_remove at ffffffffa0b252df [irdma]
>  #12 [ffff88aa841efae8] auxiliary_bus_remove at ffffffff8219afdb
>  #13 [ffff88aa841efb00] device_release_driver_internal at ffffffff821882e=
6
>  #14 [ffff88aa841efb38] bus_remove_device at ffffffff82184278
>  #15 [ffff88aa841efb88] device_del at ffffffff82179d23
>  #16 [ffff88aa841efc48] ice_unplug_aux_dev at ffffffffa0eb1c14 [ice]
>  #17 [ffff88aa841efc68] ice_service_task at ffffffffa0d88201 [ice]
>  #18 [ffff88aa841efde8] process_one_work at ffffffff811c589a
>  #19 [ffff88aa841efe60] worker_thread at ffffffff811c71ff
>  #20 [ffff88aa841eff10] kthread at ffffffff811d87a0
>  #21 [ffff88aa841eff50] ret_from_fork at ffffffff82e0022f
>=20
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definit=
ions")
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20

Other than the suggested-by tag being incorrect, looks good to me.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

