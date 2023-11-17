Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BF67EF70E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbjKQRh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 12:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbjKQRh6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 12:37:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0CA5;
        Fri, 17 Nov 2023 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700242675; x=1731778675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KGLgtNHrIgMN3LLKDZ5Y5Kyfn+aGrz+haxx266iaAMo=;
  b=QEyHNZJoiu+B9sOC7Puf9ODVl0VZGd84Jjp/ZWJHFbjRDz3ZIQ1AXaIQ
   ZuUl4MoyArSbKn07izixj6lg67FlnR+QYDsOOXPWecjukCoROj9iPdfHf
   QdlrizYBM+ItnHQXgpk4wABPp3Brs4rkMFkXBIwAad0e3lOI8n0Yq62ap
   5L5YOwHdZ0nky4Rv/u+gAvkIre30Ln+hVmjc1ep0v3Eeq168EM0Hgj9ns
   B1Jh7Ox/PdLY71ebP6EGRNFQ3ACDFDLuaAy4ikOAqWLllg2rrt6mmQ9L1
   tBFuleFuP9RLIznRPDiQWGq5sEwiHIfk2cPMBybkzHbwwWKwiwmNuw9cf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="388488401"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388488401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 09:37:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="759228189"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="759228189"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 09:37:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 09:37:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 09:37:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 09:37:52 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 09:37:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC1KSCMf2GAPVr2kjZ0H7t2OUsI45Iwq9Kyskb77oWNjMEYP/NjBID3PO1G6UYv2wAUmOQpFYPXEkAGwsfcqGJnJlxqKO1pBkBPBowjv8ScVC0I4BBKv7LDFAfrEnN5xzkZtEDdK5eNh25Gg38ObTpzr8EMLYJ1yV5OF+SY7cY5wfFLnGXkIt6jJ3KjnFNJtP8FdKs/9WVZRWFoh4oqZv8kzfFeJbFFHccu1lo1RF9PpOXNexbelOPDitUlX7lUH0d4Z/46L+UIBd3JBloA3jnbeiWIFxXKYK2m+kC1MHbCAsjdKFlbuWPMCM7kM2HZh6tXDaRqomQ1p3OG9zwGT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlDezLJ70+madNT3LeNCQAqNfPGGriVrQQ94c1MJwZc=;
 b=RHZTIBhy21KN+mOXvWdlcLTw8gDo1QG35tsK4YS2qLHzZUtFRhTD7YelG5fE5n7BzmT5wvHRrpYvoOH8LpjNa5lNZb5FS7dgVOplmwZLn6YTgJg4dN87evtwD5pn8weB0q6cCE3bco+K7Fz4QnOxWQyqqk8jDJLnn1Te1VVmarBt8PsGc6IRkV1JfcmprvC90iGMkh5q+ujAECHg560+Zy3sFBYZNHg7NaY8AxMX39x7uygO+hq7gs9Z38g3nXd/4Ds9m2F9YliH97CXDp29Oar3q3iMPvLlbbH52gcu924/Y2rNL2zhpdwMbgPcptCqkgO1SWxsUGkrMD5h6cqFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 17:37:50 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5%7]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 17:37:49 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Shifeng Li <lishifeng1992@126.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ding, Hui" <dinghui@sangfor.com.cn>
Subject: RE: [PATCH] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
Thread-Topic: [PATCH] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
Thread-Index: AQHaGSJxg+35xx64yEWIe5/VQm5WyLB+nHiA
Date:   Fri, 17 Nov 2023 17:37:49 +0000
Message-ID: <MWHPR11MB00298470BB2C1542CE0D008AE9B7A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20231117065043.3822-1-lishifeng1992@126.com>
In-Reply-To: <20231117065043.3822-1-lishifeng1992@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|SJ2PR11MB8345:EE_
x-ms-office365-filtering-correlation-id: 84ce9881-0d62-45b2-d367-08dbe793eb57
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YvhyEwysN9X6cZx02TEvfLSAPJG+bOujcnuPNLuGOVQFVdaE64UZJ5C6N1qOQfVhabMa4K4B3T4dhy7bK0MbHla33UmwJTP/XF7+ZOyGfXR2jfVcXpM4kat1wOWxaqP4Epl/98sCiWJBF0+MREYND2WhA8AKEFb77U4KE9lek7yvGOXoZgquswbRiS7fx1iIFkMOvSqynRcElvlAoDOklt1Ywuac8HYLa5sqKDmweS2ZoV8hlKrZoDc8j5kflLUBi9wbDcfGPIlltZL6ujGoOcwS3gQaSbqDMU7vfmRVl7M3Ax5Nohu/ZLAHfUTKgPG+axtMSzgdszXnXeNWV0dS1euOZ8zzZx+agRB7bqtI0Hnj4xDjpqOP0s5yGVgyMKc5QQIRCVZf8kjhXvnh1lg96UGiDIwL/kZE1QkfbD/zIAEvKgs8M+JdPNXXg9w4keSD35tCDm3+0OUUdPAZzh2XFNG1BXRLdy4CDDhAiFf3uQer/MV0X4J1I83ysXZs2ujhFvEmdP1NaQTnLUjv+4nuexgoub77ttn/fZuEsIgghFRzM1y/QpMWbwqd7BqFpThWJSjLKKQ0j4IyHnGBOD3KvW7at+krYA58KMXAEyjr5hvt6wVByNx4gsvEmYUsRgK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(38070700009)(122000001)(55016003)(83380400001)(82960400001)(26005)(9686003)(6506007)(7696005)(71200400001)(478600001)(5660300002)(86362001)(4326008)(66446008)(110136005)(66556008)(66476007)(66946007)(76116006)(41300700001)(64756008)(54906003)(6636002)(316002)(8936002)(52536014)(8676002)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w5CpDy4/ffxElzx399k4dEcl+TMZEtepfl7Cd5WeSLmJNEWpUU0ecRMrl5rd?=
 =?us-ascii?Q?S4496AtHQDhuukCm4Ya7wvVDpFggs6NIZfeuyb9NBTLa4eUPF52/1WiBOhRS?=
 =?us-ascii?Q?X238BOcGwHpsGbwMecfIswnuSHACWZDGI6uwYHt3LL8ZC87EQ6QX0o2K6CSe?=
 =?us-ascii?Q?JfwkuS3MQX2osQLSPDyqGSlqQbVL8rHe1jRlXOzyaE0iKJnSfO6MgrLzOoAb?=
 =?us-ascii?Q?MqXP03MG4ZUfbKVmvYQZQLAq85efmO8t9hhm4jILpXzlkXwSBlRQMi8jR6gA?=
 =?us-ascii?Q?f66eoIMoWuguHPTMudtVUjt90DlEuhGFmlPHoSuE5Yu2Ue4XIurvw3Nte7/r?=
 =?us-ascii?Q?zLYUWoLBc2qRAUJ3HkQ6b2kuvoABnY+VKp9mqaof3u1t0yO4hvnv7VOfpZxn?=
 =?us-ascii?Q?J8z6WQoTipgKUZT0kqSCBumNb8xSOe6ZX9crWVRbtmxA1B6txxSZH4Bm9RXk?=
 =?us-ascii?Q?tEnOoj9uFKdh3rwm57pkRG+tq324BTwxYp0glpeptjc1JJGFDB40EZxm4jNk?=
 =?us-ascii?Q?yn8vvYyQIu5anyojmsrC4qkBDgGYvAmK/8/vykN+DSq/XCYQks/bc2P4Hx4H?=
 =?us-ascii?Q?WAAERD/FuC1tiq1jfI1lVImqGKsJFxtmDOkg/VcFjxH7cygfJymmEMBgIN19?=
 =?us-ascii?Q?zBA09L48RxD+633Q7rm5/Dp5ffO323u7pk3YcjqqsXcjthO5Zi2wTRTNzxa9?=
 =?us-ascii?Q?U8MgF4riKU2irk/nu94Jm6iziQkcLBwVSnkd0takltYbtn5XxAl88tGNMiJh?=
 =?us-ascii?Q?szlebbFNzstPWa4WH33kkQSf+8l1jyI0CYvseN/VbFn9U7ZJAKmkVL9lb/Z0?=
 =?us-ascii?Q?etcXobv7yxa4HixVOjYKdSX2lUyxuXeKfrrITmy3IXLprjfYlrpvvoxOgfY7?=
 =?us-ascii?Q?VKZDWBTdnkIAoVCYrcKVyd60eIJ0GZygpAeP5PlGWXNfpbw+7KUeywMcWiCP?=
 =?us-ascii?Q?/p6j6/UTVn9Mx22BO0jTms/L0XhNqLqyDY8exBR8BWR7Xg0zYEiEqRdxdFar?=
 =?us-ascii?Q?ytc8w2i5s2/6C/VgjaDxHUy2GcMxaSwJaLWqwFXJJoKa6fRmNk1pgE1JKF7e?=
 =?us-ascii?Q?J1jaKWmaRhqG/tvzT+hrugpW4QpXDg/5OnWlg8wizHjAsvYhSjOX0ikZTwqG?=
 =?us-ascii?Q?6D888vgy81mScnOOFRsgJNjwH5W0wOIc0R8SoSvoR2JUPsUIOFLsZ5zBdV1C?=
 =?us-ascii?Q?pYSIUY3OY/JdXvY29morDRAJa/jUJCp/DiS/OeDgIMDB5DvQeQORpzHNDhi2?=
 =?us-ascii?Q?8UQ+3tRK2mZW93nWdpAxspwHKaOExuDqagEuDb+oFXZxoBPIU2lSO61Iak7J?=
 =?us-ascii?Q?CHBUVIapYWeUeZp1tAwUzuSxLwj7/ysYjtCPm9qmcxyU3jINeSyhdqeeSaBt?=
 =?us-ascii?Q?uJOglc8r299zMvPHrX84cU0Of38FEiIqcc9xItPQPfwcPiZdwvS7KlUUVji9?=
 =?us-ascii?Q?zgcfaOTCNcDHGdkJI8zW+Rrkv5zANvEN2Bo9voNgv8q4ApYsTTiJFIgWCAzI?=
 =?us-ascii?Q?SzKwmms//JSJQYBkBSMmVl5VE9OUkwx2uneam5YLbtiQBqDf+Ym1ZzChkmhX?=
 =?us-ascii?Q?dz6Ov4Sus4rXRw5rHUYYKjLx+uwRo7CKsUH98FHI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ce9881-0d62-45b2-d367-08dbe793eb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 17:37:49.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBKTXFfiPNvnpQqD9S3bQaKvEhf4REO4HfWKyXG0gKcki3Mpv3RzkZ3L/PO7UUKxnFSXLZABDDO4ungEToiBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
>=20
> When removing the irdma driver or unplugging its aux device, the ccq queu=
e is
> released before destorying the cqp_cmpl_wq queue.
> But in the window, there may still be completion events for wqes. That wi=
ll cause a
> UAF in irdma_sc_ccq_get_cqe_info().
>=20
> [34693.333191] BUG: KASAN: use-after-free in
> irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma] [34693.333194] Read of size=
 8
> at addr ffff889097f80818 by task kworker/u67:1/26327 [34693.333194]
> [34693.333199] CPU: 9 PID: 26327 Comm: kworker/u67:1 Kdump: loaded
> Tainted: G           O     --------- -t - 4.18.0 #1
> [34693.333200] Hardware name: SANGFOR Inspur/NULL, BIOS 4.1.13
> 08/01/2016 [34693.333211] Workqueue: cqp_cmpl_wq cqp_compl_worker
> [irdma] [34693.333213] Call Trace:
> [34693.333220]  dump_stack+0x71/0xab
> [34693.333226]  print_address_description+0x6b/0x290
> [34693.333238]  ? irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
> [34693.333240]  kasan_report+0x14a/0x2b0 [34693.333251]
> irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma] [34693.333264]  ?
> irdma_free_cqp_request+0x151/0x1e0 [irdma] [34693.333274]
> irdma_cqp_ce_handler+0x1fb/0x3b0 [irdma] [34693.333285]  ?
> irdma_ctrl_init_hw+0x2c20/0x2c20 [irdma] [34693.333290]  ?
> __schedule+0x836/0x1570 [34693.333293]  ? strscpy+0x83/0x180
> [34693.333296]  process_one_work+0x56a/0x11f0 [34693.333298]
> worker_thread+0x8f/0xf40 [34693.333301]  ? __kthread_parkme+0x78/0xf0
> [34693.333303]  ? rescuer_thread+0xc50/0xc50 [34693.333305]
> kthread+0x2a0/0x390 [34693.333308]  ? kthread_destroy_worker+0x90/0x90
> [34693.333310]  ret_from_fork+0x1f/0x40
>=20
> Signed-off-by: Shifeng Li <lishifeng1992@126.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/ird=
ma/hw.c
> index ab246447520b..de7337a6a874 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -570,8 +570,6 @@ static void irdma_destroy_cqp(struct irdma_pci_f *rf,
> bool free_hwcqp)
>  	struct irdma_cqp *cqp =3D &rf->cqp;
>  	int status =3D 0;
>=20
> -	if (rf->cqp_cmpl_wq)
> -		destroy_workqueue(rf->cqp_cmpl_wq);
>  	if (free_hwcqp)
>  		status =3D irdma_sc_cqp_destroy(dev->cqp);
>  	if (status)
> @@ -737,6 +735,8 @@ static void irdma_destroy_ccq(struct irdma_pci_f *rf)
>  	struct irdma_ccq *ccq =3D &rf->ccq;
>  	int status =3D 0;
>=20
> +	if (rf->cqp_cmpl_wq)
> +		destroy_workqueue(rf->cqp_cmpl_wq);
>  	if (!rf->reset)
>  		status =3D irdma_sc_ccq_destroy(dev->ccq, 0, true);
>  	if (status)
> --
> 2.25.1

Looks good. Thanks!

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>

