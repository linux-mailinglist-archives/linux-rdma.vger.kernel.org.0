Return-Path: <linux-rdma+bounces-18444-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNIvBAsrvWmI7QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18444-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:10:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508BE2D9543
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31742300A53B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF739DBEB;
	Fri, 20 Mar 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ptyVoPWX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF939FCDE
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004999; cv=none; b=W1NgmShSI7PsvNv2muuOLjcoPENpYuIZKoind2YsaWrR+/UHtwJ3+mb+vZohTH2aAkMv6EzmqO4y4mdnEPhJdTVzAMCK0bg5fx4ryTZ4aOHkjk9qSTdVJXti1jqw2a+4/KFI1A+3pJdlLVGnC0S31vY0y5/KS0grHP20jd/bv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004999; c=relaxed/simple;
	bh=muj+S0CwdCa4Mdabtxh88dHeY5bgveIdxMpzHzByQ6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VbHE9mavHApjUbs8mRla5PuO7qPdvc/wWiFxE0kGWMvDoKLcgrARwnUeAqtWy1MoPSH2EvkeqZ/WX6MVA3CCvzr7qJ/2+N0IjtGmUbk98VLEnDSmwJA0+VdGLGALzj2xZjOnRD6ECU57895VMZr+Gm7ChvPlCl5FWxG2vUyqUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ptyVoPWX; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260320110956euoutp027f0828a5b69dc357901a27288772711a~eiCUc039-1913419134euoutp02F
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 11:09:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260320110956euoutp027f0828a5b69dc357901a27288772711a~eiCUc039-1913419134euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774004996;
	bh=pTmqpdf8GjnyZsUw8L2XfkacmPpa02J4Xau6gTuFHFk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ptyVoPWXcBIi6CFajqz8jBHUc7QxmVLROBIa6B07X05T2gMHSAF3qJV+Mxu2faMdW
	 uAMswRdsBVr/P6CT4N9vFmq0zmpofYL/qZzw6yGNXtUr+3CNEGQBePtGtm+H/geV65
	 29SmHCE/UzvDdepCwlLyhLC/iO2gx/kPUCouI5Ys=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260320110955eucas1p27a53a87afc17b63b07866d088aeac78a~eiCUCPSBF0485504855eucas1p2p;
	Fri, 20 Mar 2026 11:09:55 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260320110953eusmtip1e57b08b4312207c095ed6eee93225c85~eiCR0ORyQ2928429284eusmtip1k;
	Fri, 20 Mar 2026 11:09:53 +0000 (GMT)
Message-ID: <b9bdd287-6bd7-4223-be06-7531845c5a19@samsung.com>
Date: Fri, 20 Mar 2026 12:09:52 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/8] RDMA: Enable operation with DMA debug enabled
To: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Petr Tesarik <ptesarik@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260320110955eucas1p27a53a87afc17b63b07866d088aeac78a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260316190712eucas1p27573f4514f2cf7dca5d58414b3c2b7e8
X-EPHeader: CA
X-CMS-RootMailID: 20260316190712eucas1p27573f4514f2cf7dca5d58414b3c2b7e8
References: <CGME20260316190712eucas1p27573f4514f2cf7dca5d58414b3c2b7e8@eucas1p2.samsung.com>
	<20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18444-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.905];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 508BE2D9543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16.03.2026 20:06, Leon Romanovsky wrote:
> Add a new DMA_ATTR_REQUIRE_COHERENT attribute to the DMA API to mark
> mappings that must run on a DMA‑coherent system. Such buffers cannot
> use the SWIOTLB path, may overlap with CPU caches, and do not depend on
> explicit cache flushing.
>
> Mappings using this attribute are rejected on systems where cache
> side‑effects could lead to data corruption, and therefore do not need
> the cache‑overlap debugging logic. This series also includes fixes for
> DMA_ATTR_CPU_CACHE_CLEAN handling.
> Thanks.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied to dma-mapping-fixes. Thanks!

> ---
> Changes in v3:
> - Enriched commit messages and documentation
> - Added ROB tags
> - Link to v2: https://protect2.fireeye.com/v1/url?k=9c1ba148-fd90b40f-9c1a2a07-000babff99aa-86ebd022a97425b3&q=1&e=3c8e10cc-4c34-4bf6-aa9d-c339877d6a27&u=https%3A%2F%2Fpatch.msgid.link%2F20260311-dma-debug-overlap-v2-0-e00bc2ca346d%40nvidia.com
>
> Changes in v2:
> - Added DMA_ATTR_REQUIRE_COHERENT attribute
> - Added HMM patch which needs this attribute as well
> - Renamed DMA_ATTR_CPU_CACHE_CLEAN to be DMA_ATTR_DEBUGGING_IGNORE_CACHELINES
> - Link to v1: https://protect2.fireeye.com/v1/url?k=cc0590de-ad8e8599-cc041b91-000babff99aa-07e4da206b7e0d97&q=1&e=3c8e10cc-4c34-4bf6-aa9d-c339877d6a27&u=https%3A%2F%2Fpatch.msgid.link%2F20260307-dma-debug-overlap-v1-0-c034c38872af%40nvidia.com
>
> ---
> Leon Romanovsky (8):
>        dma-debug: Allow multiple invocations of overlapping entries
>        dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
>        dma-mapping: Clarify valid conditions for CPU cache line overlap
>        dma-mapping: Introduce DMA require coherency attribute
>        dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
>        iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
>        RDMA/umem: Tell DMA mapping that UMEM requires coherency
>        mm/hmm: Indicate that HMM requires DMA coherency
>
>   Documentation/core-api/dma-attributes.rst | 38 ++++++++++++++++++++++++-------
>   drivers/infiniband/core/umem.c            |  5 ++--
>   drivers/iommu/dma-iommu.c                 | 21 +++++++++++++----
>   drivers/virtio/virtio_ring.c              | 10 ++++----
>   include/linux/dma-mapping.h               | 15 ++++++++----
>   include/trace/events/dma.h                |  4 +++-
>   kernel/dma/debug.c                        |  9 ++++----
>   kernel/dma/direct.h                       |  7 +++---
>   kernel/dma/mapping.c                      |  6 +++++
>   mm/hmm.c                                  |  4 ++--
>   10 files changed, 86 insertions(+), 33 deletions(-)
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260305-dma-debug-overlap-21487c3fa02c
>
> Best regards,
> --
> Leon Romanovsky <leonro@nvidia.com>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


