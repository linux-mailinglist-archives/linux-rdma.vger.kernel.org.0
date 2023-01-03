Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA6265CA3C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjACXLN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 18:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjACXLM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 18:11:12 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28334C3D
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 15:11:11 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id d13so22467337qvj.8
        for <linux-rdma@vger.kernel.org>; Tue, 03 Jan 2023 15:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwSas1/oV6OHXihKNRCGQI5XX+aaTLu+0pV5KWEUIhk=;
        b=VpSE4K8VVBlmKAE7YHoFq1kiJdGbePgbqQb6VkRXepYgbwVpHXdKUnbdukPZTjPGt8
         kyYDY4HQkALfSj6Oh1QzxJZ7mt4uEYTSOJ+9nkoaPRi4d9Mf22wyMNBjVyfJeRDbUZ/o
         2NIlS+CZxnKQgdiyqHfvkn4XE316mw0LnuwYKlsqERfkzs7tdkh9KnOghmGZ2sxZRVdL
         zUCjE70djWseIYWN9FJrwe6wKEaX1+07DwKK7LEjd0p3AndRw4082h0KxfkFuemCOaYL
         JGYp3kRTHdrWFURNFHQUXQ2w5CclsQ6ud/M4bSVz2/Ummnogum++feJqjxw+h2grwgxx
         pztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwSas1/oV6OHXihKNRCGQI5XX+aaTLu+0pV5KWEUIhk=;
        b=xQpWZQbfC616TBXUiHLhUJOBU7QqYjlA64PPX5lbYDf2uGOVCT80P5d0H0GGYnYJpO
         ak/7ajW0KvlgsQvB+UqmExA8Fgl//jSkhN1Xm3pbX0NIncWDvtimoDJN1JAPWEYwt/U6
         ZWqhelNd0GSxltqtrke6gFwN1uz5N8jD8swGfEnpKaiTQrdNmN+njJBHa8rujJYxg8+O
         Wz5xmOOg8O8y9367YTnCGayZAiNLWtepFtQKxGH54/r77p1Ps8nR/gfn4z0pCKTtg91w
         oO80b5FhrI2ByovSRwdsnSeFvs6AwJ2HDxdDOre3IbeHohWgxFsHUcHnetleH55yr4lP
         RPYw==
X-Gm-Message-State: AFqh2kobd9XFc4l/c1rAh+kU3LNoIU1Xn0tLWOMZHVumGwS//pI0QQMz
        0uQnmkqyiiXdrtuN2mrHHgqN7g==
X-Google-Smtp-Source: AMrXdXsMch6cVgoMaCXF/yXaK79LilsS4bTVTMVavNA9S5DoHaXLp7G3uhqr+tjngCHqpqV/XqeVbw==
X-Received: by 2002:a0c:eac7:0:b0:531:913e:3ba7 with SMTP id y7-20020a0ceac7000000b00531913e3ba7mr37555493qvp.14.1672787470272;
        Tue, 03 Jan 2023 15:11:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id n78-20020a374051000000b006f9ddaaf01esm22680093qka.102.2023.01.03.15.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:11:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pCqR2-001c5Y-V1;
        Tue, 03 Jan 2023 19:11:08 -0400
Date:   Tue, 3 Jan 2023 19:11:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/irdma: Add support for dmabuf pin memory regions
Message-ID: <Y7S2DO0TFjxgDV6M@ziepe.ca>
References: <20230103013433.341997-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103013433.341997-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 02, 2023 at 08:34:33PM -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This is a followup to the EFA dmabuf[1]. Irdma driver currently does
> not support on-demand-paging(ODP). So it uses habanalabs as the
> dmabuf exporter, and irdma as the importer to allow for peer2peer
> access through libibverbs.
> 
> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
> This function is introduced in EFA dmabuf[1] which allows the driver
> to get a dmabuf umem which is pinned and does not require move_notify
> callback implementation. The returned umem is pinned and DMA mapped
> like standard cpu umems, and is released through ib_umem_release().
> 
> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 158 ++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index f6973ea55eda..76dc6e65930a 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2912,6 +2912,163 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  	return ERR_PTR(err);
>  }
>  
> +struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> +				       u64 len, u64 virt,
> +				       int fd, int access,
> +				       struct ib_udata *udata)
> +{
> +	struct irdma_device *iwdev = to_iwdev(pd->device);
> +	struct irdma_ucontext *ucontext;
> +	struct irdma_pble_alloc *palloc;
> +	struct irdma_pbl *iwpbl;
> +	struct irdma_mr *iwmr;
> +	struct irdma_mem_reg_req req;
> +	u32 total, stag = 0;
> +	u8 shadow_pgcnt = 1;
> +	bool use_pbles = false;
> +	unsigned long flags;
> +	int err = -EINVAL;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +
> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
> +		return ERR_PTR(-EINVAL);
> +
> +	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd,
> +						access);
> +	if (IS_ERR(umem_dmabuf)) {
> +		err = PTR_ERR(umem_dmabuf);
> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n", err);
> +		return ERR_PTR(err);
> +	}
> +
> +	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen))) {
> +		ib_umem_release(&umem_dmabuf->umem);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
> +	if (!iwmr) {
> +		ib_umem_release(&umem_dmabuf->umem);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	iwpbl = &iwmr->iwpbl;
> +	iwpbl->iwmr = iwmr;
> +	iwmr->region = &umem_dmabuf->umem;
> +	iwmr->ibmr.pd = pd;
> +	iwmr->ibmr.device = pd->device;
> +	iwmr->ibmr.iova = virt;
> +	iwmr->page_size = PAGE_SIZE;
> +
> +	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
> +		iwmr->page_size = ib_umem_find_best_pgsz(iwmr->region,
> +							 iwdev->rf->sc_dev.hw_attrs.page_size_cap,
> +							 virt);

You can't call rdma_umem_for_each_dma_block() without also calling
this function to validate that the page_size passed to
rdma_umem_for_each_dma_block() is correct.

This seems to be an existing bug, please fix it.

Also, is there a reason this code is all duplicated from
irdma_reg_user_mr? Please split things up like the other drivers to
obtain the umem then use shared code to process the umem as required.

Jason
