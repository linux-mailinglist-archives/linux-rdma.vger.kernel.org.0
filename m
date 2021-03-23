Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3C346477
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhCWQIB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhCWQH7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 12:07:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F1C061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 09:07:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g20so14854973qkk.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Mar 2021 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dd78KVo/k+65hHvXqmy428M/itdMaDI0EMLjgBSStvc=;
        b=Zacl8M6UShpatRgwJ5S4Gv1Q/Q79vfpMMuYtwjRd/taoEOxzT0hRZOpvzrGsmXVcwq
         hBan0o4xa6ECzobfCVwk1df3fhQxZtnWKQ2FS62ZxRb9JT6ipSQD5WhSjaXQUPIfqwT9
         RwjAAGGVFgSZIV015gN9/KG3nOmi3xXnEvFx1twpmZH6FWUJxh2/nZTdDB+xcSrENUSe
         0DvFr3W4VWNvK4hLC3Cq5Ef55yd5K95QO4qZk0Kldirsddr48MGJBbX/2wDAC3twjDVw
         8Z0gr7bFciWunZkv345G03NqT4TgzBzIrX5W+Y+FlzzWEB3FYw97VOd2DGBvHcZw2VC4
         DrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dd78KVo/k+65hHvXqmy428M/itdMaDI0EMLjgBSStvc=;
        b=rEn8ly5WU1sbS4f9MkNWLKa/lKzmxOXypfQaGp66FtVxnRpLukMnzqCwbwy551tP1j
         IGFgjSrcNJswyg1TD9kBnWlVrRTJS157M7fpK9goI+DfxnvWDpb0IkoR49eR3vSRSveJ
         gM+ouRwHNNWwuDWtBIm6BNLJruJfv2kcjV1YWrg5VtQfYIxFB/uF0iPT9sY/xNTlESDW
         Kh/6qa3axJF15Q4EW5yQwVMQPu1dMoEX6t/sCgcAVOX31Re9csU3EU7YdIKGEhAbc/cu
         56aA+dEEzorLRNSzpyUg6U7kb0WiQ10lL5se66Imi4j96i0ebT0zvje0nwC5dR3wupc+
         slxQ==
X-Gm-Message-State: AOAM532yAY6GJMYLpa1IHbx/lVMWrgyrC/LQRS5pbUsbh46VZ4KK6pZW
        3Pd7fYOOiLdZ2bAq+6LYz0M1iA==
X-Google-Smtp-Source: ABdhPJxc/r/vIzkCrmPr5/mVRQPFep2fDF30vYvBJDdtU58ruq0WNUBKEDlxzrUY0ydcR7PtVEpGiw==
X-Received: by 2002:a37:bd7:: with SMTP id 206mr6442976qkl.284.1616515678468;
        Tue, 23 Mar 2021 09:07:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g25sm3116375qtq.7.2021.03.23.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:07:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lOjZU-001Zq3-Pm; Tue, 23 Mar 2021 13:07:56 -0300
Date:   Tue, 23 Mar 2021 13:07:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        rajesh.sivaramasubramaniom@oracle.com,
        rama.nichanamatlu@oracle.com, aruna.ramakrishna@oracle.com,
        jeffery.yoder@oracle.com
Subject: Re: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Message-ID: <20210323160756.GE2710221@ziepe.ca>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 16, 2021 at 01:09:01PM +0000, Praveen Kumar Kannoju wrote:
> To update xlt (during mlx5_ib_reg_user_mr()), the driver can request up to
> 1 MB (order-8) memory, depending on the size of the MR. This costly
> allocation can sometimes take very long to return (a few seconds),
> especially if the system is fragmented and does not have any free chunks
> for orders >= 3. This causes the calling application to hang for a long
> time. To avoid these long latency spikes, limit max order of allocation to
> order 3, and reuse that buffer to populate_xlt() for that MR. This will
> increase the latency slightly (in the order of microseconds) for each
> mlx5_ib_update_xlt() call, especially for larger MRs (since were making
> multiple calls to populate_xlt()), but its a small price to pay to avoid
> the large latency spikes with higher order allocations. The flag
> __GFP_NORETRY is used while fetching the free pages to ensure that there
> are no long compaction stalls when the system's memory is in fragmented
> condition.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
>  drivers/infiniband/hw/mlx5/mr.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index db05b0e..dac19f0 100644
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1004,9 +1004,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
>  	return mr;
>  }
>  
> -#define MLX5_MAX_UMR_CHUNK ((1 << (MLX5_MAX_UMR_SHIFT + 4)) - \
> -			    MLX5_UMR_MTT_ALIGNMENT)
> -#define MLX5_SPARE_UMR_CHUNK 0x10000
> +#define MLX5_SPARE_UMR_CHUNK 0x8000
>  
>  /*
>   * Allocate a temporary buffer to hold the per-page information to transfer to
> @@ -1028,30 +1026,16 @@ static void *mlx5_ib_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
>  	 */
>  	might_sleep();
>  
> -	gfp_mask |= __GFP_ZERO;
> +	gfp_mask |= __GFP_ZERO | __GFP_NORETRY;
>  
> -	/*
> -	 * If the system already has a suitable high order page then just use
> -	 * that, but don't try hard to create one. This max is about 1M, so a
> -	 * free x86 huge page will satisfy it.
> -	 */
>  	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
> -		     MLX5_MAX_UMR_CHUNK);
> +		     MLX5_SPARE_UMR_CHUNK);
>  	*nents = size / ent_size;
>  	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
>  				       get_order(size));
>  	if (res)
>  		return res;
>  
> -	if (size > MLX5_SPARE_UMR_CHUNK) {
> -		size = MLX5_SPARE_UMR_CHUNK;
> -		*nents = get_order(size) / ent_size;
> -		res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
> -					       get_order(size));
> -		if (res)
> -			return res;
> -	}

Why did you delete this and make the size smaller? Isn't GFP_NORETRY
enough?

Jason
