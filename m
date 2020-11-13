Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42C62B1357
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKMAjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAjs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 19:39:48 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2207C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:39:48 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so5641074qtx.3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h6qBToDAZs6M5ADvF0HkEp/ds1rUaGZSMQv/VFn44Q8=;
        b=m5g0crMfZzWb5UJhVrQqe2+NCXyDggfeAw5sI3nNLCax7HdjWx792Rc/SMNcq5I82b
         pnlaepsazd+OQ7JeJWTicHIR0+JlmtHvjCqE+QION5ssNDtbHjitPvAs101WDoeAtiD6
         hhbrEHmMKFJdAHlMfl544iJHlSjn1PmJ8vBIsRB32JYXhS2IKj4M4LzqLTtGWwtkUsE/
         +u25dwF4PXz/krTgkr9NKReX0Am6ISF8iCKcJLRABg9e00YmKx7DLrCXGI/3YH7bgwFx
         d2Y0dYmUvq+nTN1tnlaV2CkgvW+ay98hZ3tLuLJzwYRWDqzlyb3RSGrwd0/jr8Zbl7SI
         OcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6qBToDAZs6M5ADvF0HkEp/ds1rUaGZSMQv/VFn44Q8=;
        b=Mx8XxMeN52Zqts1O4JQGlblcM1dR/iwkURes+F4QdcTcJRaq2LlpJVhh4PTKXOXFDD
         n9142nzOwEoMkYelNtIkjejy6DcGb+tISwPLmpQ3BE11so7EFhd+CQ3cDHNgG00gyZPo
         QBepl+HyU923cG6mtFu8ldLgUFp+jvr6ImDf5e/h1idrRkkW/gU8qJ6Xahea1gBLK5W7
         9xDTDUrRsOR99/r7LP5YvPeL51AQrP3Sw7XuuRm2GC/7Leeo083kOzKsTNV5f8a8xAHy
         KR6NT9HmNryzjk0SS41QN1SRQSvWkHrZXHOLYQcgZ0ec585eS6HoKd4ljDpTQq7/Q3k0
         0Tfg==
X-Gm-Message-State: AOAM532NIuBINfrkkDc7ox7cx1CggtUhehtmPOWdcrnEKaRxn0sVWyAB
        tWDweYGHY48gJcAE2OVOM/HkNyMSSGJfi00x
X-Google-Smtp-Source: ABdhPJzMypy5XG3wUJxMiu91C2Tc3la7UW0arNLqhXTsQV7Hpa0T4g89Blb1+ksigKf2Qn6dLFNNSg==
X-Received: by 2002:aed:2ce1:: with SMTP id g88mr1965953qtd.299.1605227988052;
        Thu, 12 Nov 2020 16:39:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z88sm4335279qtd.46.2020.11.12.16.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:39:47 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdN7y-004Cbm-Tw; Thu, 12 Nov 2020 20:39:46 -0400
Date:   Thu, 12 Nov 2020 20:39:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v10 4/6] RDMA/mlx5: Support dma-buf based userspace
 memory region
Message-ID: <20201113003946.GA244516@ziepe.ca>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
 <1605044477-51833-5-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605044477-51833-5-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 01:41:15PM -0800, Jianxin Xiong wrote:

> -static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
> +int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
>  {
>  	struct mlx5_ib_dev *dev = mr->dev;
>  	struct device *ddev = dev->ib_dev.dev.parent;
> @@ -1255,6 +1267,10 @@ static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
>  		cur_mtt->ptag =
>  			cpu_to_be64(rdma_block_iter_dma_address(&biter) |
>  				    MLX5_IB_MTT_PRESENT);
> +
> +		if (mr->umem->is_dmabuf && (flags & MLX5_IB_UPD_XLT_ZAP))
> +			cur_mtt->ptag = 0;
> +
>  		cur_mtt++;
>  	}
>  
> @@ -1291,8 +1307,15 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
>  	int err;
>  	bool pg_cap = !!(MLX5_CAP_GEN(dev->mdev, pg));
>  
> -	page_size =
> -		mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
> +	if (umem->is_dmabuf) {
> +		if ((iova ^ umem->address) & (PAGE_SIZE - 1))
> +			return ERR_PTR(-EINVAL);
> +		umem->iova = iova;
> +		page_size = PAGE_SIZE;
> +	} else {
> +		page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
> +						     0, iova);
> +	}

Urk, maybe this duplicated sequence should be in a function..

This will also collide with a rereg_mr bugfixing series that should be
posted soon..

> +static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
> +	struct mlx5_ib_mr *mr = umem_dmabuf->private;
> +
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (mr)

I don't think this 'if (mr)' test is needed anymore? I certainly
prefer it gone as it is kind of messy. I expect unmapping the dma to
ensure this function is not running, and won't run again.

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
> +	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!mr->cache_ent) {
> +		mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
> +		WARN_ON(mr->descs);
> +	}

I didn't check carefully, but are you sure this destroy_mkey should be
here??

Jason
