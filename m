Return-Path: <linux-rdma+bounces-1422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783687AAF9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 17:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB7283429
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD63FB1E;
	Wed, 13 Mar 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPTeae3E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBA48790
	for <linux-rdma@vger.kernel.org>; Wed, 13 Mar 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346809; cv=none; b=EnV2worupiQ94YOUiuzFnSQj/fhYcC/9XMMTFuaCAOYjiWwRANi8OaRKJj1bw2NWsE1cBIQzIjl5QdHxccOKPX5s8Uhy9jwAY3+ykD9U7wq1Ie5YK535fcUbw+ZV1zzPukAZbYQf2lT46h9xHKJAs6Sj72IoRcf2xKwBTd2QOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346809; c=relaxed/simple;
	bh=xlZrtX1JBAbOWbuM3HEyWtokvDRNlFg3VvW7YifGnyE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D4e79S8mDNFE3c+LdiCrkWba45E/2qcgOV7LJ69Z/33Xd6pdSr5K8lGEB3CSbIrl6wEE6PPyAnXOYwgbIgzD+BqyvC0uiabiJOKou3vkddm20Sr94wdoKXRPM2gkQ42ZdMaxBKVY5/v8GaXs13ElVod+zgQRubq8GXYK5cF0isA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPTeae3E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-413ef6985bfso107405e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 Mar 2024 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710346805; x=1710951605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nT+HtsmQ+DTtvgKtQQLSlYwAT2QranI+8sGPxndB35c=;
        b=dPTeae3EbP4p81g6W7ZEa41X4GIbIl06+ZJjxPXqgOJTfemlqQULhbpDUqAYMDfaEO
         O8eM670/lSrYXMNFq5xejy+i3V8ADl/6hMMpZMr31Pl1p5reL+ygK9YSB1KurFDMPC18
         SPLj7/h9evdip+XRD/bY1oaQnE5DpkHHi2xd83V/0w286NjwO126aOkGHSZAkumw0jUW
         HKWy8EenfYrFpyGy/KlZd04aAXWzjglW71o90+QFcV5YBCV40lMyuLQ7OC6lg+BWQrp4
         5CbMsOF2uAlXPsg51kYHZXIcFEEzAU2uwK8Fu6Yf1ogoytYx+bPMSwYy7witWtJbNt6j
         P+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710346805; x=1710951605;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT+HtsmQ+DTtvgKtQQLSlYwAT2QranI+8sGPxndB35c=;
        b=jkDA5nubuOoSu1fLoI/AFe7MR9va0biVCuP8OA2yetjeBBlR41LqsGFTt9v0Odut7t
         09jDK1JQe3r5AVKXDV1sHd6CpmO2tXxPlxoY305HxoFPLG6TE1JdZmK1w9loIXQH16/h
         d4PIbIPijq8ZuQy79hHwWIZdn3am15MK6T3Z0MDQmoRfnMW+lx8lPYV6KYIQOWTg8Stc
         QCxMFfUqlkqXELm8wNktkE/G4WceeNrFU4roLlKL3ualzmEwtq+6utId868PaPneAqdO
         kVRLZ2xLNL2L6AeQEfizdbVSCAvPjW2GW/HwhO+4qnbFPWImLBN9IPwXzSWlE6wOtS23
         6X6A==
X-Gm-Message-State: AOJu0Yx+Wi25klOWIcTA5Waurmrx5FmbQfdhB+DgPd/WkLCFkaTYIwYh
	uBvHVHvmfgKPZL5OtyGGEMt/QHglLPb++O7Mfrh4bZMDrfoCANf1
X-Google-Smtp-Source: AGHT+IG/hyIxMvt6bpWh6Z+ETDJTA4IWmFaZ5KP2iTsw14aCnd6igwD8dj1CEpWlGSNp49kt42MiuQ==
X-Received: by 2002:a05:600c:4f91:b0:413:ea5c:1b08 with SMTP id n17-20020a05600c4f9100b00413ea5c1b08mr284101wmq.40.1710346804926;
        Wed, 13 Mar 2024 09:20:04 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413ea26f942sm2268530wmq.14.2024.03.13.09.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:20:04 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <09da3e92-3da5-405a-9f55-60533e966f09@linux.dev>
Date: Wed, 13 Mar 2024 17:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] RDMA/erdma: Allocate doorbell records from
 dma pool
Content-Language: en-US
To: Boshi Yu <boshiyu@alibaba-inc.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
 KaiShen@linux.alibaba.com
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
 <20240311113821.22482-2-boshiyu@alibaba-inc.com>
In-Reply-To: <20240311113821.22482-2-boshiyu@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.24 12:38, Boshi Yu wrote:
> From: Boshi Yu <boshiyu@linux.alibaba.com>
> 
> Currently, the 8 byte doorbell record is allocated along with the queue
> buffer, which may result in waste of dma space when the queue buffer is
> page aligned. To address this issue, we introduce a dma pool named
> db_pool and allocate doorbell record from it.
> 
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> ---
>   drivers/infiniband/hw/erdma/erdma.h       |   7 +-
>   drivers/infiniband/hw/erdma/erdma_cmdq.c  | 102 +++++++++++++---------
>   drivers/infiniband/hw/erdma/erdma_eq.c    |  55 +++++++-----
>   drivers/infiniband/hw/erdma/erdma_main.c  |  15 +++-
>   drivers/infiniband/hw/erdma/erdma_verbs.c |  85 ++++++++++--------
>   drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +
>   6 files changed, 167 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
> index 5df401a30cb9..e116263a608f 100644
> --- a/drivers/infiniband/hw/erdma/erdma.h
> +++ b/drivers/infiniband/hw/erdma/erdma.h
> @@ -34,6 +34,7 @@ struct erdma_eq {
>   
>   	void __iomem *db;
>   	u64 *db_record;
> +	dma_addr_t db_record_dma_addr;
>   };
>   
>   struct erdma_cmdq_sq {
> @@ -49,6 +50,7 @@ struct erdma_cmdq_sq {
>   	u16 wqebb_cnt;
>   
>   	u64 *db_record;
> +	dma_addr_t db_record_dma_addr;
>   };
>   
>   struct erdma_cmdq_cq {
> @@ -62,6 +64,7 @@ struct erdma_cmdq_cq {
>   	u32 cmdsn;
>   
>   	u64 *db_record;
> +	dma_addr_t db_record_dma_addr;
>   
>   	atomic64_t armed_num;
>   };
> @@ -177,9 +180,6 @@ enum {
>   	ERDMA_RES_CNT = 2,
>   };
>   
> -#define ERDMA_EXTRA_BUFFER_SIZE ERDMA_DB_SIZE
> -#define WARPPED_BUFSIZE(size) ((size) + ERDMA_EXTRA_BUFFER_SIZE)
> -
>   struct erdma_dev {
>   	struct ib_device ibdev;
>   	struct net_device *netdev;
> @@ -213,6 +213,7 @@ struct erdma_dev {
>   	atomic_t num_ctx;
>   	struct list_head cep_list;
>   
> +	struct dma_pool *db_pool;
>   	struct dma_pool *resp_pool;
>   };
>   
> diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> index a151a7bdd504..c2c666040949 100644
> --- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
> +++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> @@ -89,20 +89,19 @@ static int erdma_cmdq_sq_init(struct erdma_dev *dev)
>   {
>   	struct erdma_cmdq *cmdq = &dev->cmdq;
>   	struct erdma_cmdq_sq *sq = &cmdq->sq;
> -	u32 buf_size;
>   
>   	sq->wqebb_cnt = SQEBB_COUNT(ERDMA_CMDQ_SQE_SIZE);
>   	sq->depth = cmdq->max_outstandings * sq->wqebb_cnt;
>   
> -	buf_size = sq->depth << SQEBB_SHIFT;
> -
> -	sq->qbuf =
> -		dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
> -				   &sq->qbuf_dma_addr, GFP_KERNEL);
> +	sq->qbuf = dma_alloc_coherent(&dev->pdev->dev, sq->depth << SQEBB_SHIFT,
> +				      &sq->qbuf_dma_addr, GFP_KERNEL);
>   	if (!sq->qbuf)
>   		return -ENOMEM;
>   
> -	sq->db_record = (u64 *)(sq->qbuf + buf_size);
> +	sq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
> +					&sq->db_record_dma_addr);
> +	if (!sq->db_record)
> +		goto err_out;
>   
>   	spin_lock_init(&sq->lock);
>   
> @@ -112,29 +111,35 @@ static int erdma_cmdq_sq_init(struct erdma_dev *dev)
>   			  lower_32_bits(sq->qbuf_dma_addr));
>   	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_DEPTH_REG, sq->depth);
>   	erdma_reg_write64(dev, ERDMA_CMDQ_SQ_DB_HOST_ADDR_REG,
> -			  sq->qbuf_dma_addr + buf_size);
> +			  sq->db_record_dma_addr);
>   
>   	return 0;
> +
> +err_out:
> +	dma_free_coherent(&dev->pdev->dev, sq->depth << SQEBB_SHIFT,
> +			  sq->qbuf, sq->qbuf_dma_addr);
> +
> +	return -ENOMEM;
>   }
>   
>   static int erdma_cmdq_cq_init(struct erdma_dev *dev)
>   {
>   	struct erdma_cmdq *cmdq = &dev->cmdq;
>   	struct erdma_cmdq_cq *cq = &cmdq->cq;
> -	u32 buf_size;
>   
>   	cq->depth = cmdq->sq.depth;
> -	buf_size = cq->depth << CQE_SHIFT;
> -
> -	cq->qbuf =
> -		dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
> -				   &cq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
> +	cq->qbuf = dma_alloc_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
> +				      &cq->qbuf_dma_addr,
> +				      GFP_KERNEL | __GFP_ZERO);

<...>

>   	if (!cq->qbuf)
>   		return -ENOMEM;
>   
>   	spin_lock_init(&cq->lock);
>   
> -	cq->db_record = (u64 *)(cq->qbuf + buf_size);
> +	cq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
> +					&cq->db_record_dma_addr);
> +	if (!cq->db_record)
> +		goto err_out;
>   
>   	atomic64_set(&cq->armed_num, 0);
>   
> @@ -143,23 +148,26 @@ static int erdma_cmdq_cq_init(struct erdma_dev *dev)
>   	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_CQ_ADDR_L_REG,
>   			  lower_32_bits(cq->qbuf_dma_addr));
>   	erdma_reg_write64(dev, ERDMA_CMDQ_CQ_DB_HOST_ADDR_REG,
> -			  cq->qbuf_dma_addr + buf_size);
> +			  cq->db_record_dma_addr);
>   
>   	return 0;
> +
> +err_out:
> +	dma_free_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT, cq->qbuf,
> +			  cq->qbuf_dma_addr);
> +
> +	return -ENOMEM;
>   }
>   
>   static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>   {
>   	struct erdma_cmdq *cmdq = &dev->cmdq;
>   	struct erdma_eq *eq = &cmdq->eq;
> -	u32 buf_size;
>   
>   	eq->depth = cmdq->max_outstandings;
> -	buf_size = eq->depth << EQE_SHIFT;
> -
> -	eq->qbuf =
> -		dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
> -				   &eq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
> +	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> +				      &eq->qbuf_dma_addr,
> +				      GFP_KERNEL | __GFP_ZERO);
<...>
>   	if (!eq->qbuf)
>   		return -ENOMEM;
>   
> @@ -167,7 +175,10 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>   	atomic64_set(&eq->event_num, 0);
>   
>   	eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG;
> -	eq->db_record = (u64 *)(eq->qbuf + buf_size);
> +	eq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
> +					&eq->db_record_dma_addr);
> +	if (!eq->db_record)
> +		goto err_out;
>   
>   	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_ADDR_H_REG,
>   			  upper_32_bits(eq->qbuf_dma_addr));
> @@ -175,9 +186,15 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>   			  lower_32_bits(eq->qbuf_dma_addr));
>   	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_DEPTH_REG, eq->depth);
>   	erdma_reg_write64(dev, ERDMA_CMDQ_EQ_DB_HOST_ADDR_REG,
> -			  eq->qbuf_dma_addr + buf_size);
> +			  eq->db_record_dma_addr);
>   
>   	return 0;
> +
> +err_out:
> +	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
> +			  eq->qbuf_dma_addr);
> +
> +	return -ENOMEM;
>   }
>   
>   int erdma_cmdq_init(struct erdma_dev *dev)
> @@ -211,17 +228,19 @@ int erdma_cmdq_init(struct erdma_dev *dev)
>   	return 0;
>   
>   err_destroy_cq:
> -	dma_free_coherent(&dev->pdev->dev,
> -			  (cmdq->cq.depth << CQE_SHIFT) +
> -				  ERDMA_EXTRA_BUFFER_SIZE,
> +	dma_free_coherent(&dev->pdev->dev, cmdq->cq.depth << CQE_SHIFT,
>   			  cmdq->cq.qbuf, cmdq->cq.qbuf_dma_addr);
>   
> +	dma_pool_free(dev->db_pool, cmdq->cq.db_record,
> +		      cmdq->cq.db_record_dma_addr);
> +
>   err_destroy_sq:
> -	dma_free_coherent(&dev->pdev->dev,
> -			  (cmdq->sq.depth << SQEBB_SHIFT) +
> -				  ERDMA_EXTRA_BUFFER_SIZE,
> +	dma_free_coherent(&dev->pdev->dev, cmdq->sq.depth << SQEBB_SHIFT,
>   			  cmdq->sq.qbuf, cmdq->sq.qbuf_dma_addr);
>   
> +	dma_pool_free(dev->db_pool, cmdq->sq.db_record,
> +		      cmdq->sq.db_record_dma_addr);
> +
>   	return err;
>   }
>   
> @@ -238,18 +257,23 @@ void erdma_cmdq_destroy(struct erdma_dev *dev)
>   
>   	clear_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
>   
> -	dma_free_coherent(&dev->pdev->dev,
> -			  (cmdq->eq.depth << EQE_SHIFT) +
> -				  ERDMA_EXTRA_BUFFER_SIZE,
> +	dma_free_coherent(&dev->pdev->dev, cmdq->eq.depth << EQE_SHIFT,
>   			  cmdq->eq.qbuf, cmdq->eq.qbuf_dma_addr);
> -	dma_free_coherent(&dev->pdev->dev,
> -			  (cmdq->sq.depth << SQEBB_SHIFT) +
> -				  ERDMA_EXTRA_BUFFER_SIZE,
> +
> +	dma_pool_free(dev->db_pool, cmdq->eq.db_record,
> +		      cmdq->eq.db_record_dma_addr);
> +
> +	dma_free_coherent(&dev->pdev->dev, cmdq->sq.depth << SQEBB_SHIFT,
>   			  cmdq->sq.qbuf, cmdq->sq.qbuf_dma_addr);
> -	dma_free_coherent(&dev->pdev->dev,
> -			  (cmdq->cq.depth << CQE_SHIFT) +
> -				  ERDMA_EXTRA_BUFFER_SIZE,
> +
> +	dma_pool_free(dev->db_pool, cmdq->sq.db_record,
> +		      cmdq->sq.db_record_dma_addr);
> +
> +	dma_free_coherent(&dev->pdev->dev, cmdq->cq.depth << CQE_SHIFT,
>   			  cmdq->cq.qbuf, cmdq->cq.qbuf_dma_addr);
> +
> +	dma_pool_free(dev->db_pool, cmdq->cq.db_record,
> +		      cmdq->cq.db_record_dma_addr);
>   }
>   
>   static void *get_next_valid_cmdq_cqe(struct erdma_cmdq *cmdq)
> diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
> index ea47cb21fdb8..809c33628f38 100644
> --- a/drivers/infiniband/hw/erdma/erdma_eq.c
> +++ b/drivers/infiniband/hw/erdma/erdma_eq.c
> @@ -83,14 +83,12 @@ void erdma_aeq_event_handler(struct erdma_dev *dev)
>   int erdma_aeq_init(struct erdma_dev *dev)
>   {
>   	struct erdma_eq *eq = &dev->aeq;
> -	u32 buf_size;
>   
>   	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
> -	buf_size = eq->depth << EQE_SHIFT;
>   
> -	eq->qbuf =
> -		dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
> -				   &eq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
> +	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> +				      &eq->qbuf_dma_addr,
> +				      GFP_KERNEL | __GFP_ZERO);

<...>

>   	if (!eq->qbuf)
>   		return -ENOMEM;
>   
> @@ -99,7 +97,10 @@ int erdma_aeq_init(struct erdma_dev *dev)
>   	atomic64_set(&eq->notify_num, 0);
>   
>   	eq->db = dev->func_bar + ERDMA_REGS_AEQ_DB_REG;
> -	eq->db_record = (u64 *)(eq->qbuf + buf_size);
> +	eq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
> +					&eq->db_record_dma_addr);
> +	if (!eq->db_record)
> +		goto err_out;
>   
>   	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG,
>   			  upper_32_bits(eq->qbuf_dma_addr));
> @@ -107,18 +108,25 @@ int erdma_aeq_init(struct erdma_dev *dev)
>   			  lower_32_bits(eq->qbuf_dma_addr));
>   	erdma_reg_write32(dev, ERDMA_REGS_AEQ_DEPTH_REG, eq->depth);
>   	erdma_reg_write64(dev, ERDMA_AEQ_DB_HOST_ADDR_REG,
> -			  eq->qbuf_dma_addr + buf_size);
> +			  eq->db_record_dma_addr);
>   
>   	return 0;
> +
> +err_out:
> +	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
> +			  eq->qbuf_dma_addr);
> +
> +	return -ENOMEM;
>   }
>   
>   void erdma_aeq_destroy(struct erdma_dev *dev)
>   {
>   	struct erdma_eq *eq = &dev->aeq;
>   
> -	dma_free_coherent(&dev->pdev->dev,
> -			  WARPPED_BUFSIZE(eq->depth << EQE_SHIFT), eq->qbuf,
> +	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
>   			  eq->qbuf_dma_addr);
> +
> +	dma_pool_free(dev->db_pool, eq->db_record, eq->db_record_dma_addr);
>   }
>   
>   void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb)
> @@ -209,7 +217,6 @@ static void erdma_free_ceq_irq(struct erdma_dev *dev, u16 ceqn)
>   static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
>   {
>   	struct erdma_cmdq_create_eq_req req;
> -	dma_addr_t db_info_dma_addr;
>   
>   	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
>   				CMDQ_OPCODE_CREATE_EQ);
> @@ -219,9 +226,8 @@ static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
>   	req.qtype = ERDMA_EQ_TYPE_CEQ;
>   	/* Vector index is the same as EQN. */
>   	req.vector_idx = eqn;
> -	db_info_dma_addr = eq->qbuf_dma_addr + (eq->depth << EQE_SHIFT);
> -	req.db_dma_addr_l = lower_32_bits(db_info_dma_addr);
> -	req.db_dma_addr_h = upper_32_bits(db_info_dma_addr);
> +	req.db_dma_addr_l = lower_32_bits(eq->db_record_dma_addr);
> +	req.db_dma_addr_h = upper_32_bits(eq->db_record_dma_addr);
>   
>   	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
>   }
> @@ -229,12 +235,12 @@ static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
>   static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
>   {
>   	struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
> -	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
>   	int ret;
>   
> -	eq->qbuf =
> -		dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
> -				   &eq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
> +	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
> +	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> +				      &eq->qbuf_dma_addr,
> +				      GFP_KERNEL | __GFP_ZERO);

The patch in this link 
(https://lore.kernel.org/all/20181214082515.14835-1-hch@lst.de/T/#m70c723c646004445713f31b7837f7e9d910c06f5) 
makes sure that dma_alloc_coherent(xxx) always returns zeroed memory.

So __GFP_ZERO is necessary? can we remove them?

Zhu Yanjun

>   	if (!eq->qbuf)
>   		return -ENOMEM;
>   
> @@ -242,10 +248,17 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
>   	atomic64_set(&eq->event_num, 0);
>   	atomic64_set(&eq->notify_num, 0);
>   
> -	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>   	eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG +
>   		 (ceqn + 1) * ERDMA_DB_SIZE;
> -	eq->db_record = (u64 *)(eq->qbuf + buf_size);
> +
> +	eq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
> +					&eq->db_record_dma_addr);
> +	if (!eq->db_record) {
> +		dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> +				  eq->qbuf, eq->qbuf_dma_addr);
> +		return -ENOMEM;
> +	}
> +
>   	eq->ci = 0;
>   	dev->ceqs[ceqn].dev = dev;
>   
> @@ -259,7 +272,6 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
>   static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
>   {
>   	struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
> -	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
>   	struct erdma_cmdq_destroy_eq_req req;
>   	int err;
>   
> @@ -276,8 +288,9 @@ static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
>   	if (err)
>   		return;
>   
> -	dma_free_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size), eq->qbuf,
> +	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
>   			  eq->qbuf_dma_addr);
> +	dma_pool_free(dev->db_pool, eq->db_record, eq->db_record_dma_addr);
>   }
>   
>   int erdma_ceqs_init(struct erdma_dev *dev)
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> index 472939172f0c..7080f8a71ec4 100644
> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -178,16 +178,26 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
>   	if (!dev->resp_pool)
>   		return -ENOMEM;
>   
> +	dev->db_pool = dma_pool_create("erdma_db_pool", &pdev->dev,
> +				       ERDMA_DB_SIZE, ERDMA_DB_SIZE, 0);
> +	if (!dev->db_pool) {
> +		ret = -ENOMEM;
> +		goto destroy_resp_pool;
> +	}
> +
>   	ret = dma_set_mask_and_coherent(&pdev->dev,
>   					DMA_BIT_MASK(ERDMA_PCI_WIDTH));
>   	if (ret)
> -		goto destroy_pool;
> +		goto destroy_db_pool;
>   
>   	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
>   
>   	return 0;
>   
> -destroy_pool:
> +destroy_db_pool:
> +	dma_pool_destroy(dev->db_pool);
> +
> +destroy_resp_pool:
>   	dma_pool_destroy(dev->resp_pool);
>   
>   	return ret;
> @@ -195,6 +205,7 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
>   
>   static void erdma_device_uninit(struct erdma_dev *dev)
>   {
> +	dma_pool_destroy(dev->db_pool);
>   	dma_pool_destroy(dev->resp_pool);
>   }
>   
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 23dfc01603f8..b78ddca1483e 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -76,10 +76,8 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
>   
>   		req.rq_buf_addr = qp->kern_qp.rq_buf_dma_addr;
>   		req.sq_buf_addr = qp->kern_qp.sq_buf_dma_addr;
> -		req.sq_db_info_dma_addr = qp->kern_qp.sq_buf_dma_addr +
> -					  (qp->attrs.sq_size << SQEBB_SHIFT);
> -		req.rq_db_info_dma_addr = qp->kern_qp.rq_buf_dma_addr +
> -					  (qp->attrs.rq_size << RQE_SHIFT);
> +		req.sq_db_info_dma_addr = qp->kern_qp.sq_db_info_dma_addr;
> +		req.rq_db_info_dma_addr = qp->kern_qp.rq_db_info_dma_addr;
>   	} else {
>   		user_qp = &qp->user_qp;
>   		req.sq_cqn_mtt_cfg = FIELD_PREP(
> @@ -209,8 +207,7 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
>   				       ERDMA_MR_MTT_0LEVEL);
>   
>   		req.first_page_offset = 0;
> -		req.cq_db_info_addr =
> -			cq->kern_cq.qbuf_dma_addr + (cq->depth << CQE_SHIFT);
> +		req.cq_db_info_addr = cq->kern_cq.db_record_dma_addr;
>   	} else {
>   		mem = &cq->user_cq.qbuf_mem;
>   		req.cfg0 |=
> @@ -482,16 +479,24 @@ static void free_kernel_qp(struct erdma_qp *qp)
>   	vfree(qp->kern_qp.rwr_tbl);
>   
>   	if (qp->kern_qp.sq_buf)
> -		dma_free_coherent(
> -			&dev->pdev->dev,
> -			WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
> -			qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
> +		dma_free_coherent(&dev->pdev->dev,
> +				  qp->attrs.sq_size << SQEBB_SHIFT,
> +				  qp->kern_qp.sq_buf,
> +				  qp->kern_qp.sq_buf_dma_addr);
> +
> +	if (qp->kern_qp.sq_db_info)
> +		dma_pool_free(dev->db_pool, qp->kern_qp.sq_db_info,
> +			      qp->kern_qp.sq_db_info_dma_addr);
>   
>   	if (qp->kern_qp.rq_buf)
> -		dma_free_coherent(
> -			&dev->pdev->dev,
> -			WARPPED_BUFSIZE(qp->attrs.rq_size << RQE_SHIFT),
> -			qp->kern_qp.rq_buf, qp->kern_qp.rq_buf_dma_addr);
> +		dma_free_coherent(&dev->pdev->dev,
> +				  qp->attrs.rq_size << RQE_SHIFT,
> +				  qp->kern_qp.rq_buf,
> +				  qp->kern_qp.rq_buf_dma_addr);
> +
> +	if (qp->kern_qp.rq_db_info)
> +		dma_pool_free(dev->db_pool, qp->kern_qp.rq_db_info,
> +			      qp->kern_qp.rq_db_info_dma_addr);
>   }
>   
>   static int init_kernel_qp(struct erdma_dev *dev, struct erdma_qp *qp,
> @@ -516,20 +521,27 @@ static int init_kernel_qp(struct erdma_dev *dev, struct erdma_qp *qp,
>   	if (!kqp->swr_tbl || !kqp->rwr_tbl)
>   		goto err_out;
>   
> -	size = (qp->attrs.sq_size << SQEBB_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
> +	size = qp->attrs.sq_size << SQEBB_SHIFT;
>   	kqp->sq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
>   					 &kqp->sq_buf_dma_addr, GFP_KERNEL);
>   	if (!kqp->sq_buf)
>   		goto err_out;
>   
> -	size = (qp->attrs.rq_size << RQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
> +	kqp->sq_db_info = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
> +					  &kqp->sq_db_info_dma_addr);
> +	if (!kqp->sq_db_info)
> +		goto err_out;
> +
> +	size = qp->attrs.rq_size << RQE_SHIFT;
>   	kqp->rq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
>   					 &kqp->rq_buf_dma_addr, GFP_KERNEL);
>   	if (!kqp->rq_buf)
>   		goto err_out;
>   
> -	kqp->sq_db_info = kqp->sq_buf + (qp->attrs.sq_size << SQEBB_SHIFT);
> -	kqp->rq_db_info = kqp->rq_buf + (qp->attrs.rq_size << RQE_SHIFT);
> +	kqp->rq_db_info = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
> +					  &kqp->rq_db_info_dma_addr);
> +	if (!kqp->rq_db_info)
> +		goto err_out;
>   
>   	return 0;
>   
> @@ -1237,9 +1249,10 @@ int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>   		return err;
>   
>   	if (rdma_is_kernel_res(&cq->ibcq.res)) {
> -		dma_free_coherent(&dev->pdev->dev,
> -				  WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
> +		dma_free_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
>   				  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
> +		dma_pool_free(dev->db_pool, cq->kern_cq.db_record,
> +			      cq->kern_cq.db_record_dma_addr);
>   	} else {
>   		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
>   		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
> @@ -1279,16 +1292,7 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   	wait_for_completion(&qp->safe_free);
>   
>   	if (rdma_is_kernel_res(&qp->ibqp.res)) {
> -		vfree(qp->kern_qp.swr_tbl);
> -		vfree(qp->kern_qp.rwr_tbl);
> -		dma_free_coherent(
> -			&dev->pdev->dev,
> -			WARPPED_BUFSIZE(qp->attrs.rq_size << RQE_SHIFT),
> -			qp->kern_qp.rq_buf, qp->kern_qp.rq_buf_dma_addr);
> -		dma_free_coherent(
> -			&dev->pdev->dev,
> -			WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
> -			qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
> +		free_kernel_qp(qp);
>   	} else {
>   		put_mtt_entries(dev, &qp->user_qp.sq_mem);
>   		put_mtt_entries(dev, &qp->user_qp.rq_mem);
> @@ -1600,19 +1604,27 @@ static int erdma_init_kernel_cq(struct erdma_cq *cq)
>   	struct erdma_dev *dev = to_edev(cq->ibcq.device);
>   
>   	cq->kern_cq.qbuf =
> -		dma_alloc_coherent(&dev->pdev->dev,
> -				   WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
> +		dma_alloc_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
>   				   &cq->kern_cq.qbuf_dma_addr, GFP_KERNEL);
>   	if (!cq->kern_cq.qbuf)
>   		return -ENOMEM;
>   
> -	cq->kern_cq.db_record =
> -		(u64 *)(cq->kern_cq.qbuf + (cq->depth << CQE_SHIFT));
> +	cq->kern_cq.db_record = dma_pool_zalloc(
> +		dev->db_pool, GFP_KERNEL, &cq->kern_cq.db_record_dma_addr);
> +	if (!cq->kern_cq.db_record)
> +		goto err_out;
> +
>   	spin_lock_init(&cq->kern_cq.lock);
>   	/* use default cqdb addr */
>   	cq->kern_cq.db = dev->func_bar + ERDMA_BAR_CQDB_SPACE_OFFSET;
>   
>   	return 0;
> +
> +err_out:
> +	dma_free_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
> +			  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
> +
> +	return -ENOMEM;
>   }
>   
>   int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> @@ -1676,9 +1688,10 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
>   		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
>   	} else {
> -		dma_free_coherent(&dev->pdev->dev,
> -				  WARPPED_BUFSIZE(depth << CQE_SHIFT),
> +		dma_free_coherent(&dev->pdev->dev, depth << CQE_SHIFT,
>   				  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
> +		dma_pool_free(dev->db_pool, cq->kern_cq.db_record,
> +			      cq->kern_cq.db_record_dma_addr);
>   	}
>   
>   err_out_xa:
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
> index db6018529ccc..b02ffdc8c811 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.h
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
> @@ -170,6 +170,9 @@ struct erdma_kqp {
>   	void *sq_db_info;
>   	void *rq_db_info;
>   
> +	dma_addr_t sq_db_info_dma_addr;
> +	dma_addr_t rq_db_info_dma_addr;
> +
>   	u8 sig_all;
>   };
>   
> @@ -247,6 +250,7 @@ struct erdma_kcq_info {
>   	spinlock_t lock;
>   	u8 __iomem *db;
>   	u64 *db_record;
> +	dma_addr_t db_record_dma_addr;
>   };
>   
>   struct erdma_ucq_info {


