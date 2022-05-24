Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF44C532F3D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiEXQxw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiEXQxv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 12:53:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848DC6D3B5;
        Tue, 24 May 2022 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653411230; x=1684947230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q/Lx9Uy+Ynjn/7ObGa3Z4eP9kw/OdCN7GgoXd8aGlrs=;
  b=AMEwAIwgp9FURu8zJ/3Rcmbtw3MA+201B1S0Wu4afe/VSQhl2S/EO1Z7
   bF/9+t0zOzhkIDqAc8aRUH7ENjnkcGbM/vptdTYIMHy+1hKu8cel/VngN
   CrBR2kheJ1Ie3rp0GsFTP26SM3111N5e58hGzYEC5Kr+PKx49tgDCY/MZ
   /9zIWCtSz0as4BKRedwBY9VhMMRopUd3nGupBNUJnZ+r7rLZGOu+KO9Os
   8tXYkEH+srV4WnLKDWQXWacNj6A7Q0q9a+xwTUC/ZCMV2+PS0jfHJnrm5
   dSLXpw3XLj0h2w8mv2LRpXRfRKOS/mc3ngIMmjVcBdnTW51k5W53Iznmg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273580850"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273580850"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 09:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="663987422"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2022 09:53:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 09:53:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 09:53:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 09:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkJ8/4gmaPp1+ThcaGlgmnJ6j7MMrNgAL0NUYVIvnBE3+H6YW9/woueANIrF5t9dws9tLXmsSvH6i7eDaSrXGxurvIdlHb1q1xSpoNIfXuu0pL+WqSklafJmmyalOb/LPsYB+zhwEd7ey/OxIQTG6SCKdLywZdP0MmjfUVmtgOSZSrJq7ScTLqmZ6VsE3/0JKqBNmP2QB2iy8ejmJ3ADNop5LJn7PHUENSt3dJ54VdL1by7xbzRmkgGTHU33n4r5QeQ5uHpfQae5rfxcP33Vs/kD3jtBs3hJzMBkGx+phnwDfyfKRQ/CzFS1GbhgTpzXGVNOoOEHNAt7PEuKTNK72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QeYlDo9cq7CwdPC2ZCfK/eY3IiK496NoVsDEB/2/00=;
 b=Q7WyDKPahMF8KDIc00NFoPj9LiiPGiB7wUkjDhkeXWx2OILMQr4uYkN2MhyCkls7AhnVYMJipA1ybwl4tqsRa3cStv6ksfzQAXDcPyq/qy+PKQRl2WDRwqwDdWMIn0o/qhb8WPunq2IKsQb0pTsiEOdIXWe8+gWhN/vnUnDsKGQA3Nl9d/T5xxvlaWiZbKDLXrsiEUR+zXjb+l5D69wmFXFyf7J4RTbA4QP+TImyG6UiG/dnodiW5/Lpe6G9Bz+PMQAgXl+kOaTD8DHOch8YqiSwQAtOHf9iilpXA74QwcFJy9J3n1lUUOD55YpLeSD74X2bX4gqTjs78tf6uJ/eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by BYAPR11MB3704.namprd11.prod.outlook.com (2603:10b6:a03:f9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 16:53:46 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::4c1c:f0a6:2e85:4df2]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::4c1c:f0a6:2e85:4df2%7]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 16:53:46 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Initialize struct members in
 irdma_reg_user_mr()
Thread-Topic: [PATCH] RDMA/irdma: Initialize struct members in
 irdma_reg_user_mr()
Thread-Index: AQHYb4Jn++uEhOvAVkqr/YS58HKDLK0uKOsAgAAQZlA=
Date:   Tue, 24 May 2022 16:53:46 +0000
Message-ID: <MWHPR11MB0029F37D40D9D4A993F8F549E9D79@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <Yoz4iXtRJ8jw6IeD@kili> <20220524153600.GB2661880@ziepe.ca>
In-Reply-To: <20220524153600.GB2661880@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd777f44-1199-4cd6-9a6f-08da3da5f7b9
x-ms-traffictypediagnostic: BYAPR11MB3704:EE_
x-microsoft-antispam-prvs: <BYAPR11MB37043FD53F31FD2A87CDFD47E9D79@BYAPR11MB3704.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4H49K5jxqE5xFY3jj/Gaac00OVJioa0gdaWVYXvpqWVQN+spmX9O3sdD1BmssHVp5uvqiexIZ3hp77ukdt5WOaoKBxGd/6FH9B+KnwMNUQk5PPksdscaZB/UwUZ/ypnKFXXpXzQjpdPNqgQx5QB9kLpTCitpE5Uq4vxpq/pc0HuOn5DmztRdzX0vBj3xTmX3HqGa7gFo4Y48MvjtcRunsvjpabY1Cf+iJcBzr6/xekCP09wBknZo8Ov3SCnt4BrVNeoqU94tMeHE6/i6sjQkvNqjI9tfkY4oadPvZ2NKZ8L8ubbOcWARDSyqyzK1796x33iA1SITj2gN1Y5m6mqWDQknwf+uRqCufWE2IPM3//ORmPqg/CX0kPqaCZ+hXPClKIyDjU7/l0R2nVeCAtR3EbK4LcY++zWBV5oF9sPLNnd4m8kM4fVwO2izk27yNtNYEAxXwemI4jcvWPZsaB8sx6QKnMml/7i77advoFoB9GafjNuS3bQYHbSeIqSdwnxb+e72J0q4wGxALVDig1ReVRKaFBMTYH62/kcZjtdUVmOjhUMkkKm4d1JG9XxiZGNm2OK+XCM27SzALfpwnMvvFvgJQ3IxtnZex8Xx6rjPxJ5EH1dwCXDV91hpuE/rPUi5HX8N5j1K8m36iCXdxIcTMIES1FDRcHzbiCN3u8no8Tti8BoTA2xLX+a5FZr+fHUFD5u9ejFwNw+yOXUg3lutXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(8676002)(7696005)(64756008)(2906002)(4326008)(66446008)(316002)(66476007)(38070700005)(38100700002)(8936002)(33656002)(55016003)(52536014)(122000001)(82960400001)(5660300002)(508600001)(83380400001)(66556008)(71200400001)(54906003)(110136005)(186003)(9686003)(26005)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?etDbKd/bMhaWlwTQisJcGLAlrORLPWB0v+/z0v2vpPxYOYosQy+lb+bCGbpW?=
 =?us-ascii?Q?Af+bKH5Fci9NAWvIZqSydGYmFsbiiWgzDYvBXeQ5L2GGunAIVtraebn3IoOY?=
 =?us-ascii?Q?22gSJ3ZNIBuEaQcvJ9hQhKYpiGlUQSHi+qlo6RAr+MlrFtq3U8xWTx/mqYLN?=
 =?us-ascii?Q?fAHc0i/UWHHwwfdBSR0Igjxkz00x5NjQcoIRwBVUZX+bzChS9errfnUeYXqf?=
 =?us-ascii?Q?y+X/3ymMmzaZkicFKOBdfL5QcgZHEi8dPHoPP8smeupT63lS7eiBMSVDMiEW?=
 =?us-ascii?Q?lflBbp5LLmItg98TaqVgtLBepi2A4z7UtNVyncgHcTY81rMUtsGpXJcj8joq?=
 =?us-ascii?Q?Zsq9IZop/cZuYEuhgZHjciQql1UbfmjLmM9Jig8gWXjUWQMMlixxXBrnKwAq?=
 =?us-ascii?Q?waVF4O1ssGq4iP66bSPgso89IApTIxbMr6aNaD339HX4JaMUN1KUIRSAnQ6v?=
 =?us-ascii?Q?WDslFZxjYSMINFUTD/M2uLtkNIEdKs7osNbkMrqBX+FiRw4s6civRKKwg+F3?=
 =?us-ascii?Q?ZXJVIbY4toPRFPRlEj32S+3yJ5YsoNESWeS+fadAtmVPw982bBlDSvqmua0G?=
 =?us-ascii?Q?iz5DWjXsmeOdHOodpWCFX7VGtfp+VnaKcUCAIiW/gbkGCyW1yc2leUxVSliV?=
 =?us-ascii?Q?BAI+pzdU/66IfOKaEMo9JdjpaAEcLkZgqRqLY00Nd5tXO/o85yDwPyAtAGqI?=
 =?us-ascii?Q?/A7iNcQpCrK5l4v7oBsY59GBxtBIig/kbjC1yydFcVWPOekYF2JN0msdPgr2?=
 =?us-ascii?Q?zkp/zloCAUToiPWa0jGnNZjSNM0blDdl5WSskiblW3JM4cyn3U8DTjb1y2WX?=
 =?us-ascii?Q?ipQAbGb7sOAQbrJ9DavwDIYgmstftlBkJ/oj0MYKd6maxgT8e5lbQLDF0H3F?=
 =?us-ascii?Q?7SYyQBlGUEyPDHhuwE9oETyyFGi4Vkt3sOhxY/z6UxGmuW4IXimx22u+gR5i?=
 =?us-ascii?Q?MMGtYnDJmliU26YzShOtXxuQbECwlrsnWxWvwgkpekQwKFiMJWn9VRtOELkl?=
 =?us-ascii?Q?2x3EIURPdwzQx/8o8MsKn/jyjxZVJWUJSyieEllckbxkwLtMeT2qJ4GGnn36?=
 =?us-ascii?Q?AQ2RDU9errX6NdYtXTut1RKQDsTvCuAs586qiBJWs95i8JZJV7C+g7yr2ht/?=
 =?us-ascii?Q?bPBQG5uvCr6mcbksiKoecdKT6HUpfVEnBll9FZxJvFaBq+zrAUYJVCvVyhwr?=
 =?us-ascii?Q?TTjlFOyV2FbfrAFfU3Md6MWkerRWjhi0JmKj0b9C8+cC+zkGBkHD19/5K/mc?=
 =?us-ascii?Q?Q4KMgl60Vvus439Y8hTxoz2qFx3qJbv3rcOWwr1zaJJBOa8fyx91WPcndIjr?=
 =?us-ascii?Q?kLF77KPeLn3UY4mtFTmJalwsOxHowWpdp2sSfa4yjB3/8CJreaCHJzCNYXZs?=
 =?us-ascii?Q?TbLGtOwREcE2mDS6dh/nS5K0EhnzTljYtCIHFueOQmQ8m5Yc4L/1b0C802bR?=
 =?us-ascii?Q?rdjSkhF2LETXXMwVFCTuTsxRulBHfXA6zFkOd8dPoz5P9p3gKtJkFhHDfWI0?=
 =?us-ascii?Q?MUT4VwDasxKjZwPxjNdJAvvHISVN8+eZ947ThXLF5nMipBHuiJ4OtoJw927t?=
 =?us-ascii?Q?MtyJfiurmtAOOUbD6WkCY7V7CMhsw7F2T2jSlTXJSAhap6vJFPjjoV4wQKoT?=
 =?us-ascii?Q?T5XH4s3RxJN8bIVakqfPi9pQRPgxYQjgYpefJtJLQcZxCMZh5pZrlI62xAe3?=
 =?us-ascii?Q?hw4G5fTieOLXVi3BaFzqIbUbs009slc/swJ0mBwU3T0WUF7Y90qnPRPoLw8L?=
 =?us-ascii?Q?h3BpM+RTwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd777f44-1199-4cd6-9a6f-08da3da5f7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 16:53:46.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcUomAWSbBXA99u+Z9Ri8MUgRPTdkYVfGUmXZpLMg6lkkLTNX0mf9zrM0HkzT/n82gKbircJIPbw415KCEANVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3704
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH] RDMA/irdma: Initialize struct members in
> irdma_reg_user_mr()
>=20
> On Tue, May 24, 2022 at 06:23:53PM +0300, Dan Carpenter wrote:
> > The ib_copy_from_udata() function does not always initialize the whole
> > struct.  It depends on the value of udata->inlen.  So initialize it to
> > zero at the start.
> >
> > Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb
> > APIs")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com> What I know is
> > that RDMA takes fast paths very seriously.
> >
> > This is probably a fast path so you may want to implement a different
> > solution.  If you want to do something else then, just feel free to do
> > that and give me a Reported-by tag.
>=20
> This isn't fast path..
>=20
> But the bug here is not validating inlen properly and should be fixed the=
re, not by
> zero-initing and allowing userspace to pass in an invalid inlen..
>=20
Hi Jason -

So something like this is appropriate?

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/ir=
dma/verbs.c
index 52f3e88..aecfedc 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2735,6 +2735,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *=
pd, u64 start, u64 len,
        if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
                return ERR_PTR(-EINVAL);
=20
+       if (udata->inlen < sizeof(req))
+               return ERR_PTR(-EINVAL);
+
        region =3D ib_umem_get(pd->device, start, len, access);
=20
        if (IS_ERR(region)) {
