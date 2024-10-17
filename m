Return-Path: <linux-rdma+bounces-5449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F99A24D3
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F9F28B060
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DB1DE3C2;
	Thu, 17 Oct 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tvv6Ppsr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DD1DD0CE;
	Thu, 17 Oct 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174742; cv=none; b=kP1dN9C4ZRlsF48h/XK+ZZOyEJBl4/leAYYZQU/N8x0A/zzFN+3wsT1dEFbcmNs6Nfku+m7zVofl0OzprGFxulvYUbGV8u0FKqQZtxwVtehF4aL5Y7LgIk9FbdateguY3pvEp+qnzAhi/ZchaGEEdb40j6sBuGb05nZJyNgueOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174742; c=relaxed/simple;
	bh=NDDniqJxzgHwV01RtGVnhVfmeX/eHlg2rFb/J5PUkGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDXbCz+Nfq9Y/ckVKZmSLE1Cm7wxY2Y2x9rNF9WzhtiknBeyk0nBRgTM6RTQVnFpn8KXFPWQSRus/VIvLzwC/n4X1OFwhSFam/UKBUbCP0hYyGJM3VcqNi0GDI8WKZZvEXyKkl9HiqlTM7jbA79PNKis6FkrJbAdpXiOm1DX8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tvv6Ppsr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VUpe5RP1fWYLGbbUSAQN8Sy0lKKV6KEg6Paot5a6ppc=; b=tvv6Ppsr9GSJLGFeYRLEOIeL2f
	dbWejfWHj9+awYPTEEkcbJ/9wo3+V9QROWHYLRcZzBxls8PC3PlGSr2pT63t34XiV0KP46cJv17Kb
	88DkrhJ8kbdE5E1uTYcCl+B+P5HilAif1ZISvdEycKL6e450KWT15Euw1mQVCGDyE79KNqNONym7Q
	M+cQHEJSI67H6VJVLNojN+J6ML358u48TJP+RzffmY06NWZ0rOtzfeXUklhIbXFH9bGsJ7ieJIVOZ
	CaUuqEeTBdfDzBBcO174ra/NCnU48aUl3NUjGIx0hnteK932Ga5F0Ku6FjbvJuV6kFiNblFagbMlY
	lC2v23Rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1RLA-0000000F5Su-2wpy;
	Thu, 17 Oct 2024 14:19:00 +0000
Date: Thu, 17 Oct 2024 07:19:00 -0700
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
Message-ID: <ZxEc1HSBP2QuQLj4@infradead.org>
References: <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
 <20241017130539.GA897978@ziepe.ca>
 <ZxENV_EppCYIXfOW@infradead.org>
 <20241017134644.GA948948@ziepe.ca>
 <ZxEV6ocpKLjPC8H4@infradead.org>
 <20241017140507.GB948948@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140507.GB948948@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 11:05:07AM -0300, Jason Gunthorpe wrote:
> BTW this:
> 
>   iommu: generalize the batched sync after map interface
> 
> I am hoping to in a direction of adding a gather to the map, just like
> unmap. So eventually instead of open coding iotlb_sync_map() you'd
> flush the gather and it would do it.

I don't really care either way, I just need something to not regress
map behavior vs map_sg.


