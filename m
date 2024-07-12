Return-Path: <linux-rdma+bounces-3844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BEB92F4C0
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 06:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6E2B219C2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 04:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7B1798C;
	Fri, 12 Jul 2024 04:54:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F631754B;
	Fri, 12 Jul 2024 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760069; cv=none; b=qVosB9TmoKmUiRNzVZ90TqqQUs/AXWZUdON/OUobjOc43LoLHTdqiZWhx9yeI+N5srrghu3iSidhn0cuqI/9jGlVLAnbN2qnVG5TcpeUcFY4qqHpaMy6uDzs8bkeTahfuaUZNDR9xTMO34NBrqlz7ZZcbKC9NDOxIH+AxMJ/cKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760069; c=relaxed/simple;
	bh=TMu0MQvA9M0EFsXQs2/I0o+BYZmm1BaNxhY+TcEXn20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjSWn5pee+HO83jG/R7hK0v0KPUZRh/lPxzF8EPoK7GTxV9TVwXXreIf9fsv5/OuslK1jov9wdI+N72vr7JO0RX4RUWCptWU7B6/3khgcNWt9sqFbxJatXyUGe+6nIOGVpOYzZ8jYMfKoewAZlhZDh1zwF7Fr+QPbtUCkhWumoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F8DD68BEB; Fri, 12 Jul 2024 06:54:23 +0200 (CEST)
Date: Fri, 12 Jul 2024 06:54:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
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
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240712045422.GA4774@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240705063910.GA12337@lst.de> <20240708235721.GF14050@ziepe.ca> <20240709062015.GB16180@lst.de> <20240709190320.GN14050@ziepe.ca> <20240710062212.GA25895@lst.de> <20240711232917.GR14050@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711232917.GR14050@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 11, 2024 at 08:29:17PM -0300, Jason Gunthorpe wrote:
> So this little detail needs to be taken care of somehow as well, and I
> didn't see it in this RFC.

Yes.  Same about generally not mixing P2P and non-P2P.

> 
> > For the block layer just having one kind per BIO is fine right now,
> > although I could see use cases where people would want to combine
> > them.  We can probably defer that until it is needed, though.
> 
> Do you have an application in mind that would want multi-kind per BIO?

If you are doing say garbage collection in a file system, and do write
that sources data from multiple devices, where some sit directly on the
root port and others behind a switch.

This is all purely hypothetical, and I'm happy to just check for it
and reject it for it now.

