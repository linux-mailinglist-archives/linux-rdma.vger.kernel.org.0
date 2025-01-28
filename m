Return-Path: <linux-rdma+bounces-7268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16DA20C42
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 15:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C74188955B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B465F1AA1D9;
	Tue, 28 Jan 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdKAfcoR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95822F9F8;
	Tue, 28 Jan 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075755; cv=none; b=rbCVQzeZv4bYBkcZ5Fh6T6ze3Oc3tNLs/f3+UoDfrkVgFvFv8NSqLNDa7YZCCoxUftE6gaTlM6ZiYQtaeF7ih0Wpeu7HFEyPCOTyxF6EaghT8B0BzOtSp8DAWmyWzaoxTIlUxZPbWPoP8JA4LrNcdS+HTCXk1cqWK5BpMdtViAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075755; c=relaxed/simple;
	bh=uNNV9AiWSNOX6ApUsgEFrkkAU4pDKZfbG0WkJNIOQ4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xi3ZaNm7efqJ+LSBaS85wg1UdBvE+r235cMWt5UENvFHAYwqGE+k8Vcx1XQdL7tyBgvA8xno/hmXLErupTt7nU9Q6g1asgVQOfvHjYDkSG1nnflU5k7BKbpofFe8/WFX63xCCnqIkNIEeoH5JgyzS7Yq4bUI/nrQ+xejzANymXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdKAfcoR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738075754; x=1769611754;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uNNV9AiWSNOX6ApUsgEFrkkAU4pDKZfbG0WkJNIOQ4k=;
  b=FdKAfcoRI9KBSCH8pc6JEariBsAbnLihWL80SVSGZGYKMo1bwzcDfQvR
   mKKdkXsKkqIhct52oDLEQPPRM72LVlYK5mxm8yZFYWiFQady28GT5CBij
   gqgRe/Nl9OU9L86gmV7nlRxISrSFnIP+rgqOJPzbZQnL15F8egItJLYyQ
   rdy/mUXs8dOYwchHkahiMBpRHmUnRzbuuJMvvwYZi7C8y+hI4YIMb7jf9
   qeyVmqBECsyAhqyOK+PLkvIdJngyVnwo9aVOY+L/BK4usG0kC+b2HKrhD
   hGzbEx28tXPQn1+uQNHWAY6Td3xnOu1JGm85aauu1vosVuDAyxwSJ+Tzo
   g==;
X-CSE-ConnectionGUID: IZcQJQCcT0q7SraW2KQ6Pg==
X-CSE-MsgGUID: BuIAk16fTwGcxs0S4Wn3Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38662575"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38662575"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 06:49:13 -0800
X-CSE-ConnectionGUID: hYHxh45jRjqWTCGeN8qB/A==
X-CSE-MsgGUID: IlkXYCWZQdmDqhIdG2o5hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="109330374"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO [10.245.246.161]) ([10.245.246.161])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 06:49:08 -0800
Message-ID: <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
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
Date: Tue, 28 Jan 2025 15:48:54 +0100
In-Reply-To: <20250128132034.GA1524382@ziepe.ca>
References: <20241201103659.420677-1-ymaman@nvidia.com>
	 <20241201103659.420677-2-ymaman@nvidia.com>
	 <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
	 <20250128132034.GA1524382@ziepe.ca>
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

On Tue, 2025-01-28 at 09:20 -0400, Jason Gunthorpe wrote:
> On Tue, Jan 28, 2025 at 09:51:52AM +0100, Thomas Hellstr=C3=B6m wrote:
>=20
> > How would the pgmap device know whether P2P is actually possible
> > without knowing the client device, (like calling
> > pci_p2pdma_distance)
> > and also if looking into access control, whether it is allowed?
>=20
> The DMA API will do this, this happens after this patch is put on top
> of Leon's DMA API patches. The mapping operation will fail and it
> will
> likely be fatal to whatever is going on.
> =C2=A0
> get_dma_pfn_for_device() returns a new PFN, but that is not a DMA
> mapped address, it is just a PFN that has another struct page under
> it.
>=20
> There is an implicit assumption here that P2P will work and we don't
> need a 3rd case to handle non-working P2P..

OK. We will have the case where we want pfnmaps with driver-private
fast interconnects to return "interconnect possible, don't migrate"
whereas possibly other gpus and other devices would return
"interconnect unsuitable, do migrate", so (as I understand it)
something requiring a more flexible interface than this.

>=20
> > but leaves any dma- mapping or pfn mangling to be done after the
> > call to hmm_range_fault(), since hmm_range_fault() really only
> > needs
> > to know whether it has to migrate to system or not.
>=20
> See above, this is already the case..

Well what I meant was at hmm_range_fault() time only consider whether
to migrate or not. Afterwards at dma-mapping time you'd expose the
alternative pfns that could be used for dma-mapping.

We were actually looking at a solution where the pagemap implements
something along

bool devmem_allowed(pagemap, client); //for hmm_range_fault

plus dma_map() and dma_unmap() methods.

In this way you'd don't need to expose special p2p dma pages and the
interface could also handle driver-private interconnects, where
dma_maps and dma_unmap() methods become trivial.

>=20
> > One benefit of using this alternative
> > approach is that struct hmm_range can be subclassed by the caller
> > and
> > for example cache device pairs for which p2p is allowed.
>=20
> If you want to directly address P2P non-uniformity I'd rather do it
> directly in the core code than using a per-driver callback. Every
> driver needs exactly the same logic for such a case.

Yeah, and that would look something like the above, although initially
we intended to keep these methods in drm allocator around its pagemaps,
but could of course look into doing this directly in dev_pagemap ops.=C2=A0
But still would probably need some guidance into what's considered
acceptable, and I don't think the solution proposed in this patch meets
our needs.

Thanks,
Thomas

>=20
> Jason


