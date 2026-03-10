Return-Path: <linux-rdma+bounces-17872-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMAYErMosGn1ggIAu9opvQ
	(envelope-from <linux-rdma+bounces-17872-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:20:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D76251C51
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB7853384E29
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039CC26FA6F;
	Tue, 10 Mar 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GKoMqxdY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1A40DFD6
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150136; cv=none; b=ows4lX0193TmFK598LdO9eoqpn1jxsEpUE/2Os1uLP3u7Cx4Sb6tFQ2jzkbvGXVYxho9SAm2BZRC1BbOnfgDz3hO7/8CPiBkLfBTMwFl2Ozs3X7qZgIHNBU9K3OPTMmacMgSKEdFQKXfgMQtbLT/orRM2xCHpBeuneSHeVhK4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150136; c=relaxed/simple;
	bh=qulK1RzZmBbuDTqnOmkzDPqZcbx1aZhShZN0mn82XoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRRZE0zrHvB/dPsClyzntRPwqaR36zBoN9u8BZFIQpznGNN9UhbcPspJmJSMhvDEfxbq2LfqLPS5sGMtVqqBEUnfHE/WI1uLpquUNEWXt3SCsojCTCixlNahUhNDvHXppHLmNj6pLqCSRj3e5ThchA/saiGWJWHZ/6/HjXqdXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GKoMqxdY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WmdoR152p+CYHDGon3b+3jjz67CCIIXXgwhgRGWcBcY=; b=GKoMqxdY7cnVZChf/L9sMRRwOl
	zdK6KLSYIkn4HZ8dCGwEYycU9K1INH3BrQ4woZ4kLa8R6QITNnt4PjBtmlOIeEeCj6S/wonP4krq0
	6/Jfpbt3/TVUEg+5SGIAugeAqfYnoGgNEfZS7Iw8UBLjIH3Z9ltt2QEQV3/mJe7azK7hY3GBqeEl9
	pY7kMJwURHG5aUjHJC4NLJsjEgcCtZbRli2HnRd9vy4JBH4infNZunwjrLZZBf7xUOWUUnRsNjXFv
	8BKfqD8leifh0knzghIFGoWeANMSAtRPtSXDeiMBw44ubyjrcscG/fKlCf+eUPdBmC9DFai954FWH
	e8YHOihw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxLi-00000009cc3-23Pp;
	Tue, 10 Mar 2026 13:42:14 +0000
Date: Tue, 10 Mar 2026 06:42:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
Message-ID: <abAftjplHdwdwrkd@infradead.org>
References: <20260310034621.5799-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310034621.5799-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: E4D76251C51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17872-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:46:21PM -0400, Chuck Lever wrote:
> Under NFS WRITE workloads the server performs RDMA READs to
> pull data from the client. With the inflated MR demand, the
> pool is rapidly exhausted, ib_mr_pool_get() returns NULL, and
> rdma_rw_init_one_mr() returns -EAGAIN. svcrdma treats this as
> a DMA mapping failure, closes the connection, and the client
> reconnects -- producing a cycle of 71% RPC retransmissions and
> ~100 reconnections per test run. RDMA WRITEs (NFS READ
> direction) are unaffected because DMA_TO_DEVICE never triggers
> the max_sgl_rd check.

So this changelog extensively describes the problem, but it doesn't
actually say how you fix it.

>  	/*
> +	 * IOVA not available; map each bvec individually. Do not
> +	 * check max_sgl_rd here: nr_bvec is a raw page count that
> +	 * overstates DMA entry demand and exhausts the MR pool.

It fails to explain why that is fine?

> +	 *
> +	 * TODO: A bulk DMA mapping API for bvecs analogous to
> +	 * dma_map_sgtable() would provide a proper post-DMA-
> +	 * coalescing segment count here, enabling the map_wrs
> +	 * path in more cases.

This isn't really something the DMA layer can easily do without getting
as inefficient as the sgtable based path.  What the block layer does
here is to simply keep a higher level count of merged segments.  The
other option would be to not create multiple bvecs for continguous
regions, which is what modern file system do in general, and why the
above block layer nr_phys_segments based optimization isn't actually
used all that much these days.

Why can't NFS send a single bvec for contiguous ranges?

> -	if (rdma_rw_io_needs_mr(dev, port_num, dir, nr_bvec))
> -		return rdma_rw_init_mr_wrs_bvec(ctx, qp, port_num, bvecs,
> -						nr_bvec, &iter, remote_addr,
> -						rkey, dir);
> -
>  	return rdma_rw_init_map_wrs_bvec(ctx, qp, bvecs, nr_bvec, &iter,
>  			remote_addr, rkey, dir);

First I thought this breaks iWarp reads, but they are handled earlier,
which might have been usefu in the commit log.

