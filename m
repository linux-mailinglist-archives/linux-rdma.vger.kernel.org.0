Return-Path: <linux-rdma+bounces-12562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779DAB1770E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 22:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4783E627610
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA531D7E37;
	Thu, 31 Jul 2025 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r+B7kxPr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD4481A3
	for <linux-rdma@vger.kernel.org>; Thu, 31 Jul 2025 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993220; cv=none; b=eY5rtlXdR1NhndxZEAms6jtzDZRsztr8RfYca4K2wEIgbTB48W/A15zi7JQV3bLCoD516P96lAGX8yXq7MJcgFwE7Q+uN0stwWiWYxQ7/aAZFdiIguTPGyN37z5clc4gOubEbC/JpD33o63l1gdt1hbOg9EJDE9WaJX38DjtKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993220; c=relaxed/simple;
	bh=RxsNgT0Xg2p+BUHxc0CyVSLbaFaCgA1fOCFEyJb4GDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0KvCPK75sHSHZnxyoKs1mPmPh0sSqZnOxiRczPsoGQZaGaPKs93PWuUErf6dPoamithkVlMCqevJdx43vrIRPfnICGa/sHFFQhgBkvNy6M0pm/jAfZDuuKjkHII0jZqdedicZ7otxpooksRJes2EuVAlFz6Y7TmzdNBXD/znWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r+B7kxPr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <631a1251-5bbc-484d-9bd9-167c5e7cb69f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753993206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/N/Zzs9sQW4KIe9YYyHArbjN2w5AkIlMqy06wqviZAk=;
	b=r+B7kxPr2Nbf13zeA7/xZqmltlK03ecVgTUdnlAAYQkAgEhI7ndwcqXZkJ4LLOO4TbARLW
	wwJ7qUidPXIw+FS7mZPExq6awE96cWZzYHI4mrh21TIpC5fG17ogMRKji7T4rPsIGSs4fR
	rQituKvDAcJNTmf+y9hpdAL0R0CBXQ0=
Date: Thu, 31 Jul 2025 22:19:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/siw: Fix the sendmsg byte count in
 siw_tcp_sendpages
To: Pedro Falcato <pfalcato@suse.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, torvalds@linux-foundation.org, stable@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20250729120348.495568-1-pfalcato@suse.de>
 <8fad6c00-9c15-4315-a8c5-b8eac4281757@linux.dev>
 <x43xlqzuher54k3j4iwkos36jz5qkhtgxw4zh52j5cz6l2spzw@yips5h4liqbi>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <x43xlqzuher54k3j4iwkos36jz5qkhtgxw4zh52j5cz6l2spzw@yips5h4liqbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30.07.2025 11:26, Pedro Falcato wrote:
> On Tue, Jul 29, 2025 at 08:53:02PM +0200, Bernard Metzler wrote:
>> On 29.07.2025 14:03, Pedro Falcato wrote:
>>> Ever since commit c2ff29e99a76 ("siw: Inline do_tcp_sendpages()"),
>>> we have been doing this:
>>>
>>> static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
>>>                                size_t size)
>>> [...]
>>>           /* Calculate the number of bytes we need to push, for this page
>>>            * specifically */
>>>           size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
>>>           /* If we can't splice it, then copy it in, as normal */
>>>           if (!sendpage_ok(page[i]))
>>>                   msg.msg_flags &= ~MSG_SPLICE_PAGES;
>>>           /* Set the bvec pointing to the page, with len $bytes */
>>>           bvec_set_page(&bvec, page[i], bytes, offset);
>>>           /* Set the iter to $size, aka the size of the whole sendpages (!!!) */
>>>           iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
>>> try_page_again:
>>>           lock_sock(sk);
>>>           /* Sendmsg with $size size (!!!) */
>>>           rv = tcp_sendmsg_locked(sk, &msg, size);
>>>
>>> This means we've been sending oversized iov_iters and tcp_sendmsg calls
>>> for a while. This has a been a benign bug because sendpage_ok() always
>>> returned true. With the recent slab allocator changes being slowly
>>> introduced into next (that disallow sendpage on large kmalloc
>>> allocations), we have recently hit out-of-bounds crashes, due to slight
>>> differences in iov_iter behavior between the MSG_SPLICE_PAGES and
>>> "regular" copy paths:
>>>
>>> (MSG_SPLICE_PAGES)
>>> skb_splice_from_iter
>>>     iov_iter_extract_pages
>>>       iov_iter_extract_bvec_pages
>>>         uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
>>>     skb_splice_from_iter gets a "short" read
>>>
>>> (!MSG_SPLICE_PAGES)
>>> skb_copy_to_page_nocache copy=iov_iter_count
>>>    [...]
>>>      copy_from_iter
>>>           /* this doesn't help */
>>>           if (unlikely(iter->count < len))
>>>                   len = iter->count;
>>>             iterate_bvec
>>>               ... and we run off the bvecs
>>>
>>> Fix this by properly setting the iov_iter's byte count, plus sending the
>>> correct byte count to tcp_sendmsg_locked.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: c2ff29e99a76 ("siw: Inline do_tcp_sendpages()")
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Closes: https://lore.kernel.org/oe-lkp/202507220801.50a7210-lkp@intel.com
>>> Reviewed-by: David Howells <dhowells@redhat.com>
>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>> ---
>>>
>>> v2:
>>>    - Add David Howells's Rb on the original patch
>>>    - Remove the offset increment, since it's dead code
>>>
>>>    drivers/infiniband/sw/siw/siw_qp_tx.c | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
>>> index 3a08f57d2211..f7dd32c6e5ba 100644
>>> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>>> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>>> @@ -340,18 +340,17 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
>>>    		if (!sendpage_ok(page[i]))
>>>    			msg.msg_flags &= ~MSG_SPLICE_PAGES;
>>>    		bvec_set_page(&bvec, page[i], bytes, offset);
>>> -		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
>>> +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
>>>    try_page_again:
>>>    		lock_sock(sk);
>>> -		rv = tcp_sendmsg_locked(sk, &msg, size);
>>> +		rv = tcp_sendmsg_locked(sk, &msg, bytes)
>>>    		release_sock(sk);
>>>    		if (rv > 0) {
>>>    			size -= rv;
>>>    			sent += rv;
>>>    			if (rv != bytes) {
>>> -				offset += rv;
>>>    				bytes -= rv;
>>>    				goto try_page_again;
>>>    			}
>> Acked-by: Bernard Metzler <bernard.metzler@linux.dev>
>
> Thanks!
>
> Do you want to take the fix through your tree? Otherwise I suspect Vlastimil
> could simply take it (and possibly resubmit the SLAB PR, which hasn't been
> merged yet).
>
Thanks Pedro. Having Vlastimil taking care sounds good to me.

I am currently without development infrastructure (small village

in the mountains thing). And fixing the SLAB PR in the

first place would be even better.


Best,

Bernard.


