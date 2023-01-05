Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BA465ED2D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jan 2023 14:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjAENho (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Jan 2023 08:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAENhg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Jan 2023 08:37:36 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC1DF19
        for <linux-rdma@vger.kernel.org>; Thu,  5 Jan 2023 05:37:35 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id t190so7361083vkb.6
        for <linux-rdma@vger.kernel.org>; Thu, 05 Jan 2023 05:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7VnxI6MjQ87cR8d+Sm50ejKLJDfHuBXCm8eyNFM75s=;
        b=pFwMTNdYJtp9UIGh0eQgHbl9uUZ9x1IgxrVLtou9tO0LYUbODByw86VhFqXB6ReAcI
         EENs1vlxy7i1a1EfMyiH0U1X/R5EbULgEMOwYZ2C9vcIr46AAmUGvZk/VtUaZmDny8NU
         XuxmOSx0wl08AQKVrtWQvtcJ+Of32O3WT9NRyLoIqEMasRGYkIfq6dhEp1a6Aq2i8qqN
         uExhFzeAiqauTw9TRPoHkguZfbBz0NKfpfZZdTQG1Q/vu7H/UZArPUO4yn0OQCt3kfZT
         N2F0mq2dSsMWfZH+j8FMEygME4waWlQpotcnUFr76rRDBkmUfmhYOxdZFMAMGWzS9gHI
         2kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7VnxI6MjQ87cR8d+Sm50ejKLJDfHuBXCm8eyNFM75s=;
        b=TrjwhUJJySt7TxaM4UKS4QLfVB2kVZiGYCvd7lQtysszUTFrs3hZ5zZQwpnOvRzTpr
         btCR7AnQOerK9N6hGI5iOEKbqR0uIRLBgXxqYCgnvD3ZXHjqFKItFQRFAYUW4u7TZEUC
         Kt3eRvRenCcqBVJmKuH56QX8irH2zb/5Qe6VmPzm7VxQFx6HzWGL+/dXIrlKhwmwfU2u
         FjMOpuCdfi5ZQ3eJOdEJLsXAQNfx1ZRwCnsbwan+rGRHWjvWKuW8X1pL2xACBMOF+ABe
         OPggp3oA/Z8g22wMFZ8/qfTbVtoar/Lm7c0oA89KMXd+sHfZ0Uje53IO4gTrW9yL1lAf
         9jqw==
X-Gm-Message-State: AFqh2krIrTd5YVvQcbRDrerzzndt2aRfcX58wUtuNoAdv3ZlT9HLWR8d
        Iqly8Mu9+gfBBLEhhlae9WhT0g==
X-Google-Smtp-Source: AMrXdXtxJ4pQtLh1AjPpCmF/cqOBjKw4pR1KqUwfWqyiLX85/FKtsWl9FBTI7SKwGJERspp/Lxrkjw==
X-Received: by 2002:ac5:cd58:0:b0:3d5:fa29:6249 with SMTP id n24-20020ac5cd58000000b003d5fa296249mr2974498vkm.16.1672925854013;
        Thu, 05 Jan 2023 05:37:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006fc2f74ad12sm25990304qkp.92.2023.01.05.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:37:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pDQR2-003PDq-De;
        Thu, 05 Jan 2023 09:37:32 -0400
Date:   Thu, 5 Jan 2023 09:37:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
Message-ID: <Y7bSnIT+vxjEX3w3@ziepe.ca>
References: <20230105223710.973148-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105223710.973148-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 05, 2023 at 05:37:10PM -0500, Zhu Yanjun wrote:
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
> V2->V3: Simplify the function by removing QP and CQ handling;
> V1->V2: Fix the build warning by adding a static;
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 97 +++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index f6973ea55eda..7028b8af87b9 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2912,6 +2912,102 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  	return ERR_PTR(err);
>  }
>  
> +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> +					      u64 len, u64 virt,
> +					      int fd, int access,
> +					      struct ib_udata *udata)
> +{
> +	struct irdma_device *iwdev = to_iwdev(pd->device);
> +	struct irdma_pble_alloc *palloc;
> +	struct irdma_pbl *iwpbl;
> +	struct irdma_mr *iwmr;
> +	u32 stag = 0;
> +	bool use_pbles = false;
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
> +	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
> +	if (!iwmr) {
> +		ib_umem_release(&umem_dmabuf->umem);
> +		return ERR_PTR(-ENOMEM);
> +	}

again, please don't duplicate all this code, refactor the mr code so
it can be shared.

Jason
