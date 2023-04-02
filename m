Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED566D3824
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Apr 2023 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDBNwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Apr 2023 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBNwB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Apr 2023 09:52:01 -0400
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [IPv6:2001:41d0:203:375::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F97EEE
        for <linux-rdma@vger.kernel.org>; Sun,  2 Apr 2023 06:51:59 -0700 (PDT)
Message-ID: <020c55e0-0b6d-9807-b021-b0b99fa5dd92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680443515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2E9/WeVM4TGeNySCHOnz9KtvQ+UAFk8cP9H49XfTqQ=;
        b=RqXwaJ9KwXxMxFvENR17n3xXNJ1HoB57zjRdKnVODAaer2Vbny0f/H5+nYFkc4YrukjqVj
        vSSNR0nGOBv8oNrUZeenkusP5qpWHFlFxYQdyjutEylvYW0QKRBEP0masgVygdwiuqNNA2
        7JkNl+rj3Cbz20xiYovQFN3VKvD0D7E=
Date:   Sun, 2 Apr 2023 21:51:43 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Treat physical addresses right
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>
References: <20230329142341.863175-1-linus.walleij@linaro.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230329142341.863175-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/3/29 22:23, Linus Walleij 写道:
> Whenever the IB_MR_TYPE_DMA flag is set in imbr.type, the "iova"
> (I/O virtual address) is not really a virtual address but a physical
> address.
> 
> This means that the use of virt_to_page() on these addresses is also
> incorrect, this needs to be treated and converted to a page using
> the page frame number and pfn_to_page().
> 
> Fix up all users in this file.

It is better to have a summary to these 2 commits.
Anyway, thanks.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> 
> Fixes: 592627ccbdff ("RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray")
> Cc: Bob Pearson <rpearsonhpe@gmail.com>
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-rdma/ZB2s3GeaN%2FFBpR5K@nvidia.com/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - New patch prepended to patch set.
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index b10aa1580a64..8e8250652f9d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -279,16 +279,20 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>   	return 0;
>   }
>   
> -static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
> +/*
> + * This function is always called with a physical address as parameter,
> + * since DMA only operates on physical addresses.
> + */
> +static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 phys, void *addr,
>   			    unsigned int length, enum rxe_mr_copy_dir dir)
>   {
> -	unsigned int page_offset = iova & (PAGE_SIZE - 1);
> +	unsigned int page_offset = phys & (PAGE_SIZE - 1);
>   	unsigned int bytes;
>   	struct page *page;
>   	u8 *va;
>   
>   	while (length) {
> -		page = virt_to_page(iova & mr->page_mask);
> +		page = pfn_to_page(phys >> PAGE_SHIFT);
>   		bytes = min_t(unsigned int, length,
>   				PAGE_SIZE - page_offset);
>   		va = kmap_local_page(page);
> @@ -300,7 +304,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
>   
>   		kunmap_local(va);
>   		page_offset = 0;
> -		iova += bytes;
> +		phys += bytes;
>   		addr += bytes;
>   		length -= bytes;
>   	}
> @@ -487,8 +491,11 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   	}
>   
>   	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
> -		page_offset = iova & (PAGE_SIZE - 1);
> -		page = virt_to_page(iova & PAGE_MASK);
> +		/* In this case iova is a physical address */
> +		u64 phys = iova;
> +
> +		page_offset = phys & (PAGE_SIZE - 1);
> +		page = pfn_to_page(phys >> PAGE_SHIFT);
>   	} else {
>   		unsigned long index;
>   		int err;
> @@ -544,8 +551,11 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   	}
>   
>   	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
> -		page_offset = iova & (PAGE_SIZE - 1);
> -		page = virt_to_page(iova & PAGE_MASK);
> +		/* In this case iova is a physical address */
> +		u64 phys = iova;
> +
> +		page_offset = phys & (PAGE_SIZE - 1);
> +		page = pfn_to_page(phys >> PAGE_SHIFT);
>   	} else {
>   		unsigned long index;
>   		int err;

