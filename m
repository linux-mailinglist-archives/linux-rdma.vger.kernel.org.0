Return-Path: <linux-rdma+bounces-18293-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABQ8LUpdumnFUgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18293-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:07:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B75092B783B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27D403050A96
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2CB3783D1;
	Wed, 18 Mar 2026 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QgHOLe5E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755137BE76
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820988; cv=none; b=R2PfTbIosQFtwqLQYeUWf+QN9KUlJ81Gd8xEUWN4pdNx+M49Lx02n9RKPD4QCUGz5PHicRGFSat2XkbIFg8TKPgvcc+Y1kFX9NHKAy3lxxyN47t36F3aP1YmKqml560nCPa7WEuARoYAcnmzmLwP8tNR3GwG6Qsm8Rk3YFLHxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820988; c=relaxed/simple;
	bh=KpETAyrs7YIkUM70PUxFjh8e+vMzcwee8eeDvL3R0fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Oyd2Y+oRtULN4FXt7x4tZX4jbJugUhzEDOq45Oh2gPF7cB2FT5F61YDVj8wr3GrzHCqud5CCYo/+16Ni/k0Fyj9aOHWrIRu1zhhnJgszUPRD+QknO9hQq5SfHMiPmjWMFn0K8VPAI/IwwT3nkJ0SVp81BH0cro/uhqSIkw54+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QgHOLe5E; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260318080302euoutp01c93b7d72b57cfc78339d6f0bb9fc97ef~d4Mkqx2lB0393903939euoutp01u
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260318080302euoutp01c93b7d72b57cfc78339d6f0bb9fc97ef~d4Mkqx2lB0393903939euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773820982;
	bh=5GOrx/bM09mWS7d4FWSxDkysESa+9H3SzC9X1DevVpM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QgHOLe5EykCGGsrBolTj2JuPKhQ1Bki0f6knoOEenxKjutlnI1f1a+IvYzTNANjPB
	 g3MbC1nXSFcfIo0O8YAnngJsBgO+mlGjP/L4WRyaF1fcYTT5wusxKKB3bQtIBpaz+e
	 S5X3ZWGOfil6XUIO2rZg9WqmuiJ2qfPQBkCSac3g=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260318080302eucas1p2c05885afc838bdc98d55972adc31ab96~d4MkRZpJ60631706317eucas1p2v;
	Wed, 18 Mar 2026 08:03:02 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260318080300eusmtip289c1a6818cde8d982e474c8d0c9ee8f6~d4Mi2Bedq1876518765eusmtip2G;
	Wed, 18 Mar 2026 08:03:00 +0000 (GMT)
Message-ID: <de23ccf6-75ef-48af-8c69-2f416c564f2d@samsung.com>
Date: Wed, 18 Mar 2026 09:03:00 +0100
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
In-Reply-To: <20260317190538.GD61385@unreal>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260318080302eucas1p2c05885afc838bdc98d55972adc31ab96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260317190552eucas1p28f3e818f88d252b1e4161332be084177
X-EPHeader: CA
X-CMS-RootMailID: 20260317190552eucas1p28f3e818f88d252b1e4161332be084177
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
	<CGME20260317190552eucas1p28f3e818f88d252b1e4161332be084177@eucas1p2.samsung.com>
	<20260317190538.GD61385@unreal>
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-18293-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:dkim,samsung.com:mid]
X-Rspamd-Queue-Id: B75092B783B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Leon,

On 17.03.2026 20:05, Leon Romanovsky wrote:
> On Mon, Mar 16, 2026 at 09:06:44PM +0200, Leon Romanovsky wrote:
>> Add a new DMA_ATTR_REQUIRE_COHERENT attribute to the DMA API to mark
>> mappings that must run on a DMA‑coherent system. Such buffers cannot
>> use the SWIOTLB path, may overlap with CPU caches, and do not depend on
>> explicit cache flushing.
>>
>> Mappings using this attribute are rejected on systems where cache
>> side‑effects could lead to data corruption, and therefore do not need
>> the cache‑overlap debugging logic. This series also includes fixes for
>> DMA_ATTR_CPU_CACHE_CLEAN handling.
>> Thanks.
> <...>
>
>> ---
>> Leon Romanovsky (8):
>>        dma-debug: Allow multiple invocations of overlapping entries
>>        dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
>>        dma-mapping: Clarify valid conditions for CPU cache line overlap
>>        dma-mapping: Introduce DMA require coherency attribute
>>        dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
>>        iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
>>        RDMA/umem: Tell DMA mapping that UMEM requires coherency
>>        mm/hmm: Indicate that HMM requires DMA coherency
>>
>>   Documentation/core-api/dma-attributes.rst | 38 ++++++++++++++++++++++++-------
>>   drivers/infiniband/core/umem.c            |  5 ++--
>>   drivers/iommu/dma-iommu.c                 | 21 +++++++++++++----
>>   drivers/virtio/virtio_ring.c              | 10 ++++----
>>   include/linux/dma-mapping.h               | 15 ++++++++----
>>   include/trace/events/dma.h                |  4 +++-
>>   kernel/dma/debug.c                        |  9 ++++----
>>   kernel/dma/direct.h                       |  7 +++---
>>   kernel/dma/mapping.c                      |  6 +++++
>>   mm/hmm.c                                  |  4 ++--
>>   10 files changed, 86 insertions(+), 33 deletions(-)
> Marek,
>
> Despite the "RDMA ..." tag in the subject, the diffstat clearly shows that
> you are the appropriate person to take this patch.

I plan to take the first 2 patches to the dma-mapping-fixes branch 
(v7.0-rc) and the next to dma-mapping-for-next. Should I also take the 
RDMA and HMM patches, or do You want a stable branch for merging them 
via respective subsystem trees?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


