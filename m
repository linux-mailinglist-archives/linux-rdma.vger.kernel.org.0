Return-Path: <linux-rdma+bounces-17849-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JTeNwrpr2nkdAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17849-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96547248CC9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FD743091B3D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7FB43D51D;
	Tue, 10 Mar 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DUa33BIc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B0199D8
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135943; cv=none; b=CXFCo2WiNrsWzIscXYHB49sZnP837viZDIsQv3zehfpOW4Ku7yF/wwigCzM23pLidKkH9jmalHPzo/6j4ghWatpTDSvWw840D5EaX0XADHTkpUGEnzqAv3f0ldTX2oDBVB063FXhlcRd5OBeTdSbIOPCtD9H2l8B8/hUTsxPAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135943; c=relaxed/simple;
	bh=ZLvezuR8s0+OWVqfo92KUk4UlTJ6DqfgkS4fGtPZbTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=prFcjs1kDZxsM/IAwnjUA3JUu+Ti5cXLg/pPedD4C6KQWaLQRjPrTVkzfVbGssQhwxVhsACFjorNr/8KdU30OqOW652IHkCH2dnzksU45lU1BfUZTAtT4uiiZdYt+QTmUtt/iehK3RGk3Su619weB76foKVa8qopqXtrZ8hiT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DUa33BIc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260310094539euoutp0265647b65cd64f7b25b935114541b74e8~bcb4uYGPv0692606926euoutp02R
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 09:45:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260310094539euoutp0265647b65cd64f7b25b935114541b74e8~bcb4uYGPv0692606926euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773135939;
	bh=g4Z4ok96NWqzBgjOcLsFlXJfC/4zjtxkfiYjt2twx7A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DUa33BIcjnjYaDcrUwR4b3y4tN6gJrXkmaBcwcJ4p2c4tZGQM9R38aSaC2a0O/Bbo
	 0xa64kwxr8dc0Yov8gz0+bhz5Z3p5QxpyUFH3txM4dysJYcWw+sParNspVxK2j8cYf
	 dHSDbRa7PdBI1Opg2OUQSyeLHuC0MQYAqRPXhB3s=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260310094539eucas1p15d2320cc87bfb317f5be51b359fb08c6~bcb4brfjb0410104101eucas1p1p;
	Tue, 10 Mar 2026 09:45:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260310094538eusmtip17998daf8f2a16ee4d9b5c8cb775d1e36~bcb3virLM2940529405eusmtip1i;
	Tue, 10 Mar 2026 09:45:38 +0000 (GMT)
Message-ID: <aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>
Date: Tue, 10 Mar 2026 10:45:38 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260309151356.GN1687929@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260310094539eucas1p15d2320cc87bfb317f5be51b359fb08c6
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
	<c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
	<20260309150502.GX12611@unreal> <20260309151356.GN1687929@ziepe.ca>
X-Rspamd-Queue-Id: 96547248CC9
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
	TAGGED_FROM(0.00)[bounces-17849-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.895];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 09.03.2026 16:13, Jason Gunthorpe wrote:
> On Mon, Mar 09, 2026 at 05:05:02PM +0200, Leon Romanovsky wrote:
>> Regarding failure on unsupported systems, I have tried more than once to
>> make the RDMA fail when the device is known to take the SWIOTLB path
>> in RDMA and cannot operate correctly, but each attempt was met with a
>> cold reception:
>> https://lore.kernel.org/all/d18c454636bf3cfdba9b66b7cc794d713eadc4a5.1719909395.git.leon@kernel.org/
> I think alot of that is the APIs used there. It is hard to determine
> if SWIOTLB is possible or coherent is possible, I've also hit these
> things in VFIO and gave up.
>
> However, DMA_ATTR_REQUIRE_COHERENCE can be done properly and not leak
> alot of dangerous APIs to drivers (beyond itself).
>
> It is also more important now with CC systems, I think.

Jason is right. Indeed the rdma/uverbs case needs some extension to 
ensure that the coherent mapping is used, what is not possible now. This 
however doesn't mean that the DMA_ATTR_CPU_CACHE_OVERLAP is not needed 
for that use case too. I'm open to accept both. The only question I have 
is which name should we use? We already have DMA_ATTR_CPU_CACHE_CLEAN, 
while DMA_ATTR_CPU_CACHE_OVERLAP and 
DMA_ATTR_DEBUGGING_IGNORE_CACHELINES were proposed here. The last seems 
to be most descriptive.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


