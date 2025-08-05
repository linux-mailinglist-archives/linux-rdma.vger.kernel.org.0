Return-Path: <linux-rdma+bounces-12591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1804B1B69E
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B41E1898A12
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436FD27877B;
	Tue,  5 Aug 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kaDTtUVO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983F259CBC
	for <linux-rdma@vger.kernel.org>; Tue,  5 Aug 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404508; cv=none; b=m3KbDTF4z4ZFm17DLZ0wm/+0vTmo9pE4OjDQY2ZaSJfMook0QWvaAlbaMm/h051zf3sfnC+cpEG6ohKKX7nNfhgERuQxHKoT5ivkspg31DLEe10nnZrCXBaWwKsZyNV4NXXkXCYhiBYhmnRxNZLeFRX7V4243A2dyQqyJ7mRcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404508; c=relaxed/simple;
	bh=Cwbx4fAo3v6Kvmo6qZurjhrji8V9gCulLFdPdTB/AJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7OplqgaVzFWdw06mV5s0eCkXRimFIDIXbyA2f7euoX9pZgvlGYroWT0q1dxdDlR4tJNy76oHRpX1QMspMy7FC3SHsKb1kGCjt5SRCRrZa1L8/2oJ5xGYzQJhkomFDD6tIILVkbGEKsrPP0w+rspOjwNTGf6LGvpRCephcTcfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kaDTtUVO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e7f940a386so145688885a.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Aug 2025 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754404504; x=1755009304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBToXdvc7vhVURp+VSgDGT8CNn/O/Lx3N4Cacd9QC+s=;
        b=kaDTtUVOdsgW+SanOdS8detQSiuBhifz7s5q7Q96YUopgFQgZywMedTVza5U8yIxll
         ALPmtOY3tFzvmI1rKiWdkzIU0jwxaMQyPL0SgyOmFQnoqytBjj97wVsRJif7mq+9pgQG
         69ELtb4hgNq3yV8JNjG2BXDuS3NpBrxQ3TvRMcuGxJw0so6H0H337S3NBwioKKtdF57d
         vtNr7t/ofrVvu7Xcvv7OKtPd1CLmu0WT8ikJDFFzNNfnT9E0Ovwm4fDiEnBFFO89CJe9
         K+b1dOs7x82+NXGrxUVQEWLQMNxzOeA3dYo6ch/C4J45haSbqcpb8YoeAdrJ2VCjewyT
         RTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404504; x=1755009304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBToXdvc7vhVURp+VSgDGT8CNn/O/Lx3N4Cacd9QC+s=;
        b=OlJcJeZ+4TFBiQuP9p7oAQ1erQoGwZpfbiwO/uzuQ3rJ0G28SQdFjLyZ9oWzTNt9IM
         HEDw3GQ0N1wX+BjTWYocwv7np6oz95RQybVtucrvddGf97d+5vNaBUhw7EdPao7nP3Yq
         yHFFgQuDR0D5XA2E/koCuJ2KHIyoWtO9/eSp30blO9/1FqjGxQaFR7uJ1dzzJw21V+jG
         GGOin2iVJFQdSktm2ENxcEg56qtZn5t6vowp5Nwk6GDkXQhCZXlFvq3gqI7KWAyc4njM
         lu3YaAmh9x5faJAfVeQwtCh6v1sLTGuinIBuzijyouB64clnJ3KNEPSh31Y3nABCTBcf
         jwwg==
X-Forwarded-Encrypted: i=1; AJvYcCWIoBRIcIR4uFGwJ705vlepLIrB2AvovEa12UI8y/jM2xMxK7xe3RYuiEtzBnVnCKgC8FtnhO3ifvlH@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgmtoz2dXszOrCz8ZZ5Cms3QBC33JIO2fEDXCD/27KotxZM53
	AaVx8EIXtjzHQuGfULFpQ/gmAyAoDKRKFOhmigXqXj74gixgOFuKNTNaOfL+lzGrvug=
X-Gm-Gg: ASbGncs4RC6VZxU/Ensbr7iSNGF0zbPt5ms3EBpw9+KtsUjvI/p+3UUUtFyEHkkuioD
	Rr4Myocla3drhFu8zal6JXBnjiqPaxiVlV4eO5DGoo7+CyuL5OXw6Etgd087JRGWAgM2RWKtTtw
	tuGLzGMixoPII6g+F1XvhktoeDboMTLGVIXhtD/Rd555xRAht/EoPJ9gG5DZV8oXT6Kzgcrv1PH
	WPHoer9A6kQEs7iHKxzspM7/0snNvHvfxrFty4xNd5USwGRdL28iRYs7VU/NrekjG9oDNdOqnth
	nEO0N/Uspo+oDd1eoUxmMLR9rOICpnfp25WeEkh5yDC9sI44DktpNtKsCT0jgExBtYEz5m7DaW3
	14p/32g4QUQ0lI4wbzIGLlOjO6nCNm9a5A6cTFaZO9DAyMfSNl0l+WMBd/qVB6bJSz6OeCmXsE9
	GoToI=
X-Google-Smtp-Source: AGHT+IF+3kfrwzrTgPnPbgiihuZwD781MauBUX6H7jY1e1xn+FzW3NhXvH6UtxUPt9nNb/NESu2wng==
X-Received: by 2002:a05:620a:a483:b0:7e6:7e39:be55 with SMTP id af79cd13be357-7e696269e7amr1410178785a.2.1754404503789;
        Tue, 05 Aug 2025 07:35:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5bee91sm681707485a.32.2025.08.05.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:35:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujIko-00000001Y5w-2i8N;
	Tue, 05 Aug 2025 11:35:02 -0300
Date: Tue, 5 Aug 2025 11:35:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Jakub Kicinski <kuba@kernel.org>,
	David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, torvalds@linux-foundation.org,
	stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] RDMA/siw: Fix the sendmsg byte count in
 siw_tcp_sendpages
Message-ID: <20250805143502.GQ26511@ziepe.ca>
References: <20250729120348.495568-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729120348.495568-1-pfalcato@suse.de>

On Tue, Jul 29, 2025 at 01:03:48PM +0100, Pedro Falcato wrote:
> Ever since commit c2ff29e99a76 ("siw: Inline do_tcp_sendpages()"),
> we have been doing this:
> 
> static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
>                              size_t size)
> [...]
>         /* Calculate the number of bytes we need to push, for this page
>          * specifically */
>         size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
>         /* If we can't splice it, then copy it in, as normal */
>         if (!sendpage_ok(page[i]))
>                 msg.msg_flags &= ~MSG_SPLICE_PAGES;
>         /* Set the bvec pointing to the page, with len $bytes */
>         bvec_set_page(&bvec, page[i], bytes, offset);
>         /* Set the iter to $size, aka the size of the whole sendpages (!!!) */
>         iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> try_page_again:
>         lock_sock(sk);
>         /* Sendmsg with $size size (!!!) */
>         rv = tcp_sendmsg_locked(sk, &msg, size);
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
>   iov_iter_extract_pages
>     iov_iter_extract_bvec_pages
>       uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
>   skb_splice_from_iter gets a "short" read
> 
> (!MSG_SPLICE_PAGES)
> skb_copy_to_page_nocache copy=iov_iter_count
>  [...]
>    copy_from_iter
>         /* this doesn't help */
>         if (unlikely(iter->count < len))
>                 len = iter->count;
>           iterate_bvec
>             ... and we run off the bvecs
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

Applied thanks,

Jason

