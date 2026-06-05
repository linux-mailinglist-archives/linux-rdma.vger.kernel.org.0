Return-Path: <linux-rdma+bounces-21884-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2EJBGk9YI2pBqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21884-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 01:14:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41D64BC13
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 01:14:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=Sro0e4tk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21884-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21884-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62C58303BDEE
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 23:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687B409603;
	Fri,  5 Jun 2026 23:13:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB13955F3
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 23:13:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701197; cv=pass; b=N0L2BgXFWb9W7VsUletjuFp0j5SAHhmcl3Zra+SxwJ4S/zg3zbjNnZEVD/c1lBo1SF1FZ5Vn05c0k7MO2vDrnP5Bv4A+xy02qonV1li9i7Cv874hdDx7MyRycpjWY67rWeEg1d04F0lyxypN9wzvrEeFus+ivmPMkO2sEwUxUy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701197; c=relaxed/simple;
	bh=4cE486h5t6YIIigwj5Ql88T65gS4pqp6vVCrPMt54vY=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0s2QiWJ/Lmcw1dDUO+iXuYrCt1UtLOA0KFHG54RznMqkuQ2P9sesbTCT+n6PrMCrA0nHq040Iyraq0HGmO052/LTiqD85S+yARoJ1GoF2KLlHKGh1m6FOl/pbbFjDQ6uPT8GzzLdPyHvPuMPNk3LF9HekrrYQjVCmw8NZ1zPkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Sro0e4tk; arc=pass smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b9318997so18116755e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jun 2026 16:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780701193; cv=none;
        d=google.com; s=arc-20240605;
        b=IZRTnkp5DN5XOfTYMGmbg49DnWi68XqY+/vMXQbT0NvHIBy4oo1Ds4acW7LoeXmANZ
         GjTfvEvJav3rVXo2MIrmz9MQlrnlevJ3C00txTylOi8U9L3lwckfQ33KMnsikSnptbbB
         CM4/IwpwVSFvfV8/KMLVTTliwNpqKsvJb+6NEGKLW68e36Hu/rsPu4r/UXdtSN/iZOV1
         yjV+0UxluJGyRjZZAZg9cCZsgLB1jOq5Vt6D51hIkjF1HcKOXS7rmqQSmd0W4+vgDFi9
         PtLL6AYb99ownTTlS4uLUHIIdJSSIbMiDUuGV3uqFzb4SYJTMr4tg2fd9HWbZNKCO7AK
         L9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:dkim-signature;
        bh=79tlu8fv//QY1Mz5hfzUvL7B6kALz4yuxyZKouUvpEA=;
        fh=7h68sSiNgeI1X36AbYsFDq+DRINt+lkaxir3aw8RQ8I=;
        b=EF+YrnfWwLT95T+o5Ot3xsAjODnkbq4faIBqX+ONw80G6iEs1PUlVgTliHL+M1fnh1
         Sl4rMdew5SQ0kzjrh3lFlqpamOItu7vo5aNah1JMDDUgY3nzM/O6QZd1C6ldXQUQ6lwk
         FZNGHcJo0/Ssmceb27DmlOtYpckmiQgzYZh7CWs+qZkf9Fu7acTFoMdkQTPAXXNVG1fr
         VZFRKPvVR+LzOTuiVAXK3tz4JrzU32bUcUVZQQXsV1ZeVWacR4Ru32lBSYqyFKbNEoGA
         DZ+/3f7k5AFUTlBsimsYLlzoUbWwVVajNRlJr7hhAmI6tNm+oAic0DMe3xcjz0XV6Ese
         w7+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780701193; x=1781305993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79tlu8fv//QY1Mz5hfzUvL7B6kALz4yuxyZKouUvpEA=;
        b=Sro0e4tkAKPOnRXFRQ8v4kPraQLZOK6t5d94gln1A9t6aAnh04YmkITeCel4NhGyPu
         jjrUmX/9olqBO0gCRVpxRo1Iu0zmJJRjs2qRIZhXCQNVt9UtZ6HwSb38SPC5VU16+6ME
         MSXuCWNMKIQpJrzrTCDTsaTsXw6ImLRAj+pG5Ntkn+1Z58YCJ4Y2xir/5+dlixrX/QGS
         mUFPvG1atkEdhcpVIS19Itzc900s2pxsSdkLv/EwfjFH4ZSLt+ps7oSlmJFZmWTfRBeL
         wfgCEovnT6TPvnMzqFJIhq7tvfruMqfYFhxHqsA7E1q9p2BloxIBY0Npr7kAfDJPxTVx
         t04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780701193; x=1781305993;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79tlu8fv//QY1Mz5hfzUvL7B6kALz4yuxyZKouUvpEA=;
        b=gDNj5kcwRNWynD9zwLdarK81kXKgQ/JM3JGqnUf+OFJG+8yR8os5w8fCx4YEbuZj+C
         sn3pFtooBZvE3n6RhucuyocUtKUsxPOwVgsqn4JGK90lZ9EdZ4dG0JzSw9ECzgJrXMc4
         Exx8yC9SxuY0t7CltKnKdk21bqDCB3aEDgyAMrcNDkp+wpHRYyGcIdXJOJwTf6lMGByZ
         lEe0P2uYdE5j5IoIgD2Brk8GYqwl/FpNmwj3Gz3km9Pykq8qE7fwQH2aKQUzsqyjk65F
         bbsEKwcORiSC+zIJBvPGAK457Bw3VzPphvvYN2Tx05rYgmQGCXP65X3fP5CrbRMl7kXa
         3vEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/QGSH7quy4hKZzDPD18vqu5OjYk4VCMcqqm6mB5SYUrH8V/sE8svEvu8qDWV+97JZb1AcUnXXhKVh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3usiq2lGmGWBDgiXHBEc41idx9gggYNzIrkCksUhtAS70Q5NM
	2+K+/IJDYlJ7Rda0G6YGEiL6wJ9th03NGwMNwpqdIQ8da1cAQD1H6VLw3padsgakU1irElzJsfv
	NjCt3LEgQU2Hun3O6T99QC8TNKhy3Q70Kces+5UCCMA==
X-Gm-Gg: Acq92OFeu25tIbbw1Mxs8FHuN7ziZeX6kc56LSzZbCdj+hhDAUz7tsygBXuCy+IrhyL
	7v4DuTX4gpOc+WCBJZ0e3uuyY5SklTx5lNZv9kLQPLsYTTVI4qIICEKmU3uSuZtK4smJPm3YPje
	D1e5fUOO1H/lUUP5l+t+7BDFvHoqcpVGc46IernJ46rpF8yhZ4GcotdunQjACIgIvSYb0za73cw
	0URcH0gZ6V4rldqUIpFwDeAiBmWvTp0jK19hS75wCUuq9oX8uiFltTnQSV68TKltkRJYlxfMKxe
	xUFqPGsFjh0AXybm
X-Received: by 2002:a05:600c:628e:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-490c2599ff8mr101101885e9.4.1780701193538; Fri, 05 Jun 2026
 16:13:13 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
References: <20260605223118.75092-1-cel@kernel.org>
In-Reply-To: <20260605223118.75092-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIiV4E/dqzlDyccSLfgm6X2NNlNbLWl0DlA
Date: Fri, 5 Jun 2026 17:13:12 -0600
X-Gm-Features: AVVi8CcgDTMvhJMy5dzuXLKJ8d6pBsj9mQVdQ0taq0X4REIWYUp5n2UXMlf1Tko
Message-ID: <01eb014a108d59a6312cd23379abb49b@mail.gmail.com>
Subject: RE: [PATCH] svcrdma: Avoid direct reclaim when allocating Read sink buffers
To: Chuck Lever <cel@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jonathan.flynn@hammerspace.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21884-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.flynn@hammerspace.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:email,hammerspace.com:dkim,hammerspace.com:from_mime,hammerspace.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D41D64BC13

> -----Original Message-----
> From: Chuck Lever <cel@kernel.org>
> Sent: Friday, June 5, 2026 4:31 PM
> To: Mike Snitzer <snitzer@kernel.org>
> Cc: linux-nfs@vger.kernel.org; linux-rdma@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>; Jonathan Flynn
> <jonathan.flynn@hammerspace.com>
> Subject: [PATCH] svcrdma: Avoid direct reclaim when allocating Read sink
> buffers
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> svc_rdma_alloc_read_pages() passes __GFP_NORETRY, which limits the
> allocator to a single round of direct reclaim and asynchronous
compaction per
> attempt. Under memory pressure or fragmentation that round can take a
long
> time, and the fallback loop repeats it at each order, multiplying the
stall while
> the RPC waits for its Read sink buffer.
>
> The contiguous allocation is opportunistic: when it fails, Read sink
buffers
> come from the pages already in rq_pages[]. Direct reclaim effort buys
little
> here. Allocate with GFP_NOWAIT instead, which omits
> __GFP_DIRECT_RECLAIM so the allocator takes pages only from the free
lists
> and returns NULL immediately when none are available. GFP_NOWAIT retains
> __GFP_KSWAPD_RECLAIM, so a failed attempt still wakes kswapd to
replenish
> higher-order pages in the background, and it already includes
> __GFP_NOWARN. __GFP_NORETRY has no effect once direct reclaim is off.
> skb_page_frag_refill() takes the same approach for its opportunistic
high-
> order allocation.
>
> Reported-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
> Fixes: 18755b8c2f24 ("svcrdma: Use contiguous pages for RDMA Read sink
> buffers")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
>
> Given the perf symbol resolution inaccuracies I can't swear this will
fix the
> issue, but here's a stab at it.
>
>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> index 587e4cd29303..efde26cac961 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -746,10 +746,9 @@ int svc_rdma_prepare_reply_chunk(struct
> svcxprt_rdma *rdma,  }
>
>  /*
> - * Cap contiguous RDMA Read sink allocations at order-4.
> - * Higher orders risk allocation failure under
> - * __GFP_NORETRY, which would negate the benefit of the
> - * contiguous fast path.
> + * Cap contiguous RDMA Read sink allocations at order-4. Higher orders
> + risk
> + * allocation failure under GFP_NOWAIT, which would negate the benefit
> + of
> + * the contiguous fast path.
>   */
>  #define SVC_RDMA_CONTIG_MAX_ORDER	4
>
> @@ -758,9 +757,11 @@ int svc_rdma_prepare_reply_chunk(struct
> svcxprt_rdma *rdma,
>   * @nr_pages: number of pages needed
>   * @order: on success, set to the allocation order
>   *
> - * Attempts a higher-order allocation, falling back to smaller orders.
> - * The returned pages are split immediately so each sub-page has its
> - * own refcount and can be freed independently.
> + * Attempts a higher-order allocation, falling back to smaller orders.
> + The
> + * allocation is opportunistic: it takes pages only from the free
> + lists,
> + * without direct reclaim, so it fails fast under memory pressure. The
> + * returned pages are split immediately so each sub-page has its own
> + * refcount and can be freed independently.
>   *
>   * Returns a pointer to the first page on success, or NULL if even
>   * order-1 allocation fails.
> @@ -775,8 +776,7 @@ svc_rdma_alloc_read_pages(unsigned int nr_pages,
> unsigned int *order)
>  		SVC_RDMA_CONTIG_MAX_ORDER);
>
>  	while (o >= 1) {
> -		page = alloc_pages(GFP_KERNEL | __GFP_NORETRY |
> __GFP_NOWARN,
> -				   o);
> +		page = alloc_pages(GFP_NOWAIT, o);
>  		if (page) {
>  			split_page(page, o);
>  			*order = o;
> --
> 2.54.0
Unfortunately, the GFP_NOWAIT change did not materially affect either
throughput or the perf profile. The allocator-heavy stack rooted at
svc_rdma_build_read_segment_contig() remains dominant, with
alloc_pages_noprof() and rmqueue_buddy() continuing to account for a
significant portion of the samples, similar to the original regressed
build.

I have added a gfp-nowait directory to the OneDrive link referenced in my
previous email. It contains the fio results, perf reports, and a
flamegraph for the GFP_NOWAIT test.

I have also added a flamegraph to:

rpcrdma-regression/regressed/phase2/server

for the original regressed configuration.

-Jon

