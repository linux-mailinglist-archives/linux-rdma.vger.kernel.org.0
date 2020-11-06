Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D02A8B63
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgKFAZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 19:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732930AbgKFAZT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 19:25:19 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DCDC0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 16:25:18 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id h15so1205346qkl.13
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 16:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XWSfd9PFSOxQ9Z4ECkbYxERh9Ps8KWB3FA1d9adJlLA=;
        b=YJ7Fu/CxckvvNmsfUS4PT5EJdP+6IVEDq/uzDmUH+H5AX53BtRMDIuc6UqUykL3j5v
         y+qRb5VDSGTw3t1Le9+x8hOpE3Hg4RR6SZpT/yVFYdWNjxWdCSgP99PENjJyjME45YYQ
         rbRhRXy5kODa+Cfv2ZPCXKHm82GdpYaqMtlXl2e5ejoD94kSYmSU5tfOWaIkIZysJu4c
         kabRthTL1Vz6NyvI9kjh+Vq+S2r3TlLm0CkNHd1NlcR+VW2mQpKQeUXy7iN0ywXGDSIX
         Q+tc0R82xbJY3j0o0xHO4FGPhUeYGrdVHv/3tEXZjoO9jG/E0S9kusEivjGH/TTC1L/F
         +QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWSfd9PFSOxQ9Z4ECkbYxERh9Ps8KWB3FA1d9adJlLA=;
        b=Cuk/PlvxTUlUgiVR6l1BLcWVrGGjm8yNd7BVCIuv9enB7R0fn9NRyV9wZZbhX5704s
         UnFhChnJZ2jLWU/xLpGyl8E75MjLpd5pj5JKp1o6CMfSCIjrfSHUEOHpJJ8NIQxzRgNN
         akoIP2VkGL/LSIv3scFJ/hKX7Wo0jBHHE8vF1XMOsmflbNqY2JsoTImGT/PXY5vyMgJl
         coOHIcewXrf1IQzf5V7pgmdknNghPl2R0c7AZ+vCfKqhszbgFBO+gBwyNNiJbhgAreEx
         8+zMYVv3r7KL377hOTRLvJ1AGaR5bDsG9tmkC2/h1FGWreCb7ani+CnJIv30hd7X2yx1
         Iu2Q==
X-Gm-Message-State: AOAM533wp7dSq/JiTAY/5GfRfojy8nUX/OQSnVoz9GUyBOcB4uYi1iC+
        dh2t6e3nCOna3uZiVPOQY8KwWg==
X-Google-Smtp-Source: ABdhPJwmpkVinpl13YBIyBPnH9V+s6xlQ93oQ9ihzpJHSGzyw778Yw4k1/jHqDhLtLhXWfWlmgGcMg==
X-Received: by 2002:a37:2cc2:: with SMTP id s185mr4842655qkh.118.1604622316570;
        Thu, 05 Nov 2020 16:25:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x31sm2080682qtb.81.2020.11.05.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:15 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kapZ5-000ZBJ-6K; Thu, 05 Nov 2020 20:25:15 -0400
Date:   Thu, 5 Nov 2020 20:25:15 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v8 4/5] RDMA/mlx5: Support dma-buf based userspace memory
 region
Message-ID: <20201106002515.GM36674@ziepe.ca>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-5-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604616489-69267-5-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 02:48:08PM -0800, Jianxin Xiong wrote:
> @@ -966,7 +969,10 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
>  	struct mlx5_ib_mr *mr;
>  	unsigned int page_size;
>  
> -	page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
> +	if (umem->is_dmabuf)
> +		page_size = ib_umem_find_best_pgsz(umem, PAGE_SIZE, iova);

You said the sgl is not set here, why doesn't this crash? It is
certainly wrong to call this function without a SGL.

> +/**
> + * mlx5_ib_fence_dmabuf_mr - Stop all access to the dmabuf MR
> + * @mr: to fence
> + *
> + * On return no parallel threads will be touching this MR and no DMA will be
> + * active.
> + */
> +void mlx5_ib_fence_dmabuf_mr(struct mlx5_ib_mr *mr)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
> +
> +	/* Prevent new page faults and prefetch requests from succeeding */
> +	xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
> +
> +	/* Wait for all running page-fault handlers to finish. */
> +	synchronize_srcu(&mr->dev->odp_srcu);
> +
> +	wait_event(mr->q_deferred_work, !atomic_read(&mr->num_deferred_work));
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	mlx5_mr_cache_invalidate(mr);
> +	umem_dmabuf->private = NULL;
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!mr->cache_ent) {
> +		mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
> +		WARN_ON(mr->descs);
> +	}
> +}

I would expect this to call ib_umem_dmabuf_unmap_pages() ?

Who calls it on the dereg path?

This looks quite strange to me, it calls ib_umem_dmabuf_unmap_pages()
only from the invalidate callback?

I feel uneasy how this seems to assume everything works sanely, we can
have parallel page faults so pagefault_dmabuf_mr() can be called
multiple times after an invalidation, and it doesn't protect itself
against calling ib_umem_dmabuf_map_pages() twice.

Perhaps the umem code should keep track of the current map state and
exit if there is already a sgl. NULL or not NULL sgl would do and
seems quite reasonable.

> @@ -810,22 +871,31 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
>  			u32 *bytes_mapped, u32 flags)
>  {
>  	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
>  
>  	lockdep_assert_held(&mr->dev->odp_srcu);
>  	if (unlikely(io_virt < mr->mmkey.iova))
>  		return -EFAULT;
>  
> -	if (!odp->is_implicit_odp) {
> +	if (is_dmabuf_mr(mr) || !odp->is_implicit_odp) {
>  		u64 user_va;
> +		u64 end;
>  
>  		if (check_add_overflow(io_virt - mr->mmkey.iova,
> -				       (u64)odp->umem.address, &user_va))
> +				       (u64)mr->umem->address, &user_va))
>  			return -EFAULT;
> -		if (unlikely(user_va >= ib_umem_end(odp) ||
> -			     ib_umem_end(odp) - user_va < bcnt))
> +		if (is_dmabuf_mr(mr))
> +			end = mr->umem->address + mr->umem->length;
> +		else
> +			end = ib_umem_end(odp);
> +		if (unlikely(user_va >= end || end - user_va < bcnt))
>  			return -EFAULT;
> -		return pagefault_real_mr(mr, odp, user_va, bcnt, bytes_mapped,
> -					 flags);
> +		if (is_dmabuf_mr(mr))
> +			return pagefault_dmabuf_mr(mr, umem_dmabuf, user_va,
> +						   bcnt, bytes_mapped, flags);

But this doesn't care about user_va or bcnt it just triggers the whole
thing to be remapped, so why calculate it?

Jason
