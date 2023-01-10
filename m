Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF7663805
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 05:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjAJEKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 23:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjAJEKt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 23:10:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D103726C
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 20:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673323848; x=1704859848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6CQrYs2ADnK/E12eqZJ86f47jTX5rwSdZ7IoRRF8f68=;
  b=VpJ5WwWSIfcf4NEBclBjstaU251rOHrZ5Kz4+v1wdGCUmpM0kw6pHWfq
   28bFqpJW8LQIT006cAb2iuuDG4w/l1Did1vjEdoSDYstYKFSuw2CwTVm7
   j+k+XcoAJ3zNgv82yosgYWNXcggRWUY5MxUOu1cmnD4yLUkWgD+NQn8jM
   N+l+hF4gbtyhueLlDV1DthC7XZAOa10Glixmvo4i+d56LYLpMHAOXezec
   gWMCau2E7HGXCwOowRwb49ZYLJniXTzaPGPQiwXvo/9uU52K7ohsZOtOf
   u9qDn9m74IQEcp6c6gDDxWtXeOvrQbbsn0RP2U7NhDXEPHAN7qVm0GLVV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306569243"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="306569243"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 20:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830855014"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="830855014"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 20:10:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 20:10:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 20:10:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 20:10:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjLqtQGS4BghQw9/PZ1qy55oviuQ6irlp9aWU4YxykAAi1wS7oaPmEbdx2i+B/SwVS1Lc8Spxk1DlJT93VM1yTmjKO/vKN52g469W+fZWKT+kH2yspZGlKuYh8lRF23z3eFrppEKJ09ejtGTGQRaI5MgBn+LVOVxCErMXznQvvNs8SfmZ/6DUQJWsStZPOYJM/WRmG+UsZfWKc0luXX1ExybOSAB1L0XhykDXyoK8UrdVTcldJuv/XwPuh6S7/dhIYlqpEHAYdMO/FDw14H7AhXYof8AozjQAMxLi2l+DjCWSnmifNW5KO/REJ/FNf1ZEn+CWLCLLP1of00n+llmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYZQnwK26wAip3WLnHmEmTxDeYUcTgD2wiSgHK7k398=;
 b=ZyQCaSmKgT8poeGkW75lFz0qTS6IHLnnPzAX31y+m4+b6rzcDJt7q+j27F0OHYLGkm5aC3vl5Pn7Sevftzgx47BaXoN9kogBdqTAkqr4Nh4JXYVntIO9lvMevPcJfwoW6475JKszRnaGOujEZvzkCWy7LHNztM9Ds09IC80uftHQ93G5tLbQwX/YugvPNCZf+2AZTPM10HH09Amu1FYhjuboISR7+hgqOqe1Vk3mixxQMW9w9DkLyZ5bVhB2uzXUIq6W3XP2DeLmNwwMMzuFwJP/1/PifCq8tDpeUCRoXO7WHe90tQZ/9e/JBwbT6EZ9MZOUMchN/66G2src9pdXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DM4PR11MB5407.namprd11.prod.outlook.com (2603:10b6:5:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 04:10:38 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 04:10:38 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCH for-next 3/4] RDMA/irdma: Split QP handler into
 irdma_reg_user_mr_type_qp
Thread-Topic: [PATCH for-next 3/4] RDMA/irdma: Split QP handler into
 irdma_reg_user_mr_type_qp
Thread-Index: AQHZI9pPTvm1vqadU0SLjGzs5JUUVq6W0mWg
Date:   Tue, 10 Jan 2023 04:10:37 +0000
Message-ID: <MWHPR11MB00297D796AE392D8FFCFD0A3E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-4-yanjun.zhu@intel.com>
In-Reply-To: <20230109195402.1339737-4-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DM4PR11MB5407:EE_
x-ms-office365-filtering-correlation-id: 477cba94-f73e-4584-9513-08daf2c0a14a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4lLI5v/1ETc9XIBO8ammWv6dAEbQWQ8s6JnQEM4YulNl3L3Dzc+Y2NC05WLCMRevVC/Bx+U2AZdh8xQgHzAPZAxobzCSLwBT01gNjtMSWaAm7BSGDAIsZtjOT68XX1nzh/EWLE04B/MsHSV2u7umDsTJmJcVPknxTKl8jiAWkVLxIF5ngQmE2OBkOeAF+B6E1hnp3tqSizWvPKikbS+JZ3R55PD6h93CfydaWiKYRro/TRTbgj0DPAOtvAg051SK3tFHB9HoV2kA+47EM0708Jk38ZcGn4ESLAz5YjL+f2p9xEpPO0gfzE9+QUOt3uCQ2O3PRS57ixE0frpRmmlo++YvpMnlodeBQaLgGuKcp38ckQBKO2Uqv2JctjfoWzhQARJkf2IoPO85nLLH1FchvbuRwYlT+f+ra8jz5KezJSlmCJdsIXvnctapaO/HOuzX0pbyHmMJUE+BDWveq1eudN5fF7F4bYIFvnTwxlFMbd7gkFujDPuSiLYXROGQHDp/l7iFH5BBnp/Us3PclMZeJe72FTzmc2MiaDRy3L7j00bHI8PgQnGsJ4RFrJ3PskbqQqBLzvqZJ2kuCm4T042BS44+igWQPJyuEKkaMLIRYMtluZ/6ihTo2HVak4z1Vxx4YPjmG7h4jdLgUfRDMpfZZ/c3OrnaUsTak2nO+jE1IdiL7Vl/i8SHt4eFflL7Ts09SGmPy9pUpQq7C6QfWmEcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(66556008)(4326008)(8676002)(64756008)(66946007)(66476007)(76116006)(7696005)(316002)(66446008)(110136005)(38070700005)(2906002)(8936002)(5660300002)(71200400001)(41300700001)(52536014)(83380400001)(33656002)(6506007)(82960400001)(478600001)(186003)(9686003)(38100700002)(26005)(86362001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?70MpVgL7Z/fhk6CwxLdTrp+3IaIHOG5R8Z0MBnaYOKWYjOm0LUJ3JtzksZfQ?=
 =?us-ascii?Q?pijZ0oMvvuxE6+LX3vHYiL2z2aQw7KMMWafDeYWSdO9YejcmbMr++zLKEP3x?=
 =?us-ascii?Q?00aAUatTMBeEDmy8dlNAO1CAMf6sNOOL2cgmoKJSb/e+iKwKT4vlpt0GwbgY?=
 =?us-ascii?Q?hPMkSQBWbDqG/wwNtkqsM98fCgmcXUiFMsoKaUmw+0pLnCsrZ55KzdkP+Bcz?=
 =?us-ascii?Q?1CZEf/oUplu7RsD+dmNT4iKq6yc3HaGLgfE+pMVxNyrXkUvhJevYWghXjR4i?=
 =?us-ascii?Q?Zjrs5AEVp9G8CLTBM5ctl0TseLAFfiH5RPiVe64cPQ78xNQqMxcMpnBbwowV?=
 =?us-ascii?Q?5NKv3f5ZYEtW1UlX5eA2yW2A2BjddcChHZHxgNLL4A02sdJ/7I7jN+sxHz8b?=
 =?us-ascii?Q?KLvf5TA73xAiyynHPX0KN/VTSstXfHnhrogK4H3HPBavjEWvE1AwU7jxrjjV?=
 =?us-ascii?Q?k5kwSXgSUkRDkpOY3Ui+bVKulBnJKvf5uV+cz1rPx6s0/Nwf1cVi1RNuToF+?=
 =?us-ascii?Q?ix59EJrF+xZIAs6C+PyqA3NQWMraX7izVH0LcUaGD20xYag+0beOlT6kvv5Y?=
 =?us-ascii?Q?DO6yk4TGeNiuQ9Ht9KSv1rVLJDP/zyM3ayQWTy54kh0+qB3385xuMHZ4e8m0?=
 =?us-ascii?Q?+2zjIOFYXMSxIJVXi0Ly+BR69PwVvReTzq+JU1CSnbynzNY8znXKLcmcMkVF?=
 =?us-ascii?Q?AIMeO/sELiTrrT5h4oApG0y2i0ZH1HWVzhJKKTG/DwX7zyaD7IJIgByygNME?=
 =?us-ascii?Q?jVc+92+ZxFYXtcrHXaNVgRQmlxmfxGEi592SF+YsvYMhVVfQPQ22vk66+ciB?=
 =?us-ascii?Q?KU10U1JMJmZLModoIMxSZ8EizFFcCsMYAfgRvj5gj0krtbORhRGOZQD+dAng?=
 =?us-ascii?Q?P6kgvCkclgHnrxlfzHyWwjdTSxiUdREXEf5cJmzoqLcm3Q7My99/tG4ufd0I?=
 =?us-ascii?Q?HjOVJyloCl0jv7vqiyRRkfPTK9hih0OsEDwqw8IasQ85+BIbPZMjQK5dR27U?=
 =?us-ascii?Q?Q3UuKJ6Zh/ZphXXagEMKHHhdRw2/IAR+hzeM5IQ10K08ZfFWwQSFlnrCb5jl?=
 =?us-ascii?Q?3APcU5TV0C93CmCkvWoqDI50uJOZY4eC8PvYOnMiiaoGuk4l2EciyQ1o7hrp?=
 =?us-ascii?Q?Cns4QhlMNUoxM1CF68AO6YumYQUK3C4F9Os93ryp8wf7Gq9jgr7w4rszuybM?=
 =?us-ascii?Q?wF6DNYaAkl3JHeQa3wrjREe7hFbEVBitU4r/pQY+eywugbE1R3nIKgDSb0dU?=
 =?us-ascii?Q?bJw5sAR2FY+zOZDP997l3zugIbPmrLOCfZ6N/JSu1ZlbBQHiy/u+LdkpV8I6?=
 =?us-ascii?Q?3s9GjODCSAodwd8yQN0wzJh5jEU7CWCBoUY6RqGN7elFGoQVonTzkO1/e2T3?=
 =?us-ascii?Q?RWw8jTFRunLy3tKltGbszFK9YH1tB6Nd5thVEl6zyIgM1lvkJ8CkMx+FA89d?=
 =?us-ascii?Q?eGd7RQkyakJFMBLSwhfxFy1vW3DIaxhLuvU2o2xd9DDvHlNesdoYheOzHPVO?=
 =?us-ascii?Q?7e8xC7DsVq/sWrmBESXEzm+E6Wb08utayXkH8/SfYN6m1hJ1pmYSEyDCAS0H?=
 =?us-ascii?Q?l/3f3a0G93dwLmCHPcq/5JIVOYYUam51ZDocFnS6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477cba94-f73e-4584-9513-08daf2c0a14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 04:10:37.9383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZIdDGv+IhgnyGOaJQUHVA7NlJhwHck9m6L/FO2TtGEabeR8igXtHHI68KBitZjIkyYMoHImbU0RF5jIEaoDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-next 3/4] RDMA/irdma: Split QP handler into
> irdma_reg_user_mr_type_qp
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Split the source codes related with QP handling into a new function.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 48 ++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 287d4313f14d..e90eba73c396 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2831,6 +2831,39 @@ static void irdma_free_iwmr(struct irdma_mr *iwmr)
>  	kfree(iwmr);
>  }
>=20
> +static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
> +				     struct irdma_device *iwdev,
> +				     struct ib_udata *udata,
> +				     struct irdma_mr *iwmr)

You could omit iwdev and compute it from iwmr.

> +{
> +	u32 total;
> +	int err =3D 0;

No need to initialize.

> +	u8 shadow_pgcnt =3D 1;

> +	bool use_pbles =3D false;


No need to initialize use_pbles.


> +	unsigned long flags;
> +	struct irdma_ucontext *ucontext;
> +	struct irdma_pbl *iwpbl =3D &iwmr->iwpbl;
> +
> +	total =3D req.sq_pages + req.rq_pages + shadow_pgcnt;
> +	if (total > iwmr->page_cnt)
> +		return -EINVAL;
> +
> +	total =3D req.sq_pages + req.rq_pages;
> +	use_pbles =3D (total > 2);
> +	err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +	if (err)
> +		return err;
> +
> +	ucontext =3D rdma_udata_to_drv_context(udata, struct irdma_ucontext,
> +					     ibucontext);
> +	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> +	list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
> +	iwpbl->on_list =3D true;
> +	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
> +
> +	return err;
> +}
> +
>  /**
>   * irdma_reg_user_mr - Register a user memory region
>   * @pd: ptr of pd
> @@ -2886,23 +2919,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_=
pd
> *pd, u64 start, u64 len,
>=20
>  	switch (req.reg_type) {
>  	case IRDMA_MEMREG_TYPE_QP:
> -		total =3D req.sq_pages + req.rq_pages + shadow_pgcnt;
> -		if (total > iwmr->page_cnt) {
> -			err =3D -EINVAL;
> -			goto error;
> -		}
> -		total =3D req.sq_pages + req.rq_pages;
> -		use_pbles =3D (total > 2);
> -		err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +		err =3D irdma_reg_user_mr_type_qp(req, iwdev, udata, iwmr);
>  		if (err)
>  			goto error;
>=20
> -		ucontext =3D rdma_udata_to_drv_context(udata, struct
> irdma_ucontext,
> -						     ibucontext);
> -		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> -		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
> -		iwpbl->on_list =3D true;
> -		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
>  		break;
>  	case IRDMA_MEMREG_TYPE_CQ:
>  		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
> IRDMA_FEATURE_CQ_RESIZE)
> --
> 2.31.1

