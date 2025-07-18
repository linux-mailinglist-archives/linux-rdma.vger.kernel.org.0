Return-Path: <linux-rdma+bounces-12308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA7B0A604
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E1CA82A5D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E72376EC;
	Fri, 18 Jul 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rBJeb8Ct"
X-Original-To: linux-rdma@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74D2AEF5;
	Fri, 18 Jul 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848233; cv=none; b=SjZD/rhVTbVrArKMLHobjaKRLSWyNbF6GIe3AGTJpbSeYstUXX039T7lwGhEvSGRxqXyOaFsikuwWoAJXRarm96sDb3aTAmWnpo+o3Iz9dE5/sHoF9NBabLrz4jk9G+7EKSx1cMvPYp1Zi+pgvXGgqvBXWmiucJQQ/VKwOmbYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848233; c=relaxed/simple;
	bh=Vk6MlnJrG83won4Szr2uhzQYbW4610Yv0l6PcFFF7SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4nO6B5Erey+wP6Sld4ualIqIJbHWrMhIHkytlrSmlgpXG0TJzW69WRp66be7vjtbAUl9ZSZ/4Mw/QtayAd3oXdWaj76JDU9tLr4J7ZGz7tEdV3ovx20MKihu+9AWAtW2YmyqQzeesnxQpnCEMOhJNcJUNvnwOP/Pp4Bez+dmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rBJeb8Ct; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nGat+aN/dUwx1e0CItMWnTJtYUFtXq1FOMv6w5QXIC4=; b=rBJeb8CtLixKT9l+aLVC1RQE1I
	Dveh3IljHpIJBFoA3sSWw2gY3xIDbSHioOrM7Q9Gcx14AJXR7JSOS6OW43vthaszlAsuDK510ve8X
	+OjROYs5T6be/WHCW/7SipY9DAMP3lh/Ck/HiTsCwKbHqZMTORmD7ta3f1iSKPwdT6/aTgWtAUQ+v
	pCdh6+N9ph0JZEdzxxI9dlYB175XdqBrIATo6pcdPAZRgW5MjT+Zo04Xu9aH9TjFKrsVfAZhhj7E7
	Z2oG62/swGwITcCJaMyeZ0o9hm+JIQOmN9YuB5cToI33n3ezsWoL5UEqSKNOD0K1RHQKngip/fsc/
	Hvds9ctQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucltU-00000007NL5-3jwd;
	Fri, 18 Jul 2025 14:17:00 +0000
Date: Fri, 18 Jul 2025 15:17:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <aHpXXKTaqp8FUhmq@casper.infradead.org>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718115112.3881129-2-ymaman@nvidia.com>

On Fri, Jul 18, 2025 at 02:51:08PM +0300, Yonatan Maman wrote:
> +++ b/include/linux/memremap.h
> @@ -89,6 +89,14 @@ struct dev_pagemap_ops {
>  	 */
>  	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
>  
> +	/*
> +	 * Used for private (un-addressable) device memory only. Return a
> +	 * corresponding PFN for a page that can be mapped to device
> +	 * (e.g using dma_map_page)
> +	 */
> +	int (*get_dma_pfn_for_device)(struct page *private_page,
> +				      unsigned long *dma_pfn);

This makes no sense.  If a page is addressable then it has a PFN.
If a page is not addressable then it doesn't have a PFN.

