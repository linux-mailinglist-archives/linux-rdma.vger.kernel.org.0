Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787BB6813C1
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 15:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjA3OuV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjA3OuU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 09:50:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A71E1F4
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 06:50:19 -0800 (PST)
Received: from [192.168.2.197] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 995E46602CFF;
        Mon, 30 Jan 2023 14:50:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675090218;
        bh=ibQoCtrC5IR8slzaYDDOugeFP/LewvHrc+4USqcyzTM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fofENOqKHlnCHP56xH0193OVWMcF2Fbi/KNGk9JtQOVe087I48GafJwSvyOnxsi1u
         cUhudmef5HBVNJy2cq9QFgUHH+Ziq9rPpcIICMvxxQ9M+gYzOdWdl3T0/Tu7xObmVq
         DbPDgO9gCplK2sqFdLZcOpC11FiLLO0p+0FVsOTEpdxg/hPvvNy6zhVTRA6DOgt4W7
         5kFa0sgi/A7Fe/yir0UItkTX/VqYP92G4nx9NiMHLhV8llzsRM3N69tgXYZSARuZf0
         UYc/eoWEnz0dy/t+aBIPLW1BhQzQ3gzCu1+OHJg0GE7twDnW+cuk6/jyKCERJwOdDF
         Mk9cX70cVvaXw==
Message-ID: <c872f49e-5522-d162-8360-093d7131ff9c@collabora.com>
Date:   Mon, 30 Jan 2023 17:50:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH rdma-rc] RDMA/umem: Use dma-buf locked API to solve
 deadlock
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-rdma@vger.kernel.org
References: <311c2cb791f8af75486df446819071357353db1b.1675088709.git.leon@kernel.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <311c2cb791f8af75486df446819071357353db1b.1675088709.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/30/23 17:25, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> The cited commit moves umem to call the unlocked versions of dmabuf
> unmap/map attachment, but the lock is held while calling to these
> functions, hence move back to the locked versions of these APIs.
> 
> Fixes: 21c9c5c0784f ("RDMA/umem: Prepare to dynamic dma-buf locking specification")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_dmabuf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> index 43b26bc12288..39357dc2d229 100644
> --- a/drivers/infiniband/core/umem_dmabuf.c
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -26,8 +26,8 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
>  	if (umem_dmabuf->sgt)
>  		goto wait_fence;
>  
> -	sgt = dma_buf_map_attachment_unlocked(umem_dmabuf->attach,
> -					      DMA_BIDIRECTIONAL);
> +	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
> +				     DMA_BIDIRECTIONAL);
>  	if (IS_ERR(sgt))
>  		return PTR_ERR(sgt);
>  
> @@ -103,8 +103,8 @@ void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf)
>  		umem_dmabuf->last_sg_trim = 0;
>  	}
>  
> -	dma_buf_unmap_attachment_unlocked(umem_dmabuf->attach, umem_dmabuf->sgt,
> -					  DMA_BIDIRECTIONAL);
> +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
> +				 DMA_BIDIRECTIONAL);
>  
>  	umem_dmabuf->sgt = NULL;
>  }

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

