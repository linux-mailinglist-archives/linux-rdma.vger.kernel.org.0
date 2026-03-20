Return-Path: <linux-rdma+bounces-18443-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GVSF8kqvWmI7QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18443-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:08:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A62D951E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24FF30166EF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270A3988FB;
	Fri, 20 Mar 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tC3YC+f/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2843A0B2E
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004924; cv=none; b=MJlxRKl3fV00IBLoIpn6vagcmON+vTc+Mq+clCkk4nmc1qmO2Td+duindst6aVKx1bKfaOqBuig+6PfJo0SMkv6gQW7HxWVxa2ItCNH04lhYo5j7dVGaaOlLIiatz9JZaIE8VNfWuQLwuRSs+TRHHJI5LkbJzbSKFVPr30jpnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004924; c=relaxed/simple;
	bh=DcSdZ1Od4bjS1xSpPlNiqp2KmerXVT1VSew5Vlvza1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HaB2EIpBhL4/VIQNSoX5LklgM8oakmr/SHBBjo+FOusbiRzMGVz1oBB/UDJ4bgQ6+2Tbpfd2QIUuLCziny9XZJ0CNp0Gn8vfG/G/uYk9rViO4Kf95sPH+Cfcs83B8I2ygu2WFEMW0GVeJHW7l/HYd5rO4GQqLnTwQD9F98Sd+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tC3YC+f/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260320110837euoutp01c4cd859b971509ec467575b9f3e10916~eiBLEAtep0470104701euoutp01c
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 11:08:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260320110837euoutp01c4cd859b971509ec467575b9f3e10916~eiBLEAtep0470104701euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774004917;
	bh=4qovv9+aD8RsPS13oGAV/y3xbW2UGToHDWte0hu5auQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tC3YC+f/cwuKn2RlZKFwY2x8rUDgAsDAFY60UyBWpLPBL+67Y08nlVUxai1DNaN5D
	 sFUfqzCG/9wmcnOrRRU7vo76g8QFm1fOPCix13urNlB577UaZgeKHor7NP4Zw+PBBu
	 i0Qd/1bii8ZaKPiERbuc0j3N6JUtuaGTgrhxYrZ8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260320110836eucas1p13ceb4f958f17b568b1b6a89ce9cdbea5~eiBKofPAW2282122821eucas1p1u;
	Fri, 20 Mar 2026 11:08:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260320110835eusmtip2ba021ee90f681f3ad044dd9fe0d2ed25~eiBI-eTqE1236312363eusmtip2w;
	Fri, 20 Mar 2026 11:08:35 +0000 (GMT)
Message-ID: <3fe54fb7-8192-4b0c-9f51-d04cb8ac1300@samsung.com>
Date: Fri, 20 Mar 2026 12:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/8] RDMA: Enable operation with DMA debug enabled
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260318081858.GE61385@unreal>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260320110836eucas1p13ceb4f958f17b568b1b6a89ce9cdbea5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260317190552eucas1p28f3e818f88d252b1e4161332be084177
X-EPHeader: CA
X-CMS-RootMailID: 20260317190552eucas1p28f3e818f88d252b1e4161332be084177
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
	<CGME20260317190552eucas1p28f3e818f88d252b1e4161332be084177@eucas1p2.samsung.com>
	<20260317190538.GD61385@unreal>
	<de23ccf6-75ef-48af-8c69-2f416c564f2d@samsung.com>
	<20260318081858.GE61385@unreal>
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18443-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.930];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CB3A62D951E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Leon,

On 18.03.2026 09:18, Leon Romanovsky wrote:
> On Wed, Mar 18, 2026 at 09:03:00AM +0100, Marek Szyprowski wrote:
>> On 17.03.2026 20:05, Leon Romanovsky wrote:
>>> On Mon, Mar 16, 2026 at 09:06:44PM +0200, Leon Romanovsky wrote:
>>>> Add a new DMA_ATTR_REQUIRE_COHERENT attribute to the DMA API to mark
>>>> mappings that must run on a DMA‑coherent system. Such buffers cannot
>>>> use the SWIOTLB path, may overlap with CPU caches, and do not depend on
>>>> explicit cache flushing.
>>>>
>>>> Mappings using this attribute are rejected on systems where cache
>>>> side‑effects could lead to data corruption, and therefore do not need
>>>> the cache‑overlap debugging logic. This series also includes fixes for
>>>> DMA_ATTR_CPU_CACHE_CLEAN handling.
>>>> Thanks.
>>> <...>
>>>
>>>> ---
>>>> Leon Romanovsky (8):
>>>>         dma-debug: Allow multiple invocations of overlapping entries
>>>>         dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
>>>>         dma-mapping: Clarify valid conditions for CPU cache line overlap
>>>>         dma-mapping: Introduce DMA require coherency attribute
>>>>         dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
>>>>         iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
>>>>         RDMA/umem: Tell DMA mapping that UMEM requires coherency
>>>>         mm/hmm: Indicate that HMM requires DMA coherency
>>>>
>>>>    Documentation/core-api/dma-attributes.rst | 38 ++++++++++++++++++++++++-------
>>>>    drivers/infiniband/core/umem.c            |  5 ++--
>>>>    drivers/iommu/dma-iommu.c                 | 21 +++++++++++++----
>>>>    drivers/virtio/virtio_ring.c              | 10 ++++----
>>>>    include/linux/dma-mapping.h               | 15 ++++++++----
>>>>    include/trace/events/dma.h                |  4 +++-
>>>>    kernel/dma/debug.c                        |  9 ++++----
>>>>    kernel/dma/direct.h                       |  7 +++---
>>>>    kernel/dma/mapping.c                      |  6 +++++
>>>>    mm/hmm.c                                  |  4 ++--
>>>>    10 files changed, 86 insertions(+), 33 deletions(-)
>>> Marek,
>>>
>>> Despite the "RDMA ..." tag in the subject, the diffstat clearly shows that
>>> you are the appropriate person to take this patch.
>> I plan to take the first 2 patches to the dma-mapping-fixes branch
>> (v7.0-rc) and the next to dma-mapping-for-next. Should I also take the
>> RDMA and HMM patches, or do You want a stable branch for merging them
>> via respective subsystem trees?
> I suggest taking all patches into the -fixes branch, as the "RDMA/..." patch
> also resolves the dmesg splat. With -fixes, there is no need to worry about
> a shared branch since we do not expect merge conflicts in that area.
>
> If you still prefer to split the series between -fixes and -next, it would be
> better to use a shared branch in that case. There are patches on the RDMA
> list targeted for -next that touch ib_umem_get().

Okay, I will merge all patches to the -fixes branch then.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


