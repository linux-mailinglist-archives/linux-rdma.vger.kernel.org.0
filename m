Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD44505B28
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiDRPhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiDRPg7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 11:36:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E0433B7;
        Mon, 18 Apr 2022 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650293829; x=1681829829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HQFSbUqZXurLVsirj9RigvMFn6YtZdalSvFWYOQnStk=;
  b=BmDFIWuLA4hU74Wvvd+KF2Bz8WqoUQJsdMsNprW7qxDc4FG3sauunULf
   Ipu1Gdo7eUGvk5SJiuxtg/x11lUC8ol69E4wf3Z6S2r1nXCqa5NI5IaX9
   kBefBLk02wF6vtIbaRHJd/gn+iBQomQd8TLBabb1SRj7kfEKmYEJaCMUY
   fWXZ4r8MYLqdkpTAyoI8nJ/t3eXTwhU7MSlUBd+twsnPQ9vDHNwh5YlH7
   N7feipqpITzpGfIWrudUUzxKrJYH5e2GVE8LTQvPRTHT/E3CFa9AHjuEQ
   hejt/ccNuoFBmVxsfLgxlA8asIPPbNydKU0PJ3oVZ7/3eFKF3/nhOTEo5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288622678"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="288622678"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="613633155"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2022 07:57:09 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 07:57:08 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 07:57:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 07:57:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 07:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWNLmugZqRB07P4Pzxdeu8b6Sl7M4VJ82bcGXd/hcMPEd0czcJiFxtGcnomV3i2Q5TlyQ5EDvjghiVgoOMi8s2aK+6Hb8BpdzevbG0mFYsy4uZgwYCHcBxQt5F+G+SuobhOHZePU5mEi+ZKh30Odkvt27tNnqDGXaJvhRuTMdAR8kcDCJo4TdgZ7rrO3n5ypHy+XVXVa6RHN3Lx+iUdlTrww5Wo0getVm1gEslGUO9dT+0JVsONg1vU8R8z6cAKTouaBpBtmU7/tBUmVcS/kstR2ZOrxDjMMn1owXYgWXiOyJmAYCAW0+uDKfy299e8Wz0MJUU3lYjt2YY/bCoy3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Vzy2/KG0gsWa3QYONKFKBNYIVfdWiMYNTAVDJbNZc=;
 b=EVjGSghCKMrz5NHqYpCXe/nvtQ18H8d6jv7+FqyQUcEZDmq7r6FJO0FSALzGDl0jGLUZVCLo6zGo4HBand9K5wpjDYlulQUA2TwtH0o16T3CMZTQo9j3uRDvTaJbhLm7UhYVN6eXPREPlH/TRUPrSbxxcPQrpl6es9Tahvz8XgFXqjThdHw1moaHW8TelBsD/+GWV+qYzaLMmVvT1+L24NQvBeg9ndhHSXQvVCHGVjC1b3//OSztgiFsh2Qj4GZkBgqk7ramJNo4VN65MFWDrMkf3VMRAi0tLYSTDY6cpxY3a7oEcK1GA8kIZTqxVhIQGcy4xMEQCQWl3HzJ6dtIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by BN7PR11MB2740.namprd11.prod.outlook.com (2603:10b6:406:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 14:57:06 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a94a:2e9c:5d29:e1bc]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a94a:2e9c:5d29:e1bc%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 14:57:06 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Duoming Zhou <duoming@zju.edu.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V5] drivers: infiniband: hw: Fix deadlock in
 irdma_cleanup_cm_core()
Thread-Topic: [PATCH V5] drivers: infiniband: hw: Fix deadlock in
 irdma_cleanup_cm_core()
Thread-Index: AQHYUl0X7fm3G8cR30aQTmxnyZcE/Kz1vDqQ
Date:   Mon, 18 Apr 2022 14:57:06 +0000
Message-ID: <MWHPR11MB0029A6F789272ED3AB28F0E7E9F39@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20220417131414.98144-1-duoming@zju.edu.cn>
In-Reply-To: <20220417131414.98144-1-duoming@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68deaf04-fecd-449a-629c-08da214bb4c3
x-ms-traffictypediagnostic: BN7PR11MB2740:EE_
x-microsoft-antispam-prvs: <BN7PR11MB274078982D395D8195A40AE0E9F39@BN7PR11MB2740.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ah/bKb2HZqB/o8CI6PxBY0FWcYfdfyaYAgeiT3PZxZ0NseXXK1bEQ3BMkfNBAC8NUDIB9mZAV0zaRaktsMfh55gQ8jNdGdBtihJhwJsdPy0x5papvUPNyFGy3tClOCW9Brdq2uDiqybdhUcO7yA5WNn48fsHlCBqqkCR7bPTSS9ZSdW7uVx4ym/bjFQw8MqgPmzWgpg7IYF3G1iCrxbtw974QPGk23SCM7J/Ww1nAyRzQAnTOvIvRcDDzKrT6XH36iOT9CRTcoEx+dhKi4tGQhU7E06IAW7byaAOP5WA88QapeQWFUqGuiap1SdIXcf+0dg4d7ZvbM5xFW9MxtL3LOz2NjcfuuyTTBF0hjY7uzizKZQQdXFWZmpMQS80XwmFLqMKee77WtEcUFcZ26dyaCeT9KWqWR2sYZ15wQQjrLMSA/gQDA5zxm/Qys0V+TQB490gt1ifWoFyofhr8FdY3zYwzNNYhMGmBFWntwiTIOkaxmNpgmte0hc1tgOZ+V4ibcMN5GnZRHEnazmXUxstnBLzbBLt4S3WrRjp0CZem9f1A6rtvJkNPshgGyuP/CNUd/im+lN+85dhQSP1HzqGK8UL3QZpakR8bziJs8Lfo6Nbmis3fQydvY9Rcn01c6C7ya7Fcsl6hG4oNBqszS+z8F+ZT4wXD/RWTxT1pWlvBYtbVAqlKUaYoWEcj5TU4RL3MwmwigUFRR97e+7MxRjFQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(9686003)(33656002)(8676002)(76116006)(55016003)(83380400001)(66946007)(66476007)(66556008)(6506007)(186003)(64756008)(316002)(71200400001)(66446008)(54906003)(26005)(508600001)(2906002)(5660300002)(110136005)(86362001)(38100700002)(38070700005)(52536014)(82960400001)(8936002)(7696005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?akNNRPbi9s5AQ4E9BMLzxNR8LWMbXwGd5eTVPBIQtSDjGbQT5SGw5NhIqE6X?=
 =?us-ascii?Q?zGAbIj1wgV0hJhhDovjOxwq+c3cPm6IlrueD+U9+WoQDIU0UAMfD3cvgKGWz?=
 =?us-ascii?Q?ab1ofbKdqb/hyJ9ZwBl11ht9tJ268+VeSwRSGHLwfX2VOgoyttnKDoS8fZG8?=
 =?us-ascii?Q?vIMmVIAFstP71wCXQZcHHPNzKk6h9YpRCDKooBa9+nDk1TsQRPtEjmy6xUJJ?=
 =?us-ascii?Q?Zcn24nzHXpkbq8kKJeLNQ/T+zteSVT/Tb+YH9zwjXm3MfJpqql5MWe0pr1gY?=
 =?us-ascii?Q?DS3C86+7P8vuNd4kTw2FEEz6jeEq0/xX/r4E6HNMc7/tavcYHMPRrjMSb1VX?=
 =?us-ascii?Q?iDWrjtXmzAMgaA6h1B1yKYe6sQMByc6pS2+C8MeDHfomuCVJeYL8qrWp8W/S?=
 =?us-ascii?Q?tp0J7vWxhCnzZuF4J4i36xtb/wTySXWRaO60Yfp1YcqyGNSD5+9X5M0Dra57?=
 =?us-ascii?Q?VIgrLRckjYT+wHFhpKjIAiesFiO2lfYuG7Tq0Ddg7UNEoUXB2/4m3Y9PHp7C?=
 =?us-ascii?Q?tVVZXirzZquMnbrZ4E5t4DbbDUyMnppeZtnNeaOq1BywBmHRL4lz4tk6Po1U?=
 =?us-ascii?Q?j7NSwdasXW7dG2GO28iEyFqad1IDP/sf1Y2LODhtiB7ffWioPABdHf3QWaQO?=
 =?us-ascii?Q?jBB8QjT8bMC12NyxA9GmDy3cmbUNMIhCIwnXdjdk2WwlWQelH/4vKG98Z2F7?=
 =?us-ascii?Q?kpTSbztQv6h0zMPr9SvRgDe8HPJKy25yO9yIFWgV5zF6vOBBGINt/uLrd2a/?=
 =?us-ascii?Q?sU/rg7faKxDt8yKi4a1OzJgMbFfpXvNF3V4558Fv88hcRNe9uWpb+NughQCa?=
 =?us-ascii?Q?gRJr0KetOeyQ4iA3uMyrqGeJmo9bhfo0dH02oylhJNQGxEmuKbT/ET/59Q3Z?=
 =?us-ascii?Q?FdGoLZy+TyI635UUHymNNTaViezpQ8EogFI7RqKHBgentx94H/Zzkq3Pv+1w?=
 =?us-ascii?Q?C5HCVVpA1+X7Dr9/4/Hzj6nrEZI2fSLfmuPCW6vsP6zniOzuUYB8itQOjL6i?=
 =?us-ascii?Q?YRsItT20+4Xn7iJ4+Sw37GjpMYseeIbWn3YoLWA5mJY7+rL9xPPORMSNnGI3?=
 =?us-ascii?Q?82RhBszDFa5YokrcChmveovLRmSPUy4J3NZSih6hXuex9j9W6XZp3uTlWmCg?=
 =?us-ascii?Q?VYfFt1II4S4Q8vxY3CFxxwC+kWaxZ0dDBv3vFNCWoR4Mx17Gw6hlO1XQ+b68?=
 =?us-ascii?Q?ufmfVSXVmToCk0Hf7PQ7TfRWF6LfUgC5WOH6MRqshuD2Enw/gxyk+wpV1CBy?=
 =?us-ascii?Q?H0fFQCbn2Xe8Z35n40fSe+plDKckTj5fn3ynHT44nGaDHkJBVsKDQblAm49Y?=
 =?us-ascii?Q?24KUmC5vz+XfnFLlS6uGUxr3n1TCSxppdzzZujCYq5ZT4ltTzTwlW6Fc5QL1?=
 =?us-ascii?Q?3Mbfiv63LJfvQc8K/bbw7d7IBteH+LDGwKP41hnGxXNbSzAS4ClYJija6CVG?=
 =?us-ascii?Q?HVt0Zbe4WIEceAnMUAVjlgT/01o+QgsgUsTsMvFht5LQqPv6dG50+NsJjYP1?=
 =?us-ascii?Q?89imlRxp4O28TBOYj1e3SBrPO9XhA6nZIhp8/nKGScQ9lOMnMCh91udCKLXU?=
 =?us-ascii?Q?k/mTbRZv6xPZwQUtiSxIP/ufvnRi2C5zkWJu69nMiyxO4O+Rp9oSqEMJnHcT?=
 =?us-ascii?Q?UghXk++VYvb7bex8aHaBMK1bXmHIeDsdwKyfr7mT5KuaaE7uvuCQaCnypPcK?=
 =?us-ascii?Q?e5ytZAZK+xiLQoYKWHmdZce07Eym/b+wEKr4+Z8aZxclkwzVCSU9cRH625z/?=
 =?us-ascii?Q?eD5WQYYzWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68deaf04-fecd-449a-629c-08da214bb4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 14:57:06.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4e/BiOKVjy9ZpNM/FvvPoY5shP5+yqvveN/mEBjMP+fauyP36PEbrwTJBUnS5JrOCVC1NJbYCWM/QLfYZ0zlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH V5] drivers: infiniband: hw: Fix deadlock in
> irdma_cleanup_cm_core()
>=20
> There is a deadlock in irdma_cleanup_cm_core(), which is shown
> below:
>=20
>    (Thread 1)              |      (Thread 2)
>                            | irdma_schedule_cm_timer()
> irdma_cleanup_cm_core()    |  add_timer()
>  spin_lock_irqsave() //(1) |  (wait a time)
>  ...                       | irdma_cm_timer_tick()
>  del_timer_sync()          |  spin_lock_irqsave() //(2)
>  (wait timer to stop)      |  ...
>=20
> We hold cm_core->ht_lock in position (1) of thread 1 and use del_timer_sy=
nc()
> to wait timer to stop, but timer handler also need cm_core->ht_lock in po=
sition (2)
> of thread 2.
> As a result, irdma_cleanup_cm_core() will block forever.
>=20
> This patch removes the check of timer_pending() in irdma_cleanup_cm_core(=
),
> because the del_timer_sync() function will just return directly if there =
isn't a
> pending timer. As a result, the lock is redundant, because there is no re=
source it
> could protect.
>=20
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in V5:
>   - Remove mod_timer() in irdma_schedule_cm_timer and irdma_cm_timer_tick=
.
>=20
>  drivers/infiniband/hw/irdma/cm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/ird=
ma/cm.c
> index dedb3b7edd8..4b6b1065f85 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -3251,10 +3251,7 @@ void irdma_cleanup_cm_core(struct
> irdma_cm_core *cm_core)
>  	if (!cm_core)
>  		return;
>=20
> -	spin_lock_irqsave(&cm_core->ht_lock, flags);
> -	if (timer_pending(&cm_core->tcp_timer))
> -		del_timer_sync(&cm_core->tcp_timer);
> -	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
> +	del_timer_sync(&cm_core->tcp_timer);
>=20
>  	destroy_workqueue(cm_core->event_wq);
>  	cm_core->dev->ws_reset(&cm_core->iwdev->vsi);
> --

I am not sure the deadlock is possible practically since all CM nodes shoul=
d be culled by the time we get to irdma_cleanup_cm_core.

However, timer_pending check and locks are redundant and should be removed.

The subject line for patches to our driver are typically prefixed with "RDM=
A/irdma: "

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
