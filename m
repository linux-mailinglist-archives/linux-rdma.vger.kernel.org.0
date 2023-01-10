Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F140663803
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 05:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjAJEKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 23:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjAJEKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 23:10:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93733726C
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 20:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673323806; x=1704859806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ePDeyPmIpGk/LU7BflqPyqDmjPaIMWSxYefDp+Q9mAA=;
  b=SBvyqUNYWOE3t9bLgkJIObhcaSFRdqR1II18445wrWimZfU9iqCsKuzT
   EhiIo2Y6TRn41zY0Ug+UOzZDvnWy5e9zBNugOHD5JCt2BMEyWuH1eofLr
   jlRP5SPalSnltEtyNomB+uKxmCpyhnB+vNajO8JuOuUW5g5JaTHfCHgmv
   I1Sl6uPgh6mZmPX8CSZifOoah9P6TjKc6FVcqaj5zhyp4fHblgI0aRPHq
   Qjl82foXfqOYgFtwHR2AaXEFgwsxD9lAmY2DEfs8WXmJJt6rpm+y1Vhq2
   ibbtqjZvFuzRVwY4qc5xJwkWYqsnEG8Sm1PqRK5XTqgs8uboGLjhGNH/v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="325060500"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="325060500"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 20:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689281249"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="689281249"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 20:10:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 20:10:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 20:10:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 20:10:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 20:10:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SitamLjLPxZ8iiZvVUILSNNYjZ8HVN+drDqrfv/7PZuGCZlfRhtuGGoazM25EqJj8g+VdjKi4rIbe5NzW6674tQOFhp/cKF9Rxkc/TmQKfrtOUuK+W7gt37SaTDt08dSFTczaFkGx5+RrVYfu/0irmJiuaOyQfiMeEiKVtFdCtPVQT6WGfhTxWhcvdv64T5qpOaO8hoB/OI7tA7FkDTrC9xC1hTAd0bdtu08VrkYwow+COfjltyIyfFczc1xm3ajMSBSOCuwVz8Nhd4KqWJiE37RYw/Nj7v/gyydJSsw8BqdIins7dfG57xgO1NEyl/NdWjxb2jwp40f3bnnPodRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk6d2CVt2ygbiNQN+f7AqNF1EAxRi+Apfz58yOV5OLE=;
 b=YdGNhGNkG/V6KPhd80WpdmW0h/cIk/luQUKQLvTG34HAwhQbaNhMfHDhF2lViQ84oH8lqvONX2J71RALK0OIO9qNzgjzFqq6rA2G4fr7LAdgbn/s+4eUMMDBp/972c9zRCSfhu/pVWzf+KQhpv5N7cE8tyIL/h94iFSbciW0ihd7bULeAMAiektAIIhDY9bzrczBkeiRpVFHR0oc3OIVt05rwrb44jtp2EvVgQm+mg0nX3gVh2rkq9Uigzb9ccyVTouqAcnEbv4N9dKVV2y9XPopaGlK7KCLacSf9eCh0nKCPRDd0GSV1iIIEBz7IbmPU0c1v9sTU/PeORhFjNxVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DM4PR11MB5407.namprd11.prod.outlook.com (2603:10b6:5:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 04:10:02 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 04:10:02 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCH for-next 1/4] RDMA/irdma: Split MEM handler into
 irdma_reg_user_mr_type_mem
Thread-Topic: [PATCH for-next 1/4] RDMA/irdma: Split MEM handler into
 irdma_reg_user_mr_type_mem
Thread-Index: AQHZI9pKXN+NY/AiN0euemTByLRs9K6WvyxA
Date:   Tue, 10 Jan 2023 04:10:02 +0000
Message-ID: <MWHPR11MB00297F705B53748288FB03E9E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-2-yanjun.zhu@intel.com>
In-Reply-To: <20230109195402.1339737-2-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DM4PR11MB5407:EE_
x-ms-office365-filtering-correlation-id: f95fc546-dc64-4e43-8680-08daf2c08c05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5tgAZKYMDqexY2lt0ByRsEvxIQlTQVKvOF+bVUNgQX/7r+SblxxzJ0WWsUZCdbVlqM2HBCp+GRhOOBUWZBX9pktr7vOoT6SotavMvvUgVeImXwvv7QbEMktvlkjAkXS8ukv9uwjj5zMkxcaF4hL6qj6fDys7ckzWQaNd8PZfwVClgu0N4Occ0ENLz+jG9EbLbAHT78/MdkgXcJ3WflkQm7q6lQRmYH/PIQxXgJxDReuYTv7e1ba9CMUBh4HV9GY9Pd9DL6ESQdNZsX5eRB9m+s+MIlG2J+k0QDScj+d20kMJ2V26mENpwaLv412kVJX89tmyHjxAo3mj9Crfq+tLby8Bdj+vPTxei1fgVZ7cvDHBdfvzES2PCyHNozOVSjxF4BwdIbXkpRWSHMECWFQnUIbO6fil7YUphR9Df3YpnUPwtK7QHcbdUjtmsMyJo4AJbmTXttVe1yszmoWETZZGB3qHDd5gAF28O5M4R4Wx1TD3q1f1SMbppgnu7yLxsQgn3bS4LrODz4YlThFhTdLOTM8KXLW7/woGhfntUDaoP74t9de+7aEA2dTJATWVauVkaovQK70cEpySNYbCwpl9Fu8oxsvnVwsesHC6hhhZ2SXGP93H8mbandLo2gvihbC7PlWsWMb6AA9BCZWSd74whdlvVoBefvvz8q7EE2bCQps3gS+iu6uZBJMFTbVbsPID+ACRgBJthII51MnPGttUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(66556008)(4326008)(8676002)(64756008)(66946007)(66476007)(76116006)(7696005)(316002)(66446008)(110136005)(38070700005)(2906002)(8936002)(5660300002)(71200400001)(41300700001)(52536014)(83380400001)(33656002)(6506007)(82960400001)(478600001)(186003)(9686003)(38100700002)(26005)(86362001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/kAJBE91vxAJWdhrWoj3JmEfhGjtvLBjFYXkOBbdUbyZVodd1pAPIKlhVV6d?=
 =?us-ascii?Q?Vxt/gZ5dAvDyllCLusPopsKcDIOxtng2M2nJWE5I3fa5JJo7uYd9MhVSfXnO?=
 =?us-ascii?Q?3x7RkQWLOkKzHhIbbqwx75JFGMnCMMmJrlRCnKVwXFqG2FNQC9xG3vj1DcXP?=
 =?us-ascii?Q?rmi2mIWQZNQkfKYpesWlIPvllKkBaKj7as9pLBEHGcx4kvYBO69nlyQigw5g?=
 =?us-ascii?Q?GKgMYQe8iN2T86fXreLC+aaLcaAR7blOGxo+6KHaZRUTUI1CG55sz+tYASri?=
 =?us-ascii?Q?mxmbmvK5su9y0ZC2K1U1np+PY2w61kqa5Nn91UrG7YWvf4Y4c51RuMHXDiEG?=
 =?us-ascii?Q?AQleUDbdUZRb2tNRKzDIcro0GfNLckyzcOj6qX7D35qS6WtIt8C1B3EnS2hA?=
 =?us-ascii?Q?OYOafxcYopxHILTIR+h6T6cEqN7Oe+T7Vt/Dqv18cJp7KGdeZwNdKVIpUOPN?=
 =?us-ascii?Q?zm7QgcEj4sbfJ7X8G7LRjT8n2IkFylpaJGLgAgyYIHlTK42jtkvYcfRQFtjf?=
 =?us-ascii?Q?ZsmFKQXxT6MmWDtmVFeGnLAUBbwCvRvNReqXrrY7C+m/+wM+J9uM/x0DXKWI?=
 =?us-ascii?Q?GKq1FIipEDv4hmGaPMbVVw2zcXtboOl5V5leU7ecuFdAuOftFj3wb4+txvMK?=
 =?us-ascii?Q?od0ak2QgtsXmCzFNLt88GL7aZydT0UMrBysWhBuhh6kvM/owfNpR10/LsSmi?=
 =?us-ascii?Q?Mw6KSJuzxpgBAC0bWdfUpnxk0BCCIcITuomHsOl5pcFiwYd3Jl+B4vB3SP/B?=
 =?us-ascii?Q?dmFhvrSSGKUElR/vSW2Atfda+4kXNogLG54rapWwZj9Wu1rKCzwofm3wMOOx?=
 =?us-ascii?Q?JHLhGkLvHhl+yVB5vywVkHcHzkQTq9/M1o1wcAJS/es1VomizBFMt8TMMx/a?=
 =?us-ascii?Q?O+Pc+3giyswP+zSbZqNd+guG5tycKANcDwsft+mkgDre/06zS3CnpVyPQ6Ok?=
 =?us-ascii?Q?8Jg5LKll952GI3/F8MyR1NAdIdgZQSa2AUOmRiFC8dAPPOHO0C1j4trIAmYr?=
 =?us-ascii?Q?B31Ajm8fDQ4zR2xAtBbazXtgUOEuDSlP+NzQ9s/lzsc7h2PhcHdYnXIb/kpS?=
 =?us-ascii?Q?tnuFNDby3qkojssZH2khLRPZ648QjVbEGL5NO79lHQKXw3Ssv/bLiM8ZVmtS?=
 =?us-ascii?Q?S3lVLAFL7zr9o+zNKuuVdfY++jerZJdfQ9UK1XcuhD5Pytih98y4sscdbO0P?=
 =?us-ascii?Q?QRUjoHwVk9GHUO5t8cj5mA5UEiPFjMRf0w+adkxmBO9s1AmGzfdpazaTL5c+?=
 =?us-ascii?Q?LDzRKrXRhFhym3YRkyn65cn5id9MzO5hxY3u0RiP4+d/9G1yUEZroE2NPXzk?=
 =?us-ascii?Q?JlI10RnWoSuf1ERx++q6BzPXm2YdkMDnABGf1W/9dUksSft95uxAg3BIvEZA?=
 =?us-ascii?Q?NJqHFHwO5TgkmTBd8BnrUChyW/zCISkZzvoEZWN6MES2vwvGHdo3O9b4eJI9?=
 =?us-ascii?Q?y/rPdvwazssClgfLwLRoJKnTkwZxOWY2Un69ARDq7kEYzjMOfWoHKR7OS/x5?=
 =?us-ascii?Q?EIQ5dnDiYCYtxyKiRoWAbIGjBSa4GOZUlt+qhHMD6rJy9B8hPfBqiDY0thRL?=
 =?us-ascii?Q?YdwZcWNQFg7kYYXxLgpYAuDt9zeh3lKB3+2GXM5T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95fc546-dc64-4e43-8680-08daf2c08c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 04:10:02.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJ/hpLNlyYnSggJy68/YDM7G5FYtlLbwrQsxwHguoH709bhBcTmz/Lbm2il/jN421TvE+Y88JBW5ZADC7Hogdg==
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

> Subject: [PATCH for-next 1/4] RDMA/irdma: Split MEM handler into
> irdma_reg_user_mr_type_mem
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> The source codes related with IRDMA_MEMREG_TYPE_MEM are split into a new
> function irdma_reg_user_mr_type_mem.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 85 +++++++++++++++++------------
>  1 file changed, 51 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index f6973ea55eda..40109da6489a 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2745,6 +2745,55 @@ static int irdma_hwreg_mr(struct irdma_device *iwd=
ev,
> struct irdma_mr *iwmr,
>  	return ret;
>  }
>=20
> +static int irdma_reg_user_mr_type_mem(struct irdma_device *iwdev,
> +				      struct irdma_mr *iwmr, int access) {
> +	int err =3D 0;
> +	bool use_pbles =3D false;
> +	u32 stag =3D 0;

No need to initialize any of these?

> +	struct irdma_pbl *iwpbl =3D &iwmr->iwpbl;
> +
> +	use_pbles =3D (iwmr->page_cnt !=3D 1);
> +
> +	err =3D irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
> +	if (err)
> +		return err;
> +
> +	if (use_pbles) {
> +		err =3D irdma_check_mr_contiguous(&iwpbl->pble_alloc,
> +						iwmr->page_size);
> +		if (err) {
> +			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl-
> >pble_alloc);
> +			iwpbl->pbl_allocated =3D false;
> +			return err;

No this should not cause an error. Just that we don't want to use pbles for=
 this region. reset use_pbles to false here?

> +		}
> +	}
> +
> +	stag =3D irdma_create_stag(iwdev);
> +	if (!stag) {
> +		if (use_pbles) {
> +			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl-
> >pble_alloc);
> +			iwpbl->pbl_allocated =3D false;
> +		}
> +		return -ENOMEM;
> +	}
> +
> +	iwmr->stag =3D stag;
> +	iwmr->ibmr.rkey =3D stag;
> +	iwmr->ibmr.lkey =3D stag;
> +	err =3D irdma_hwreg_mr(iwdev, iwmr, access);
> +	if (err) {
> +		irdma_free_stag(iwdev, stag);
> +		if (use_pbles) {
> +			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl-
> >pble_alloc);
> +			iwpbl->pbl_allocated =3D false;

Setting the iwpbl->pbl_allocated to false is not required. We are going to =
free up the iwmr memory on this error anyway.

Just a suggestion. Maybe just use a  goto a label "free_pble" that does the=
 irdma_free_pble and returns err. And re-use it for irdma_create_stag error=
 unwind too.

> +		}
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
>  /**
>   * irdma_reg_user_mr - Register a user memory region
>   * @pd: ptr of pd
> @@ -2761,17 +2810,15 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_=
pd
> *pd, u64 start, u64 len,  #define IRDMA_MEM_REG_MIN_REQ_LEN
> offsetofend(struct irdma_mem_reg_req, sq_pages)
>  	struct irdma_device *iwdev =3D to_iwdev(pd->device);
>  	struct irdma_ucontext *ucontext;
> -	struct irdma_pble_alloc *palloc;
>  	struct irdma_pbl *iwpbl;
>  	struct irdma_mr *iwmr;
>  	struct ib_umem *region;
>  	struct irdma_mem_reg_req req;
> -	u32 total, stag =3D 0;
> +	u32 total;
>  	u8 shadow_pgcnt =3D 1;
>  	bool use_pbles =3D false;
>  	unsigned long flags;
>  	int err =3D -EINVAL;
> -	int ret;
>=20
>  	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>  		return ERR_PTR(-EINVAL);
> @@ -2818,7 +2865,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd=
 *pd,
> u64 start, u64 len,
>  	}
>  	iwmr->len =3D region->length;
>  	iwpbl->user_base =3D virt;
> -	palloc =3D &iwpbl->pble_alloc;
>  	iwmr->type =3D req.reg_type;
>  	iwmr->page_cnt =3D ib_umem_num_dma_blocks(region, iwmr->page_size);
>=20
> @@ -2864,36 +2910,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_p=
d
> *pd, u64 start, u64 len,
>  		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
>  		break;
>  	case IRDMA_MEMREG_TYPE_MEM:
> -		use_pbles =3D (iwmr->page_cnt !=3D 1);
> -
> -		err =3D irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
> +		err =3D irdma_reg_user_mr_type_mem(iwdev, iwmr, access);

Perhaps you can just pass the iwmr and access as args for this API and comp=
ute the iwdev in the function using to_iwdev(iwmr->ibmr.device)

>  		if (err)
>  			goto error;
> -
> -		if (use_pbles) {
> -			ret =3D irdma_check_mr_contiguous(palloc,
> -							iwmr->page_size);
> -			if (ret) {
> -				irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
> -				iwpbl->pbl_allocated =3D false;
> -			}
> -		}
> -
> -		stag =3D irdma_create_stag(iwdev);
> -		if (!stag) {
> -			err =3D -ENOMEM;
> -			goto error;
> -		}
> -
> -		iwmr->stag =3D stag;
> -		iwmr->ibmr.rkey =3D stag;
> -		iwmr->ibmr.lkey =3D stag;
> -		err =3D irdma_hwreg_mr(iwdev, iwmr, access);
> -		if (err) {
> -			irdma_free_stag(iwdev, stag);
> -			goto error;
> -		}
> -
>  		break;
>  	default:
>  		goto error;
> @@ -2904,8 +2923,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd=
 *pd,
> u64 start, u64 len,
>  	return &iwmr->ibmr;
>=20
>  error:
> -	if (palloc->level !=3D PBLE_LEVEL_0 && iwpbl->pbl_allocated)
> -		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
>  	ib_umem_release(region);
>  	kfree(iwmr);
>=20
> --
> 2.27.0

