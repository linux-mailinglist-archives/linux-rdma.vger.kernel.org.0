Return-Path: <linux-rdma+bounces-17777-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGw+F2++rmlEIgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17777-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 13:34:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC9F238EB4
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 13:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5588D30268A7
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706BA3A7F59;
	Mon,  9 Mar 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZHEYuoVE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790183A4F4F
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059436; cv=none; b=ScCkdkqrxPWkxRLBu+dQPA8HQTERiKuAyHnhr2PoH3yWaFbzRrm/ROcqN3Gm/y0URZIWQ8gK6rOqfBniEzXMZyIQO6vjRp7jQ1/uZVgIt6jqdIQeQ9WefAPqvwYyOSwNURmNmpDMVzKUkLN9IL/U6bKeUxXex1Pfcbs9cthoNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059436; c=relaxed/simple;
	bh=Atjx7GL+YNwbnYSuuJvvyi/2Xx/LTpvi9huTzoYuERw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TnYQtVOfDLSlYDcAQ8T7Jdh29GUPF6++kitWOKy+462QUEwLVzSlz37tmuoYI1+b50omfla4IXzyHykzGTy/fBF4WL1bsQr53CuJOlHaOKcNpVWNpnLzY+XlAExFOeV4xrXBHXH1bly3gEWzxPUl07ZGUe/2qgDJEaEEPC7S568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZHEYuoVE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260309123026euoutp02d721e22a331b3ff132e681e2203c8555~bLCeMd_dW1334313343euoutp02f
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 12:30:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260309123026euoutp02d721e22a331b3ff132e681e2203c8555~bLCeMd_dW1334313343euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773059426;
	bh=gp98JWQznNkZR98zt3gnsF+GVRheVa4QaSz8tPoGX4A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZHEYuoVENPNznd0xqoljK61UHKR3Hw36bx/GKYTBnu1Us7nFDI8Up96iFqiq8oROY
	 pfLEU5iHAKMwbW1m8NX8yv5QNOoIrcakV5Aaa9smsGUU2cMxFu1/e51fxPC6K3YijR
	 v7YhHKq3PlBrYH8w3DotscIKEAjnxh+MXlMzpaBk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260309123026eucas1p218b4b7e463c3f96e1a48eca954009827~bLCd364Di0084200842eucas1p2W;
	Mon,  9 Mar 2026 12:30:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260309123025eusmtip2240c0ac5f812e2669c819f74be51bf3c~bLCdK_wth2997829978eusmtip2R;
	Mon,  9 Mar 2026 12:30:25 +0000 (GMT)
Message-ID: <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
Date: Mon, 9 Mar 2026 13:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260309090342.GS12611@unreal>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260309123026eucas1p218b4b7e463c3f96e1a48eca954009827
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07
X-EPHeader: CA
X-CMS-RootMailID: 20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
	<20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
	<20260308181920.GH1687929@ziepe.ca> <20260308184902.GR12611@unreal>
	<20260308230916.GI1687929@ziepe.ca>
	<CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
	<20260309090342.GS12611@unreal>
X-Rspamd-Queue-Id: CFC9F238EB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17777-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,samsung.com:dkim,samsung.com:mid]
X-Rspamd-Action: no action

On 09.03.2026 10:03, Leon Romanovsky wrote:
> On Sun, Mar 08, 2026 at 08:09:16PM -0300, Jason Gunthorpe wrote:
>> On Sun, Mar 08, 2026 at 08:49:02PM +0200, Leon Romanovsky wrote:
>>> On Sun, Mar 08, 2026 at 03:19:20PM -0300, Jason Gunthorpe wrote:
>>>> On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:
>>>>
>>>>> -This attribute indicates the CPU will not dirty any cacheline overlapping this
>>>>> -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
>>>>> -multiple small buffers to safely share a cacheline without risk of data
>>>>> -corruption, suppressing DMA debug warnings about overlapping mappings.
>>>>> -All mappings sharing a cacheline should have this attribute.
>>>>> +DMA_ATTR_CPU_CACHE_OVERLAP
>>>> This is a very specific and well defined use case that allows some cache
>>>> flushing behaviors to work only under the promise that the CPU doesn't
>>>> touch the memory to cause cache inconsistencies.
>>>>
>>>>> +Another valid use case is on systems that are CPU-coherent and do not use
>>>>> +SWIOTLB, where the caller can guarantee that no cache maintenance operations
>>>>> +(such as flushes) will be performed that could overwrite shared cache lines.
>>>> This is something completely unrelated.
>>> I disagree. The situation is equivalent in that callers guarantee the
>>> CPU cache will not be overwritten.
>> The RDMA callers do no such thing, they just don't work at all if
>> there is non-coherence in the mapping which is why it is not a bug.
>>
>> virtio looks like it does actually keep the caches clean for different
>> mappings (and probably also in practice forced coherent as well given
>> qemu is coherent with the VM and VFIO doesn't allow non-coherent DMA
>> devices)
>>
>>>> What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
>>>> fails any mappings requests that would use any SWIOTLB or cache
>>>> flushing.
>>> You are proposing something orthogonal that operates at a different layer
>>> (DMA mapping). However, for DMA debugging, your new attribute will be
>>> equivalent to DMA_ATTR_CPU_CACHE_OVERLAP.
>> DMA_ATTR is a dma mapping flag, if you want some weird dma debugging
>> flag it should be called DMA_ATTR_DEBUGGING_IGNORE_CACHELINES with
>> some kind of statement at the user why it is OK.
> And this is the issue: the existing DMA_ATTR_CPU_CACHE_CLEAN is essentially
> a debug-oriented attribute. The upper layers are already handled through
> __dma_from_device_group_begin()/end(), which pad cache lines on
> non-coherent systems.
>
> Marek,
>
> What do you see as the right path forward here? RDMA has a legitimate use
> case where CPU cache lines may overlap. The underlying reason differs from
> VirtIO, but the outcome is the same. Should I keep the current name? Should
> we rename it to the proposed DMA_ATTR_CPU_CACHE_OVERLAP or
> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES? Should we introduce a new
> DMA_ATTR_REQUIRE_COHERENT attribute instead? Or do you have another
> recommendation?

My question here is if RDMA works on any non-coherent DMA systems? If 
not then it should fail early (during init or probe?) to avoid potential 
data corruption and new DMA attributes won't help it. On the other hand, 
theDMA_ATTR_CPU_CACHE_OVERLAP attribute is a bit more descriptive to me 
than DMA_ATTR_CPU_CACHE_CLEAN, but this indeed looks like a separate 
issue from the RDMA case.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


