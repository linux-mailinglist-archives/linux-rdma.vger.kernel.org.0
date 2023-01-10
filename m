Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F4663808
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 05:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjAJENI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 23:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAJENH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 23:13:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE37DF36
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 20:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673323985; x=1704859985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z6lRYb1AMC0/YV0iqaOGv5Eh9YLOVG1RaQVms7gthGE=;
  b=h5Nsu6bJsrAwEl5NEzXauAnFc38VBUWBDH2X2Q+nwnMhDpP0RHfe2e5X
   TXAtK/5hz7Ku2mX9SLA30Solr6KETPU/K3w1F7jk/V0PQ3gFQfzRfFtRv
   AuzX4TLkRy33IEh7Y6AUVV1KQGHmxL6/9Tm1pluh55rdLw7Hx3/cAXyv3
   zFM7MbrpYe2iLFfW1a2EJRPSRKFrZ3HZLON7UaoNBcHfhJI+XrFHyJC1G
   tERRkIWv3mqTi5Ol5wfqjY14oPE6y9tGvOjCL+Z2Wf7dq5oYVdV1Yd1eI
   IXyX/erBowdszpOoP3TYy1vbFl0so8e7y13ZHnRXjlyndiGStM0eL1Cf8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="325061347"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="325061347"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 20:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689281978"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="689281978"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 20:12:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 20:12:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 20:12:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 20:12:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 20:12:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBKZUWIab9mXWsgbRbQGLirHVu8gWn6Hrro6aV4Y2l352ce7Buw+izD8THvBmh4wPM6Bg4iTCBzD8/Hh3ALOafKDoHLTXtxczFzfOoItKe7QstMAnls1BKpbtYZdjBp+pJSZZv2jipMTS1hVb1Y/4W1fD+p0Aqtc6OKSeM24tHOiC2fTL5N17oHCCV/RA6kYBT1KAkrWOdW5TEMqNM2n1FBMmVyhIfXkdVS9mJhRGj7cHAcPtQKlqXPJwhE2Rs2QULzyaLWBKXwdAhM6d2OE64IrBIP+l788GQc8TwyyWCVTdjLyajEnF6ikO6KgZtxCCuRZdaHWF7qHNGKhJORQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qERizKtSwpDX0QmJj5cszVma7uUJAGFgROifawhfe6Y=;
 b=jp0FcJSb2RLiZ18qw+CzM48zvTDVhB/lW2W7P/JGvMgzRlUoZ/h2oEjnx2tgZGml7yatJ5TuVz5UL0/38/VsKBMtsQ9byA+fN0xHQzzFz34a3AHZn+W8Sl2OQubWdIdx8Laj5TAAXQOZF7nkS2rU5LTQQewdld8kS6RFJt698srT9sYEtWi6pqS4fvSxf5L5AmQdPlx/v8Z1HdXRudkPpbuhY6f5ku87NC0+WOTh5kRxRuLg1NBJHbZwCROb17Q5ZHOKPmUk8ydaC4187/LSdBm3gIMOEHscMA6pJYxJkr1EJFLNBZZbJywB+hGr0wsENTmigO9NnwrMvu2y5nGSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DM4PR11MB5407.namprd11.prod.outlook.com (2603:10b6:5:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 04:12:47 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 04:12:46 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCH for-next 4/4] RDMA/irdma: Split CQ handler into
 irdma_reg_user_mr_type_cq
Thread-Topic: [PATCH for-next 4/4] RDMA/irdma: Split CQ handler into
 irdma_reg_user_mr_type_cq
Thread-Index: AQHZI9pLXMcGNaSHh0i3X6R9kdgR2K6W0xcA
Date:   Tue, 10 Jan 2023 04:12:46 +0000
Message-ID: <MWHPR11MB002968ADD8E903D7ED9F84FEE9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-5-yanjun.zhu@intel.com>
In-Reply-To: <20230109195402.1339737-5-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DM4PR11MB5407:EE_
x-ms-office365-filtering-correlation-id: 26fe7673-e010-4980-5336-08daf2c0edb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eqp/UEjSNXT1RS2tYGwzzZ8WR5P9zAOrfC59tOKNakfWz1+Wp8qPaSKXYqs2kxKiSBrmUiGSw3vt+peeJsoenw8JeJu4M4LyfRrxouESJcMvj8CpnRa6ItBUfB9DqmJtV0wyhhCpC7e1zv/ARKJU0jXNJalsjUOsinYSl7J+Yz7CspW+h6Ouvso7obmMP7lhrPESI4XB72OOjPobc/aeca2dwR+CMIHxOLHVyUU+/Z+LHmjk0ldBUTDN/mfoHhIrluS/dMLcmLTKZqiEsEQp0FpV4WKoiaK6OH3ZpXKUt3Ig1IG9GXvjl0Jl96WHkyARUx3eL5FPzKol0dvnaULdVJ6CQ1xGOteW06Jj3czIJ51IENXLG2UqjLPyKDOyLMc8DzZa8Pw8Qj3vsBRCWYwPJKe/61duyEItyQYt+dAK9hYlcpq49R3kEXUdT0DnoZUGKJIpGWt9iiMhN+QFLd1bi4/dafbK/B/yXOKLpkO2Za/m5FaMtOGZ0T1waMYu5QQlBbEy1orG1DTOu0xeGFgELEKjUF66UoSJc+qAfGprXhuQwr+zUOajYrgHlgyWzhiKgxKTVF6orV/T5Ny3LAedqT99AiQaq/XuidLhbuXiZO0EvLZuDYOiQXdAbts7ZqLQ0RPNWrVzYkGi9NCdRaaWArUAeSTINB7yIU3ErWUSUfIGuSdU7s9++R3tzo5OuL6WbP60dMKUbztozlEEWo3yUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(66556008)(4326008)(8676002)(64756008)(66946007)(66476007)(76116006)(7696005)(316002)(66446008)(110136005)(38070700005)(2906002)(8936002)(5660300002)(71200400001)(41300700001)(52536014)(83380400001)(33656002)(6506007)(82960400001)(478600001)(186003)(9686003)(38100700002)(26005)(86362001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nGQ/lRQXBPsmTvjD+yK8ZwFOE+8vreurB7fUFId/nt4I5ItFB+HpEUX8wdtu?=
 =?us-ascii?Q?JBYUdBQxiZ3pvGjKms8LdbmrJDQITNwWZp/RGxbqshq1mMv+IdgFcD8f3wtu?=
 =?us-ascii?Q?rFJhqZJkNOS3qBWc/D6xPC9Ylkk0Vr7QbKhAS3+Cek6Q1D6AH2/EXbhJyu3Q?=
 =?us-ascii?Q?6v7aGxLWXy3H8KKCwSOhwUBIkZGBBlkK/2l21HmO0nHkwTt975/myyGyJn9h?=
 =?us-ascii?Q?Sd/15NErr+CCZecl3BSgYsgW909otRs7JULP8GokWOwMvsUU9kYhEviG+Atr?=
 =?us-ascii?Q?envMpDbpAeYipCtHX1r6dL7Xdk66A/qs9XuoLQp8Fjf6//Mg1LhXheyLqVmi?=
 =?us-ascii?Q?f3tajCyuyrpK3FczFFC/f/XtTO/aENarZk/SR4te4qLukM9RwOa7mjQHkImv?=
 =?us-ascii?Q?gJ4upIyvaJ4IY58W4z5UrAqpzN9qC1uZjFReMkMGsa8/sHedCEs4MDv8I5rV?=
 =?us-ascii?Q?jwwxmCkl7hNWSpdnqzd5JyWLF6/ftjlhvyTXz3VHWgUrOw/Um0KX97KIbbm+?=
 =?us-ascii?Q?8sqRevZxCdMorT+D+89NUwU0G7n1Mq61UEuFSROg+jw9PVPPw2kU68zwgnJQ?=
 =?us-ascii?Q?L1tR+3PZ2og1yq2PXu2icKoBqLr5EvxXQX1sX/QdcrcyqVxvw61eEuTPeb53?=
 =?us-ascii?Q?buwcKjjJIaUKJbAUyzVOJ1ihpttXKvlnnMEKdj7Yjuie3kEnoz7hV/2sXvMT?=
 =?us-ascii?Q?h4mrwx8pK1Hu1ueDAmk6YseFLLWShCA47pa+ESWS84kfnWC14KmQjaAHzC0O?=
 =?us-ascii?Q?fse+LOV+r77k7MbC7eFbYCamuEWfq60pbnT+vm9AHMegBaYsLqqpRbyicSsj?=
 =?us-ascii?Q?wAqoxMg3wwBf36RcM9q7ndPMtciBOu+SeZHegQb32EoR+0cJ8HiJtCXwoheC?=
 =?us-ascii?Q?poWNo2DdLFKX7LyPoHypxIv03V0Xvgo2H07AYK3mMHxnbc7dkdUxAt1sZz7z?=
 =?us-ascii?Q?dKVy7AHfG1dSU0ayyljRUCEhZAEE3WZopjy0gQg5h63oLQQQjBiq77YNPaoB?=
 =?us-ascii?Q?fv99QO4+xfeaZm2mtwQQewNDHlsOdeNksf2qWD0hNE9Ye78I1SKcWMeg9qGx?=
 =?us-ascii?Q?58w0n0VO8glg+s7SjOWBxIaWSlqLg+XI6TpAyhG9XZKit9qaBc9/4Lt4jTT4?=
 =?us-ascii?Q?erOEtEzf5wR3Z2wlMC7GZalfXC/KTdh2ugUtuY83h5P3qhJp6qqgFD+Bs0O4?=
 =?us-ascii?Q?B4qS7dWSZvC+WsyZkvJ296xpIq/5gUguazmBwqujjvKdgznP9h47TMIqCaGk?=
 =?us-ascii?Q?6obbIIbSSFwRntHPGPchPDaFY6gj/P1jgHvZpI1arrMWkVh4LnBa0BXKpnDq?=
 =?us-ascii?Q?KP96V28BQ4L/N4zkXgUXQnFh1twkBRgr4FnOZIsa3jZVlZbbkI3i5tvJmHGx?=
 =?us-ascii?Q?xkV57RQgyzYgd3VYuf4YISmnMAjXnF/p06Ybxsy8cz+tFHmwPRU+58PlSbbL?=
 =?us-ascii?Q?xel4n1qtzlN4jlyvxfGgg3TqRXZXsmmZOSkDf7CtGq7Iuqgjmv4VvBS0YU7Z?=
 =?us-ascii?Q?wrR3Fg1fnX3Vu6wZG8XXPuzsXP8uQLw9SP9jFJK6ZBDE496/+dQuWQ4d/lI7?=
 =?us-ascii?Q?9k3dshmQvG/EhtQxFyzKEpcwZJFy4kjk2PBAXi8W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fe7673-e010-4980-5336-08daf2c0edb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 04:12:46.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Dy4PK9lusot5SBz8aeGthilhuELPI+4F790id+Efcy04bca2jgteNOZVmyHY9Y2fqkr7hcKmEILGpKzMvqIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-next 4/4] RDMA/irdma: Split CQ handler into
> irdma_reg_user_mr_type_cq
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Split the source codes related with CQ handling into a new function.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 60 +++++++++++++++++------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index e90eba73c396..b4befbafb830 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2864,6 +2864,40 @@ static int irdma_reg_user_mr_type_qp(struct
> irdma_mem_reg_req req,
>  	return err;
>  }
>=20
> +static int irdma_reg_user_mr_type_cq(struct irdma_device *iwdev,
> +				     struct irdma_mr *iwmr,
> +				     struct ib_udata *udata,
> +				     struct irdma_mem_reg_req req)

I would keep the order of these API args same as the one for irdma_reg_user=
_mr_type_qp.

> +{
> +	int err =3D 0;

No need to initialize.

> +	u8 shadow_pgcnt =3D 1;
> +	bool use_pbles =3D false;

No need to initialize use_pbles.

> +	struct irdma_ucontext *ucontext;
> +	unsigned long flags;
> +	u32 total;
> +	struct irdma_pbl *iwpbl =3D &iwmr->iwpbl;
> +
> +	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
> IRDMA_FEATURE_CQ_RESIZE)
> +		shadow_pgcnt =3D 0;
> +	total =3D req.cq_pages + shadow_pgcnt;
> +	if (total > iwmr->page_cnt)
> +		return -EINVAL;
> +
> +	use_pbles =3D (req.cq_pages > 1);
> +	err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +	if (err)
> +		return err;
> +
> +	ucontext =3D rdma_udata_to_drv_context(udata, struct irdma_ucontext,
> +					     ibucontext);
> +	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> +	list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
> +	iwpbl->on_list =3D true;
> +	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
> +
> +	return err;
> +}
> +
>  /**
>   * irdma_reg_user_mr - Register a user memory region
>   * @pd: ptr of pd
> @@ -2879,15 +2913,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_p=
d
> *pd, u64 start, u64 len,  {  #define IRDMA_MEM_REG_MIN_REQ_LEN
> offsetofend(struct irdma_mem_reg_req, sq_pages)
>  	struct irdma_device *iwdev =3D to_iwdev(pd->device);
> -	struct irdma_ucontext *ucontext;
> -	struct irdma_pbl *iwpbl;
>  	struct irdma_mr *iwmr;
>  	struct ib_umem *region;
>  	struct irdma_mem_reg_req req;
> -	u32 total;
> -	u8 shadow_pgcnt =3D 1;
> -	bool use_pbles =3D false;
> -	unsigned long flags;
>  	int err =3D -EINVAL;

Do we need to initialize err here too? Probably separate from this patch bu=
t could clean up.

>=20
>  	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
> @@ -2915,8 +2943,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd=
 *pd,
> u64 start, u64 len,
>  		return (struct ib_mr *)iwmr;
>  	}
>=20
> -	iwpbl =3D &iwmr->iwpbl;
> -
>  	switch (req.reg_type) {
>  	case IRDMA_MEMREG_TYPE_QP:
>  		err =3D irdma_reg_user_mr_type_qp(req, iwdev, udata, iwmr); @@ -
> 2925,25 +2951,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *p=
d, u64
> start, u64 len,
>=20
>  		break;
>  	case IRDMA_MEMREG_TYPE_CQ:
> -		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
> IRDMA_FEATURE_CQ_RESIZE)
> -			shadow_pgcnt =3D 0;
> -		total =3D req.cq_pages + shadow_pgcnt;
> -		if (total > iwmr->page_cnt) {
> -			err =3D -EINVAL;
> -			goto error;
> -		}
> -
> -		use_pbles =3D (req.cq_pages > 1);
> -		err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +		err =3D irdma_reg_user_mr_type_cq(iwdev, iwmr, udata, req);
>  		if (err)
>  			goto error;
> -
> -		ucontext =3D rdma_udata_to_drv_context(udata, struct
> irdma_ucontext,
> -						     ibucontext);
> -		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> -		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
> -		iwpbl->on_list =3D true;
> -		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>  		break;
>  	case IRDMA_MEMREG_TYPE_MEM:
>  		err =3D irdma_reg_user_mr_type_mem(iwdev, iwmr, access);
> --
> 2.31.1

