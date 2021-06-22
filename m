Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542813B0FAB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 23:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhFVV7I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 17:59:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:43516 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVV7H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 17:59:07 -0400
IronPort-SDR: VWSD/lH5UiM8RwMxAW/DijbsHfy3/SpkN9Mc11e4vmfpF4vOLjwe/YoxlmnBAnRcnsyWpXh2WQ
 7JmtueoCXYtA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="186837368"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="186837368"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 14:56:50 -0700
IronPort-SDR: CSus63hLyCeu9ShAXVp3Wuj2W65Eg8TcRcliO0EujesEIsrRzdvpn3OO3qksDjJIgmtxUUGH7r
 QkSBzXA/FQoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="487062401"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2021 14:56:49 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 14:56:49 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 14:56:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 22 Jun 2021 14:56:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 22 Jun 2021 14:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIG5ngd7b+4vYgaDMKz9/6PKnqp926+RApD4FT806WWkw+TIXKWXLakrQ8pnrU++3k4mci3iq/5knT66/zl5cx1taNVQegtsOXNq+2nbs7pXmNuuLl+oMHweXYPozbrGxd6eA8XBBcgo0nHPAzijS17/OCARkL+Fgr4YwiDbo3FSZRp70SAC8kKPoLfPcMoBuBxQ7R1rbTR0M1+K2VhY8Dfj6qA0tbll6pULzj/76UeaUSI/vuwkQfaRyTC5OkSHNpTPNhxr/pi4AQyQuiaqGpeV4rvmHc8Mru41rL9EdS27+a50onkXbeosNzbzMCnzLuFdbsWwn9A6+Dh5SLzZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SONA3eN2OC4PU+l7smis22zPye/PSzoqE2eTBNPFeIw=;
 b=fwAhDIuejUpGWzYST4DjYevqhKNv/A+WmV5q7dJv4/vZAZ+thbT3JikMtEdAf/9RW1+6703PPTJjMItK/j8l4TLts6EaCh8osYjsbOzkb4tK5/CAHfwxBYY2sF0MrFCiO1e1/2oc7Rt7XNoC9SBt6gVYwFtpecCzKvAzyedo72+UhTzgnyUnGZy9w308YPmMomCva8f0dw5tWujTj1tUJK821/Snc1/VjWUzyQJDF9nJPnG/yTULMCtg0lWR9nSeK0iSZs3gsHPfh4V1oLPIvizKQV0p34UYIu2/aqcAl8+c1Q66GRKRaqKlANAyFOq3F7rPNW7KKwJGFYIeZqiiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SONA3eN2OC4PU+l7smis22zPye/PSzoqE2eTBNPFeIw=;
 b=bnbC6BtVx3oo0W8TBBDd/VLKhPM9H4uXQIUU+arGwgPKZPqjcAICvWv5jIcb2bPss6P2lYme0Loy3oo3a/OPXDz7N5HdiSQuzZV8xA4gx/2vzUbSIkpmsITUFnQQDEkBFpZSuvsA4mXZNrQIEr/+DuKBd8MzV7r1vIiO8FlooE8=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 21:56:43 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::dd75:a3f0:5ec3:f7e7]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::dd75:a3f0:5ec3:f7e7%8]) with mapi id 15.20.4242.024; Tue, 22 Jun 2021
 21:56:43 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: RE: [PATCH rdma-next 1/3] RDMA/irdma: Check contents of user-space
 irdma_mem_reg_req object
Thread-Topic: [PATCH rdma-next 1/3] RDMA/irdma: Check contents of user-space
 irdma_mem_reg_req object
Thread-Index: AQHXZ499v+9XCl0noUOKRKBPyCofn6sgUVwAgABCTOA=
Date:   Tue, 22 Jun 2021 21:56:42 +0000
Message-ID: <DM6PR11MB4692C781B07DD976DD9D7C7FCB099@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
 <20210622175232.439-2-tatyana.e.nikolova@intel.com>
 <20210622175844.GE2371267@nvidia.com>
In-Reply-To: <20210622175844.GE2371267@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [136.49.218.139]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcba7015-edc8-48d5-7603-08d935c89f4a
x-ms-traffictypediagnostic: DM8PR11MB5736:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB57367DA671C4BD724B700C2ACB099@DM8PR11MB5736.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qREHhdbzuU1nxjGaGZKgaQminQEtRzQmcSv0i3e0Nh9rAiePeJiOLxjUkBz7UQdUN5QXAJUEsYlv5IgFfQUawGnuXH2O3g1hC1USgjIou/MfjWLncQ5+Utcc9WRh5uBVheQnMJ2Zd9p+sPBNHLxHxG960CPtOuMvdm2C0oAxKbbujCOZvXt4QW5Zjv3JwaaESQc5RyiHxY9EgZG4Y5gFeiuWgSpiXRXLTIEsLJDa1myrjx8a5sCGs7wZFxea/Y8NE58jvQ46yUMMek5rO/diUtCTdt0zb9pyk0ooS8PFxUbT04t0lH4FY178Wp1HWhKNJteOwRvXYuN1F/h9vkTPhfkKyoCrW5YOfCijFlE2607Ni4OPyzTnIETbnBvZBWWPlT3DVjpEYxH1AIpH70N+o5v/UoDmqLftHv4448dmfzfCWvMSfu6d6k2dUvx8U3ZRPWJY9ZkJ2Z4NuFpjxbm+nvqLc5lc4+d1ODXy6+cqfqPyJiGxhJ3457XlBcjYZSCvumWvUm2BJSa1ALtAD9XjbZhbEp8HvcV21G18yoEhn4PjD78JsEm1oHlp/6oftW8DPxnLCPQlf9TwDdy8V0yKQdS6xOFm/0q5sbHWqHhZgNU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(6916009)(52536014)(7696005)(53546011)(6506007)(54906003)(66476007)(478600001)(2906002)(64756008)(316002)(76116006)(66446008)(66556008)(5660300002)(86362001)(66946007)(26005)(71200400001)(4326008)(9686003)(186003)(8936002)(33656002)(55016002)(8676002)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AcPa0201RsXgH/8BEmojEquQy7KWhPL3iCT60XF8WCH69dzhdVNQtY3xocRq?=
 =?us-ascii?Q?VdTgdbUvHV+7qJjRibkzZ+GG1cjwZZpL9KW2ea8vNs/kr/QnmjhOpWRinlFl?=
 =?us-ascii?Q?sLXfJETjZ0KSaQLMS1xMdRONfwzH9Bn9hNzjyoW721ZG6/7HjA0NQijWt5TS?=
 =?us-ascii?Q?ewumF1egXpLmCcmKj+lo6wuM60STpAEx15YyexHZIe2BpjXmedsaenXwtw/w?=
 =?us-ascii?Q?UnKklSyTHy+N6Sy6tz29grSWjAfGDQ2yYFTEMQyODtDrPymSSEJkPyWnHMV9?=
 =?us-ascii?Q?EaEKhsIwL62kYOrhMglXzRXBBtM1uPiGdBYhXMAcdtoHBYLSyrEKTEBX8I1K?=
 =?us-ascii?Q?8PDTYIe8Yx657xZL+qhBJgdhD0zuhxeYR9qWpJTr+2JpsKgIaqbsSd3mIn94?=
 =?us-ascii?Q?vvukfrFHMMfLJDGSTXhuq2WByEZgcrx3SHkkHzyHF0DGiAH3uk9T1uWfI3bp?=
 =?us-ascii?Q?/zdD8mmczWcV4foAVccg/s4kjxY3M4kM8MSP6ILpIq34E/tLQ9mUO+tSFP0H?=
 =?us-ascii?Q?BwT5oMVwhFM+JAPUmaivrKm6nG1fRBuPp7iGsrMT5vgWtRA4K46ZprciF9rv?=
 =?us-ascii?Q?IGMEPZ7BEg2MC3LZ9CY3yVSIiswo/LRESzhhS1FPqTKiuHoUE+cnjaSKO6Yu?=
 =?us-ascii?Q?k7q+6MVSwwvkY7J15Hg4B4qCCR4D+4iAqrA4fNHojJ8nPy0NCKmUGGZDGmLZ?=
 =?us-ascii?Q?6qWKeI1o88YSk7RjLus+KGDj57kdJ6e7ARomQEytnyosiu0AGn8/LjVUyA4R?=
 =?us-ascii?Q?wbmpWIx70Ep83WJTbKcnFc8vA0T3+4lpjTvTdfxgh6kTGFuALvrdctlCbedC?=
 =?us-ascii?Q?rjh5ZLzEDAnQjE2f86wDEmypxrEnvVBavyXU29Tic82K/nC+q9ffXXU/brag?=
 =?us-ascii?Q?FZrqusmW/vJaO9bZ2cFr75TzKhvuLeDS5Z/kyD5L1iITwD8ZJ1MuxA+Azf1h?=
 =?us-ascii?Q?sdQDWhxC/IZ1x8tAyOBKhtvhmf0wL/oA9kzuq/BaY5j3bRhpxRODxFAq+YEL?=
 =?us-ascii?Q?j4sXHCkM1YVpGRdtS0uoZ2/51YGHaRpGVzZeBAjXmYRL10IJI03NiywEaFD0?=
 =?us-ascii?Q?r3lD2PM+99NzO0tkgDmeudWD4GBafxySPHNCx09DLtKL3/94GDuoVoVwqhrd?=
 =?us-ascii?Q?8l61byLL/OL1H6Qjp38OGNI13ln7iFbYjQ1bTduIYzgdrF/OtyctljorKJvc?=
 =?us-ascii?Q?o5sRczVoLUMYQodT/zLoeBNw67znsYzs8/IAhDXAWnM3bQ8NZLFOVF/bIM1j?=
 =?us-ascii?Q?8R5iNeDEGBF/gWqc1505AGN0Th0EB0Lx1zgtOzu29AYxl6qLeO3xD1SbYQsS?=
 =?us-ascii?Q?6iJJmeNlJ9RrgA8SLO1w4qcs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcba7015-edc8-48d5-7603-08d935c89f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 21:56:43.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxAEmooUvbKCkWzixtCQe5Xhr9c/Q1zKuURcKvVeY581PNQO6zq9Gpf/r5WokVRnibpwuHJI6UEioF/DbAUQ6iVFSVT7X5Hta0ezjP83e3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5736
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, June 22, 2021 12:59 PM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Saleem, Shiraz
> <shiraz.saleem@intel.com>; Ismail, Mustafa <mustafa.ismail@intel.com>;
> coverity-bot <keescook+coverity-bot@chromium.org>
> Subject: Re: [PATCH rdma-next 1/3] RDMA/irdma: Check contents of user-
> space irdma_mem_reg_req object
>=20
> On Tue, Jun 22, 2021 at 12:52:30PM -0500, Tatyana Nikolova wrote:
> > From: Shiraz Saleem <shiraz.saleem@intel.com>
> >
> > The contents of user-space req object is used in array indexing in
> > irdma_handle_q_mem without checking for valid values.
> >
> > Guard against bad input on each of these req object pages by limiting
> > them to number of pages that make up the region.
> >
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1505160 ("TAINTED_SCALAR")
> > Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb
> > APIs")
> > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > drivers/infiniband/hw/irdma/verbs.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/irdma/verbs.c
> > b/drivers/infiniband/hw/irdma/verbs.c
> > index e8b170f0d997..8bd31656a83a 100644
> > +++ b/drivers/infiniband/hw/irdma/verbs.c
> > @@ -2360,10 +2360,8 @@ static int irdma_handle_q_mem(struct
> irdma_device *iwdev,
> >  	u64 *arr =3D iwmr->pgaddrmem;
> >  	u32 pg_size;
> >  	int err =3D 0;
> > -	int total;
> >  	bool ret =3D true;
> >
> > -	total =3D req->sq_pages + req->rq_pages + req->cq_pages;
> >  	pg_size =3D iwmr->page_size;
> >  	err =3D irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
> >  	if (err)
> > @@ -2381,7 +2379,7 @@ static int irdma_handle_q_mem(struct
> irdma_device *iwdev,
> >  	switch (iwmr->type) {
> >  	case IRDMA_MEMREG_TYPE_QP:
> >  		hmc_p =3D &qpmr->sq_pbl;
> > -		qpmr->shadow =3D (dma_addr_t)arr[total];
> > +		qpmr->shadow =3D (dma_addr_t)arr[req->sq_pages + req-
> >rq_pages];
> >
> >  		if (use_pbles) {
> >  			ret =3D irdma_check_mem_contiguous(arr, req-
> >sq_pages, @@ -2406,7
> > +2404,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
> >  		hmc_p =3D &cqmr->cq_pbl;
> >
> >  		if (!cqmr->split)
> > -			cqmr->shadow =3D (dma_addr_t)arr[total];
> > +			cqmr->shadow =3D (dma_addr_t)arr[req->cq_pages];
> >
> >  		if (use_pbles)
> >  			ret =3D irdma_check_mem_contiguous(arr, req-
> >cq_pages, @@ -2748,6
> > +2746,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64
> start, u64 len,
> >  	struct ib_umem *region;
> >  	struct irdma_mem_reg_req req;
> >  	u32 stag =3D 0;
> > +	u8 shadow_pgcnt =3D 1;
> >  	bool use_pbles =3D false;
> >  	unsigned long flags;
> >  	int err =3D -EINVAL;
> > @@ -2795,6 +2794,10 @@ static struct ib_mr *irdma_reg_user_mr(struct
> > ib_pd *pd, u64 start, u64 len,
> >
> >  	switch (req.reg_type) {
> >  	case IRDMA_MEMREG_TYPE_QP:
> > +		if (req.sq_pages + req.rq_pages + shadow_pgcnt > iwmr-
> >page_cnt) {
>=20
> Math on values from userspace should use the check overflow helpers or
> otherwise be designed to be overflow safe
>=20
Hi Jason,

The mem_reg_req fields sq_pages and rq_pages are u16 and the variable shado=
w_pgcnt is u8. They should be promoted to u32 when compared with iwmr->page=
_cnt which is u32. Isn't this overflow safe?=20

Is the issue you are mentioning about this line:
> > +		qpmr->shadow =3D (dma_addr_t)arr[req->sq_pages + req-
> >rq_pages];

Thank you,
Tatyana
