Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B9BE7381
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 15:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfJ1OSq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 10:18:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJ1OSq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 10:18:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id l15so8161098qtr.10
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqPRCSYlNxyJ9QsOnnbZxCWEH33oWa5gKeDbNMZJ7Vc=;
        b=jnJ1P9Lia01x32v5cksIltO7AFbODqdGjN1uA8zp/TWe7IT3Xp/kVOX0n4rr68Ni5a
         j2Xq/ggzv0m+n2NIj7LzZJ3VBWayfNS9g9d/2p0SbFR0jWdYWFJKPypsWWTtMD6yPAQO
         Qr7ebv0ycI4QGWEc203AIiYEGL+2VhcfO6aCIB08LBAoWvlWZhiJcM8hJ4FvmlFmNkKI
         /RsaGNaQE1cTcOhWoTJUFQaL567HHcczGVIV/WsObZojlYqNz4D3wQwzMouVP0OxDd2P
         VC2E/wK/O5cB94bhXmA5+Zxa/rTpe4MCqJ+WzmB7VtxX29kHAc3LgFR2xXz0ZW/ZXRQc
         rGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqPRCSYlNxyJ9QsOnnbZxCWEH33oWa5gKeDbNMZJ7Vc=;
        b=oJSagMGauIfdfUUefIfncgRqHWKdSwqmeil+W/wevclhdavKktL4dOtTPZ9zKoGDxk
         PCnRepMZdkJ6pNBGIhtxAz0M5bSGDV2GS7CK1/g85CEPm5sD8cbeuV7zbrvpfeTTfItA
         MnupISSFa3Wz4nfYmkEO+IQnTsA9bW3ssL8u7bPCvczwZEka8qIluVZl9rULmy6IK722
         dHxtIjYDxyxRhRqXWahbjztX3gZ2XJaAEZ/8lHjKURnWDQGprMryh+JlyEb13GnwGLzE
         NqPaEaLxNgiUWCSYmnWuTwTVBm13WTegEkVdoeO/B2JO0mPiQH9m9JH+LI0P+L+oWPSu
         CY6w==
X-Gm-Message-State: APjAAAXPcMe16sZeSjT5th5HENOTUVFg2Ugt6s+kvJx19A+FRinyMi1o
        TqD4UvxUdjhvs5yxaIbajTa/CfXTR9s=
X-Google-Smtp-Source: APXvYqzMsnmBUI/EDd/WnXF2fSKaqFHVRP+a4wdhCOzzjbeEJXGn8Oj/e5AOiG/3FxlNAUHPO5uVHg==
X-Received: by 2002:a0c:87b5:: with SMTP id 50mr17063951qvj.143.1572272325356;
        Mon, 28 Oct 2019 07:18:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id m13sm9492qka.112.2019.10.28.07.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 07:18:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP5r2-0002PP-EH; Mon, 28 Oct 2019 11:18:44 -0300
Date:   Mon, 28 Oct 2019 11:18:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH 14/15] RDMA/mlx5: Do not race with
 mlx5_ib_invalidate_range during create and destroy
Message-ID: <20191028141844.GA31700@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
 <20191009160934.3143-15-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009160934.3143-15-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 09, 2019 at 01:09:34PM -0300, Jason Gunthorpe wrote:
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> index 66523313c3e46c..fd2306aff78ad7 100644
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -144,6 +144,32 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
>  	}
>  }
>  
> +static void dma_fence_odp_mr(struct mlx5_ib_mr *mr)
> +{
> +	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
> +
> +	/* Ensure mlx5_ib_invalidate_range() will not touch the MR any more */
> +	mutex_lock(&odp->umem_mutex);
> +	if (odp->npages) {
> +		/*
> +		 * If not cached then the caller had to do clean_mrs first to
> +		 * fence the mkey.
> +		 */
> +		if (mr->allocated_from_cache) {
> +			mlx5_mr_cache_invalidate(mr);
> +		} else {
> +			/* clean_mr() */
> +			mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
> +			WARN_ON(mr->descs);
> +		}
> +		ib_umem_odp_unmap_dma_pages(odp, ib_umem_start(odp),
> +					    ib_umem_end(odp));
> +		WARN_ON(odp->npages);
> +	}
> +	odp->private = NULL;
> +	mutex_unlock(&odp->umem_mutex);

The new mmu notifier debugging catches that mlx5_core_destroy_mkey()
allocates as GFP_KERNEL and cannot be called under umem_mutex, so this
needs to be reworked.

I think to rely on mlx5_mr_cache_invalidate() to fence the DMA, then
destroy out of the lock:

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 74c45356d54007..f713eb82eeead4 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -151,23 +151,18 @@ static void dma_fence_odp_mr(struct mlx5_ib_mr *mr)
 	/* Ensure mlx5_ib_invalidate_range() will not touch the MR any more */
 	mutex_lock(&odp->umem_mutex);
 	if (odp->npages) {
-		/*
-		 * If not cached then the caller had to do clean_mrs first to
-		 * fence the mkey.
-		 */
-		if (mr->allocated_from_cache) {
-			mlx5_mr_cache_invalidate(mr);
-		} else {
-			/* clean_mr() */
-			mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
-			WARN_ON(mr->descs);
-		}
+		mlx5_mr_cache_invalidate(mr);
 		ib_umem_odp_unmap_dma_pages(odp, ib_umem_start(odp),
 					    ib_umem_end(odp));
 		WARN_ON(odp->npages);
 	}
 	odp->private = NULL;
 	mutex_unlock(&odp->umem_mutex);
+
+	if (!mr->allocated_from_cache) {
+		mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
+		WARN_ON(mr->descs);
+	}
 }
 
 /*
