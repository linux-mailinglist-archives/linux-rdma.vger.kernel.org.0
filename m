Return-Path: <linux-rdma+bounces-25-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081A97F34E8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711E6B21172
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18D5B1E9;
	Tue, 21 Nov 2023 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx1Ih+Bk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37070A4;
	Tue, 21 Nov 2023 09:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700587511; x=1732123511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G46BJSCpBrGSq3byMn+ObGuP0nly+2DHUq42Yhz7UH4=;
  b=Vx1Ih+BkUnrqICwdqxhzHmC/fuGE6TR9G8r7Z0QX45LVXqfF2CQ/NDvz
   Zt2CLnW3HQArMwPw6ZFZQvfxyc+5rerEoWhxfQblA24G9hiNTb7IzMpW5
   aes9TFO6RMDMlUlokPnot4XjEeSsVFYOvuXBthYFu/B42YK2/YJYOPcjI
   y6HFQ9S2XZ19Rf/1LwoTJSSeK0h+A3+J6NroWOndmX5dHXTRIQ98qpBkS
   W4AZFyC9allQFu1yp9BPCKvLY4EbDtZG9pke3C3avDFztmrc9gGC/ry0r
   8Je3Bz61B4gXTqOTw2RDupuBzNKsUNqfkul3Xg1uHqiltjx17vDmonubt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372062764"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="372062764"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801604426"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="801604426"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 09:25:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 09:25:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 09:25:09 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 09:25:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah9AUmoJK+LVnxDVEw5dJIbMhI1INfMHNyM4UdU+xFePVfM1Q5Wi2GGkjQU3ZxZHjJU2+bglCVMBc0p9usYADRD5qJ/3c8ttfSbBQ7l5DUMSnQCjRALOOIE4JW0gepYQ+P+JROnwzYtfGbhUAsaE7XdDz3EJ+6rJ7iAuI2ViAerVWvKjoWX2bhxpQq7HBdP1FQeD8y6S8QE4rjh+sPUe0lFGugccyavqP2RtbtKGNxJGH4mGEk+3NU6ivOmoXDuJMjTUl7ocfl9tAXDQHXnfUCPM4DvkSWUaDhora+8gxcwG0rptbLRRTyp//JtCnXsjovgwk9fuOWTuUs+YUHqelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxJFlC2iiLvPPl1SX0fC3b9ywtgDA80D/Pj+Ikg7ZyA=;
 b=UOf0pkx/xBApvfuGArLJXmNJCw3JIEOQv+amgTLi6tdP2trzNCbwfOZca6iq+TctJGRW2AuoMQauQRhsuORvQcM+78lz74ZOyUJiA4plu1lR0lMW7McLh+m/eEpwxme6G7b6oAxL2acGgKxoRvXUvBC504hXgPNY5NHS+GHHlzawoJGnxft98/5zV7xt8+xlm/lqu9snE5OUQVviepFsPxDMLLoyvskds3Yoz8od6ZSUJL0jskblEXbY6OlvgHNJoxc6ZGMLdwwGP9IgMdv7jlRbsP3TBpfHtPX+dwZrWyYFAYS+n7yWNWN4V+Sj6cWiKU6vEAYIBfSlMulUkYiStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9)
 by CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 17:25:06 +0000
Received: from PH7PR11MB6403.namprd11.prod.outlook.com
 ([fe80::bd47:c87b:9c31:95d8]) by PH7PR11MB6403.namprd11.prod.outlook.com
 ([fe80::bd47:c87b:9c31:95d8%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 17:25:06 +0000
From: "Ismail, Mustafa" <mustafa.ismail@intel.com>
To: Shifeng Li <lishifeng1992@126.com>
CC: "Saleem, Shiraz" <shiraz.saleem@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ding, Hui" <dinghui@sangfor.com.cn>
Subject: RE: [PATCH] RDMA/irdma: Avoid free the non-cqp_request scratch
Thread-Topic: [PATCH] RDMA/irdma: Avoid free the non-cqp_request scratch
Thread-Index: AQHaG4wUKVhkHCy5pkCaG2ghLlOwKrCFA3aA
Date: Tue, 21 Nov 2023 17:25:06 +0000
Message-ID: <PH7PR11MB6403F06E4A2984375BF121758BBBA@PH7PR11MB6403.namprd11.prod.outlook.com>
References: <20231120083122.78532-1-lishifeng1992@126.com>
In-Reply-To: <20231120083122.78532-1-lishifeng1992@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6403:EE_|CH3PR11MB8496:EE_
x-ms-office365-filtering-correlation-id: fd2fa9c4-eff3-4ebc-bc26-08dbeab6ce3f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGmypu+EuX8AtvXuA7/HJyLQ7TIYFsvpF351UhamkA2VdfMQsfgAysMEnbfyYl9TygYDsbke19FitIWRyn/tPcHdAbm81F3xmw6HKHrqkFM3mrxzYhOx+EZot/FAy2Nh+U8n67rEl5yFV4gdqTuNOl+KTLpHsJbJpya0VLjkW22BcoQo2WfP1KmRvxMzGN8/bpF5P51dKDBWT64oBqc46AMNLcPyHoErNiMha9DpVxlC+/QEkcpJOuum6+H9DSVk4Bg7WkejNhenF+F2uoLDRWccvRgMnqJcqEkJpzmVX5EbL6yY4m7s/zG/B4yeYg2emw/SmxdnFXZc5ez6AFqRKChfFZc5vSNyp4zX5sBk1BeslmFyQiPu9Gzjc8uFFWEKambxpaj3VpxXf7qop31TnkASSoLAYkwoD7HpF4YRpNGAneTstCG8FyL0UmGQ0zkZOnuyng4nAFL4lI/ev59SC34s76NGIabWuZ4iXeRA3/iuCEs4XwcSOY1J432v+fGflSKRusl7Iv0y1shEtJ+MLpktVf/MbGq25+CVARokkiXHYwd4JM+PpxyP3KOuwGfXSIad86UbOSURsl80JAbDbGhpk26LvIxjeY2tkjip9wiVhnj2keORPjlzDxPYC3S8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6403.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38100700002)(55016003)(122000001)(64756008)(66446008)(66476007)(54906003)(76116006)(66556008)(66946007)(5660300002)(86362001)(316002)(8936002)(4326008)(8676002)(6916009)(53546011)(6506007)(52536014)(33656002)(41300700001)(7696005)(71200400001)(478600001)(9686003)(2906002)(82960400001)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8fBvvtCnZmM0LDdeafypWMvXiYOZZs7fQOiZdinEgnn0vUysGF2bXFBDKhv5?=
 =?us-ascii?Q?TMeJ3Xx26/1zFnWNC7Yf8xUBCc1cZQfulidlTleXfMBN+MjMGurNkAPLWfTm?=
 =?us-ascii?Q?4CUTKsnw/pDilbMbeQjquMwaeVyJptjMRiw9uxMEIMVffbPt0j8FJW+6KcaI?=
 =?us-ascii?Q?Hjc7nMiz1AWLBRXytvDZVcvz7QY5eRgGwQM2vu9Ze9zihm1onSx2jGQz242t?=
 =?us-ascii?Q?cR2DCs1tI2cgpwAe/h2A/zm/WncL3/I/9E1JLDn7WZItMcxRB8C3HoT4NMsU?=
 =?us-ascii?Q?4p1tQv9nRGSxQJsOSFzsKJvTQAQtzUG0QPK/hnlXOeWTDNC44KALhUj2i0vm?=
 =?us-ascii?Q?eiGBFnj9d6n/pbwrep0P952ImJ+C1Tz1ay1GrW1sWhLmNP5O37hnFrwdukgR?=
 =?us-ascii?Q?hU/BhrRVs0YbfYHW8rv94EMkHYT1Z6deWIvG54GQ8+y6cyh+HW31k5R3EYi1?=
 =?us-ascii?Q?rnGoRce9dVncfFyJVXsX6fqQfHVJaxrjLS//7bBY99IfEDecXQaU8ZW9+u6g?=
 =?us-ascii?Q?G3oo5UHrhx1KNrDVgwevZ4vnukwTQnmynic2mjxhShi3GpkeBFgIPXmHnxtv?=
 =?us-ascii?Q?rnCTU+WBwGxR9j9v2g7urrZ4YrZNGnaQhoTWxMWySlw6iB7wQNNl3vpuSCRb?=
 =?us-ascii?Q?k85xCl8iPMpu1z4pPW5YNeaBgGirdgr3gWd+Z0OGYqK41ZKH5QzoPlgoYELt?=
 =?us-ascii?Q?tW2kPMyZgE36Eui3fR+DbLbnfm3lZUoTsPH/d4SghIGz31YiN2ijQduFd+e1?=
 =?us-ascii?Q?VF8jnVz6Yh6Atp1pbSxrxNTyV8j5AT8Cz1MJOJtInbTlH4AlY4jMpQ27PkGq?=
 =?us-ascii?Q?0PgQU3Bck/AgfFSgD6bqCIRmddWr+jIuQEnztDwrBGb+ZCt4i7FlDUo2xoU5?=
 =?us-ascii?Q?OMG100/HbQqxP/WADUPOdImagawJrCzZwCkDclhJ/f9rxo20xVTsmsRy3+p8?=
 =?us-ascii?Q?yM6bwQYw+X6atc9YqbYV8ZfMj+LBeLgS4iZ5MvSzJ14N1jTlyEeF8XvD8dmC?=
 =?us-ascii?Q?7600saaYrHao0GLclgOq/T2MuIhR3Y1kdYoxOe+eRaG2496AlOf7nEVxcEb8?=
 =?us-ascii?Q?OJW5VmfSVfUvGwrNjUbBKjJbriYAGSAeUosQ4kp0j0WjBdWAc/hhQH2LCuz9?=
 =?us-ascii?Q?LOl41DNb7hvKUshlAAC99MMCGOcnn4uQPEp1phiZX6pnJ+zcZ5B0yQgjiuKg?=
 =?us-ascii?Q?JDO5vRx+V1MJqsZ3bTvK7gd2GBAIth02XTx8RU665JIvkPOKjdg1d0s5ORyk?=
 =?us-ascii?Q?Y2ulLN1NlLA0304fVSfGwQC/FaAT8ZXD5TZ/CypkXWF08eZQ6Us0a3lhBHsn?=
 =?us-ascii?Q?hFsI9KGo74iWKUY0Fgh/4UPLaYPfYn3ohglhJ7fkSTWvLvR3O5QDYTVURbd5?=
 =?us-ascii?Q?F5jTVGVZcj1cTWO3i2gxaASqn2NBQWU92L2V6/Cov6PhEJRV3DpGnWzoBN6q?=
 =?us-ascii?Q?6yIDkISDml6mfb+fkr7yrn082tezt6d8wveCEo1FkpjpiHSG6UZ/09YVBVYB?=
 =?us-ascii?Q?XB9gRYD2Wxic53fWaaxv5kqHAN049g2P56Gy4+OzlhjWdJd7oXdLonnIwNgf?=
 =?us-ascii?Q?4o7HgoMYsMpWrhhCiy4pAU6cDWgQEwHziDG+LBhu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6403.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2fa9c4-eff3-4ebc-bc26-08dbeab6ce3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 17:25:06.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPCPZHWTwbdyUw1NnTdctROOsmzxrKcMdpBPUeTnfEvhZqi5P1xeH0ZYOsrvYMW6SnVIdzpO69uMdbOeq2v6GfE0NzkzVUMi6M2T4DK8zIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8496
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Shifeng Li <lishifeng1992@126.com>
> Sent: Monday, November 20, 2023 2:31 AM
> To: Ismail, Mustafa <mustafa.ismail@intel.com>
> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>; jgg@ziepe.ca;
> leon@kernel.org; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org=
;
> Ding, Hui <dinghui@sangfor.com.cn>; Shifeng Li <lishifeng1992@126.com>
> Subject: [PATCH] RDMA/irdma: Avoid free the non-cqp_request scratch
>=20
> When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as a
> cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when removi=
ng
> the irdma driver or unplugging its aux device, cqp.sc_cqp will be derefer=
enced
> as wrong struct in irdma_free_pending_cqp_request().
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
>  #9 [ffff88aa841ef958] irdma_cleanup_pending_cqp_op at ffffffffa0ba1469
> [irdma]
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
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization
> definitions")
> Signed-off-by: Shifeng Li <lishifeng1992@126.com>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/utils.c
> b/drivers/infiniband/hw/irdma/utils.c
> index 445e69e86409..222ec1f761a1 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -541,7 +541,7 @@ void irdma_cleanup_pending_cqp_op(struct
> irdma_pci_f *rf)
>  	for (i =3D 0; i < pending_work; i++) {
>  		cqp_request =3D (struct irdma_cqp_request *)(unsigned long)
>  				      cqp->scratch_array[wqe_idx];
> -		if (cqp_request)
> +		if (cqp_request && cqp_request !=3D (struct irdma_cqp_request
> +*)&cqp->sc_cqp)
>  			irdma_free_pending_cqp_request(cqp, cqp_request);
>  		wqe_idx =3D (wqe_idx + 1) % IRDMA_RING_SIZE(cqp-
> >sc_cqp.sq_ring);
>  	}
> --
> 2.25.1

Hi Li,=20

Could you describe how you hit this issue? It seems like the probe would no=
t have completed successfully if the create cceq request was still pending.

A better fix might be to set the scratch to 0 in this case: In irdma_create=
_ceq(), pass 0 for scratch in call to irdma_sc_cceq_create(&iwceq->sc_ceq, =
0), since it doesn't appear to be used in this case. Is it possible to test=
 this fix? Thanks!


