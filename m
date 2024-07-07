Return-Path: <linux-rdma+bounces-3693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 713FB9297A9
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130B5B20E58
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B3F1B7FD;
	Sun,  7 Jul 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxWYBQff"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C31BC43
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720352403; cv=none; b=ROVFugCzMNa7+qlNR3zZAENwRIwpyi+/QMfqaapUA/0aOoMY+SrIjAVQMX+tWR3pGDY8eee/QlCAE/zlq68NRiidWsxbfARojJPK3kNecMezo6lmjYGMrXHudoqTcTQirtgl0macTyrL3C+MlLTht5vJRAcwp9aP0S6xIcjJ86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720352403; c=relaxed/simple;
	bh=bGSjiirg+DD5w9ip3rMHuinCcdiM9Wnt43RzhfNTmPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKK55ytFw/E0UC6g9btoeTL7dw80EL73aFz0EJaxPmh9tWWmwSSQ45TMCy+eG3tQQHhI/REFQwVTtMAtpgHXFiaSyUhD6PCW7ayOVmT+ZF/XYqkBls9vQnmsM7X/r25xMsV4p1irBPz3qY5XxkvSm6RAJAvetx/dTKqnZ1Al46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxWYBQff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2182CC3277B;
	Sun,  7 Jul 2024 11:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720352402;
	bh=bGSjiirg+DD5w9ip3rMHuinCcdiM9Wnt43RzhfNTmPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxWYBQfff8XEBaHUE097o4QT0NxZoYTlxVTuC3T3k1bmhL5YTTUsl6VqwxJfVBo40
	 IvmBE8my8Tlp3t1g0/ZgnsSqiF6MVhXnHslLDqAist8kxI/77bTTvXTQOxFKyoaEKp
	 jf2jvNnpwud9yVVkcvg+Opxh/gQDNvGpRevicYMyda78kG7eJEUxQ+PHbpQSX2um3O
	 IlN+muc1818SeRWFMtwMEXQoLGMCNnx4DThb1nB2lqNAODbPLwjp5PAJoD6amwEEgv
	 BVzilJ6kgoZHdCQM9Zg7uoRodiKjsPJQ2mP4CqC6768A6KY8MdY70iMvswMF6DnhRa
	 Bgv3jwoX8hx4w==
Date: Sun, 7 Jul 2024 14:39:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Anumula Murali Mohan Reddy <anumula@chelsio.com>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: use dma_mmap_coherent() for mapping
 non-contiguous memory
Message-ID: <20240707113957.GJ6695@unreal>
References: <20240705131753.15550-1-anumula@chelsio.com>
 <20240707091105.GG6695@unreal>
 <20240707113103.GA4441@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707113103.GA4441@lst.de>

On Sun, Jul 07, 2024 at 01:31:03PM +0200, Christoph Hellwig wrote:
> On Sun, Jul 07, 2024 at 12:11:05PM +0300, Leon Romanovsky wrote:
> > On Fri, Jul 05, 2024 at 06:47:53PM +0530, Anumula Murali Mohan Reddy wrote:
> > > dma_alloc_coherent() allocates contiguous memory irrespective of
> > > iommu mode, but after commit f5ff79fddf0e ("dma-mapping: remove
> > > CONFIG_DMA_REMAP") if iommu is enabled in translate mode,
> > > dma_alloc_coherent() may allocate non-contiguous memory.
> > > Attempt to map this memory results in panic.
> > > This patch fixes the issue by using dma_mmap_coherent() to map each page
> > > to user space.
> > 
> > It is perfect time to move to use rdma_user_mmap_io(), instead of
> > open-code it in the driver.
> 
> rdma_user_mmap_io does not work on dma coherent allocations.

They used dma_mmap_coherent() to implement workaround, original cxgb4
didn't use it and probably doesn't need too.

Thanks

