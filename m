Return-Path: <linux-rdma+bounces-12506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE93B13B0E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1614418884DA
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 13:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1D263C8C;
	Mon, 28 Jul 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCW0IxAa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED641D63C7
	for <linux-rdma@vger.kernel.org>; Mon, 28 Jul 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708375; cv=none; b=tF65bkdpnooH4KE6xBf6bcVj1LxBC9ulrMiYVCFLdHSiFGzyLNyXL1G8qrv0qz8YDCwEKJBJMlgAPPiWFBD5EF65ANpBPdp9vykO0ZXlD6H8CegzUjaIZ6Y2pKvPd2HBZD7pSHuE5lt/DuHcHYN++KGgbHjnc25CuF8djc+fVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708375; c=relaxed/simple;
	bh=EOBUsEhzabXILTABjWugrVr2QPbsGLmTQ9BGvfHF6XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sxh8Zqqh4k2uFHvvEQyzH68gHf/YJjwfPyGEXNQZNxtClnuus1RYfOWfmqFm0YGWYVa1l4eyxSk1OfT6NvGnnzuTsG1RFN2gCVa4sOwrYIPndEuEFdVjNuJH4FmbCqEV2/qbuizs8oetiaye4cmCaUXyyU9bIEWOCneJWcmMX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCW0IxAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722C7C4CEEF;
	Mon, 28 Jul 2025 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753708374;
	bh=EOBUsEhzabXILTABjWugrVr2QPbsGLmTQ9BGvfHF6XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCW0IxAaaDJzCVs3IoJjj2jZOEItxSpeT23ZTleQLTxHn+UizJ+biusTORmEvZSo8
	 cBB2Zr6kYbEzwOo6E36RVmR5G+8dgTGe30ZywS5P6nWwQUQztwB53cpvsW8bVZat0R
	 FLxff51KdOxxMaQOaWq3R5Ap1K34Jvmiafs4aC3UbSMbI6y4B/V3WrETIUkzADDLcB
	 kw6+h0ZN+/DCR/5932RU3tymHo7cA89L5WRDB8O/8t0epxRmstSm3FkDWEBFHyCkIQ
	 B836y5oUWx//qKxvln3AxQo7Zhxd90cOFFLwFRc8Lxn+fMM3aNWTv8Vg7SZPhSi7l4
	 s0IcXqW8QHmbg==
Date: Mon, 28 Jul 2025 16:12:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: Boshi Yu <boshiyu@linux.alibaba.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com
Subject: Re: [PATCH for-next 1/3] RDMA/erdma: Use dma_map_page to map scatter
 MTT buffer
Message-ID: <20250728131250.GC402218@unreal>
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
 <20250725055410.67520-2-boshiyu@linux.alibaba.com>
 <20250727112757.GZ402218@unreal>
 <5cd4c86c-fc28-4ff5-a135-4d468bff7f36@linux.alibaba.com>
 <20250728070841.GB402218@unreal>
 <d243319c-c57b-ee30-a54f-aeaee6b1b663@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d243319c-c57b-ee30-a54f-aeaee6b1b663@linux.alibaba.com>

On Mon, Jul 28, 2025 at 03:47:57PM +0800, Cheng Xu wrote:
> 
> 
> On 7/28/25 3:08 PM, Leon Romanovsky wrote:
> > On Mon, Jul 28, 2025 at 11:08:46AM +0800, Boshi Yu wrote:
> >>
> >>
> >> On 2025/7/27 19:27, Leon Romanovsky wrote:
> >>> On Fri, Jul 25, 2025 at 01:53:54PM +0800, Boshi Yu wrote:
> >>>> Each high-level indirect MTT entry is assumed to point to exactly one page
> >>>> of the low-level MTT buffer, but dma_map_sg may merge contiguous physical
> >>>> pages when mapping. To avoid extra overhead from splitting merged regions,
> >>>> use dma_map_page to map the scatter MTT buffer page by page.
> >>>>
> >>>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> >>>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> >>>> ---
> >>>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 110 ++++++++++++++--------
> >>>>   drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
> >>>>   2 files changed, 71 insertions(+), 43 deletions(-)
> >>>
> >>> <...>
> >>>
> >>>> +	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
> >>>> +	if (!pg_dma)
> >>>> +		return 0;
> >>>> -	sg_init_table(sglist, npages);
> >>>> +	addr = buf;
> >>>>   	for (i = 0; i < npages; i++) {
> >>>> -		pg = vmalloc_to_page(buf);
> >>>> +		pg = vmalloc_to_page(addr);
> >>>
> >>> <...>
> >>>> +
> >>>> +		pg_dma[i] = dma_map_page(&dev->pdev->dev, pg, 0, PAGE_SIZE,
> >>>> +					 DMA_TO_DEVICE);
> >>>
> >>> Does it work?
> >>
> >> Hi Leon,
> >>
> >> I would like to confirm which part you think is not working properly. I
> >> guess that you might be concerned that if the buffer is not page-aligned, it
> >> could cause problems with dma_map_page.
> >>
> >> In fact, when allocating the MTT buffer, we ensure that it is always
> >> page-aligned and that its length is a multiple of PAGE_SIZE. We have also
> >> tested the new code in our production environment, and it works well.
> >>
> >> Look forward to your further reply if I have misunderstood your concerns.
> > 
> > DMA API expects Kmalloc addresses and not Vmalloc ones.
> > 
> 
> Hi Leon,
> 
> Thanks for your reply. Could you provide some references for this point?
> We cannot find the constraint in the Kernel Documentation.

Documentation/core-api/dma-api.rst.

The reason to such constraint is a need to get contiguous memory, which
vzalloc doesn't guarantee. In your case, it works because you have
vmalloc_to_page() call.

So everything is ok, sorry for the noise.

Thanks

