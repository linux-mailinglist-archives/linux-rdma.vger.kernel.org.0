Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2217F096C
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Nov 2023 23:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjKSWYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Nov 2023 17:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKSWYU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Nov 2023 17:24:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7415F2
        for <linux-rdma@vger.kernel.org>; Sun, 19 Nov 2023 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700432656; x=1731968656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5+VE++eHf8RV893flgCJiOPj7hJ/IaJ9XeCJoJbx+xY=;
  b=lQtnEDp1BUICZR52EHQ9uu0nGtdFHzKhsHYO2mRWlww9v5g/6XHmMeuh
   FzhWCyVufekdjVRzPw6YEajqw6mwHWYtYdnARro0h/PLKXVUW+vP4OU7t
   BW1BEvuXRd5aA6k1gO5IZhNS/oUEWxbFK1apd8H3LAb5+uiQh3kb4VtWD
   SO7MW9hCBNhf3gAjWpagYk/vG7v8vF4VO83hp6PvoNTK3tpR+Vls1O1W0
   kWVRs2vwEVSl6SZL3vTatXrcU8T8a8SsZLxHlO87EHRES8kvTX9KknnlR
   hv+4zam4dzCJAyZt7qLl8gmzPFQlt7rcUnR/sCkccjAfQfOPuhnkVQTXU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4636747"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="4636747"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 14:24:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="883677591"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="883677591"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 14:24:15 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 14:24:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 14:24:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 14:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bptIsTPg71QhA7qga4zxrTcTG/cW3ZZEyGiFeuZ/VbR6U3HJQZi9Mg+EoBXKNhUVSkVbljtjeYI5+NlIWckMKODouzFn1WOkJN01BUaVD+UAK2CkGBQStVgtW9Lx/XGn/h4CSGKclt1rnhWxESwZoKEHYV1vXq/93LNcO4JIsZDhG4FzKzmaoP54pTJuL+zNi9tHydz9B0iN4h7iN+WpZnucKwr4aK4yLyMZAd0mMv5n6jeywM+jHvvPt27ka3WVsn6Nk3tSw9LhHs5El8sxqpb6zEdi4ljUf99Y4tIuDzEByfCyAuZY7Ft5zI6LruMrLK05ia7hbwhrK2tF1ifFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGRGi2oOM2b+qqzc2t9KAByzNseyIqazVeUa0FtuTLM=;
 b=P3T+zE9WlWZlx+mlq3Bq7iyzeobQprj5KkVWXoKFnHPE+Hhmmz7Zq6PecWQM0IvCydWcvUyqJDc6ApsIO5IMq4ZIB3GR33NtRtyVvOdgEnXY8EPZVHBgreThdE3hRdCgcsLqVI0e96eJfiiuZRsdOt1jGDdvRGJqVbO5mp0Xmmxh0NW0BJOW8VTHbT7ZKKmK3AC/Cwjm42v/yqhuCBtc2J9VeHBFlQL2N1AmOvqZYwXC5+FnkBmzCPqV5hYDsipq194txOWQp3Ia+YnP8Y6ymwKggTmC1LxbcNm3WBdULPzh6jdot2b/iy1AHRMWHdrz8X5o7X1BZLY04490lrIwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sun, 19 Nov
 2023 22:24:12 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5%7]) with mapi id 15.20.7002.026; Sun, 19 Nov 2023
 22:24:12 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: RE: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE is
 greater then HCA pgsz
Thread-Topic: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE
 is greater then HCA pgsz
Thread-Index: AQHaF/h9/NuU5o1MfkWULjSmPBue2bB9MEEAgAUL3oA=
Date:   Sun, 19 Nov 2023 22:24:12 +0000
Message-ID: <MWHPR11MB0029FC85107F82C98CB3BB06E9B5A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20231115191752.266-1-shiraz.saleem@intel.com>
 <20231115191752.266-2-shiraz.saleem@intel.com> <ZVZNhpx6oTBS+PIP@nvidia.com>
In-Reply-To: <ZVZNhpx6oTBS+PIP@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DS7PR11MB6063:EE_
x-ms-office365-filtering-correlation-id: 6c689c22-b607-46c0-d810-08dbe94e421b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyToFO3qc63o4l5umt2g5HUUn0D3IKi2ad5/rh0Y3M76ItIeej5Myaz6DxcXSP3gzhnlD+og26An+87+1++D4al+vbvdKQUJL8KuRBh+8Q6twHSLwUr79abo3xxtcvVqQYQKpXfgdW9/XazLKBhDykA56XTotSTRvtZoF5xWprbZbQV0flmZA8rOVVghhhXGbqJGLZFIj/yMa4/JcT/3zGOmFVFrryBwbJBlVyp7jsmESZP35PNcfI3essioZcL/kb8HEZr45LUQfgkTC6D0OYlhIECmRNo3Hx/FH0xqa9wV4rhC1M+97HkIvbdTIWA9VAuo7UP8NJaF87L1hRcjL/E4C1ekXtsG9ATmOUPIHqb8OpzB+QTnbheIDZ9xqycROQpNpzaNBijnnoYnY6hdnDsd0v8464wLd4ibA3gTB8sn4udAiOmNI1amFOWDkoSE7ny3g+ewkM94XL9mEuROtDQKxB2p3AfQsWQucQECLx6FDza0Jr+NVlBEprivot+qegr0QCwA2fbd4P5sr+eHnnYJtYZeCDYDzTDzsHlNZlSxki6j8puhGL22QfoP3ZSj7hfWowvvv/B/bF3jzdqFHJXEuJigRm17wN90IwgJM3ueKPtl9r4gMrYjNGSaWeuK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(107886003)(33656002)(6506007)(7696005)(9686003)(26005)(71200400001)(478600001)(38070700009)(41300700001)(86362001)(2906002)(66476007)(6916009)(5660300002)(52536014)(66446008)(66946007)(54906003)(64756008)(122000001)(76116006)(66556008)(55016003)(316002)(8936002)(82960400001)(38100700002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?67dHRtnSE70Y0y5M4dJTO3S8yZlxw0+apPlR3bE/GDecQZxVZxmtkX9rYrEz?=
 =?us-ascii?Q?d6Z3h5+lM02dat01TKAHULRYeaLPZexFYhHnyE/qciHfZA5f9ND0JSo8zmb+?=
 =?us-ascii?Q?Ce8FulcMxvbwSPr/3aSU38wI6G5DEtVCIO3yahAQ0Q2oyxaCSrp3pF/Py504?=
 =?us-ascii?Q?tTpZhbvOXmIH2anSZYWx3bKyBqvOSvbFfszNX6Bw8SOi/MIoK/rt3gzBz0nz?=
 =?us-ascii?Q?Epr1weRx7/FZ4F5CmyoBh5GxTm1uSyBs8c9YBw8rtHQkAOQszuEX74vXGNKO?=
 =?us-ascii?Q?/D5ixEP0csj6w+ZaixviaInPccSsk2cTVkn5zQX1GWYZH31w2EmmsJ2vOCJC?=
 =?us-ascii?Q?WRd21PFngqFCaq/EDYofJVDi4hm9b3s8dcYF6u/rDIgV/UXbdf+YSCGEbR4o?=
 =?us-ascii?Q?B8M2gkKlAwPZxJ8FGjpB8rNSaLLSHoQq2Hc+FzZ2T1e2pq8dNAbEyRhgNbos?=
 =?us-ascii?Q?IYXetVGQmuqEQjqe0XiAT6MS0rgnCKEJMrURrifLF5Bcpzi3MC18sKSVi7LY?=
 =?us-ascii?Q?6gRh5ckgV/JJShTqa4ycjJVoEEXi0HRRP3VEGj8fOKTcxG1gq9AHqLJS1bt6?=
 =?us-ascii?Q?r9UGdr7I2GcLQDRNQnca7PiJDS6utCukj2b89Gf+hRDTZ2EgWN/qb2RsZuk9?=
 =?us-ascii?Q?JakPyZWyQup75xHJmW1T6ATl9Pl1YQ2HkSTeXR9RiM2F8ZxG6SkoCeCd7ktY?=
 =?us-ascii?Q?lL5015LaQ0IgBgedFMJ7efyEa7r3goVZ21s7h77GmL3G277nWZy0n7XN33Pb?=
 =?us-ascii?Q?4On6m44TC/VLucGvEFLPJudgzxOKs89cFrn7019K/yzp70mVSYkEmYyi8AoP?=
 =?us-ascii?Q?YQYNjL9C0TEj1HIP3b2vwvT5K/rRBEpUDC5aOpTI0OElLpnBiwlBd0BdNjuB?=
 =?us-ascii?Q?+K3b77x2g3zObJR8tbKBsgjQOkpvOJ74XgqlIb/hj9qimGS7lFA5JyTCMLmm?=
 =?us-ascii?Q?hU5ODuNZD3Iu7zsLLhErvjrq4if3hYtvTLmkDbNvmLME6wTuvbb+DvXLQA0s?=
 =?us-ascii?Q?/wRxAHIdwciXs8K9oF3Wy3pSevWqxYEUxXzVV4T9rNezWeNd7QyDkJFecGzU?=
 =?us-ascii?Q?3ilwx7V5EuXwri+9HYU87QeJY0G9Yt8WWCpVGfecgRGmPJ+zKPTCrQtILsu6?=
 =?us-ascii?Q?Rsd31qwncX83SHwoA08aBd9mpcMfaUbB4V1dQtfPqw+3cdkp2XtvqTdVjY2b?=
 =?us-ascii?Q?A2kcFrOrxKf/HTiLWWkf7Dbcvm27gBvn8lUctQJIgIy7kCgNZYo7Sr87tBTj?=
 =?us-ascii?Q?SKo3Zfa8sa/z2W6KcaG1DOTKM7VoyPVaqT7LHH3g0sLNIG0YXpt8G3s9Q4XT?=
 =?us-ascii?Q?5yEjLyDbirqK0FEjvALmXvZUiwf43Qf/eiDTWs9hYgygUVzcjaCjfoJT1F9v?=
 =?us-ascii?Q?RnARJcj3I+h4fxgnwqWqbT+QatZy1VnH56N3X8BZT0ASN/Q10germzMRnjZJ?=
 =?us-ascii?Q?3jHplap6YvWIiIIlP6mlJao03wyflV8NwWhs9XliuoCX2YYelY++DHUQ3TJh?=
 =?us-ascii?Q?1BSw0t39woeLcZV3ho+h8/NYdwTWnuBvVYsF3/SJxfj5yCyQMTP0MTSKtu1R?=
 =?us-ascii?Q?kbWYH7pvAT37XjiBNnlCXBUpzAzEXiWprz5s0Bbo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c689c22-b607-46c0-d810-08dbe94e421b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2023 22:24:12.8361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zO1vYUIjF9+hmxbajOF6fPj38njN74bBF0E/X0KbxRPy+Q2zrfy6sXVobQUJ32rn22fNbvl18N29tAZOuJjJqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SI=
ZE
> is greater then HCA pgsz
>=20
> On Wed, Nov 15, 2023 at 01:17:50PM -0600, Shiraz Saleem wrote:
> > diff --git a/drivers/infiniband/core/umem.c
> > b/drivers/infiniband/core/umem.c index f9ab671c8eda..07c571c7b699
> > 100644
> > --- a/drivers/infiniband/core/umem.c
> > +++ b/drivers/infiniband/core/umem.c
> > @@ -96,12 +96,6 @@ unsigned long ib_umem_find_best_pgsz(struct
> ib_umem *umem,
> >  		return page_size;
> >  	}
> >
> > -	/* rdma_for_each_block() has a bug if the page size is smaller than t=
he
> > -	 * page size used to build the umem. For now prevent smaller page siz=
es
> > -	 * from being returned.
> > -	 */
> > -	pgsz_bitmap &=3D GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
> > -
> >  	/* The best result is the smallest page size that results in the mini=
mum
> >  	 * number of required pages. Compute the largest page size that could
> >  	 * work based on VA address bits that don't change.
> > diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h index
> > 95896472a82b..e775d1b4910c 100644
> > --- a/include/rdma/ib_umem.h
> > +++ b/include/rdma/ib_umem.h
> > @@ -77,6 +77,8 @@ static inline void
> > __rdma_umem_block_iter_start(struct ib_block_iter *biter,  {
> >  	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
> >  				umem->sgt_append.sgt.nents, pgsz);
> > +	biter->__sg_advance =3D ib_umem_offset(umem) & ~(pgsz - 1);
> > +	biter->__sg_numblocks =3D ib_umem_num_dma_blocks(umem, pgsz);
> >  }
> >
> >  /**
> > @@ -92,7 +94,7 @@ static inline void __rdma_umem_block_iter_start(struc=
t
> ib_block_iter *biter,
> >   */
> >  #define rdma_umem_for_each_dma_block(umem, biter, pgsz)               =
         \
> >  	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                =
  \
> > -	     __rdma_block_iter_next(biter);)
> > +	     __rdma_block_iter_next(biter) && (biter)->__sg_numblocks--;)
>=20
> This sg_numblocks should be in the __rdma_block_iter_next() ?
>=20
> It makes sense to me
>=20
The __rdma_block_iter_next() is common to two iterators: rdma_umem_for_each=
_dma_block() and rdma_for_each_block.

The patch makes adjustments to protect users of rdma_for_each_block().

We are working on a v2 to add a umem specific next function that will imple=
ment the downcount.
