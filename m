Return-Path: <linux-rdma+bounces-7173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A60A18CA2
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 08:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB623A6A25
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729CD1BD4F1;
	Wed, 22 Jan 2025 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE38QQ6v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3371BBBE0;
	Wed, 22 Jan 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530166; cv=none; b=WiUEhaWFol6rqGetcpcfr+r/GarmdWLkKIvqCxWiyGXs28tcNnSUan534s0/OKsfxjib9v74hVLRVjUpBOFhslJlIu2Nh4FdZDtvKIxoaO9jif+7JkdFC7KuW20edphxHYvIlqa9z2pI8M3IKWpiOKRdfV7xrfDMj3VETtteFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530166; c=relaxed/simple;
	bh=tSo5YKl5X3DFM1qWK3NIAZZXFJGx8VgXV6QXZ6sOkCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xu9n8p9dnmiP36EDZUHpvlHckaihNKE6AVSMLHqwJXhlvwAHSu+R3KkJXkbNKrKzWADgP539UuzBX13Bxe7WZezmhO3QJoVW4aVmdJ0DayzV1sKlfP1VMeSrW3d0e4DkwOoyWLjtdg7Wi5kgJf7t/DPnYgJFzUSiafYSp4BE1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE38QQ6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F05C4CEE2;
	Wed, 22 Jan 2025 07:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737530164;
	bh=tSo5YKl5X3DFM1qWK3NIAZZXFJGx8VgXV6QXZ6sOkCs=;
	h=Date:From:To:Cc:Subject:From;
	b=bE38QQ6vnaUxbTv5Xsmn18B0iOF4kSDFj4rpFxv8Mms3apibukB9coTAosEmDhXdg
	 pLpiMUba7Pt7NmZ3Vb4ilncay0Exvoo31IIQA333KVqd1sh9VoDfEZAXO9Xnw1/DSp
	 g0J8O5XqJReO4BkUd4VTMv9ZTpHZ84Rkwxfh+v5Z5y5wLuR89QxJzsMKUiYUZklyUP
	 yPR2Py/GUuBXWQJsriiuwLQMQ1HxSiwm/6J5ZKG8HezsuhGG43G5CCqEpPQjZCyhJL
	 Of7JJzziQa8zqgoKWKtc4uWtJRP2OCSNdWAaC/F62hPvfJ6fqfv9Sr9OWVB33vw9Ku
	 v0X2rrbjIBfTg==
Date: Wed, 22 Jan 2025 09:16:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] DMA mapping API in complex scenarios
Message-ID: <20250122071600.GC10702@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently the only efficient way to map a complex memory description through
the DMA API is by using the scatterlist APIs. The SG APIs are unique in that
they efficiently combine the two fundamental operations of sizing and allocating
a large IOVA window from the IOMMU and processing all the per-address
swiotlb/flushing/p2p/map details.

This uniqueness has been a long standing pain point as the scatterlist API
is mandatory, but expensive to use. It prevents any kind of optimization or
feature improvement (such as avoiding struct page for P2P) due to the
impossibility of improving the scatterlist.

Several approaches have been explored to expand the DMA API with additional
scatterlist-like structures (BIO, rlist), instead split up the DMA API
to allow callers to bring their own data structure [1].

The API is split up into parts:
 - Allocate IOVA space:
    To do any pre-allocation required. This is done based on the caller
    supplying some details about how much IOMMU address space it would need
    in worst case.
 - Map and unmap relevant structures to pre-allocated IOVA space:
    Perform the actual mapping into the pre-allocated IOVA. This is very
    similar to dma_map_page().

In this topic, I would like to present existing DMA API abuses and present path
to move forward with the help of new DMA API.

In this topic I will briefly present the new API and have a forward
looking discussion about how such a significant change is expected to
impact the kernel.

Particularly how this API fits with Matthew's phyr sketch, and where
we might see this go in the storage layer (David's proposal for iter [2]).
In addition, we will discuss the roadmap of converting DMABUF and RDMA to
SG-free world (Jasons's vision [3]):

 1) The new DMA API lands
 2) We improve the new DMA API to be fully struct page free, including
    setting up P2P
 3) VFIO provides a dmbuf exporter using the new DMA API's P2P
    support. We'd have to continue with the scatterlist hacks for now.
    VFIO would be a move_notify exporter. This should work with RDMA
 4) RDMA works to drop scatterlist from its internal flows and use the
    new DMA API instead.
 5) VFIO/RDMA implement a new non-scatterlist DMABUF op to
    demonstrate the post-scatterlist world and deprecate the scatterlist
    hacks.
 6) We add revoke semantics to dmabuf, and VFIO/RDMA implements them
 7) iommufd can import a pinnable revokable dmabuf using CPU pfns
    through the non-scatterlist op.
 8) Relevant GPU drivers implement the non-scatterlist op and RDMA
    removes support for the deprecated scatterlist hacks.

[1] https://lore.kernel.org/all/cover.1737106761.git.leon@kernel.org
[2] https://lore.kernel.org/all/886959.1737148612@warthog.procyon.org.uk/
[3] https://lore.kernel.org/all/20250120175901.GP5556@nvidia.com

----------------------------------------------------------------------------
 LWN coverage:
Dancing the DMA two-step - https://lwn.net/Articles/997563/
----------------------------------------------------------------------------

Thanks

