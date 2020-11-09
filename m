Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842342AC652
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 21:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgKIUwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 15:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIUwf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Nov 2020 15:52:35 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE9AC0613CF
        for <linux-rdma@vger.kernel.org>; Mon,  9 Nov 2020 12:52:35 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so7038048qtb.10
        for <linux-rdma@vger.kernel.org>; Mon, 09 Nov 2020 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h+5AS1UAN6IG5itjeosMYs/x5pZ1pPVekrx/fUTSQGA=;
        b=UAw9/1Oz58ga9K9N3oXk3xZcD/LnhKQyXgzvxSGqzkqbYZJHaNbAgARCUUxja1yFz2
         WXhDVyEGvSWw0l/i8jhadaYHM4JsPvo4kTye05bihGmZwav0k6TbkqPM29fRpS/wsvWJ
         MYXU4jOW8cTwqzhw3zlA7szl4ez/zp3y77+NGNO7YmpVtrqI1dIYL+f/69dgH4x2AQmQ
         LH6R7/9IRhvsL20Q3sU2pslj7fLHM7sE1S4/5MZCoVGkeTRwqDzs/Rd24QpbUoLzKv4P
         BbQT+YkgR84GsJXepnhv0T/qAcvDDg/m8GfxVGiND1m92TB1ekN32HnMtG3yYIrjardh
         jkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+5AS1UAN6IG5itjeosMYs/x5pZ1pPVekrx/fUTSQGA=;
        b=pFzEp0+yr4VsgTtsN5UWsCGiGAuEkZ6K1geTQ012FZBShZk20TqnJdEfLCTiE2YCHI
         chvR3igyPj6D0hyf8bj34N8v38oMnVoo0biFwaPeMzOzm31KR46c7oZo4dmHuTogR1ER
         KCZ67Wu2/cMamGxLDIgIg0COrRFJEUErL+hjNECKhvRJvHdz2Jf5xeMsWOq4yxS3tWxr
         AxW7MN1YrJTViVwsSJsKF4qZu/Zjw25CoEUzu1ALKhmOQzJ/e/VL7ZB03cydwmDan3gx
         axWFH7Hb4GtGUD67/tusi6ObfmqI4UD00H8CN/BDRmL5fOqTx2bfuK0RJKxpadW7BXj4
         dxVA==
X-Gm-Message-State: AOAM531flaucaeDrzGqs/05xOEffCppgw3pmJ80CRaoVy+fR4Lkw4nYv
        43Hc7zzFVI70wDax6o3LjuA1RA==
X-Google-Smtp-Source: ABdhPJywNymnP2MR+G1kl8vN/jM3BTl2P5r2jzpnYkweiQvO0UUHaB8V8tMztuoOxJHNPOz53DUzLA==
X-Received: by 2002:ac8:1288:: with SMTP id y8mr14996277qti.177.1604955154334;
        Mon, 09 Nov 2020 12:52:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l3sm5075169qkj.114.2020.11.09.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:52:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kcE9Q-0026th-Pc; Mon, 09 Nov 2020 16:52:32 -0400
Date:   Mon, 9 Nov 2020 16:52:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v9 4/5] RDMA/mlx5: Support dma-buf based userspace memory
 region
Message-ID: <20201109205232.GH244516@ziepe.ca>
References: <1604949781-20735-1-git-send-email-jianxin.xiong@intel.com>
 <1604949781-20735-5-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604949781-20735-5-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 09, 2020 at 11:23:00AM -0800, Jianxin Xiong wrote:
> @@ -1291,8 +1303,11 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
>  	int err;
>  	bool pg_cap = !!(MLX5_CAP_GEN(dev->mdev, pg));
>  
> -	page_size =
> -		mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
> +	if (umem->is_dmabuf)
> +		page_size = ib_umem_find_best_pgsz(umem, PAGE_SIZE, iova);
> +	else
> +		page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
> +						     0, iova);

Any place touching the sgl has to also hold the resv lock, and sgl
might be NULL since an invalidation could come in at any time, eg
before we get here.

You can avoid those problems by ingoring the SGL and hard wiring
PAGE_SIZE here

> +static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
> +			       u32 *bytes_mapped, u32 flags)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
> +	u32 xlt_flags = 0;
> +	int err;
> +
> +	if (flags & MLX5_PF_FLAGS_ENABLE)
> +		xlt_flags |= MLX5_IB_UPD_XLT_ENABLE;
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
> +	if (!err)
> +		err = mlx5_ib_update_mr_pas(mr, xlt_flags);

This still has to call mlx5_umem_find_best_pgsz() each time the sgl
changes to ensure it is still Ok. Just checking that 

  mlx5_umem_find_best_pgsz() > PAGE_SIZE

and then throwing away the value is OK

Jason
