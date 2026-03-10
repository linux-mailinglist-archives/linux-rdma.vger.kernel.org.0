Return-Path: <linux-rdma+bounces-17913-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMKvAmuIsGl2kQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17913-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:08:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D4D2581C3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9DB130DEC1A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079C03AD502;
	Tue, 10 Mar 2026 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eZ8XyXaP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AD39DBFB
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176930; cv=none; b=HV0L7rgepnSRpncafk8U+06svAIRPBD86UL3Er5Jo9V0VX+z+xESyRjFs23l0TbwKUkRorwm4vgRRFr1sXHpXcDkyXG3LGuLq0MgrTgb0qK0YboQZFl+2X6kXNP7uYkLerS2KSbr//uD17K0z/VZD9GE47Sx2BrJ1EBzKo9rGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176930; c=relaxed/simple;
	bh=SxvFwt6RNoWEPsMfWZcfBn5YT6mZDJktqM19xKBdhV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tC8ezyuWPXywcGZGqXpeoAandp7KPNjlT1JcYZWu1IsF2UvkTdD96FThI9jyTTdj3LvB3nG0PqfbPi5ZYtyNl6aakDi3G/EO1UbcMCwEXJm6219KgTZMgK58MMm1dlXAClNiZwyJs57En5r6Z3+7TKktRxSM4xyaMF/D7Jb2ii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eZ8XyXaP; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260310210841euoutp02b83b914c97d5fce71955e07094dfc5bd~blwPh6Mez3003230032euoutp02D
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 21:08:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260310210841euoutp02b83b914c97d5fce71955e07094dfc5bd~blwPh6Mez3003230032euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773176921;
	bh=tGKcv9KXSZ8NeZkMwYhCoqHzYQKa6iNvw2bZS+J/rzE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eZ8XyXaPRQAjrmD4tNZ3xUXMKKEX3h1oOCD4TsFqZXdYBieeyb/LtVoxH2f21WRDs
	 FseqmW6UqV5Wnori+EXSWkMHCW3pnM/7xRBu1chhgHxCLymTyDSRwFQpU7xFOprv5y
	 rxzqJwl64rsea6rmb5pyIdwHoZqCHAqngy2W2YQE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260310210840eucas1p2dc0fce312c0fe458cd71faffb303d0a6~blwPOKs7r3236232362eucas1p2y;
	Tue, 10 Mar 2026 21:08:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260310210839eusmtip17c631ae9b4a7af8f06cd5dfe1f3e6b7d~blwNydyN01109311093eusmtip1E;
	Tue, 10 Mar 2026 21:08:39 +0000 (GMT)
Message-ID: <a61f8814-b896-4ec0-bb83-a8cbd8aca4e8@samsung.com>
Date: Tue, 10 Mar 2026 22:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Petr Tesarik <ptesarik@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260310123405.GR1687929@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260310210840eucas1p2dc0fce312c0fe458cd71faffb303d0a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07
X-EPHeader: CA
X-CMS-RootMailID: 20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07
References: <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
	<20260308181920.GH1687929@ziepe.ca> <20260308184902.GR12611@unreal>
	<20260308230916.GI1687929@ziepe.ca>
	<CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
	<20260309090342.GS12611@unreal>
	<c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
	<20260309150502.GX12611@unreal> <20260309151356.GN1687929@ziepe.ca>
	<aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>
	<20260310123405.GR1687929@ziepe.ca>
X-Rspamd-Queue-Id: A5D4D2581C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17913-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.870];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,samsung.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 10.03.2026 13:34, Jason Gunthorpe wrote:
> On Tue, Mar 10, 2026 at 10:45:38AM +0100, Marek Szyprowski wrote:
>> Jason is right. Indeed the rdma/uverbs case needs some extension to
>> ensure that the coherent mapping is used, what is not possible now. This
>> however doesn't mean that the DMA_ATTR_CPU_CACHE_OVERLAP is not needed
>> for that use case too. I'm open to accept both. The only question I have
>> is which name should we use? We already have DMA_ATTR_CPU_CACHE_CLEAN,
>> while DMA_ATTR_CPU_CACHE_OVERLAP and
>> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES were proposed here. The last seems
>> to be most descriptive.
> If we do DMA_ATTR_REQUIRE_COHERENCE then I imagine it would internally
> also set DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, but I'd prefer that
> detail not leak into the callers.

Why DMA_ATTR_REQUIRE_COHERENCE should imply 
DMA_ATTR_DEBUGGING_IGNORE_CACHELINES?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


