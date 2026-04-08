Return-Path: <linux-rdma+bounces-19126-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFfQOPzq1Wkd/QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19126-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 07:43:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4B3B7552
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 07:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E043019068
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 05:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F226835AC3B;
	Wed,  8 Apr 2026 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lcnz2lKi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10911D88D7;
	Wed,  8 Apr 2026 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626977; cv=none; b=kNALbZ/I/KQJEoTjyL1wPRUgQJX5pk04fgfoGtdadHVLI6YUK92LRvcaza/cXSEtyvLXLwdfF/nEmm1tV/VsZr3QuyKS8PhCMykoke5zjWl4zQCTFaxgSAt27R69reh+NzSEeT7y0VkKpbzYSQQPwz+smSgjZ+Z83XqLrY4on5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626977; c=relaxed/simple;
	bh=V5fZV5BfHSr+Ac5FRNYMhTfgY4qnFWzkV7vgykf9dYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQC81IEWs3DBX8Mh10hRROom+fYRI1REHVlSSoRZITo3uf2rpyPSOYxha9KMiOG4orf2kskw2S26grfKpRZcL1dUh0rgeDJEeNzR/X58Pbd4MTc21pYxOA5PEazqTDeOMhHt63TpNDbvCm4kJiJV/bcgVwNMSi19YsRD8VB1TMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lcnz2lKi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kf5GZujZLwj7kmPoteEI3NuMDANbKVGMElkUOE0WUNM=; b=Lcnz2lKik+BZ4qqDoc8cZaC0Ie
	+luXDaMV745g4zRp3e8YWhR4ktWoP5x1uba5qFwYlXdZ6eV4n/acHz005qYC/9bnx7x325lOGK0J8
	TTPEV2WK+IOh8pbfrlTHLLrZjF+PSrx/ormZbY2R6Bg4AM3GgzwUeP6HkiwDXoxWStpoCPMuKftN7
	/C9Z94tleMvgdDeAm06jod7KVjinqSjJJuD4I+MlfHYEF4yPxnVVhlT7IyVOTwQn4VpU/uCKHyPJT
	VjA1MBxV4sG65DP8xdrfKRQVtKW7JBpb4JVAjzJedkgVI9m6itEiHeRAuejSjETRhqQRIryxpdy9l
	a6gZPeJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wALgl-00000008INa-0hdL;
	Wed, 08 Apr 2026 05:42:55 +0000
Date: Tue, 7 Apr 2026 22:42:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Joel Colledge <joel.colledge@linbit.com>,
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 06/20] drbd: add RDMA transport implementation
Message-ID: <adXq36pbGLXMZc2r@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19126-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69E4B3B7552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

You really need to add the RDMA mailing list before adding new RDMA
code.  I'll try to review the bits I still remember, but you also
need a maintainer ACK.

> +#ifndef SENDER_COMPACTS_BVECS
> +/* My benchmarking shows a limit of 30 MB/s
> + * with the current implementation of this idea.
> + * cpu bound, perf top shows mainly get_page/put_page.
> + * Without this, using the plain send_page,
> + * I achieve > 400 MB/s on the same system.
> + * => disable for now, improve later.
> + */
> +#define SENDER_COMPACTS_BVECS 0
> +#endif

Nothing explains what "this idea" is.  And we do not add dead code as
a rule of thumb anyway.

> +/* Nearly all data transfer uses the send/receive semantics. No need to

Please use the normal kernel command style:

/*
 * Blah, blah, blah.
 */

> +int allocation_size;
> +/* module_param(allocation_size, int, 0664);
> +   MODULE_PARM_DESC(allocation_size, "Allocation size for receive buffers (page size of peer)");
> +
> +   That needs to be implemented in dtr_create_rx_desc() and in dtr_recv() and dtr_recv_pages() */
> +
> +/* If no recvbuf_size or sendbuf_size is configured use 1M plus two pages for the DATA_STREAM */
> +/* Actually it is not a buffer, but the number of tx_descs or rx_descs we allow,
> +   very comparable to the socket sendbuf and recvbuf sizes */

Please don't add random unused code.

Also while the kernel coding style has an exception for overly long
lines for selected lines where the improve readability, that by
definition can't apply to block comments.

> +/* Assuming that a singe 4k write should be at the highest scatterd over 8
> +   pages. I.e. has no parts smaller than 512 bytes.
> +   Arbitrary assumption. It seems that Mellanox hardware can do up to 29
> +   ppc64 page size might be 64k */
> +#if (PAGE_SIZE / 512) > 28
> +# define DTR_MAX_TX_SGES 28
> +#else
> +# define DTR_MAX_TX_SGES (PAGE_SIZE / 512)
> +#endif

All this looks complete bollocks.  We had multi-page bvecs for years,
aso the page size should not apply for the I/O path.

> +union dtr_immediate {
> +	struct {
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +		unsigned int sequence:SEQUENCE_BITS;
> +		unsigned int stream:2;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +		unsigned int stream:2;
> +		unsigned int sequence:SEQUENCE_BITS;
> +#else
> +# error "this endianness is not supported"
> +#endif
> +	};
> +	unsigned int i;
> +};

Bitfields for on-the-write structures are an anti-pattern,  Please
use proper masking and shifting like just about everyone else in modern
code.

> +static int dtr_init(struct drbd_transport *transport);
> +static void dtr_free(struct drbd_transport *transport, enum drbd_tr_free_op);
> +static int dtr_prepare_connect(struct drbd_transport *transport);
> +static int dtr_connect(struct drbd_transport *transport);
> +static void dtr_finish_connect(struct drbd_transport *transport);

The code structure here is totally messed up if you need all these
dozens of forward declarations.  Please reshuffled it that you only
need those actually required,

> +static struct drbd_transport_class rdma_transport_class = {
> +	.name = "rdma",
> +	.instance_size = sizeof(struct dtr_transport),
> +	.path_instance_size = sizeof(struct dtr_path),
> +	.listener_instance_size = sizeof(struct dtr_listener),
> +	.ops = (struct drbd_transport_ops) {

nested struct initializers don't need casts.

> +static bool atomic_inc_if_below(atomic_t *v, int limit)
> +{
> +	int old, cur;
> +
> +	cur = atomic_read(v);
> +	do {
> +		old = cur;
> +		if (old >= limit)
> +			return false;
> +
> +		cur = atomic_cmpxchg(v, old, old + 1);
> +	} while (cur != old);
> +
> +	return true;
> +}

Don't add you own atomics, please talk to the atomics maintainers
instead of adding hacks like this.

> +	err = -ENOMEM;
> +	tx_desc = kzalloc(sizeof(*tx_desc) + sizeof(struct ib_sge), gfp_mask);
> +	if (!tx_desc)
> +		goto out_put;

This is supposed to use the new flex kmalloc family of functions
(as much as I hate them).

> +	send_buffer = kmalloc(size, gfp_mask);
> +	if (!send_buffer) {
> +		kfree(tx_desc);
> +		goto out_put;
> +	}
> +	memcpy(send_buffer, buf, size);

and this is a kmemdup.

> +	if (err) {
> +		kfree(tx_desc);
> +		kfree(send_buffer);
> +		goto out_put;
> +	}

And please use proper gotos to unwind.

> +static int dtr_recv(struct drbd_transport *transport, enum drbd_stream stream, void **buf, size_t size, int flags)
> +{
> +	struct dtr_transport *rdma_transport;
> +	int err;
> +
> +	if (!transport)
> +		return -ECONNRESET;

How can this be NULL?

> +static int dtr_path_prepare(struct dtr_path *path, struct dtr_cm *cm, bool active)
> +{
> +	struct dtr_cm *cm2;
> +	int i, err;
> +
> +	cm2 = cmpxchg(&path->cm, NULL, cm); // RCU xchg

Wht's that comment supposed to mean?  If it is a rcu_replace_pointer,
use that.  If not the comment looks really odd.

> +	err = dtr_cm_alloc_rdma_res(cm);
> +
> +	return err;

You can return the value directly here.

Giving up for now.  I think this needs a sweep for basic sanity an
a review from the RDMA maintainers before we can go into more details.


