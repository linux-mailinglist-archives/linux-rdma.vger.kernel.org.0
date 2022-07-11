Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD256D6E3
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGKHfG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGKHfF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 03:35:05 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528BC1A05C;
        Mon, 11 Jul 2022 00:35:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VIyDJnm_1657524897;
Received: from 30.43.105.92(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VIyDJnm_1657524897)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 15:34:58 +0800
Message-ID: <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
Date:   Mon, 11 Jul 2022 15:34:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/9/22 1:37 AM, Christophe JAILLET wrote:
> Use [devm_]bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/erdma/erdma_cmdq.c | 7 +++----
>  drivers/infiniband/hw/erdma/erdma_main.c | 9 ++++-----
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 

Hi Christophe,

Thanks for your two patches of erdma.

The erdma code your got is our first upstreaming code, so I would like to squash your
changes into the relevant commit in our next patchset to make the commit history cleaner.

BTW, the coding style in the patches is OK, but has a little differences with clang-format's
result. I will use the format from clang-format to minimize manual adjustments.
 
Thanks,
Cheng Xu
 

> diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> index 0cf5032d4b78..0489838d9717 100644
> --- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
> +++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> @@ -78,10 +78,9 @@ static int erdma_cmdq_wait_res_init(struct erdma_dev *dev,
>  		return -ENOMEM;
>  
>  	spin_lock_init(&cmdq->lock);
> -	cmdq->comp_wait_bitmap =
> -		devm_kcalloc(&dev->pdev->dev,
> -			     BITS_TO_LONGS(cmdq->max_outstandings),
> -			     sizeof(unsigned long), GFP_KERNEL);
> +	cmdq->comp_wait_bitmap = devm_bitmap_zalloc(&dev->pdev->dev,
> +						    cmdq->max_outstandings,
> +						    GFP_KERNEL);
>  	if (!cmdq->comp_wait_bitmap) {
>  		devm_kfree(&dev->pdev->dev, cmdq->wait_pool);
>  		return -ENOMEM;
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> index 27484bea51d9..7e1e27acb404 100644
> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -423,9 +423,8 @@ static int erdma_res_cb_init(struct erdma_dev *dev)
>  	for (i = 0; i < ERDMA_RES_CNT; i++) {
>  		dev->res_cb[i].next_alloc_idx = 1;
>  		spin_lock_init(&dev->res_cb[i].lock);
> -		dev->res_cb[i].bitmap =
> -			kcalloc(BITS_TO_LONGS(dev->res_cb[i].max_cap),
> -				sizeof(unsigned long), GFP_KERNEL);
> +		dev->res_cb[i].bitmap = bitmap_zalloc(dev->res_cb[i].max_cap,
> +						      GFP_KERNEL);
>  		/* We will free the memory in erdma_res_cb_free */
>  		if (!dev->res_cb[i].bitmap)
>  			goto err;
> @@ -435,7 +434,7 @@ static int erdma_res_cb_init(struct erdma_dev *dev)
>  
>  err:
>  	for (j = 0; j < i; j++)
> -		kfree(dev->res_cb[j].bitmap);
> +		bitmap_free(dev->res_cb[j].bitmap);
>  
>  	return -ENOMEM;
>  }
> @@ -445,7 +444,7 @@ static void erdma_res_cb_free(struct erdma_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < ERDMA_RES_CNT; i++)
> -		kfree(dev->res_cb[i].bitmap);
> +		bitmap_free(dev->res_cb[i].bitmap);
>  }
>  
>  static const struct ib_device_ops erdma_device_ops = {
