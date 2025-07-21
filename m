Return-Path: <linux-rdma+bounces-12357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D99B0BD2D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A6F189C7DA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C727FD71;
	Mon, 21 Jul 2025 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VLQInbT8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6822DFA6;
	Mon, 21 Jul 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081425; cv=none; b=KIQ+/1iwd8RB/wNVvEnPbaYUvycHcxwtcbD7QrPuhyZUg/92Ug8zs6a2HIPci1S+R+Bf+agDTCWV603A2W6/8SGr+im3X7ReLGfr+arMPGAbFkeZW9utZj9iu0w776K3DFU3gUq0Q3cD7lBZtrxH/v/VUo/Y5DdixfHCGIBEnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081425; c=relaxed/simple;
	bh=I6akz5pfbU/lPQwpnOci9Fnqx87HkGhMiK0UmMzmsjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfOde7fK4XOCl9pCLCK6NI+B63TwWNU6zwpuK0Auc02C5yKsrRm6tgGQCHXPSkWSeO7l1hbyzQVtyVonVfxVa2NukRdjnM/864FAzqRfd7orzxGxb6uTnECn9u18r2RHtcz7/YI/TknvYjb1tBgBfYOq8QKQZMQ5nzrYAznZuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VLQInbT8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Re4nL4seh/u3rx2kBv4ujkDzUbNHaaKK5HUMeMxVLyo=; b=VLQInbT8BzS3WF2wguK3ElN1iN
	EBK9JoQe1L5sTZUvS4SJdj25s8ENLEbcU5jrkqdG2Wl3XU3aXqJ/Wvb6AlqD0QDxJkGkHS+U/FNRA
	fmYAHcH3fU6qn0TBzOkQlPFkT8HHNSfQxny60x0WNb+XI9sLT/NlRtgX/9GH/S0aA2Kin3xz+Kb1j
	kSkXmswblVe/5kGmWbVVZAEFDrOuSz/UkBOW4aZoBkccyOPc9Yp1ExwWh5MDG+Pl3IHZfxKMWRTlE
	ZJzrUaXQVpi5C02AhTravzmhWMTzx6rojxQT0sEv6mDDzHWUbHLJZk4I/rwSdW3FFApRZhcSErdKo
	DGKsP39g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udkYn-0000000GSC7-13Y2;
	Mon, 21 Jul 2025 07:03:41 +0000
Date: Mon, 21 Jul 2025 00:03:41 -0700
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
Subject: Re: [PATCH v2 4/5] RDMA/mlx5: Enable P2P DMA with fallback mechanism
Message-ID: <aH3mTZP7w8KnMLx1@infradead.org>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-5-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718115112.3881129-5-ymaman@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 18, 2025 at 02:51:11PM +0300, Yonatan Maman wrote:
> From: Yonatan Maman <Ymaman@Nvidia.com>
> 
> Add support for P2P for MLX5 NIC devices with automatic fallback to
> standard DMA when P2P mapping fails.

That's now how the P2P API works.  You need to check the P2P availability
higher up.


