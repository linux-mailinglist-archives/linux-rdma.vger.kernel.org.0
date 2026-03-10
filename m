Return-Path: <linux-rdma+bounces-17909-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DdvGDt/sGmwjwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17909-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:29:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B4A257DE1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D6E30672CB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D991D3E92BB;
	Tue, 10 Mar 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvtgtFOo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5F3E8699
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174430; cv=none; b=ZLJalgJlIQuBcoNZ9dHy32F0UjJZylvIntWgRHBeLeZHD/cK2IRhylBCH3PnSWZWk5hdhPA71gLgh2kSy74XIfIkE3gPIotus9MJZ6sddrz9CCkKtb4vd1q3N4lyRQC3YyGkdIIoh6d3wPlwOnLiDOo1E7JqR484S5K0iU4WDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174430; c=relaxed/simple;
	bh=Ef3laQJEctjPIyqixibzdFI93SEUKXu+IhYeXLMTc+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+yghWUfiqZ6AxTYT1XpDEmrdBTDJP7zWSGPNaB1koytLU9/Gcl8vH1nLKcsYvwE5Vb442R7mYbhjXh6Stds9KXWRANEwgF/7ybkUVgsfTlK3DS5KDI5VBa08OLx6LMa8MazZQacB84Q4eIKQCBW7zTyeOYIYrKGad6Lpz1IGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvtgtFOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27B1C19423;
	Tue, 10 Mar 2026 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773174430;
	bh=Ef3laQJEctjPIyqixibzdFI93SEUKXu+IhYeXLMTc+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvtgtFOoX1VaJlIe0ANe2Y+55rrQcrYzYc71syL9XO3xa6K01GxR/u6TLfW6gYEGn
	 jDwbQD3btkLxvuAqP3sl+wz31h67mVT/Zai+x+z3BvAUW9wmDpN5woWY2cAvvT9s76
	 vQtUAGbQBmOmUoTFTCz0W5WsMT14O2YbCwvv2o+5CtR+UziBW4Cz3Bg9+YQkG7YhfQ
	 vD7EA9g6XNZB2u6oC10JodnahXQO1/gjTDTuo6TiDVVWQX4TCZhb0IpMifc/8uhZWh
	 B9ElEx5+Xj2nQhuzCDPKc5S5bH6UXeHVzaj+87ZMOSFDGCI3EpQDmkxxTFgAc30fjC
	 /RcwD7tWyHYdQ==
Date: Tue, 10 Mar 2026 22:27:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] svcrdma: Use compound pages for RDMA Read sink
 buffers
Message-ID: <20260310202706.GQ12611@unreal>
References: <20260310193151.GN12611@unreal>
 <20260310195650.15785-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310195650.15785-1-cel@kernel.org>
X-Rspamd-Queue-Id: B6B4A257DE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17909-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 03:56:50PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> svc_rdma_build_read_segment() constructs RDMA Read sink
> buffers by consuming pages one-at-a-time from rq_pages[]
> and building one bvec per page. A 64KB NFS READ payload
> produces 16 separate bvecs, 16 DMA mappings, and
> potentially multiple RDMA Read WRs.
> 
> A single higher-order allocation followed by split_page()
> yields physically contiguous memory while preserving
> per-page refcounts. A single bvec spanning the contiguous
> range causes rdma_rw_ctx_init_bvec() to take the
> rdma_rw_init_single_wr_bvec() fast path: one DMA mapping,
> one SGE, one WR.

Nice, clever.

> 
> The split sub-pages replace the original rq_pages[] entries,
> so all downstream page tracking, completion handling, and
> xdr_buf assembly remain unchanged.
> 
> Allocation uses __GFP_NORETRY | __GFP_NOWARN and falls back
> through decreasing orders. If even order-1 fails, the
> existing per-page path handles the segment.
> 
> The compound path is attempted only when the segment starts
> page-aligned (rc_pageoff == 0) and spans at least two pages.

In cases where you request three pages (order‑2), one page will be wasted.
This can lead to problems later, especially under stress testing.

Thanks

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 120 ++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> What if svcrdma did something derpy like this?
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> index 9e17700fae2a..42de7151ae68 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -754,6 +754,118 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
>  	return xdr->len;
>  }
>  
> +#define SVC_RDMA_COMPOUND_MAX_ORDER	4	/* 64KB max */
> +
> +/**
> + * svc_rdma_alloc_read_pages - Allocate physically contiguous pages
> + * @nr_pages: number of pages needed
> + * @order: on success, set to the allocation order
> + *
> + * Attempts a higher-order allocation, falling back to smaller orders.
> + * The returned pages are split immediately so each sub-page has its
> + * own refcount and can be freed independently.
> + *
> + * Returns a pointer to the first page on success, or NULL if even
> + * order-1 allocation fails.
> + */
> +static struct page *
> +svc_rdma_alloc_read_pages(unsigned int nr_pages, unsigned int *order)
> +{
> +	unsigned int o;
> +	struct page *page;
> +
> +	o = get_order(nr_pages << PAGE_SHIFT);
> +	if (o > SVC_RDMA_COMPOUND_MAX_ORDER)
> +		o = SVC_RDMA_COMPOUND_MAX_ORDER;
> +
> +	while (o >= 1) {
> +		page = alloc_pages(GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN,
> +				   o);
> +		if (page) {
> +			split_page(page, o);
> +			*order = o;
> +			return page;
> +		}
> +		o--;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * svc_rdma_build_read_segment_compound - Build a single RDMA Read WR using compound pages
> + * @rqstp: RPC transaction context
> + * @head: context for ongoing I/O
> + * @segment: co-ordinates of remote memory to be read
> + *
> + * Allocates a higher-order page and splits it, then builds a single
> + * bvec spanning the contiguous physical range. The split sub-pages
> + * replace entries in rq_pages[] so downstream cleanup is unchanged.
> + *
> + * Returns:
> + *   %0: the Read WR was constructed successfully
> + *   %-EINVAL: not enough rq_pages slots
> + *   %-ENOMEM: compound allocation or rw_ctxt allocation failed
> + *   %-EIO: a DMA mapping error occurred
> + */
> +static int svc_rdma_build_read_segment_compound(struct svc_rqst *rqstp,
> +						struct svc_rdma_recv_ctxt *head,
> +						const struct svc_rdma_segment *segment)
> +{
> +	struct svcxprt_rdma *rdma = svc_rdma_rqst_rdma(rqstp);
> +	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
> +	unsigned int order, alloc_nr, nr_data_pages, i;
> +	struct svc_rdma_rw_ctxt *ctxt;
> +	struct page *page;
> +	int ret;
> +
> +	nr_data_pages = PAGE_ALIGN(segment->rs_length) >> PAGE_SHIFT;
> +
> +	page = svc_rdma_alloc_read_pages(nr_data_pages, &order);
> +	if (!page)
> +		return -ENOMEM;
> +	alloc_nr = 1 << order;
> +
> +	if (alloc_nr < nr_data_pages ||
> +	    head->rc_curpage + alloc_nr > rqstp->rq_maxpages) {
> +		for (i = 0; i < alloc_nr; i++)
> +			__free_page(page + i);
> +		return -ENOMEM;
> +	}
> +
> +	ctxt = svc_rdma_get_rw_ctxt(rdma, 1);
> +	if (!ctxt) {
> +		for (i = 0; i < alloc_nr; i++)
> +			__free_page(page + i);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < alloc_nr; i++) {
> +		put_page(rqstp->rq_pages[head->rc_curpage + i]);
> +		rqstp->rq_pages[head->rc_curpage + i] = page + i;
> +	}
> +
> +	bvec_set_page(&ctxt->rw_bvec[0], page, segment->rs_length, 0);
> +	ctxt->rw_nents = 1;
> +
> +	head->rc_page_count += nr_data_pages;
> +	head->rc_pageoff = offset_in_page(segment->rs_length);
> +	if (head->rc_pageoff)
> +		head->rc_curpage += nr_data_pages - 1;
> +	else
> +		head->rc_curpage += nr_data_pages;
> +
> +	ret = svc_rdma_rw_ctx_init(rdma, ctxt, segment->rs_offset,
> +				   segment->rs_handle, segment->rs_length,
> +				   DMA_FROM_DEVICE);
> +	if (ret < 0)
> +		return -EIO;
> +	percpu_counter_inc(&svcrdma_stat_read);
> +
> +	list_add(&ctxt->rw_list, &cc->cc_rwctxts);
> +	cc->cc_sqecount += ret;
> +	return 0;
> +}
> +
>  /**
>   * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
>   * @rqstp: RPC transaction context
> @@ -780,6 +892,14 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
>  	if (check_add_overflow(head->rc_pageoff, len, &total))
>  		return -EINVAL;
>  	nr_bvec = PAGE_ALIGN(total) >> PAGE_SHIFT;
> +
> +	if (head->rc_pageoff == 0 && nr_bvec >= 2) {
> +		ret = svc_rdma_build_read_segment_compound(rqstp, head,
> +							   segment);
> +		if (ret != -ENOMEM)
> +			return ret;
> +	}
> +
>  	ctxt = svc_rdma_get_rw_ctxt(rdma, nr_bvec);
>  	if (!ctxt)
>  		return -ENOMEM;
> -- 
> 2.53.0
> 

