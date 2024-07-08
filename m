Return-Path: <linux-rdma+bounces-3715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82A929FD4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB20A287821
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553C5589B;
	Mon,  8 Jul 2024 10:06:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716A74076
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jul 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433168; cv=none; b=T4lQV88Js3rXkD48ul5oT6sNNU5CyVdr0Q0LtUb9NInOfXzgVrjyBqauaz97JOGhIw76mxxDgvF+jRNYTu4C7CQfYciUWGN2N/cEiyZ7kodxdtB4g2AhDTbxQdvnvxj2IYX52DHXxnSY6Gq6ASs6fLiXEY7z2k9y11kY/PL4VIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433168; c=relaxed/simple;
	bh=6sM/Be3Ri8+XtdneenwOqpEOr3twmtjBn0U79x8pOsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH3HtKCjbnJg0LzLHEtmzWXUSfmNkXO2SQkSvT1cKSqB+mPkUK9K3HaoMCMXtsX8iduSNoNmzvK2HPaNAx71K/wHzYn90MdiYG4wHhHgfh7QUYgnbulMBlQCEx3jI6E/B5eYpdXxocQjghK/a3wKvWj+B0wPTfMqWHaniUvQSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A42FC68AFE; Mon,  8 Jul 2024 12:05:55 +0200 (CEST)
Date: Mon, 8 Jul 2024 12:05:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Anumula Murali Mohan Reddy <anumula@chelsio.com>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: use dma_mmap_coherent() for
 mapping non-contiguous memory
Message-ID: <20240708100555.GA24094@lst.de>
References: <20240705131753.15550-1-anumula@chelsio.com> <20240707091105.GG6695@unreal> <20240707113103.GA4441@lst.de> <20240707113957.GJ6695@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707113957.GJ6695@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 07, 2024 at 02:39:57PM +0300, Leon Romanovsky wrote:
> > > It is perfect time to move to use rdma_user_mmap_io(), instead of
> > > open-code it in the driver.
> > 
> > rdma_user_mmap_io does not work on dma coherent allocations.
> 
> They used dma_mmap_coherent() to implement workaround, original cxgb4
> didn't use it and probably doesn't need too.

dma_mmap_coherent must be paired with dma_alloc_coherent.
It seems like cxgb4 uses a c4iw_mm_entry as a sort of generic
containers for objects that can be mmaped which are used on first come,
first serve bassis in c4iw_mmap (WTF???).  Not questioning the sanity
of the higher level logic here, which is ABI by now, the right fix
is to tag each entry with what is being mmaped, DMA_ALLOC, vs
uncached ba vs WC bar and remove the guessing logic there.

While we're it, pgprot_writecombine is generally available,
t4_pgprot_wc should go away aswell.

