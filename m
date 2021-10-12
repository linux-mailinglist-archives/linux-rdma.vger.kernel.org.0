Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A21B42A8A5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 17:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhJLPnA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhJLPmu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 11:42:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733EFC061749
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 08:40:47 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q125so19724371qkd.12
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/HgQj5rWfz15ZHsdJoNM0lgYk5OwztgT423+aDJ7tE=;
        b=Fu3T91tNj215UW0bZncHSIGOCatKNDqlIdzRKEMjKgftjbcUB1O1XJY3j4/lSE4aO1
         CpX7zhisg5EWbVEOj+p1RdZSS5TjmjRB1/yWHiRptXxdcBvTJK9+ZXdqj6lWdhHMusap
         2QG3gBYv6v6Pxw52C09RhjhhQIlKptaYtmPpnSlyieakFeKnZElbFQlVUM8ejD/IAJIk
         BWkR6O/DDcafoNiTh5TBpcEHjP//rKTaWrIm9suQAIoKuj+QGhVE329ql2gAvL1fGmpQ
         htf5Xt400D1MOiBaathPnphvz3tEe+UNLfUfSU2eBLa1YGhPlkLIY1V6QAUEBll44iSh
         1xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/HgQj5rWfz15ZHsdJoNM0lgYk5OwztgT423+aDJ7tE=;
        b=aHFhwE9Dr2UajqAdltrWsasi8vUYqka/bAGWBfw5ttFYV9Xt4+ry67/+gxWWqOhGGJ
         mU+6GusZFR23jNQwiNbd4FM3mTgpMwdg3zWS36qEK3EU+QNf0FsDce7vv9LVcMTfeXl5
         aS4zXbXoil8CXKKFLFPU8v94ZZKCRgWefhMBnsBxJcigFZNV3Tcox09wyAuQb4xCqHtQ
         m79FgkBKsO5wZ4FNju3Znyhp74m0CTkMDeMpcQamkxk1OMXzFChHFeGsVUpI5lc1HN+Q
         xZeuxSi3EbkuRRgPsKxc6Iqo3Kk8zs9b1sUwL+X8csAFG2ViYcQ3NgghGagzgBlV7NPn
         dW2w==
X-Gm-Message-State: AOAM533ebuz8jO468tzzwLOO+/NHy8jc7Zsiffxxe14Cnis/Kb8DN2BS
        zSU5+e+/Kow3Ox8gAZGoVsgRLA==
X-Google-Smtp-Source: ABdhPJxV7q9r+IwF2nhiWUQKISrHlytaacskuWdJGNXlU6SkKGu1H2jTR8zruD1SwzMwQlG7SuvR5Q==
X-Received: by 2002:a37:2d46:: with SMTP id t67mr20054564qkh.84.1634053246625;
        Tue, 12 Oct 2021 08:40:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v20sm6603568qtp.44.2021.10.12.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 08:40:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1maJtV-00E4TS-KY; Tue, 12 Oct 2021 12:40:45 -0300
Date:   Tue, 12 Oct 2021 12:40:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>
Subject: Re: [PATCH for-rc v2] IB/qib: Protect from buffer overflow in struct
 qib_user_sdma_pkt fields
Message-ID: <20211012154045.GH2688930@ziepe.ca>
References: <20211012152331.64324.70193.stgit@awfm-01.cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012152331.64324.70193.stgit@awfm-01.cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 12, 2021 at 11:23:31AM -0400, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> Overflowing either addrlimit or bytes_togo can allow userspace to trigger
> a buffer overflow of kernel memory. Check for overflows in all the places
> doing math on user controlled buffers.
> 
> Fixes: f931551bafe1 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand adapters")
> Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> Changes from v0:
> 
> Incorporate Jason's suggestions and update commit message. Also added on the
> fixes line. Mike identified a different commit that is more directly
> responsible.
>  drivers/infiniband/hw/qib/qib_user_sdma.c |   38 +++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> index a67599b..6af9764 100644
> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> @@ -602,7 +602,7 @@ static int qib_user_sdma_coalesce(const struct qib_devdata *dd,
>  /*
>   * How many pages in this iovec element?
>   */
> -static int qib_user_sdma_num_pages(const struct iovec *iov)
> +static size_t qib_user_sdma_num_pages(const struct iovec *iov)
>  {
>  	const unsigned long addr  = (unsigned long) iov->iov_base;
>  	const unsigned long  len  = iov->iov_len;
> @@ -658,7 +658,7 @@ static void qib_user_sdma_free_pkt_frag(struct device *dev,
>  static int qib_user_sdma_pin_pages(const struct qib_devdata *dd,
>  				   struct qib_user_sdma_queue *pq,
>  				   struct qib_user_sdma_pkt *pkt,
> -				   unsigned long addr, int tlen, int npages)
> +				   unsigned long addr, int tlen, size_t npages)
>  {
>  	struct page *pages[8];
>  	int i, j;
> @@ -722,7 +722,7 @@ static int qib_user_sdma_pin_pkt(const struct qib_devdata *dd,
>  	unsigned long idx;
>  
>  	for (idx = 0; idx < niov; idx++) {
> -		const int npages = qib_user_sdma_num_pages(iov + idx);
> +		const size_t npages = qib_user_sdma_num_pages(iov + idx);
>  		const unsigned long addr = (unsigned long) iov[idx].iov_base;
>  
>  		ret = qib_user_sdma_pin_pages(dd, pq, pkt, addr,
> @@ -824,8 +824,8 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
>  		unsigned pktnw;
>  		unsigned pktnwc;
>  		int nfrags = 0;
> -		int npages = 0;
> -		int bytes_togo = 0;
> +		size_t npages = 0;
> +		size_t bytes_togo = 0;
>  		int tiddma = 0;
>  		int cfur;
>  
> @@ -885,7 +885,11 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
>  
>  			npages += qib_user_sdma_num_pages(&iov[idx]);
>  
> -			bytes_togo += slen;
> +			if (check_add_overflow(bytes_togo, slen, &bytes_togo) ||
> +			    bytes_togo > type_max(typeof(pkt->bytes_togo))) {
> +				ret = -EINVAL;
> +				goto free_pbc;
> +			}
>  			pktnwc += slen >> 2;
>  			idx++;
>  			nfrags++;
> @@ -904,11 +908,15 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
>  		}
>  
>  		if (frag_size) {
> -			int tidsmsize, n;
> -			size_t pktsize;
> +			size_t tidsmsize, n, pktsize, sz, addrlimit;
>  
>  			n = npages*((2*PAGE_SIZE/frag_size)+1);
> +
>  			pktsize = struct_size(pkt, addr, n);
> +			if (pktsize == SIZE_MAX) {
> +				ret = -EINVAL;
> +				goto free_pbc;
> +			}

since pktsize directly flows into another check_add_overflow which
flows into a kmalloc this hunk isn't needed. kmalloc always fails for
SIZE_MAX

Jason
