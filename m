Return-Path: <linux-rdma+bounces-12456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982EB101CA
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06737AAE5F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B5325D1FC;
	Thu, 24 Jul 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wcm48Xl9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408A7261B;
	Thu, 24 Jul 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342240; cv=none; b=sOrMCb+O0lNHQBe//AmEmyfgHifQOty/WQfPgwSgivVU2qv7RWZEuIrMIzG3Zyf8TcAcZ7jhVYiic6dK1j2DTfRMxj27hSZUmGnrMM5GA0p0TZFJHh7jbrRJYpfuLBiF4AN6qGEJgiWW1hzaEUxKv25xiTXL8UrizZedhG0qG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342240; c=relaxed/simple;
	bh=buVHH0+g5I3c2w2cFnoX8kRWvieO8kmsLByaMPNsBgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ0bevE96rHcA1zJ1ruR6L7/Mj4DKJxmOEZIq6XwUr/guiRA4RcB/R+R4ShWSH3o7OCiAQghW3ag9zBLVve48u/6ShseSxxOv+1RMPxGs76IAYHorK0oOMPsYsMBv7gIyrtrJQel8ts0eqLQrO2xvuog1aQ+T2YMaboXPnVlLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wcm48Xl9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x0ieeULae3wZoXFYbacES0pRJT+dyok9yRpzdF6F6T0=; b=Wcm48Xl9he+9gkl3mD7JfqaQce
	x8ztVwaaQNB53A5F0yo+KJrnZBPNw4lAAfrPl0N8sY5OVPJkJwDMEuhieCsS8U2mg6MaQuEwoJP8A
	xMtVgtwNnUmpskEXT899TV8M6A/t15OZ56RkAqlELlIhtEg6MJI7GHk5/pnYN3CooEIxTiMxJOupF
	e/fzMsUaHaqch4kbHHT4PsbtVhXeYYpulwGUn4Mg0RNT9PSKNDvu085SQy4hz65m6cPkTug6Yab24
	Ok2AgKIsmRhAGwRl+UsJpcNYYufuJ2+ztViaJE6jZJ4iGTvhPqtPDql8iGT7pCunDpG/dtx/NVm61
	BqqmT/kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueqPS-00000006i6Y-1TLE;
	Thu, 24 Jul 2025 07:30:34 +0000
Date: Thu, 24 Jul 2025 00:30:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 4/5] RDMA/mlx5: Enable P2P DMA with fallback mechanism
Message-ID: <aIHhGi3adOiLykJn@infradead.org>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-5-ymaman@nvidia.com>
 <aH3mTZP7w8KnMLx1@infradead.org>
 <aIBdKhzft4umCGZO@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIBdKhzft4umCGZO@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 23, 2025 at 12:55:22AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 21, 2025 at 12:03:41AM -0700, Christoph Hellwig wrote:
> > On Fri, Jul 18, 2025 at 02:51:11PM +0300, Yonatan Maman wrote:
> > > From: Yonatan Maman <Ymaman@Nvidia.com>
> > > 
> > > Add support for P2P for MLX5 NIC devices with automatic fallback to
> > > standard DMA when P2P mapping fails.
> > 
> > That's now how the P2P API works.  You need to check the P2P availability
> > higher up.
> 
> How do you mean?
> 
> This looks OKish to me, for ODP and HMM it has to check the P2P
> availability on a page by page basis because every single page can be
> a different origin device.
> 
> There isn't really a higher up here...

The DMA API expects the caller to already check for connectability,
why can't HMM do that like everyone else?


