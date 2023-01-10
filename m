Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABA3663806
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 05:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjAJELR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 23:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAJELL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 23:11:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ECA13E3C
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 20:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673323869; x=1704859869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f43tv38+GvLCBZ4cZLhT7/Br0NUqq4M2bZSTly8mAgY=;
  b=MwXiubGgEhSHx/fhUesgBbsl3jVDcW2tfOMHFkhnoow3Y/qNHnjWqHvZ
   tzpxjlVpe2CkMyHXo+QJwvr1M9KKAOJ5KFldJy5IybouOgQPpcWtm6CJK
   8hfLdAgi6WcVM6tDttrJscxZtT8FciRjRJRr3h8nfBHaYrfl49Zu5yrFg
   bGdr2hMGxY+gv2Gu7FkHQZx/0lCqEzkLqgyH5WxwlbkNyHuOv7mQR7P+w
   NcyMZMyin3lA+0pmLFjVmIxoeoctY0cvgqmM1hgv62YwcqiHI1KTULjiH
   yA4Dq0RmTqzj3qNixzT9btfp7JZIn02vCx//79tWiyl607v/gEWxuiJ89
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306569299"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="306569299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 20:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830855053"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="830855053"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 20:11:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 20:11:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 20:11:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 20:11:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOSJUynZAisI3L4ooxnk8d0weEw3Hx5clmXOrN3caLsen39bA05/eVwRTw9GPvitSUU5rKR9FB7FgJJV2YZpCE9V9cZvqcBeLj3ehfjXGrS1l5w5Ubg80TSxKVhb7fmX5g6+jzfZUm4i3V0aONwN7Ha/1fxzrq7ktSE6spLvMplUYaU7gzPVkqsOo2casskTJos+A/6D65ZgQiqI35Leq1VPRrcBriH/qo4+QFXwvFvvxItp0OpYUM7zkNkykm6GoSOj5c83GQUNNLS9qPvGE0CK1Rd/9LSpMMFyT6MC0QsCwFsDlE+CfA7TY06NSaa9E9qDWJ7I39bRB+g5JabJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkZxGAmH3Lx0O5Dm9VcALkKj+c8NXgCH5S5QE+uo8Ww=;
 b=N5rSSeELityb1lINw2sxLovKOyAtY5LKRDZV7fbsV6OwcMiyh5N70uXonlyS1lhman/vEmtctPeKzFjt/PBsGYDCAb5snwqqllZ1VOS3F9G2JXcD4kP14/vqoQT68aZbHd7hcQY0hMvIOkzOF91sbSdXHd0ScaZ/1v6GOxp8LJLucOyVHH8U0kAIIRzfBGKM5t4QNZjNOEubRP0/Go7Ftnk/X8vbEdX+0qC8NHWsn2SORmqD2Er73IPoxzxeMqn5wAzMUL67Bk7wAYLQInM8ZvZCeFPvK2JqgSEAq4KTo69Z/pCaWWjbxOTFQkhle6ScvAeix+ElrymnOUUKryNpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DM4PR11MB5407.namprd11.prod.outlook.com (2603:10b6:5:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 04:11:06 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 04:11:06 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCH for-next 2/4] RDMA/irdma: Split mr alloc and free into new
 functions
Thread-Topic: [PATCH for-next 2/4] RDMA/irdma: Split mr alloc and free into
 new functions
Thread-Index: AQHZI9pO3e60x2CcxUCE97H8FPbeDK6WzO7Q
Date:   Tue, 10 Jan 2023 04:11:06 +0000
Message-ID: <MWHPR11MB002992573341AA0ED11BB499E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
 <20230109195402.1339737-3-yanjun.zhu@intel.com>
In-Reply-To: <20230109195402.1339737-3-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DM4PR11MB5407:EE_
x-ms-office365-filtering-correlation-id: fedbbae1-8842-46ff-2716-08daf2c0b24e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlXhPQhi0cHbBApXPyMvBDarf+FVgyd8W5wXDMdQPaDvCLax58mUehJBCKjxMws7HiEjq78NmNBK+eDzPrUNRFB9rxa+u8LDu4IwuBD/sMptG0etAjbIJtYjZNKi2KFSKPUvFWww9Q0M03niG7GmCJdJY7xWlHGGa2jLHpA3sqFCe2rh7aNUpbnb47sbe4GqFblPks6zFuP68BS04NifceouB6jpP9+q1G90mfEtw+MlKHR1jDmAHU6QABw9R2ohArvx+kNJGgBAlFk0lPnVfPRMaLW6EAbrqhULohFb/fc4z8eyBtUtDpOa82WGSRmVcZzaIr/0mqu6K3Pu9O8lsMV3kiT5+cqerCdHt4SQY2xxeC38H6iiLpY3LwtLMeUcoz4ivNeR90WeqFtxwQgSKs1+U+MDErKYe+BchIfdGx3t8UUtvCd8S/xDV3QgqJE6PL3XTf8Y71MkpNIuMyrn1zXpaa9nVJ+AM+YGiEEy7ZEUl6lCux7XDsBhR6gFY6Dhpv3oq86f+6Nz7AAOZi9twPMXNcE+YOpDVd4g4s9JKlkqCYXHhTliecGfdCbp4BsU9VBiJGHbzIg+JCd4cIdTBXZTh2K/e+smxOAn4vcNmPfDdwBNTCLhCOZmaio2Pq39Vnu+mu42lpTZ4uEZFhzRoLrbz8h22usa5Uddx8YaK3XBx4uIVSouaeXRnpEZs3DR3a5/j/xHQ+vVAtZvYW7C7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(66556008)(4326008)(8676002)(64756008)(66946007)(66476007)(76116006)(7696005)(316002)(66446008)(110136005)(38070700005)(2906002)(8936002)(5660300002)(71200400001)(41300700001)(52536014)(83380400001)(33656002)(6506007)(82960400001)(478600001)(186003)(9686003)(38100700002)(26005)(86362001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0bqV5xLTnbB7vwF80UQRSxF0tWWBWQdvxlpF4r8+TCGbQde4Tatq/S5Tkz6h?=
 =?us-ascii?Q?HgFgDe9bd7YbBhCsneWyx94W26AyCWHojdh+wouKInoxb7b01cn/e7K/ZbCS?=
 =?us-ascii?Q?SQfv/uPfCpaBsVEJkowwCd7h2Mx64yLqmVd9vu0yqbRhkjDVBr+hcy2iHf0/?=
 =?us-ascii?Q?eu704nn2N+end+6GBhcAhtomzOpAtiBiU8+I8GcHl/Now6Qd3g+NDnCifqpX?=
 =?us-ascii?Q?NEP3RLUr/S7H1D+Rkdtde1gRDbhf7y3bvDp3Arca6SqGWXBlqVKEAlC9uE0c?=
 =?us-ascii?Q?gR/TzM75p1E8fpB5nqV0ZTSLzjyYRp9HjJlh5IAvdVWXk2VmJ47JWedbgJtd?=
 =?us-ascii?Q?mqkfmVbeV5jgRTqQHJcfBJ0efPsLJKJN18DfeqRyNb7MokOUsxDcYE1XrfLr?=
 =?us-ascii?Q?nBbG+4P52PbYUCqvBlHmafrxFn/rQZOQzFXyUeZQNnJlsr9VwR0s4Cj/VOn9?=
 =?us-ascii?Q?cWeK3AeV3O7S9tienq/RtuWC9bAWv1iB+60Tb2WCqXdqW2Hm9BMWZOMMJ6eq?=
 =?us-ascii?Q?WkqrTUM6GfhypS7JzHnpj1zC+muMrma5oyrJ6Q7YSJ5TDr9yisnBhDdcl21r?=
 =?us-ascii?Q?QTBVuj3BkP5qQ4jCmG2KZOdDYp0tzBxoFlbsqZ5CiAd0ODvrs7zDsS85zQwY?=
 =?us-ascii?Q?L8EYqeCwJaSZ8n3LCJTLYF7G1G2iu6d78HY+wPjBdcyzPL/Pp3F5p7wCvaXe?=
 =?us-ascii?Q?nLtcDduMjgH3vxNfaH6ddt5e7+Wn4RZTyQwSuKruCW2gUV++iwUj1G5+7iQT?=
 =?us-ascii?Q?pHiriVwgnQik2pDeKBw7UYgN2GSFdj93VHN2lX60pkv51SPZbzdB4Pn2iPcu?=
 =?us-ascii?Q?1DiZWF8qgrFtMQ5p3kon8oXkNCBJDWMA6B0xw8izMVYi6MwFOxNfHRPMc5rL?=
 =?us-ascii?Q?jPM2LqG0hillfqQ7td40JfHdxXM5OP5GwB11C3+vCpOp3S2g0WV2unL7m/YP?=
 =?us-ascii?Q?9p0OvwPY9Y6lORL0rWaRZb8FG2CdpZLDdzZG/K2Ggdss1OJk77CFzpI+qaCn?=
 =?us-ascii?Q?PuI0foE0CtuHbdUx3d0TLZ4ICWqO4LIRThSNDZTTs4kFzkXBwovpTLxq5vXE?=
 =?us-ascii?Q?95j87dy/qyVby/iaWDFSeKmcMoxRSEGfrj1qjMR7eUAX/Qcwoz+JnMBijS1w?=
 =?us-ascii?Q?fWFPQEnZrtkcZnCv0geDsPcvXg7S+4JZ89byqcD/Lmv0L4yrhT1+dNbeTXXS?=
 =?us-ascii?Q?1JZeetrwpjLP+NrwKFsvLC63htdfuKJiUBlEOKk1at3lILIoq+4VHcFtpOoN?=
 =?us-ascii?Q?0AUjNCxG/jCePxHb8JTn1ZmmYfAvpFVXDD3oKk8IjorCwN3/2DOBD1EByjZG?=
 =?us-ascii?Q?6DlmI3m4KZzqISSKReXHJNDIK9h6f6vKUPcfKPWmjGzG5tZf0Yy4XbYU+fSx?=
 =?us-ascii?Q?spUGDTyClhYJicQXBR8aGlUc3xUo2mam2FGHfzKI9vaTjsozxBHzlyS9G0rx?=
 =?us-ascii?Q?NferlnaleIqxCCHn81CJ2aBtQlk5SxkMdtv3/WD+P7l1zA6VBAOYWAvV+tkL?=
 =?us-ascii?Q?0h69Fh5DbyF62mt7FkvB0RDMhnKsOX7uRoY6klYOz3OMbT5RqXuDxkdkbin+?=
 =?us-ascii?Q?NgYD1tO+8Ld89L5pZTNGVRFPr9JLpOBAXKrUBBoV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedbbae1-8842-46ff-2716-08daf2c0b24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 04:11:06.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujVHkO6NS9nmrTUv8MRn4WmSY/cR6JTip/Ji4+JQDNzb1TEtIhKKhg12CaEeYB0722WFUVhiqNOo+ijid/INVg==
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

> Subject: [PATCH for-next 2/4] RDMA/irdma: Split mr alloc and free into ne=
w
> functions
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> In the function irdma_reg_user_mr, the mr allocation and free will be use=
d by other
> functions. As such, the source codes related with mr allocation and free =
are split
> into the new functions.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 78 ++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 40109da6489a..5cff8656d79e 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2794,6 +2794,52 @@ static int irdma_reg_user_mr_type_mem(struct
> irdma_device *iwdev,
>  	return err;
>  }
>=20
> +static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
> +					 struct ib_pd *pd, u64 virt,
> +					 __u16 reg_type,

enum irdma_memreg_type

> +					 struct irdma_device *iwdev)
> +{
> +	struct irdma_mr *iwmr;
> +	struct irdma_pbl *iwpbl;
> +
> +	iwmr =3D kzalloc(sizeof(*iwmr), GFP_KERNEL);
> +	if (!iwmr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iwpbl =3D &iwmr->iwpbl;
> +	iwpbl->iwmr =3D iwmr;
> +	iwmr->region =3D region;
> +	iwmr->ibmr.pd =3D pd;
> +	iwmr->ibmr.device =3D pd->device;
> +	iwmr->ibmr.iova =3D virt;
> +	iwmr->page_size =3D PAGE_SIZE;

Delete this and see comment below,

> +	iwmr->type =3D reg_type;
> +
> +	if (reg_type =3D=3D IRDMA_MEMREG_TYPE_MEM) {
> +		iwmr->page_size =3D ib_umem_find_best_pgsz(region,
> +							 iwdev->rf-
> >sc_dev.hw_attrs.page_size_cap,

I think Jason made the comment to always validate the page size with this f=
unction before use in rdma_umem_for_each_dma_block.

we can move it out of this if block with something like,

pgsz_bitmask =3D reg_type =3D=3D IRDMA_MEMREG_TYPE_MEM ?
			iwdev->rf->sc_dev.hw_attrs.page_size_cap : PAGE_SIZE;

iwmr->page_size =3D ib_umem_find_best_pgsz(region, pgsz_bitmask, virt);



> +							 virt);
> +		if (unlikely(!iwmr->page_size)) {
> +			kfree(iwmr);
> +			return ERR_PTR(-EOPNOTSUPP);
> +		}
> +	}
> +
> +	iwmr->len =3D region->length;
> +	iwpbl->user_base =3D virt;
> +	iwmr->page_cnt =3D ib_umem_num_dma_blocks(region, iwmr->page_size);
> +
> +	return iwmr;
> +}
> +
> +/*
> + * This function frees the resources from irdma_alloc_iwmr  */ static

This doesn't follow kdoc format? And not very useful. I would delete it.

> +void irdma_free_iwmr(struct irdma_mr *iwmr) {
> +	kfree(iwmr);
> +}
> +
>  /**
>   * irdma_reg_user_mr - Register a user memory region
>   * @pd: ptr of pd
> @@ -2839,34 +2885,13 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_=
pd
> *pd, u64 start, u64 len,
>  		return ERR_PTR(-EFAULT);
>  	}
>=20
> -	iwmr =3D kzalloc(sizeof(*iwmr), GFP_KERNEL);
> -	if (!iwmr) {
> +	iwmr =3D irdma_alloc_iwmr(region, pd, virt, req.reg_type, iwdev);
> +	if (IS_ERR(iwmr)) {
>  		ib_umem_release(region);
> -		return ERR_PTR(-ENOMEM);
> +		return (struct ib_mr *)iwmr;
>  	}
>=20
>  	iwpbl =3D &iwmr->iwpbl;
> -	iwpbl->iwmr =3D iwmr;
> -	iwmr->region =3D region;
> -	iwmr->ibmr.pd =3D pd;
> -	iwmr->ibmr.device =3D pd->device;
> -	iwmr->ibmr.iova =3D virt;
> -	iwmr->page_size =3D PAGE_SIZE;
> -
> -	if (req.reg_type =3D=3D IRDMA_MEMREG_TYPE_MEM) {
> -		iwmr->page_size =3D ib_umem_find_best_pgsz(region,
> -							 iwdev->rf-
> >sc_dev.hw_attrs.page_size_cap,
> -							 virt);
> -		if (unlikely(!iwmr->page_size)) {
> -			kfree(iwmr);
> -			ib_umem_release(region);
> -			return ERR_PTR(-EOPNOTSUPP);
> -		}
> -	}
> -	iwmr->len =3D region->length;
> -	iwpbl->user_base =3D virt;
> -	iwmr->type =3D req.reg_type;
> -	iwmr->page_cnt =3D ib_umem_num_dma_blocks(region, iwmr->page_size);
>=20
>  	switch (req.reg_type) {
>  	case IRDMA_MEMREG_TYPE_QP:
> @@ -2918,13 +2943,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_=
pd
> *pd, u64 start, u64 len,
>  		goto error;
>  	}
>=20
> -	iwmr->type =3D req.reg_type;
> -
>  	return &iwmr->ibmr;
> -
>  error:
>  	ib_umem_release(region);
> -	kfree(iwmr);
> +	irdma_free_iwmr(iwmr);
>=20
>  	return ERR_PTR(err);
>  }
> --
> 2.27.0

