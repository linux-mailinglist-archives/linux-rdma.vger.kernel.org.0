Return-Path: <linux-rdma+bounces-12356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA2B0BD21
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FFC1767A6
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D461EB39;
	Mon, 21 Jul 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrQtjwJF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B0223302;
	Mon, 21 Jul 2025 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081259; cv=none; b=qjpw4GfdLio0i/ZBb5YeePl7/POADFzo4L7XfbG1GRvpRoSjBgThg5ScW+D5MCOUljvxp0yJRXHwujJ3/+eZbDxSBUtj5Sai6cc5jh+2/HIc4onkojKl+Cr/t+zhgyF0Fm439WHgKoZygU7Dt3iUV3kBq49dC8aCq1b/c+1mofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081259; c=relaxed/simple;
	bh=30liWJhxa9QugIv20Ma09ulcUlKyc//osb4HhTAczrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5rqojUU61kUiU8gTR+uRxF25VYHPlAPoUjqYwzZReUbPGCzrKxNtuv3dzydYchUW+3dBniezt43GwN6qyHljTVMyeKZOBe7o2QSlLrON0rM45BadLCuZBz+La6M30z1PW2zVb+lRkkGfE51L4PVqNi71LVNzuXanzwdE1oTAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FrQtjwJF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AgLgPBRTNxxvHF8cSuGGdkujqZoQFY1bUgkbASNTV9k=; b=FrQtjwJFdTS0B8Kua0PIQIJwO4
	3Zk4OyGXroeJfhkGSdhFxSEBscp3zXhBhIQ6NwXrtxpbI60BKwSIZXQl+KtjCzhiJXmJFlaCgW5H6
	787Obg4n7axKxGI3qFCHvAQUEnqWrxbhqwrrQZ7WAkM4bp4H3/jz2k4IGrAPVCh0qP+LaA9JZFgDr
	jjEUKFcl8C3TQemByFLGJ1jsaQ7NovcnBV2OHT5r8P4osQ/hy1aidsCJhHekKhoWfD4Msh5vd/ph8
	axLv1bME8qKqnaZNCpYgUHNEjLQm9rPlsEFOVoq3Nv5r8+S0f7cDr5BgLpcKQstH+81zMrSB2v8cd
	PLo+MAmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udkW7-0000000GRux-455c;
	Mon, 21 Jul 2025 07:00:55 +0000
Date: Mon, 21 Jul 2025 00:00:55 -0700
From: Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH v2 2/5] nouveau/dmem: HMM P2P DMA for private dev pages
Message-ID: <aH3lpyhdnCdZISK5@infradead.org>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-3-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718115112.3881129-3-ymaman@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 18, 2025 at 02:51:09PM +0300, Yonatan Maman wrote:
> +	.get_dma_pfn_for_device = nouveau_dmem_get_dma_pfn,

Please don't shorten the method name prefix in the implementation
symbol name, as that makes reading / refactoring the code a pain.

This might also be a hint that your method name is too long.


