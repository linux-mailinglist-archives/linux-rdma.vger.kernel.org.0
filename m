Return-Path: <linux-rdma+bounces-20697-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCTeEbzKBWrvbQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20697-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 15:14:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8D542281
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 15:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CF93014553
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF93C09E4;
	Thu, 14 May 2026 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGlKofmX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE327F75C
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764472; cv=none; b=KsJbyg2ElnaUnus0EhnAKrkAl0W7YELgz41kegpYbPX8UJBLq6vq/yToNlFAmjkkix8CKeuYrm6yyNY0G3J0leI1sHPRp8Q44WEDXkPUvsgQvuVXJG5qFi78fSwRljrQnk4+TYrxky4qoMqDEiOHXXJD6bQkBn6ZazXDM08coxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764472; c=relaxed/simple;
	bh=x3PlOJRU80zRDyrVtynuTEktOPJp8Kj0xTcx30CHpqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbyn4/bwqyqMgqglIc0oB+WJm7uEMzC0W2Q2wWGLJ7BXxA6qCbzlXlKQc4gvXgUbddA/1WtuvPovyMgDaKBsJTK2jeKcM06aK2RFPJM6Wh8ilh6cHZqhOBIbycn+0sswJABDS+eOQj2/zH+f76KlQsHBf9xFtFaKIl2WgeI9+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGlKofmX; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7463ed4b-543c-49d4-9337-f41915354a3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778764467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNvf/tl2zCppYtjfin0VjNCyLest0Jrv/etKUgcv1qw=;
	b=gGlKofmXe3uoetcawVa5f5jmLG31kDRAIpkIimGboKay6a4m5lhqYmce15No/GTPpOtkGi
	pLkJ8URFTGBAklFsfhjV38QZtG+YtosNWe/yxAgn4+WLrVkiHc7H7YKiBCln6mdUBopC6h
	q78TcEK2C9vswSzHfWsZlWLaZJzuI9k=
Date: Thu, 14 May 2026 15:14:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3] RDMA/siw: use kzalloc_flex
To: Leon Romanovsky <leon@kernel.org>, rosenp@gmail.com
Cc: jgg@ziepe.ca, kees@kernel.org, gustavoars@kernel.org,
 linux-rdma@vger.kernel.org
References: <20260511141149.52362-1-bernard.metzler@linux.dev>
 <177869432039.2333679.10257766726760194039.b4-ty@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <177869432039.2333679.10257766726760194039.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9DE8D542281
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20697-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On 13.05.2026 19:45, Leon Romanovsky wrote:
> 
> On Mon, 11 May 2026 16:11:49 +0200, bernard.metzler@linux.dev wrote:
>> Simplify umem allocation by using flexible array member.
>> Add __counted_by to get extra runtime analysis.
> 
> Applied, thanks!
> 
> [1/1] RDMA/siw: use kzalloc_flex
>        https://git.kernel.org/rdma/rdma/c/79678bea399052
> 
> Best regards,
Hi Leon,

per Jason's suggestion, please amend the patch by
adding below line. We should NOT assume kzalloc_flex
to initialize anything but 0. So we shall set
umem->num_chunks explicitly.

Many thanks,
Bernard.
----

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 88ec3cacfa00..40455616d9ec 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -359,6 +359,7 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
	umem->fp_addr = first_page_va;
	umem->base_mem = base_mem;
	umem->num_pages = num_pages;
+	umem->num_chunks = num_chunks;

	sgt = &base_mem->sgt_append.sgt;
	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);


