Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555F42D48A1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 19:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgLISJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 13:09:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:54587 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgLISJQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Dec 2020 13:09:16 -0500
IronPort-SDR: KVdpH0a7As+6A7PfBzheUrXJxNRrNhZ/j0QebPiowhZ8a0h2CdGLRpaf1DzWeznw1pKbJ6Q4Kt
 TexykR/Bbtmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="238226466"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="238226466"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 10:08:34 -0800
IronPort-SDR: WtlN1aHi8NF4cLzvXXhCXmwMjuMSh25Sqvm03zH61uE2FDPwITBaL5syG97YaqoCQKxzSRJIXt
 MHzVQLa5w5Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="348424559"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2020 10:08:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Dec 2020 10:08:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Dec 2020 10:08:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 9 Dec 2020 10:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvxYQikVvw2ilC3EOfPpeK3ldjkW/bA29F/uUwmHnAJwVMBWZLXKL/PYjNj345uSisQTX0SA3GwOdvcDt+oktEqc9Metwpa2ElLcd41kjv11BQ9q18tl0rmZLsDgyxyF+8L+KXwHBLHeBCq5dPLDb1RGEYHtIiZzbzy7cBpCuliQ/Z0yZHLl4TsDJfz2FFIl9+Z/0RSAtQVLMX9D8wWGOnThyWNytzwQTcZ1eJOGlJyFo8aNiCpvv5JoLaEVr9tjrIpICmA6N+lVc9PVwD9yw7h4odxpPvyawroZs1B45jDb3AMfcKxJl2DDmxIpJeI83wrPO2k6IOERlBdomPQmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HENYitteGSuT4tOe2C9EyWYuE1fRWFGrtic/ZszZ3ME=;
 b=FID9jLnxW3BicDimtrRgVl+ZeucrhHMWILVIx4ukSOFo/BcifsSnNM8L9+JUe8gFyw5pK3JDmt94SKfezKEgTGiANuERScRj43yzwg4CESfgzHxA5a9VrJw2MuNvtx5A4tFnDQudUJg3l4+ZoC8gMT1hpGfFZLb8AceBlX30uBFKF/MJcl7IABrffDqYBaAlj5KzwCA91WBscBVG+1EEheuhzWCXfeXFyl5lPpI489VkHZYZNBGvXAl50K3pNe+QQRHG4lo0zPP47GAM55K9zipd3yUXktsI6vvCsPtEGnTlPp+AOC+UWghiRkAxLeF0N/Z7iL7qRNh0uLzDDT8cJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HENYitteGSuT4tOe2C9EyWYuE1fRWFGrtic/ZszZ3ME=;
 b=Lu7F9qKIYjPJS5M+cr6UATPyhBELhPDqIeoi6/D6pF2sny0g3ngFUwA+k4HvXMcvk3+KPKiK+Lv113MjYwy287HDMDLauGtrXFCU7oCEhiIaaWwNhTEAX9/lnmGo09LcdrJEkfGA4VRrBUcw6hPasWnGHQS8YSKOhChfmEsvO1w=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 18:08:00 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7510:71a5:3cfe:ab94]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7510:71a5:3cfe:ab94%9]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 18:07:59 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [PATCH v14 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [PATCH v14 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWzbDRIGL8UuxXakeT3neb1dqioKnuTjwAgADB0tA=
Date:   Wed, 9 Dec 2020 18:07:59 +0000
Message-ID: <MW3PR11MB4555499044DA7D47BCD04719E5CC0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1607467155-92725-1-git-send-email-jianxin.xiong@intel.com>
 <1607467155-92725-2-git-send-email-jianxin.xiong@intel.com>
 <20201209063038.GL4430@unreal>
In-Reply-To: <20201209063038.GL4430@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c9f0321-e006-446b-17d7-08d89c6d5cf0
x-ms-traffictypediagnostic: CO1PR11MB4945:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4945D389D8B072BC8E47285AE5CC0@CO1PR11MB4945.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOZ8FLT7Kj6Uw5XPbQfmnlq16t68vS8RT4bRkNaQ0RYNA5/dxZkUjVXlJxmKerl0aZvmVELMMXsyydH1R57Y1a15Dp/9AR6jPR+Oij3VGXE012pUvaNJa3v/j7iDRuOHf7UwQblbNk1sPtotOYbS7qFIMhiCo/fCUYvUr+O8OvNQtTSpMycf01/aWa/NaJYU8zp6hEFw7ceIyQv4jr9tQDlOMyxhXMDNkR9q1RXXTuaAf0M1PnYwODEy4/1Yuv1ECQrLOHcDZ0d18PzDI8T3FgmdfJ/bunO1QgTPkA7KddUtAdWC+HgQhZQ8ioEXC+3kF2xM5syY5MXbl5mFyiuE2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(186003)(6916009)(52536014)(26005)(6506007)(8936002)(66556008)(76116006)(66446008)(55016002)(86362001)(66476007)(54906003)(7696005)(9686003)(66946007)(64756008)(2906002)(107886003)(8676002)(4326008)(71200400001)(5660300002)(508600001)(53546011)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +ujUctfarHA5yDEuKTSkADk8oBG1hPo7RTV48ad9jnEKYxP1wSQJqUUoAXpGfqF1r5U+h9J6rAT1qjqWhGltjymsbSZYAi3CS7e1clwUbvqyGDjOSEyklNtjAUPKYWmp4fdvWgKN74dgAUPHuIQac127nKMrnH8tP8IgJLf44oIjFv5qv+9wTClHjNIsjRXBOhA7BwbLpOaa0tcbG99M1gEGiAJHuJ+qPrDp2HiKZWY39+2wnqxZs/oWGMtq4h0CIwDtRRsdJT4mtPE6pO4V6yQtKtt+4sw/MIe7O/ZkPTpV/ZBHkk4YLCt+67LuxUbR4H2ZGtBR6wAnoS4I9bPoqe7hszidt2uKwD2p8mB6yxwaAH2VBQNRQWBqEWMjsgpbajnUD53Pdafjx+sEdgFo6FbCTJWINjQPKIIweuc5XvcMK06MfXyrYgspukFi9mFJ7aDnijj/dgYP07KppLPAOD1b6EcSJL5ESnOqZcUpjUqaE1Ljbs9B4Gxh5AKDiMhTA/6XO81zwzbLZ4Nk+DAETclXwOLvFWpx6mgIV8LdEXf1kHJsFTTgpz0sQVzztvaKmPUl2BGCXGUeERVxQhsUyAdblYRW26JqshHFlMDiYwhmucxPj1qBU4vazUdQgoVDOm9XYdvMD373uravdDunNFsBNu4stbp4X7lLMmnIlAN3Sw/Qzw00YzhMDv17DCThu1sBW/VE4JhYOfgrxe28S4NVL5W6QD9ykSWqtf+r17k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9f0321-e006-446b-17d7-08d89c6d5cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 18:07:59.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOBtfvRocwOTYbo/wa+dqFXL6+WVSndFTt/aDzRGy3PtF5pFXWA5bO4FFTfK9qqdI4xn7a/07PXywVyct/4yMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, December 08, 2020 10:31 PM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Led=
ford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>;
> Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koeni=
g@amd.com>; Vetter, Daniel <daniel.vetter@intel.com>
> Subject: Re: [PATCH v14 1/4] RDMA/umem: Support importing dma-buf as user=
 memory region
>=20
> On Tue, Dec 08, 2020 at 02:39:12PM -0800, Jianxin Xiong wrote:
> > Dma-buf is a standard cross-driver buffer sharing mechanism that can
> > be used to support peer-to-peer access from RDMA devices.
> >
> > Device memory exported via dma-buf is associated with a file descriptor=
.
> > This is passed to the user space as a property associated with the
> > buffer allocation. When the buffer is registered as a memory region,
> > the file descriptor is passed to the RDMA driver along with other
> > parameters.
> >
> > Implement the common code for importing dma-buf object and mapping
> > dma-buf pages.
> >
> > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> > Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> > Acked-by: Christian Koenig <christian.koenig@amd.com>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  drivers/infiniband/core/Makefile      |   2 +-
> >  drivers/infiniband/core/umem.c        |   3 +
> >  drivers/infiniband/core/umem_dmabuf.c | 174 ++++++++++++++++++++++++++=
++++++++
> >  include/rdma/ib_umem.h                |  47 ++++++++-
> >  4 files changed, 222 insertions(+), 4 deletions(-)  create mode
> > 100644 drivers/infiniband/core/umem_dmabuf.c
>=20
> <...>
>=20
> > +int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf) {
> > +	struct sg_table *sgt;
> > +	struct scatterlist *sg;
> > +	struct dma_fence *fence;
> > +	unsigned long start, end, cur =3D 0;
> > +	unsigned int nmap =3D 0;
> > +	int i;
> > +
> > +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> > +
> > +	if (umem_dmabuf->sgt)
> > +		goto wait_fence;
> > +
> > +	sgt =3D dma_buf_map_attachment(umem_dmabuf->attach, DMA_BIDIRECTIONAL=
);
> > +	if (IS_ERR(sgt))
> > +		return PTR_ERR(sgt);
> > +
> > +	/* modify the sg list in-place to match umem address and length */
> > +
> > +	start =3D ALIGN_DOWN(umem_dmabuf->umem.address, PAGE_SIZE);
> > +	end =3D ALIGN(umem_dmabuf->umem.address + umem_dmabuf->umem.length,
> > +		    PAGE_SIZE);
> > +	for_each_sgtable_dma_sg(sgt, sg, i) {
> > +		if (start < cur + sg_dma_len(sg) && cur < end)
> > +			nmap++;
> > +		if (cur <=3D start && start < cur + sg_dma_len(sg)) {
> > +			unsigned long offset =3D start - cur;
> > +
> > +			umem_dmabuf->first_sg =3D sg;
> > +			umem_dmabuf->first_sg_offset =3D offset;
> > +			sg_dma_address(sg) +=3D offset;
> > +			sg_dma_len(sg) -=3D offset;
> > +			cur +=3D offset;
> > +		}
> > +		if (cur < end && end <=3D cur + sg_dma_len(sg)) {
> > +			unsigned long trim =3D cur + sg_dma_len(sg) - end;
> > +
> > +			umem_dmabuf->last_sg =3D sg;
> > +			umem_dmabuf->last_sg_trim =3D trim;
> > +			sg_dma_len(sg) -=3D trim;
> > +			break;
> > +		}
> > +		cur +=3D sg_dma_len(sg);
> > +	}
> > +
> > +	umem_dmabuf->umem.sg_head.sgl =3D umem_dmabuf->first_sg;
> > +	umem_dmabuf->umem.sg_head.nents =3D nmap;
> > +	umem_dmabuf->umem.nmap =3D nmap;
> > +	umem_dmabuf->sgt =3D sgt;
> > +
> > +wait_fence:
> > +	/*
> > +	 * Although the sg list is valid now, the content of the pages
> > +	 * may be not up-to-date. Wait for the exporter to finish
> > +	 * the migration.
> > +	 */
> > +	fence =3D dma_resv_get_excl(umem_dmabuf->attach->dmabuf->resv);
> > +	if (fence)
> > +		return dma_fence_wait(fence, false);
>=20
> You called to dma_buf_map_attachment() earlier in this function, so if yo=
u return an error here, the dma_buf won't be unmapped in
> pagefault_dmabuf_mr()

Yes, that's by design. Next time ib_unen_dmabuf_map_pages() is called, dma_=
buf_map_attachment() will be skipped and dma_fence_wait() is retried.

>=20
> Thanks
