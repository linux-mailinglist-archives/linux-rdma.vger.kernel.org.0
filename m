Return-Path: <linux-rdma+bounces-18770-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGMeOmYnyWm/vAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18770-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 15:21:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7700C352333
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6909E301387D
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151436E485;
	Sun, 29 Mar 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNQKXjUh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AC35C1B4
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790496; cv=none; b=K9kgVyBfUUtTxdjLw9r5P56rOw6Ueums2OX5fTbgvsLdpQYOuopWqKKjPX0FnVT/YK4IJ3mnSSrBd982OK+eaAdQGDtmJX6n0jYMoOfWp12lCjDO++ZTxBBM3esJwbLtnftzQJ4Bl0PAl4cAR2Lbrjqt/SvWgIuGW2OWvevgJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790496; c=relaxed/simple;
	bh=/KhAtAsI3s6fcGSybeyA8ZeIbLVIX7i2Xg+KtYf4xzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sReZSfVIh0rDlgkTQTr7e7hoHMCKCoVIKvBg5CHOHeR1Ia1ZbrqNeouNEAvEkQTGsCD8gyS/zNOGsWb8gyQKBAlMy4CDEaamHvGI7M/0Lxqm02Jl6y/g+/Rbk6s5cFBv20CpA+sglk34lDU7SPStK2mBkOJLbziL6mOi74O2eJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNQKXjUh; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49794f9f-8a35-4e36-af19-26b68c89decd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774790491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plT73sepgzsaXNz8WWASbGNtwjS/AoTdnhNGVsEsc48=;
	b=LNQKXjUhxTCq+I/Txk5shY2T0DxUff5Sr/1Y09v6XmiGyArezhnHdqBpPOeWy7p0brpAEU
	DlWAQdu8IYo2+GenLiCeGd+vsa0gc0adg4QUX8YZkTVLrE9igXwvTO0h4FCIGpuWioaygv
	SxbSc4hWjf8P1wLAWxHQpGyiz4eyk6c=
Date: Sun, 29 Mar 2026 15:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260327030056.8321-1-rosenp@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260327030056.8321-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18770-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 7700C352333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27.03.2026 04:00, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Add __counted_by to get extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/infiniband/sw/siw/siw.h     |  2 +-
>   drivers/infiniband/sw/siw/siw_mem.c | 12 +++---------
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index f5fd71717b80..2b327a899a1c 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -119,9 +119,9 @@ struct siw_page_chunk {
>   
>   struct siw_umem {
>   	struct ib_umem *base_mem;
> -	struct siw_page_chunk *page_chunk;
>   	int num_pages;

Shouldn't we replace 'num_pages' by a 'num_chunks' and change
memory allocation and release code accordingly?

>   	u64 fp_addr; /* First page base address */
> +	struct siw_page_chunk page_chunk[] __counted_by(num_pages);
>   };
>   
>   struct siw_pble {
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index 98c802b3ed72..08047fcf0df1 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -50,7 +50,6 @@ void siw_umem_release(struct siw_umem *umem)
>   		kfree(umem->page_chunk[i].plist);
>   		num_pages -= PAGES_PER_CHUNK;
>   	}
> -	kfree(umem->page_chunk);
>   	kfree(umem);
>   }
>   
> @@ -347,16 +346,12 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
>   	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
>   	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
>   
> -	umem = kzalloc_obj(*umem);
> +	umem = kzalloc_flex(*umem, page_chunk, num_chunks);
>   	if (!umem)
>   		return ERR_PTR(-ENOMEM);
>   
> -	umem->page_chunk =
> -		kzalloc_objs(struct siw_page_chunk, num_chunks);
> -	if (!umem->page_chunk) {
> -		rv = -ENOMEM;
> -		goto err_out;
> -	}
> +	umem->num_pages = num_pages;
> +
>   	base_mem = ib_umem_get(base_dev, start, len, rights);
>   	if (IS_ERR(base_mem)) {
>   		rv = PTR_ERR(base_mem);
> @@ -385,7 +380,6 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
>   		umem->page_chunk[i].plist = plist;
>   		while (nents--) {
>   			*plist = sg_page_iter_page(&sg_iter);
> -			umem->num_pages++;
>   			num_pages--;
>   			plist++;
>   			if (!__sg_page_iter_next(&sg_iter))


