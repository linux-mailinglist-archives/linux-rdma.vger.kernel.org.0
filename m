Return-Path: <linux-rdma+bounces-12355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C29AB0BD15
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 08:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C018A16AC7E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 06:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4A280017;
	Mon, 21 Jul 2025 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vYpHXEg9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2527F16A;
	Mon, 21 Jul 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081154; cv=none; b=CKOExsnOgdvoK/R6v93DqB5l8S+zCK7i2Z03sJE82sBeNf9kfEDXVmmssY1eRaV/Adq0QTbZxINELHMKWaYsIBmUaA1V3lj6Lws77qV/Dc4IlMgaebP66ajBPycyuhbpacBDFAPyMDVyyQJ5KdGblXTzhy+cF/E9Z5rKrPhBWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081154; c=relaxed/simple;
	bh=eYL+S2sPPTApEeO+rKSLfLqzKZrxBi2in8e8ZzBDGcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX5Xd1u4xJp+uy6rjEZUaLx9yYcRqAgKp3dgyhxLOA3NiHwL0MMVzYHHV0A9R3Gz4U9r8Jt1EfzYXcO6Xh5GzyyAQUQzUh+VOtzZPvNCMBHcTpgun5HoNFOB0PQqG72Jd7s/R52PG1nD/L6Tq2IsQ80P5Mdch2FBR3YZCwq1JCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vYpHXEg9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FpsdNncfl7Fn6zKa5KAn1qcGLHrA7rubnu/E/1G43iI=; b=vYpHXEg9pEu1FA2kUkaWCXV0K0
	nJYsJ3Y+pdkP151+s2eNi2zh3kWTgc6D4nBaOT8dl9jkeAe2z0BnuGbOfV5Q7rV49OFEOKlIEi4m/
	UlFmX1Fi/itPjIookMI3tKnVZ+YDzO02fHcLDY3BCFrpQ1eWeHD0A2xEJGNVHTati7lOx7KNKQiLO
	K38rVOjyQIXQ4GAHWZ5oeZ1Xrdyql/o9VTePgB+5HNSCNDgD20ULMvWTqUoPpY2Ot0N79wLc5Mnq1
	BKQrheY1HdIhK/KaPtsfAWFhJ8B9dj21ltsV23BiT1L1XI9MaqmtQ6e49tAV1SLkVyORBwavsCA0A
	dIgmTIiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udkUQ-0000000GRbM-0VEv;
	Mon, 21 Jul 2025 06:59:10 +0000
Date: Sun, 20 Jul 2025 23:59:10 -0700
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
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <aH3lPnIUGn29HJFo@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 18, 2025 at 02:51:08PM +0300, Yonatan Maman wrote:
> From: Yonatan Maman <Ymaman@Nvidia.com>
> 
> hmm_range_fault() by default triggered a page fault on device private
> when HMM_PFN_REQ_FAULT flag was set. pages, migrating them to RAM. In some
> cases, such as with RDMA devices, the migration overhead between the
> device (e.g., GPU) and the CPU, and vice-versa, significantly degrades
> performance. Thus, enabling Peer-to-Peer (P2P) DMA access for device
> private page might be crucial for minimizing data transfer overhead.

You don't enable DMA for device private pages.  You allow discovering
a DMAable alias for device private pages.

Also absolutely nothing GPU specific here.

> +	/*
> +	 * Don't fault in device private pages owned by the caller,
> +	 * just report the PFN.
> +	 */
> +	if (pgmap->owner == range->dev_private_owner) {
> +		*hmm_pfn = swp_offset_pfn(entry);
> +		goto found;

This is dangerous because it mixes actual DMAable alias PFNs with the
device private fake PFNs.  Maybe your hardware / driver can handle
it, but just leaking this out is not a good idea.

> +		    hmm_handle_device_private(range, pfn_req_flags, entry, hmm_pfn))

Overly long line here.


