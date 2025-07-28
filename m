Return-Path: <linux-rdma+bounces-12496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58EAB13558
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 09:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FEF1897D77
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF776221FD2;
	Mon, 28 Jul 2025 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYkOGxUm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EC17BB21
	for <linux-rdma@vger.kernel.org>; Mon, 28 Jul 2025 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686528; cv=none; b=Mahiq9L7sALWSneVfXQiKaEZ44Iys/1SSDNzrvRuExiftXBawV3+wQydTzpmq1H/Mz6gZlWGkd8TroKqpUz6/xwmOOqW6FuujB10FVH/WZ8SoyWDvD8kCBETTZrmMRIWhJtywxK+mFFLOK7VE6QPswBiFDhzCjd0bmJhMtR6/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686528; c=relaxed/simple;
	bh=aXNZbva1Tx5Hx67tbz/PrNLQRNAdOtft3A71HfAyhJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9PgwBmYJAp9nQSf49RNIfdsk2TAn5W3G0CFuCCyB2ltpmyUXnpU23zmPkOFLdX1MKzCIx89msD+5ueZYPr2gyNfOyG7s3zvJtQMpqym7qSapohB+wg6pfZ7tKRTTRCYivneO2PS6G4I2H8w1zrCQk5HnQPzCVs+tuYYgEgSrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYkOGxUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004BC4CEE7;
	Mon, 28 Jul 2025 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753686528;
	bh=aXNZbva1Tx5Hx67tbz/PrNLQRNAdOtft3A71HfAyhJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYkOGxUmi5fx4tHY77ePDxlF8S82+8RR5A7xrkKa48Lk/dfFTuIWVOVAlx0IvsUfW
	 lGWQdvuFcdycKII/TgT87P+6XSq8ZZA8lApidy9sO8ufY68LeXCaEdlCAi9drnI5iT
	 kMkdvjPvnvKg60EZOrBgv8FHBrr9KGVqp+zEW4VtW2y/qfloDA35eyKQ+nL2VizXyj
	 3jlIH+7kIcKvYsQETkb5dhFA05bhFy8SoSR9GXOzQC4vZ9X6E0GoU8aug16fXf+hDQ
	 tTSdbSYSQKBPUc40b5dwM8U8Q0LSd3zw49Bn4jsS024hPMk8HSHHS+qNgPNiSWvr5U
	 LA1fFfBwyIWCg==
Date: Mon, 28 Jul 2025 10:08:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: Re: [PATCH for-next 1/3] RDMA/erdma: Use dma_map_page to map scatter
 MTT buffer
Message-ID: <20250728070841.GB402218@unreal>
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
 <20250725055410.67520-2-boshiyu@linux.alibaba.com>
 <20250727112757.GZ402218@unreal>
 <5cd4c86c-fc28-4ff5-a135-4d468bff7f36@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd4c86c-fc28-4ff5-a135-4d468bff7f36@linux.alibaba.com>

On Mon, Jul 28, 2025 at 11:08:46AM +0800, Boshi Yu wrote:
> 
> 
> On 2025/7/27 19:27, Leon Romanovsky wrote:
> > On Fri, Jul 25, 2025 at 01:53:54PM +0800, Boshi Yu wrote:
> > > Each high-level indirect MTT entry is assumed to point to exactly one page
> > > of the low-level MTT buffer, but dma_map_sg may merge contiguous physical
> > > pages when mapping. To avoid extra overhead from splitting merged regions,
> > > use dma_map_page to map the scatter MTT buffer page by page.
> > > 
> > > Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> > > Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> > > ---
> > >   drivers/infiniband/hw/erdma/erdma_verbs.c | 110 ++++++++++++++--------
> > >   drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
> > >   2 files changed, 71 insertions(+), 43 deletions(-)
> > 
> > <...>
> > 
> > > +	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
> > > +	if (!pg_dma)
> > > +		return 0;
> > > -	sg_init_table(sglist, npages);
> > > +	addr = buf;
> > >   	for (i = 0; i < npages; i++) {
> > > -		pg = vmalloc_to_page(buf);
> > > +		pg = vmalloc_to_page(addr);
> > 
> > <...>
> > > +
> > > +		pg_dma[i] = dma_map_page(&dev->pdev->dev, pg, 0, PAGE_SIZE,
> > > +					 DMA_TO_DEVICE);
> > 
> > Does it work?
> 
> Hi Leon,
> 
> I would like to confirm which part you think is not working properly. I
> guess that you might be concerned that if the buffer is not page-aligned, it
> could cause problems with dma_map_page.
> 
> In fact, when allocating the MTT buffer, we ensure that it is always
> page-aligned and that its length is a multiple of PAGE_SIZE. We have also
> tested the new code in our production environment, and it works well.
> 
> Look forward to your further reply if I have misunderstood your concerns.

DMA API expects Kmalloc addresses and not Vmalloc ones.

Thanks

