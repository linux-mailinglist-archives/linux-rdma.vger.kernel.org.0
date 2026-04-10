Return-Path: <linux-rdma+bounces-19209-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NqOKUUW2Wm7lwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19209-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 17:24:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B523D93A2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF003065D83
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E33D9DC8;
	Fri, 10 Apr 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN7e6fzW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970153D4117;
	Fri, 10 Apr 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834197; cv=none; b=r/NlW3mTSlsw2ND3qC/AmJ92oE3bdWumAIqLg/VDaJkE1J3clVBELQJq9SlFlOSi3knZaQCP16h+wpvFeLRdberkDr6dSHgw58R+jonkiX0K/B/OyPDMz9jmxvk7gCCtijTZOBucdN1ezqbMysRgT2MRbO1CqTI4gM79rW6tKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834197; c=relaxed/simple;
	bh=Zbifno8UeSRvee5yMpEkcrdMKYo4zYWVvjNlJnyEkpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncxnbm5VDh33E9ylneZj6aru1BGqCNpUMgEby5lunC6LIA5KaqexWEVyw7HlrUs5RCarXETgIAE1o63eIWoAaLiKShhamloTApJvZ31iMlfMZB7qKczhEquT9HQLzmnZRe9W+s+19VkYlMs0guHV5i11sFK4RquRyePzOgaPnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN7e6fzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C21C19421;
	Fri, 10 Apr 2026 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834197;
	bh=Zbifno8UeSRvee5yMpEkcrdMKYo4zYWVvjNlJnyEkpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN7e6fzWk0vI2vN12ZiZflmNei0jSmE93f2Se4Loux8xkoL8LyCqocItVKIzmoUDO
	 LeST/JMrWWjptXQLYqILNzUmsNUvHtvNdnPC0Q/Ct10p2wD3UbQFan7QRj7ZRW2ZNy
	 PZEhj0/zTjEAgT3K5Lp/CghGonqN5eE3ETN4BR2MiJ0oZqlTKq2/5KG9fsZFELDHGJ
	 c7Idmx2ktf0jH6hS0jvRVFkEXpLFAjdjGNb7pb7RqZNiwvragGnYhCG6vtgg+9mEm1
	 VtdTO68WY13VRN/uE18qyO97AnH1pGl9Or5uqBsX4AgySfp+I+WmlIcP7NJaSblkgr
	 znrECfyXl34Hw==
Date: Fri, 10 Apr 2026 16:16:31 +0100
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: Re: [PATCH net-next v2] net/smc: cap allocation order for SMC-R
 physically contiguous buffers
Message-ID: <20260410151631.GY469338@kernel.org>
References: <20260407124337.88128-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407124337.88128-1-alibuda@linux.alibaba.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19209-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 51B523D93A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:43:37PM +0800, D. Wythe wrote:
> The alloc_pages() cannot satisfy requests exceeding MAX_PAGE_ORDER,
> and attempting such allocations will lead to guaranteed failures
> and potential kernel warnings.
> 
> For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER.
> This ensures the attempts to allocate the largest possible physically
> contiguous chunk succeed, instead of failing with an invalid order.
> This also avoids redundant "try-fail-degrade" cycles in
> __smc_buf_create().
> 
> For SMCR_MIXED_BUFS, no cap is needed: if the order exceeds
> MAX_PAGE_ORDER, alloc_pages() will silently fail (__GFP_NOWARN)
> and automatically fall back to virtual memory.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
> Changes v1 -> v2:
> https://lore.kernel.org/netdev/20260312082154.36971-1-alibuda@linux.alibaba.com/
> 
> - Move the bufsize cap from smcr_new_buf_create() up to
>   __smc_buf_create(), which is simpler and avoids touching
>   the allocation logic itself.

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/smc/smc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index e2d083daeb7e..cdd881746e21 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2440,6 +2440,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>  		/* use socket send buffer size (w/o overhead) as start value */
>  		bufsize = smc->sk.sk_sndbuf / 2;
>  
> +	/* limit bufsize for physically contiguous buffers */
> +	if (!is_smcd && lgr->buf_type == SMCR_PHYS_CONT_BUFS)
> +		bufsize = min_t(int, bufsize, (PAGE_SIZE << MAX_PAGE_ORDER));

nit: I think min() is sufficient here, and the inner parentheses are
     unnecessary

> +
>  	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
>  	     bufsize_comp >= 0; bufsize_comp--) {
>  		if (is_rmb) {
> -- 
> 2.45.0
> 

