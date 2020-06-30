Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E54820FA72
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390261AbgF3RWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 13:22:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:12593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387782AbgF3RWM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 13:22:12 -0400
IronPort-SDR: RjH6ue08zMgPMpCmA3efDbyGSp1+o43FuSaVjTUek182RrfLR2sEczwJH2SWe0+HlfAZaOOGwS
 yiPzzWlVzBAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="133776249"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="133776249"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:21:38 -0700
IronPort-SDR: +FqY2mTpewfoE93KuuxJvfqIFBfJAet/hrU6/6DB8zi5lq+775Oxp29t0tnuL4nDSAxBQtNDYo
 zqUuBBTz0Hgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="265172541"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 10:21:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 30 Jun 2020 10:21:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 30 Jun 2020 10:21:37 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 30 Jun 2020 10:21:37 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.59) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 30 Jun 2020 10:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc0AbV3xQtf+07UMZ1InsI2PZfY8Y2bQzjlCTBg361XckVjvajqG1YHgKCGap2yxBI81htzfC+TXBtzXrm+U32vSnzrpXkvXU/xMHZINnXffoDm53quLglE40w0d31NC0l8q1MW9oqVa7NTFufWJgF3DrpJcMR20xiytN/Ey/aVPbqrIO+Zz2z2ziFVljhhBa3757+ZrBPw3Ech+aMDJkS5Kc+C5svj0SkE86pXq7W2c0nUW1YRdKN2txp2t+C9EzHGBKhuPg6qBT/QQoahf+Dm9YxCSroyuoeUcd30tOrHrTKrYeFY1K26xIxvKZCM0iLDhm7jOObdqiFD29CfoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sixpFxyVva9W4KvRMzm/0oBbUoH0h/qpe6M7G7MeT8=;
 b=IgsdBHxHytyIAItU7+zVlr0i7OzMaWxVBD6MdNLMPpDeZ9VPiHEm0TQhj1zfMX1FpVAqQizA3NwCyf9I5GIV/utVN1eJrsmogXds+WbCdCJap+psE7b1MlMswSpopuH3tzZGv1E0PirQAr9Y9+KUsqLz+XgwRdg08taYUDgJeVTBmEy8K2hf+FX+zi0zxNI26nEhOgtk9/xYU7v8JpXrjtLLyC2s0b3XrZM+QgmwxZVOxgYHDepZnitndXGy3rIrt0xa28AiGo41X5O7HjZKykCkrKfK31v56cM22zSPovj4rexbuJ/pjbBE6uJ+PETK4pKI5PAEH3tBBEpQYQaARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sixpFxyVva9W4KvRMzm/0oBbUoH0h/qpe6M7G7MeT8=;
 b=nkFH9cZC+LPCD0NqNKMOSBcBpD8A7zcjBm5DQ1Ox3DTskzU27d0cN8/ImKRHHMAFNqTRy76V8riJiyozadPVHJLi5a3XRdz+m/HQGwTBoMg3qL5duvkaqTSXe/yZOlSexKbhCwfYw05twLPvUP4p/kZBDXw2/gwyOY1JT2N+lvY=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Tue, 30 Jun
 2020 17:21:33 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ed68:a00b:2bb0:21cf]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ed68:a00b:2bb0:21cf%8]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 17:21:33 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: RE: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Thread-Topic: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Thread-Index: AQHWTjmKZPnzyjUH+EiOzVuDukOX/Kjv8EEAgAFgqNA=
Date:   Tue, 30 Jun 2020 17:21:33 +0000
Message-ID: <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
In-Reply-To: <20200629185152.GD25301@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0548b516-5d9c-4daa-b9b5-08d81d1a0929
x-ms-traffictypediagnostic: MW3PR11MB4650:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4650778402E8303CF824B940E56F0@MW3PR11MB4650.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8PRji+z/USqgtRKsn/YCnTrfy+FiJxG2M1lRplze9rswlw27gDTWeFXs65r33cHrOMEZIJtleEihHWa8SA+Hjo9BvhPKR6EawVyTp0nf33gv1dTJH44kBEchbFJuz/Wv4e/g2/7Li2JNmaHO3KcL4ZWGYZoy+mfIkhqVT4j8IPBhXpBKgC+dvlA9Rr2QqA+pRMN1x0vV+Cy0IsWLbNEQR0aNIbUpVzH88BJbG0HIVsdktSpY7jz52I7ZkgRnh1bc1T3SAwbj/wXAgZjoUqM/aUhbvdlOts1vM9JQpJ9bfXQUcY2acTXnJJcunCA5mjemiSPzxhRRY9zdZZn6hPHeEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66946007)(478600001)(8936002)(8676002)(83380400001)(6916009)(54906003)(53546011)(86362001)(186003)(26005)(316002)(2906002)(7696005)(6506007)(52536014)(33656002)(66476007)(66556008)(66446008)(64756008)(5660300002)(4326008)(76116006)(71200400001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WicpvY8LrEvzBfmm91c9B1Lrmh0zDFxwK0PsXFF95WfxnpI7J1S3Xh+mVkd8nf1dCUkX4tdF1mbcAVynCDF7zkUZNSj9QdT3WAxwOaXGj4jRjMMMSaQZayoeSJkFQCImJmkOJel3o7fo9GCfu6HCl8Z6LhT63mRPUa1KQh3XxlNJJ/FBUOqyHYip+qD/fINC06LDIHA8bsgtYQW+wFDVbgmz8pFrJGzCYdMJde/kMtd6EvHkVNIUjl8mWFzbf+Bm/HMDLxwn7Do6yeZRhsRSq0yDEogXINrqTf14N1wB+L85uK0Oscb6OPVPbSp2DLQ9UuYHjZNerrYKhmGpcD9HevDxYgab5LWAPuQmaHRVY0prHVe2ShGW1v5ahIJw6Nje2OP6rclrrFrFHiksAcIP0XnuORiYut7x70r0IMB6R85YEP2so1oDhjtJTmpxQqADADcH+WU05W8GdMX2Xj89bf4Js2CG4SlBcJxtpMDOL4QK4zMoGH6HlnhoWf2Abr9z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0548b516-5d9c-4daa-b9b5-08d81d1a0929
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:21:33.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqAE0DWY0Q0G6cVIzi2JM36XROYjp0ZSG+qgEqO1k+H5wWUzhYIXQj2UDG4Y3M2dZ2xBQf7QygChnUCoXYRejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Monday, June 29, 2020 11:52 AM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>; Sumit=
 Semwal <sumit.semwal@linaro.org>; Leon Romanovsky
> <leon@kernel.org>; Vetter, Daniel <daniel.vetter@intel.com>
> Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
>=20
> On Mon, Jun 29, 2020 at 10:31:40AM -0700, Jianxin Xiong wrote:
>=20
> > ZONE_DEVICE is a new zone for device memory in the memory management
> > subsystem. It allows pages from device memory being described with
> > specialized page structures. As the result, calls like
> > get_user_pages() can succeed, but what can be done with these page
> > structures may be
>=20
> get_user_pages() does not succeed with ZONE_DEVICE_PAGEs

I stand corrected.

>=20
> > Heterogeneous Memory Management (HMM) utilizes mmu_interval_notifier
> > and ZONE_DEVICE to support shared virtual address space and page
> > migration between system memory and device memory. HMM doesn't support
> > pinning device memory because pages located on device must be able to
> > migrate to system memory when accessed by CPU. Peer-to-peer access is
> > possible if the peer can handle page fault. For RDMA, that means the
> > NIC must support on-demand paging.
>=20
> peer-peer access is currently not possible with hmm_range_fault().

Currently hmm_range_fault() always sets the cpu access flag and device
private pages are migrated to the system RAM in the fault handler. However,=
=20
it's possible to have a modified code flow to keep the device private page =
info
for use with peer to peer access.=20

>=20
> > This patch series adds dma-buf importer role to the RDMA driver in
> > attempt to support RDMA using device memory such as GPU VRAM. Dma-buf
> > is chosen for a few reasons: first, the API is relatively simple and
> > allows a lot of flexibility in implementing the buffer manipulation ops=
.
> > Second, it doesn't require page structure. Third, dma-buf is already
> > supported in many GPU drivers. However, we are aware that existing GPU
> > drivers don't allow pinning device memory via the dma-buf interface.
>=20
> So.. this patch doesn't really do anything new? We could just make a MR a=
gainst the DMA buf mmap and get to the same place?

That's right, the patch alone is just half of the story. The functionality
depends on availability of dma-buf exporter that can pin the device
memory.

>=20
> > Pinning and mapping a dma-buf would cause the backing storage to
> > migrate to system RAM. This is due to the lack of knowledge about
> > whether the importer can perform peer-to-peer access and the lack of
> > resource limit control measure for GPU. For the first part, the latest
> > dma-buf driver has a peer-to-peer flag for the importer, but the flag
> > is currently tied to dynamic mapping support, which requires on-demand
> > paging support from the NIC to work.
>=20
> ODP for DMA buf?

Right.

>=20
> > There are a few possible ways to address these issues, such as
> > decoupling peer-to-peer flag from dynamic mapping, allowing more
> > leeway for individual drivers to make the pinning decision and adding
> > GPU resource limit control via cgroup. We would like to get comments
> > on this patch series with the assumption that device memory pinning
> > via dma-buf is supported by some GPU drivers, and at the same time
> > welcome open discussions on how to address the aforementioned issues
> > as well as GPU-NIC peer-to-peer access solutions in general.
>=20
> These seem like DMA buf problems, not RDMA problems, why are you asking t=
hese questions with a RDMA patch set? The usual DMA buf
> people are not even Cc'd here.

The intention is to have people from both RDMA and DMA buffer side to
comment. Sumit Semwal is the DMA buffer maintainer according to the
MAINTAINERS file. I agree more people could be invited to the discussion.
Just added Christian Koenig to the cc-list.

>=20
> > This is the second version of the patch series. Here are the changes
> > from the previous version:
> > * Instead of adding new device method for dma-buf specific
> > registration, existing method is extended to accept an extra parameter.
>=20
> I think the comment was the extra parameter should have been a umem or ma=
ybe a new umem_description struct, not blindly adding a fd
> as a parameter and a wack of EOPNOTSUPPS

Passing a 'umem' leads to some difficulties. For example, the mlx4 driver n=
eeds to
modify the access flags before getting the umem; the mlx5 driver needs to p=
ass
driver specific ops to get the ODP umem.

If the umem_description you mentioned is for information used to create the
umem (e.g. a structure for all the parameters), then this would work better=
.

>=20
> > This series is organized as follows. The first patch adds the common
> > code for importing dma-buf from a file descriptor and pinning and
> > mapping the dma-buf pages. Patch 2 extends the reg_user_mr() method of
> > the ib_device structure to accept dma-buf file descriptor as an extra
> > parameter. Vendor drivers are updated with the change. Patch 3 adds a
> > new uverbs command for registering dma-buf based memory region.
>=20
> The ioctl stuff seems OK, but this doesn't seem to bring any new function=
ality?

Thanks.

>=20
> Jason
