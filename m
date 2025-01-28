Return-Path: <linux-rdma+bounces-7271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97CA20EA4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 17:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138051888CEE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB61DE4ED;
	Tue, 28 Jan 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+9Wv4LL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE61DE4E6;
	Tue, 28 Jan 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081953; cv=none; b=frQuhcxJ4LXzbdpdHG0kywLd3JyZA1Uv3nLNxC792udcVEzWNmh8OJ8uqNh0KB7UYBaJcLGdFDdi+1zQO3k2FVquKhpd5xdncQbgadV2YG8M4yc7wr6GsPGh2S+ibe7ZORvqE2+k4NC+3+3s5WQcTIy64rDYVkXw8un9FzZUiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081953; c=relaxed/simple;
	bh=QmV+7gtGvGbC0D7AD0FZxKqZ+uJvTV+fE2kcgk9KYwM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcQYA3r0voF9FA236hdqDSPOnUoBZ/H6WsZjfF4DsvmrRwk3gb+wDQ5CW6m9sCWrzFSzORrSOvJEU1jlvf+Dv5s8NtLK3tCZN3oGDs0Rx/p6sqheO2DzCPQ7nJ3ed3lXiYCuD56RjftdFkoJYqgYvxTeAioDx3x6FBzKbkuAHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+9Wv4LL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738081952; x=1769617952;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QmV+7gtGvGbC0D7AD0FZxKqZ+uJvTV+fE2kcgk9KYwM=;
  b=P+9Wv4LLVeIHLm58vR54XJbVSfq1pE3fG0ZY/muvRXDu0GaxkgaSmEKZ
   AZB++9/Gn/JSY4MQajT331tzlxtDLNyoU2Au4r2LoemXYOyHNnqY4wVK1
   lT1XawN/SSb7XN1DW3pG2eEA+BCfQUPBfMPtZfnaq5yBSyg2642mYiIV3
   WHJ5D/hUhQdAvraqRLyHVTM8hfKg3VGTFNrmbTpvGo1A3Rq+4bjsAmkzd
   Tkujn61/S52Sm7amQbrv3u6tt5ovDal6X+a9QDqf+532lGFHg7ZXVcUPg
   9jQAEfJs1tCYbj4JShdTIKEN0bodYlEUq5qflLuk/6wreolBnVA8FDHo5
   w==;
X-CSE-ConnectionGUID: ecvzzQxwSL6PUL+JSSMyvg==
X-CSE-MsgGUID: BvNI/X47T0q9Fmg5eisPdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="56000663"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="56000663"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 08:32:31 -0800
X-CSE-ConnectionGUID: WBIIBAoqTTGl0aER7KaBzg==
X-CSE-MsgGUID: ZX7aVbzyShGdDSqqUk7gUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="139672331"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO [10.245.246.161]) ([10.245.246.161])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 08:32:26 -0800
Message-ID: <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com, lyude@redhat.com,
 	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch, leon@kernel.org, 
	jglisse@redhat.com, akpm@linux-foundation.org, GalShalom@nvidia.com, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, 	linux-tegra@vger.kernel.org
Date: Tue, 28 Jan 2025 17:32:23 +0100
In-Reply-To: <20250128151610.GC1524382@ziepe.ca>
References: <20241201103659.420677-1-ymaman@nvidia.com>
	 <20241201103659.420677-2-ymaman@nvidia.com>
	 <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
	 <20250128132034.GA1524382@ziepe.ca>
	 <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
	 <20250128151610.GC1524382@ziepe.ca>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-28 at 11:16 -0400, Jason Gunthorpe wrote:
> On Tue, Jan 28, 2025 at 03:48:54PM +0100, Thomas Hellstr=C3=B6m wrote:
> > On Tue, 2025-01-28 at 09:20 -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 28, 2025 at 09:51:52AM +0100, Thomas Hellstr=C3=B6m wrote=
:
> > >=20
> > > > How would the pgmap device know whether P2P is actually
> > > > possible
> > > > without knowing the client device, (like calling
> > > > pci_p2pdma_distance)
> > > > and also if looking into access control, whether it is allowed?
> > >=20
> > > The DMA API will do this, this happens after this patch is put on
> > > top
> > > of Leon's DMA API patches. The mapping operation will fail and it
> > > will
> > > likely be fatal to whatever is going on.
> > > =C2=A0
> > > get_dma_pfn_for_device() returns a new PFN, but that is not a DMA
> > > mapped address, it is just a PFN that has another struct page
> > > under
> > > it.
> > >=20
> > > There is an implicit assumption here that P2P will work and we
> > > don't
> > > need a 3rd case to handle non-working P2P..
> >=20
> > OK. We will have the case where we want pfnmaps with driver-private
> > fast interconnects to return "interconnect possible, don't migrate"
> > whereas possibly other gpus and other devices would return
> > "interconnect unsuitable, do migrate", so (as I understand it)
> > something requiring a more flexible interface than this.
>=20
> I'm not sure this doesn't handle that case?
>=20
> Here we are talking about having DEVICE_PRIVATE struct page
> mappings. On a GPU this should represent GPU local memory that is
> non-coherent with the CPU, and not mapped into the CPU.
>=20
> This series supports three case:
>=20
> =C2=A01) pgmap->owner =3D=3D range->dev_private_owner
> =C2=A0=C2=A0=C2=A0 This is "driver private fast interconnect" in this cas=
e HMM
> should
> =C2=A0=C2=A0=C2=A0 immediately return the page. The calling driver unders=
tands the
> =C2=A0=C2=A0=C2=A0 private parts of the pgmap and computes the private in=
terconnect
> =C2=A0=C2=A0=C2=A0 address.
>=20
> =C2=A0=C2=A0=C2=A0 This requires organizing your driver so that all priva=
te
> =C2=A0=C2=A0=C2=A0 interconnect has the same pgmap->owner.

Yes, although that makes this map static, since pgmap->owner has to be
set at pgmap creation time. and we were during initial discussions
looking at something dynamic here. However I think we can probably do
with a per-driver owner for now and get back if that's not sufficient.

>=20
> =C2=A02) The page is DEVICE_PRIVATE and get_dma_pfn_for_device() exists.
> =C2=A0=C2=A0=C2=A0 The exporting driver has the option to return a P2P st=
ruct page
> =C2=A0=C2=A0=C2=A0 that can be used for PCI P2P without any migration. In=
 a PCI GPU
> =C2=A0=C2=A0=C2=A0 context this means the GPU has mapped its local memory=
 to a PCI
> =C2=A0=C2=A0=C2=A0 address. The assumption is that P2P always works and s=
o this
> =C2=A0=C2=A0=C2=A0 address can be DMA'd from.

So do I understand it correctly, that the driver then needs to set up
one device_private struct page and one pcie_p2p struct page for each
page of device memory participating in this way?

>=20
> =C2=A03) Migrate back to CPU memory - then eveything works.
>=20
> Is that not enough? Where do you want something different?
>=20
> > > > but leaves any dma- mapping or pfn mangling to be done after
> > > > the
> > > > call to hmm_range_fault(), since hmm_range_fault() really only
> > > > needs
> > > > to know whether it has to migrate to system or not.
> > >=20
> > > See above, this is already the case..
> >=20
> > Well what I meant was at hmm_range_fault() time only consider
> > whether
> > to migrate or not. Afterwards at dma-mapping time you'd expose the
> > alternative pfns that could be used for dma-mapping.
>=20
> That sounds like you are talking about multipath, we are not really
> ready to tackle general multipath yet at the DMA API level, IMHO.
>=20
> If you are just talking about your private multi-path, then that is
> already handled..

No, the issue I'm having with this is really why would
hmm_range_fault() need the new pfn when it could easily be obtained
from the device-private pfn by the hmm_range_fault() caller? The only
thing hmm_range_fault() needs to know is, again, whether to migrate or
not. But I guess if the plan is to have hmm_range_fault() call
pci_p2pdma_distance() on it, and we don't want the exporter to do that,
it makes sense.

>=20
> > We were actually looking at a solution where the pagemap implements
> > something along
> >=20
> > bool devmem_allowed(pagemap, client); //for hmm_range_fault
> >=20
> > plus dma_map() and dma_unmap() methods.
>=20
> This sounds like dmabuf philosophy, and I don't think we should go in
> this direction. The hmm caller should always be responsible for dma
> mapping and we need to improve the DMA API to make this work better,
> not build side hacks like this.
>=20
> You can read my feelings and reasoning on this topic within this huge
> thread:
>=20
> https://lore.kernel.org/dri-devel/20250108132358.GP5556@nvidia.com/
>=20
> > In this way you'd don't need to expose special p2p dma pages and
> > the
>=20
> Removing the "special p2p dma pages" has to be done by improving the
> DMA API to understand how to map phsyical addresses without struct
> page. We are working toward this, slowly.

> pgmap->ops->dma_map/unmap() ideas just repeat the DMABUF mistake
> of mis-using the DMA API for P2P cases. Today you cannot correctly
> DMA
> map P2P memory without the struct page.

Yeah, I don't want to drag hmm into that discussion, although
admittedly the idea of pgmap->ops->dma_map/unmap mimics the dma-buf
behaviour.

So anyway what we'll do is to try to use an interconnect-common owner
for now and revisit the problem if that's not sufficient so we can come
up with an acceptable solution.


/Thomas


