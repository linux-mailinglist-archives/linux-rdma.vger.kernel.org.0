Return-Path: <linux-rdma+bounces-5447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C349A243C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7241C2074D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223B1DE3CA;
	Thu, 17 Oct 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B4Clw0OI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F81DE2DE;
	Thu, 17 Oct 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172976; cv=none; b=j9MpMpa5dJiaMKXmQn7O/cAWWark9Xzx32rL9oyCKPlJMhEyd6Vn550QIYBt+NYOlhFCgC/wcudl9ylAY4R1Aq/47/YkBZCin4I8n+ADJWKuQGu1lzZP559QXmDQke4HE8G2NFBCOp3fyR6re4A9vPT7+ywUpcEBt3QvLEXt+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172976; c=relaxed/simple;
	bh=ZvELszGSOyHnAWYXDkvEi8RTBmD3JAHQ8VKxvMFjJTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkL9VR2HhHAEGvJKceJ57STjoSfvnaEUyTHbzb2jHoekMAEc82MvktGiHrRxjcVolpUnZWliDNKNJCv2g8/6fPgbVuqSs/64lLLUutCFeC/ZvYzW9Cf6g4w7HDskgZhpkj6jgqEO+MMm40w8legcNc6/jzkouzxO65ab3DohzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B4Clw0OI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=snZpsDz54GwpfnkEbUricuY28KyqdWxXHVT3LdPzGmY=; b=B4Clw0OIg5EUXc3aunxOUC9Ez/
	gKlaSNLiUzISmC0vOFIFFX48E2DBY4cSXf3NU9zFGsZr9w+yRK2sq6rGXUVRHVHPaqf/gJI/roXeY
	NY0L2+L/6Te6tZVl+6B9CzMGScG0EJFAqggCIf2MwRYzo0l3jUf3ZcLluLRl/yXl10xq/jMm73pFt
	jhkdiEMaAct/myAd5XzMiM1u+MYQj1G0RJJM9NMfv+XB22sQ4XypBQoG9vOHkD7qO+FImArT3KVjc
	2wmuYuQtJHyxD8EKA5YTyc5aEu9o8Da4xdg9B5ic7jKjqkAyA9v/xS6RyHxn9bvH5Qmn2nqQHXdd4
	4PbErMOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Qsc-0000000F06G-24M0;
	Thu, 17 Oct 2024 13:49:30 +0000
Date: Thu, 17 Oct 2024 06:49:30 -0700
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
Message-ID: <ZxEV6ocpKLjPC8H4@infradead.org>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
 <20241017130539.GA897978@ziepe.ca>
 <ZxENV_EppCYIXfOW@infradead.org>
 <20241017134644.GA948948@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017134644.GA948948@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 10:46:44AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 06:12:55AM -0700, Christoph Hellwig wrote:
> > On Thu, Oct 17, 2024 at 10:05:39AM -0300, Jason Gunthorpe wrote:
> > > Broadly I think whatever flow NVMe uses for P2P will apply to ODP as
> > > well.
> > 
> > ODP is a lot simpler than NVMe for P2P actually :(
> 
> What is your thinking there? I'm looking at the latest patches and I
> would expect dma_iova_init() to accept a phys so it can call
> pci_p2pdma_map_type() once for the whole transaction. It is a slow
> operation.

You can't do it for the whole transaction.  Here is my suggestion
for ODP:

http://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/dma-split-wip

For NVMe I need to figure out a way to split bios on a per P2P
type boundary as we don't have any space to record if something is a bus
mapped address.


