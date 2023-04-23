Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4FB6EBC80
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Apr 2023 04:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjDWC4m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Apr 2023 22:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDWC4l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Apr 2023 22:56:41 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [95.215.58.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F452132
        for <linux-rdma@vger.kernel.org>; Sat, 22 Apr 2023 19:56:39 -0700 (PDT)
Message-ID: <58a984d3-a89d-89d4-2491-a559bc8b1076@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682218598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dgL3xDEkr6o6FRjE7kxu44l06Ma5AgulZJtHgzYbLM=;
        b=Q7m1T9YsWl4Y5ORRjicXCwxB8qgnMV8rW0ao/MMqnGtjS/1xpC04DP0cpOg/8PZWz6HR9e
        aqaE9qWi/pMPNbDmkT56zCKn0NGohsQj1+mLYtklDWTJT0dhfomnfGm2xzsAwpNIpr2g3U
        od8Oirq5s7ybLp19iol11dEW46qadf0=
Date:   Sun, 23 Apr 2023 10:56:30 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH for-next v2 2/3] RDMA/rtrs: Fix the last iu->buf leak in
 err path
To:     Li Zhijian <lizhijian@fujitsu.com>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
 <1682213212-2-3-git-send-email-lizhijian@fujitsu.com>
Content-Language: en-US
In-Reply-To: <1682213212-2-3-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/23/23 09:26, Li Zhijian wrote:
> The last iu->buf will leak if ib_dma_mapping_error() fails.

Fixes: c0894b3ea69d("RDMA/rtrs: core: lib functions shared between 
client and server modules")

> Signed-off-by: Li Zhijian<lizhijian@fujitsu.com>
> ---
> V2: new patch to address memory leaking
> ---
>   drivers/infiniband/ulp/rtrs/rtrs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index 4bf9d868cc52..3696f367ff51 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -37,8 +37,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 iu_num, size_t size, gfp_t gfp_mask,
>   			goto err;
>   
>   		iu->dma_addr = ib_dma_map_single(dma_dev, iu->buf, size, dir);
> -		if (ib_dma_mapping_error(dma_dev, iu->dma_addr))
> +		if (ib_dma_mapping_error(dma_dev, iu->dma_addr)) {
> +			kfree(iu->buf);
>   			goto err;
> +		}
>   
>   		iu->cqe.done  = done;
>   		iu->size      = size;

Good catch, Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
