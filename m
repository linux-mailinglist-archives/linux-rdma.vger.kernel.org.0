Return-Path: <linux-rdma+bounces-12541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A9B15B7C
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C517B0B43
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A456270EDD;
	Wed, 30 Jul 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZLmdn6Ke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYn+v/AS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZLmdn6Ke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYn+v/AS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6426CE18
	for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867583; cv=none; b=Tw9cO3oUkNT9UUALxxa6ucW6p04dI3S49QthC2ambenaMr9hzBEmJ9z9mk1ud94EL2DRRuQtD1OMnpHTkr4QHqf/HUffeI9zLCJvOGnt/BDNT/VBMyHkeJ+PWU2I/spH/yG4NtTEOP6i3fCrvPt3GC/hsq6mI06L6BZ546/oMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867583; c=relaxed/simple;
	bh=iFo5w61ygk5/00ivNfP6LrdjhO0dAK1GgoLyoRyT60I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPcmw5n0HWuEoGI4criEN/k7YUh8hMAPIk7CVjIY0RRE8VB9jG6oA0JL+YHohilQeeLFiYnSt2ILIALvJ+am4tWRHfOHrKmBQ7OnZVtaqZCL/wp2ihc7dsLXG79SxHGRQk7usuGEvOcEifNq4XhqVjfE7vb5JFAXCaB3HWWZ31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZLmdn6Ke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYn+v/AS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZLmdn6Ke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYn+v/AS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F31741F45A;
	Wed, 30 Jul 2025 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753867579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwwSk2G3t3g+z+exLv/8KSZMKkvH9vcoZU1kIker1MQ=;
	b=ZLmdn6KegNLRzn+dBx89gzlvx3N85If5zqoX3jHJv/5IxACROsLEdUumVIkRVA+qfzpztX
	llTr1qluDQxRaUlsR6kyh1U/XzPdd1H7TiWrXD77yNnjpu92kgcjRv3+jV5tfv9asZF5Qz
	YQDFeqGDy0vnCXKJkSiLRysSmse6Q0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753867579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwwSk2G3t3g+z+exLv/8KSZMKkvH9vcoZU1kIker1MQ=;
	b=hYn+v/ASBkF5r+OUfvChwnoKZ4xNlRwApU8Dh9pNJIJcPp1ffL7v7NxnFmSGQTbMMcma1v
	OSpQhY2+thaekjAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753867579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwwSk2G3t3g+z+exLv/8KSZMKkvH9vcoZU1kIker1MQ=;
	b=ZLmdn6KegNLRzn+dBx89gzlvx3N85If5zqoX3jHJv/5IxACROsLEdUumVIkRVA+qfzpztX
	llTr1qluDQxRaUlsR6kyh1U/XzPdd1H7TiWrXD77yNnjpu92kgcjRv3+jV5tfv9asZF5Qz
	YQDFeqGDy0vnCXKJkSiLRysSmse6Q0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753867579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwwSk2G3t3g+z+exLv/8KSZMKkvH9vcoZU1kIker1MQ=;
	b=hYn+v/ASBkF5r+OUfvChwnoKZ4xNlRwApU8Dh9pNJIJcPp1ffL7v7NxnFmSGQTbMMcma1v
	OSpQhY2+thaekjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D61E13942;
	Wed, 30 Jul 2025 09:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id De7RAzrliWjwaAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 30 Jul 2025 09:26:18 +0000
Date: Wed, 30 Jul 2025 10:26:16 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Bernard Metzler <bernard.metzler@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, 
	stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] RDMA/siw: Fix the sendmsg byte count in
 siw_tcp_sendpages
Message-ID: <x43xlqzuher54k3j4iwkos36jz5qkhtgxw4zh52j5cz6l2spzw@yips5h4liqbi>
References: <20250729120348.495568-1-pfalcato@suse.de>
 <8fad6c00-9c15-4315-a8c5-b8eac4281757@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fad6c00-9c15-4315-a8c5-b8eac4281757@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue, Jul 29, 2025 at 08:53:02PM +0200, Bernard Metzler wrote:
> On 29.07.2025 14:03, Pedro Falcato wrote:
> > Ever since commit c2ff29e99a76 ("siw: Inline do_tcp_sendpages()"),
> > we have been doing this:
> > 
> > static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
> >                               size_t size)
> > [...]
> >          /* Calculate the number of bytes we need to push, for this page
> >           * specifically */
> >          size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
> >          /* If we can't splice it, then copy it in, as normal */
> >          if (!sendpage_ok(page[i]))
> >                  msg.msg_flags &= ~MSG_SPLICE_PAGES;
> >          /* Set the bvec pointing to the page, with len $bytes */
> >          bvec_set_page(&bvec, page[i], bytes, offset);
> >          /* Set the iter to $size, aka the size of the whole sendpages (!!!) */
> >          iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> > try_page_again:
> >          lock_sock(sk);
> >          /* Sendmsg with $size size (!!!) */
> >          rv = tcp_sendmsg_locked(sk, &msg, size);
> > 
> > This means we've been sending oversized iov_iters and tcp_sendmsg calls
> > for a while. This has a been a benign bug because sendpage_ok() always
> > returned true. With the recent slab allocator changes being slowly
> > introduced into next (that disallow sendpage on large kmalloc
> > allocations), we have recently hit out-of-bounds crashes, due to slight
> > differences in iov_iter behavior between the MSG_SPLICE_PAGES and
> > "regular" copy paths:
> > 
> > (MSG_SPLICE_PAGES)
> > skb_splice_from_iter
> >    iov_iter_extract_pages
> >      iov_iter_extract_bvec_pages
> >        uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
> >    skb_splice_from_iter gets a "short" read
> > 
> > (!MSG_SPLICE_PAGES)
> > skb_copy_to_page_nocache copy=iov_iter_count
> >   [...]
> >     copy_from_iter
> >          /* this doesn't help */
> >          if (unlikely(iter->count < len))
> >                  len = iter->count;
> >            iterate_bvec
> >              ... and we run off the bvecs
> > 
> > Fix this by properly setting the iov_iter's byte count, plus sending the
> > correct byte count to tcp_sendmsg_locked.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: c2ff29e99a76 ("siw: Inline do_tcp_sendpages()")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202507220801.50a7210-lkp@intel.com
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> > 
> > v2:
> >   - Add David Howells's Rb on the original patch
> >   - Remove the offset increment, since it's dead code
> > 
> >   drivers/infiniband/sw/siw/siw_qp_tx.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > index 3a08f57d2211..f7dd32c6e5ba 100644
> > --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> > +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > @@ -340,18 +340,17 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
> >   		if (!sendpage_ok(page[i]))
> >   			msg.msg_flags &= ~MSG_SPLICE_PAGES;
> >   		bvec_set_page(&bvec, page[i], bytes, offset);
> > -		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> > +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
> >   try_page_again:
> >   		lock_sock(sk);
> > -		rv = tcp_sendmsg_locked(sk, &msg, size);
> > +		rv = tcp_sendmsg_locked(sk, &msg, bytes)
> >   		release_sock(sk);
> >   		if (rv > 0) {
> >   			size -= rv;
> >   			sent += rv;
> >   			if (rv != bytes) {
> > -				offset += rv;
> >   				bytes -= rv;
> >   				goto try_page_again;
> >   			}
> 
> Acked-by: Bernard Metzler <bernard.metzler@linux.dev>


Thanks!

Do you want to take the fix through your tree? Otherwise I suspect Vlastimil
could simply take it (and possibly resubmit the SLAB PR, which hasn't been
merged yet).

-- 
Pedro

