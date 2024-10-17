Return-Path: <linux-rdma+bounces-5441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36489A21AB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 13:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF101F2654E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E270D1DB534;
	Thu, 17 Oct 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w6k0JD7i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58041D365B;
	Thu, 17 Oct 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166295; cv=none; b=O+hw9g7ICEP+BAQWNaHkQXlAXuU3g5O1rEX9EKLk7qPjU4pIr5Z9vmKymd8jKHIaCRAb+q0SmECSk32QcY1MkZLB4uHkR9ndzLY6XiqZetB5uY69n3hxbEIDc6ZE1CUzD85XyZBYQMkgMEQHckG01oQ3+gk4kxvOqvtgE5SRpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166295; c=relaxed/simple;
	bh=syO4Q8j73NSxChEE/Yr5+Lf2IfP7DEdL/cSY2QgVTtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoJAdJwpQ76whzfwQh/PKtzg6uEx1Acu1A0JwekeqG+0BbeaAzLV8mkbwtNxQ9QbZllOkiwFUq86oyHElbO4i4jVaKzRNbup1QC/ycsa9rYMAt9EkoMopaN5xNYcjI9vO78HQl8HsEU+TRs1aBOonBIBbY4uw9LTIzu9iVs5eUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w6k0JD7i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EEDlW0Z+27Cz1a36GnGWzG69pvQQcfAeec1992co/rU=; b=w6k0JD7itqBz1TeMuMUHKr2szV
	HdrbD5T6KpkzUq67echeUaMGiLU86Jhj67No8E02ULxoUSkbQFEG7QeJlA9i6jCbzVyHdhuhVrCm9
	QEbjccVpvAry4xZVtmywe8TpIdwRgeQCAf04vKCPZdaH0ibPWuCoga7WOklEOu7G9flfeP3TOMDbj
	PeQV3HJ2agNF9brsTbkzHmLHdvpuHq/vmfopnhKxf+H7kerzEqeNPCkgpGhg4A7F5abFkIj1VoBQt
	8WiBq5FPcPVE4wxmfiUHJ0j0xYFX5ygiAo17X3gLbyq5MXBm5g5AmNIOBNOYG/WNS1rlPDNX1CXF/
	NYo8NzBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1P8u-0000000Ehiu-2ZiO;
	Thu, 17 Oct 2024 11:58:12 +0000
Date: Thu, 17 Oct 2024 04:58:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, apopple@nvidia.com,
	bskeggs@nvidia.com, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <ZxD71D66qLI0qHpW@infradead.org>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016174445.GF4020792@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 02:44:45PM -0300, Jason Gunthorpe wrote:
> > > FWIW, I've been expecting this series to be rebased on top of Leon's
> > > new DMA API series so it doesn't have this issue..
> > 
> > That's not going to make a difference at this level.
> 
> I'm not sure what you are asking then.
> 
> Patch 2 does pci_p2pdma_add_resource() and so a valid struct page with
> a P2P ZONE_DEVICE type exists, and that gets returned back to the
> hmm/odp code.
> 
> Today odp calls dma_map_page() which only works by chance in limited
> cases. With Leon's revision it will call hmm_dma_map_pfn() ->
> dma_iova_link() which does call pci_p2pdma_map_type() and should do
> the right thing.

Again none of this affects the code posted here.  It reshuffles the
callers but has no direct affect on the patches posted here.

(and the current DMA series lacks P2P support, I'm trying to figure
out how to properly handle it at the moment).

> > IOMMU or not doens't matter much for P2P.  The important difference is
> > through the host bridge or through a switch.  dma_map_page will work
> > for P2P through the host brige (assuming the host bridge even support
> > it as it also lacks the error handling for when not), but it lacks the
> > handling for P2P through a switch.
> 
> On most x86 systems the BAR/bus address of the P2P memory is the same
> as the CPU address, so without an IOMMU translation dma_map_page()
> will return the CPU/host physical address which is the same as the
> BAR/bus address and that will take the P2P switch path for testing.

Maybe.  Either way the use of dma_map_page is incorrect.


> 
> Jason
---end quoted text---

