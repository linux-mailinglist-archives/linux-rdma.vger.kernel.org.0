Return-Path: <linux-rdma+bounces-3659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EBC928195
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 07:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D97528252A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E513C909;
	Fri,  5 Jul 2024 05:58:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F433C7;
	Fri,  5 Jul 2024 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159094; cv=none; b=DdULd0Sv/gjvr5kxVjUkcLkjuWPQxfMn11qdBv5cw0e08AWKReRqlp5HB+Q5CDcOWiZfVl6DUbQkPdweFPc89oFfdS3K1J3bVCCx+w4ngWYZd3/q5r+gR2W85mlv3FGdQo4smGv38tBQdZPEtzeUnL1Hz4rAIfChRW5QwuPnjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159094; c=relaxed/simple;
	bh=SDR7JIipxE8QBOxM4QjWEIV62+OFxXsZNSo56rAwnQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxhxj0wjQd8GIfiUePdIw/re7Ws3i8uWPOGc4G8FbAt/njyOWOoQQGBiqI5wOJdvldB+jkdxtrtHQepExuLZblevrkkDvrwYmgBg1p9dNqlFeh8DNXuVB/fjt70NjhRmKxkfXTg3j/+NA5LSY29QFY+L47Hyndvpavm/wx8Uww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D8AEF68AA6; Fri,  5 Jul 2024 07:58:06 +0200 (CEST)
Date: Fri, 5 Jul 2024 07:58:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, "Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 18/18] nvme-pci: use new dma API
Message-ID: <20240705055806.GA11885@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <47eb0510b0a6aa52d9f5665d75fa7093dd6af53f.1719909395.git.leon@kernel.org> <249ec228-4ffd-4121-bd51-f4a19275fee1@arm.com> <20240704171602.GE95824@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704171602.GE95824@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

> This is exactly how dma_map_sg() works.

Which dma_map_sg?  swiotlb handling is implemented in the underlying
ops, dma-direct and dma-iommu specifically.

dma-direct just iterates over the entries and calls dma_direct_map_page,
which does a per-entry decision to bounce based on
is_swiotlb_force_bounce, dma_capable and dma_kmalloc_needs_bounce.


