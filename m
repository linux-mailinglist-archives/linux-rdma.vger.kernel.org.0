Return-Path: <linux-rdma+bounces-12534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE3B1532D
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E649D3BA02A
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00224EABC;
	Tue, 29 Jul 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j57oc76U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C32459F6
	for <linux-rdma@vger.kernel.org>; Tue, 29 Jul 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815205; cv=none; b=cK6cgbrPxrW4c9Z9kxEw2vxxBKXCuiS1246edz5MhoSKLOH91OhAs8q7BIMYucTcvuWDclOPB5krDHbu7MGHoDRalVLvUOJm1nnDY3E7uBXEmdvCme/2ERGuREwNJ7D+mwAgZcdu+pNqbtKzUazHBsOl2HE34QmRudAkGoPfoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815205; c=relaxed/simple;
	bh=vHiAZEJQ636SOevFTzB+2khGGZwRDs3zeAMpvxkeliQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+q1wAU1PEBmREdqxB72n1H463dYA+IQ2pPB3aW0YyMFkCV8/H2/846fRE4Uuf+El2ZG8W/0y1EpLU1P4sbRw2ZpF9pYLw70wgQHSo1m1hc2hI9CBIccqMnLPrRhPXGe0CJBkGCS06j1WuQlo+Yi06U3TxySx0zmMPdPZxN/8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j57oc76U; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8fad6c00-9c15-4315-a8c5-b8eac4281757@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753815189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8uizJieSyqW56uosfxUJeKEVQ0kVEbrA+dUYFoOGRs=;
	b=j57oc76UIhZL5Xpcfh4U0tWr8C6enCpVQGbo2hG9G/0MM06fuiCJ8Y9RkLcRYz1x4orT97
	JobdnhYCZ2iemZAIgxqDkCvYrqbLu0Qm1apgcZEDuQd2TzZ6hTyq50I2Vd3GHzTBw1Z8r+
	6U+OU1uUSU0PwvKHE1NHrhjo/vcQR1Y=
Date: Tue, 29 Jul 2025 20:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/siw: Fix the sendmsg byte count in
 siw_tcp_sendpages
To: Pedro Falcato <pfalcato@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Jakub Kicinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>,
 Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20250729120348.495568-1-pfalcato@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20250729120348.495568-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29.07.2025 14:03, Pedro Falcato wrote:
> Ever since commit c2ff29e99a76 ("siw: Inline do_tcp_sendpages()"),
> we have been doing this:
>
> static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
>                               size_t size)
> [...]
>          /* Calculate the number of bytes we need to push, for this page
>           * specifically */
>          size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
>          /* If we can't splice it, then copy it in, as normal */
>          if (!sendpage_ok(page[i]))
>                  msg.msg_flags &= ~MSG_SPLICE_PAGES;
>          /* Set the bvec pointing to the page, with len $bytes */
>          bvec_set_page(&bvec, page[i], bytes, offset);
>          /* Set the iter to $size, aka the size of the whole sendpages (!!!) */
>          iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> try_page_again:
>          lock_sock(sk);
>          /* Sendmsg with $size size (!!!) */
>          rv = tcp_sendmsg_locked(sk, &msg, size);
>
> This means we've been sending oversized iov_iters and tcp_sendmsg calls
> for a while. This has a been a benign bug because sendpage_ok() always
> returned true. With the recent slab allocator changes being slowly
> introduced into next (that disallow sendpage on large kmalloc
> allocations), we have recently hit out-of-bounds crashes, due to slight
> differences in iov_iter behavior between the MSG_SPLICE_PAGES and
> "regular" copy paths:
>
> (MSG_SPLICE_PAGES)
> skb_splice_from_iter
>    iov_iter_extract_pages
>      iov_iter_extract_bvec_pages
>        uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
>    skb_splice_from_iter gets a "short" read
>
> (!MSG_SPLICE_PAGES)
> skb_copy_to_page_nocache copy=iov_iter_count
>   [...]
>     copy_from_iter
>          /* this doesn't help */
>          if (unlikely(iter->count < len))
>                  len = iter->count;
>            iterate_bvec
>              ... and we run off the bvecs
>
> Fix this by properly setting the iov_iter's byte count, plus sending the
> correct byte count to tcp_sendmsg_locked.
>
> Cc: stable@vger.kernel.org
> Fixes: c2ff29e99a76 ("siw: Inline do_tcp_sendpages()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507220801.50a7210-lkp@intel.com
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>
> v2:
>   - Add David Howells's Rb on the original patch
>   - Remove the offset increment, since it's dead code
>
>   drivers/infiniband/sw/siw/siw_qp_tx.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
> index 3a08f57d2211..f7dd32c6e5ba 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -340,18 +340,17 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
>   		if (!sendpage_ok(page[i]))
>   			msg.msg_flags &= ~MSG_SPLICE_PAGES;
>   		bvec_set_page(&bvec, page[i], bytes, offset);
> -		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
>   
>   try_page_again:
>   		lock_sock(sk);
> -		rv = tcp_sendmsg_locked(sk, &msg, size);
> +		rv = tcp_sendmsg_locked(sk, &msg, bytes)
>   		release_sock(sk);
>   
>   		if (rv > 0) {
>   			size -= rv;
>   			sent += rv;
>   			if (rv != bytes) {
> -				offset += rv;
>   				bytes -= rv;
>   				goto try_page_again;
>   			}

Acked-by: Bernard Metzler <bernard.metzler@linux.dev>


