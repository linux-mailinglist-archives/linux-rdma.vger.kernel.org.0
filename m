Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A230CB94
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbhBBT3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 14:29:35 -0500
Received: from p3plsmtpa08-09.prod.phx3.secureserver.net ([173.201.193.110]:40709
        "EHLO p3plsmtpa08-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239750AbhBBT1W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 14:27:22 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 14:27:22 EST
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 71Bal9vSjLcNc71BaluHVh; Tue, 02 Feb 2021 12:18:03 -0700
X-CMAE-Analysis: v=2.4 cv=avt3tQVV c=1 sm=1 tr=0 ts=6019a56b
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=eBu2ZcF3FvbrOdrAn-4A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
To:     Chuck Lever <chuck.lever@oracle.com>, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
References: <161227696787.3689758.305854118266206775.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <e53cc3c2-2209-5f35-c487-9e59b9b9e526@talpey.com>
Date:   Tue, 2 Feb 2021 14:18:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161227696787.3689758.305854118266206775.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFL3nY6CFG8AC38X5hM/0VaAVk+Uf8kqz7jbubdtKlVsXD3LU3eOBhayMc061k+8ROPa9dE038Xfw9hyi6XnsBOyqdqI/yYRhnuftC46uy19M0DhzQck
 peELLxXftPsCDInvuKXyKAYZ36emKulJU/1gjBfe/LFSRFI8PWE3YFtasKqttpXp4hPQa+GJ5APgjEOWV3jrvpK7gAZ0Qux5GgGHRsOiJOGRhGbDnP4Wt4+S
 grAEb/PG+598znT92zRewmnqeknu6at9z131C6GIDO29roplGI4k3Uqj6hSfq10GVtE8ZG9uEsLqf5ypeiDCSw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

What's not to like about a log that uses the words "with aplomb"? :)

Minor related comment/question below.

On 2/2/2021 9:42 AM, Chuck Lever wrote:
> Clean up.
> 
> Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
> Remove support for FMR memory registration") [Dec 2018]. That means
> the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
> commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
> on page boundaries") [Mar 2016], is no longer necessary. FRWR
> memory registration handles this case with aplomb.
> 
> A related simplification removes an extra conditional branch from
> the SGL set-up loop in frwr_map(): Instead of using either
> sg_set_page() or sg_set_buf(), initialize the mr_page field properly
> when rpcrdma_convert_kvec() converts the kvec to an SGL entry.
> frwr_map() can then invoke sg_set_page() unconditionally.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++--------
>   net/sunrpc/xprtrdma/rpc_rdma.c  |   21 +++++----------------
>   net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
>   3 files changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index baca49fe83af..5eb044a5f0be 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -306,14 +306,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
>   	if (nsegs > ep->re_max_fr_depth)
>   		nsegs = ep->re_max_fr_depth;
>   	for (i = 0; i < nsegs;) {
> -		if (seg->mr_page)
> -			sg_set_page(&mr->mr_sg[i],
> -				    seg->mr_page,
> -				    seg->mr_len,
> -				    offset_in_page(seg->mr_offset));
> -		else
> -			sg_set_buf(&mr->mr_sg[i], seg->mr_offset,
> -				   seg->mr_len);
> +		sg_set_page(&mr->mr_sg[i], seg->mr_page,
> +			    seg->mr_len, offset_in_page(seg->mr_offset));
>   
>   		++seg;
>   		++i;
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 8f5d0cb68360..529adb6ad4db 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -204,9 +204,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
>   	return 0;
>   }
>   
> -/* Split @vec on page boundaries into SGEs. FMR registers pages, not
> - * a byte range. Other modes coalesce these SGEs into a single MR
> - * when they can.
> +/* Convert @vec to a single SGL element.
>    *
>    * Returns pointer to next available SGE, and bumps the total number
>    * of SGEs consumed.
> @@ -215,21 +213,12 @@ static struct rpcrdma_mr_seg *
>   rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
>   		     unsigned int *n)
>   {
> -	u32 remaining, page_offset;
> -	char *base;
> -
> -	base = vec->iov_base;
> -	page_offset = offset_in_page(base);
> -	remaining = vec->iov_len;
> -	while (remaining) {
> -		seg->mr_page = NULL;
> -		seg->mr_offset = base;
> -		seg->mr_len = min_t(u32, PAGE_SIZE - page_offset, remaining);
> -		remaining -= seg->mr_len;
> -		base += seg->mr_len;
> +	if (vec->iov_len) {
> +		seg->mr_page = virt_to_page(vec->iov_base);
> +		seg->mr_offset = vec->iov_base;
> +		seg->mr_len = vec->iov_len;
>   		++seg;
>   		++(*n);
> -		page_offset = 0;
>   	}
>   	return seg;
>   }
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 94b28657aeeb..4a9fe6592795 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -285,7 +285,7 @@ enum {
>   
>   struct rpcrdma_mr_seg {		/* chunk descriptors */
>   	u32		mr_len;		/* length of chunk or segment */
> -	struct page	*mr_page;	/* owning page, if any */
> +	struct page	*mr_page;	/* underlying struct page */
>   	char		*mr_offset;	/* kva if no page, else offset */

Is this comment ("kva if no page") actually correct? The hunk just
above is an example of a case where mr_page is set, yet mr_offset
is an iov_base. Is iov_base not a kva?

Tom.

>   };
>   
> 
> 
> 
