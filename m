Return-Path: <linux-rdma+bounces-1429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8F87BB32
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4951C20D10
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F76E611;
	Thu, 14 Mar 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9iLQAK+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5B6D1B5
	for <linux-rdma@vger.kernel.org>; Thu, 14 Mar 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411826; cv=none; b=EQzMIgTMrH97vW9KkvZVVbQp2K276wb+sBcJAYN1BykSqP987GTfaFb7NzjNYDL52WOGJ86LxphjLh+ZMMi6CvCYNTxRO6BAXg5Exu5VDIV846LNiAK2SOdZWmiPHJGcX5LZMwVnM3b5oHyW5AP4OwBJhN/4kwzlhRnyYhVy6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411826; c=relaxed/simple;
	bh=H+OuDHWK3f7yY8aA7YBgn6zfwTAtFlyJXs73B8oHTQI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uUNcZnxYduEQWMmcuy524qLu6ErYIIFGkD5fm/lgwFQnK9ijoAUaT+HwcT+0+RNmEHfQRqhLe5b8uDdnQMf3o0Z/jA5qXqQIxIVQX6rL42KkDxgIT3UIwG6S3tJLDqTgNFCL/Y5YOviTGbJuZuiBx9U+4ClHpst918wUPz22ewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9iLQAK+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-413e93b0f54so5182345e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 Mar 2024 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710411822; x=1711016622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BI8ATlYlIh+LYBrC0DBoDqcuFflNgMrPozl0FyWqtC4=;
        b=A9iLQAK+8bB7n3co+/BUk7IDx8OVZwRv6aKW91XWo0y2RkiqRDpzuBLxCYAY2IGFVi
         CIOn8BZRRP3nPzm9E0pXFaUbYVKyD7JDTMM7Hto5Cz4EV+9+/Rd0GYYRLIbpQJKYXFNV
         elnY4fKXpaCyXlrZCb8bMkdVww46ozVy91YcDqFj+NJsXzPvUICEHpeY7RveHsssKpkk
         wrjTzPMy1V0Z6FvlF9zhZisdp4BVWUeAZ3weSwfeWNQm+D1qevm9swpYQ2uE/stSihKX
         htx1MgFsgqxyELU9zaqVzmJoOtSng39PpirCXCLihR4MyBKDmvku8mu4+RnU3k4CjG3W
         gRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710411822; x=1711016622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI8ATlYlIh+LYBrC0DBoDqcuFflNgMrPozl0FyWqtC4=;
        b=kuAkyjoqSvKUT6Tf9n8cmLixz2AOgpdpaT/k8YJJKPX3fKG97swmk1Uf+JjFPN7gSQ
         UQ6JxL9OZZjxKc8XxT2l4X5Y30KxPgYqih0sb85XQ6MrvlgMPa/VR01SQ5UdWdvRaea6
         acY934M2ASwdDKypfRnkfptrEgYuAYccFCbGqJGs8ssynOH3SFZiSKa3zTJg9R7bQ3k6
         KEhRI6D52MgsOWpLsw67FwbmzQ7KNUvhVlEuvR2xQoIHGhPxi6CZ6Wk7E8No/op+ftOP
         LyY3mBdvDviKPEGx0W1lsvtJQHFM/+3FUeHa4KC301eguYNGtuLmeeKAka8UNM5Z8u+K
         FigQ==
X-Gm-Message-State: AOJu0Yyo3X5BgI23oiX1mGMNbW/atMznUrt8wo/4zNdJBAC5eos2y1Df
	Ejo+gBoFFs7ToiUowpN4l1+UToiO65SAEeyD64hZCWKV9/2IYVGqb5FjDmmAaU/4P3Xx
X-Google-Smtp-Source: AGHT+IHEvtxjCS2n7lM9kS20NHVkWGyfzMhQHBlesUUQRwbANckoDVtU0bG34aCy739GcyBu1VfZ0A==
X-Received: by 2002:a05:600c:5409:b0:412:de1f:dd23 with SMTP id he9-20020a05600c540900b00412de1fdd23mr1045769wmb.7.1710411821932;
        Thu, 14 Mar 2024 03:23:41 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c4e0500b00413f8d50199sm208967wmq.10.2024.03.14.03.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 03:23:41 -0700 (PDT)
Message-ID: <2ee0f7b0-21fc-43d2-a126-850e73ff84fd@gmail.com>
Date: Thu, 14 Mar 2024 11:23:40 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] RDMA/erdma: Allocate doorbell records from
 dma pool
From: Zhu Yanjun <zyjzyj2000@gmail.com>
To: Boshi Yu <boshiyu@alibaba-inc.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
 KaiShen@linux.alibaba.com
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
 <20240311113821.22482-2-boshiyu@alibaba-inc.com>
 <09da3e92-3da5-405a-9f55-60533e966f09@linux.dev>
Content-Language: en-US
In-Reply-To: <09da3e92-3da5-405a-9f55-60533e966f09@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.03.24 17:20, Zhu Yanjun wrote:
> On 11.03.24 12:38, Boshi Yu wrote:
>> From: Boshi Yu <boshiyu@linux.alibaba.com>
>>
>> Currently, the 8 byte doorbell record is allocated along with the queue
>> buffer, which may result in waste of dma space when the queue buffer is
>> page aligned. To address this issue, we introduce a dma pool named
>> db_pool and allocate doorbell record from it.
>>
>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/erdma.h       |   7 +-
>>   drivers/infiniband/hw/erdma/erdma_cmdq.c  | 102 +++++++++++++---------
>>   drivers/infiniband/hw/erdma/erdma_eq.c    |  55 +++++++-----
>>   drivers/infiniband/hw/erdma/erdma_main.c  |  15 +++-
>>   drivers/infiniband/hw/erdma/erdma_verbs.c |  85 ++++++++++--------
>>   drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +
>>   6 files changed, 167 insertions(+), 101 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/erdma/erdma.h 
>> b/drivers/infiniband/hw/erdma/erdma.h
>> index 5df401a30cb9..e116263a608f 100644
>> --- a/drivers/infiniband/hw/erdma/erdma.h
>> +++ b/drivers/infiniband/hw/erdma/erdma.h
>> @@ -34,6 +34,7 @@ struct erdma_eq {
>>       void __iomem *db;
>>       u64 *db_record;
>> +    dma_addr_t db_record_dma_addr;
>>   };
>>   struct erdma_cmdq_sq {
>> @@ -49,6 +50,7 @@ struct erdma_cmdq_sq {
>>       u16 wqebb_cnt;
>>       u64 *db_record;
>> +    dma_addr_t db_record_dma_addr;
>>   };
>>   struct erdma_cmdq_cq {
>> @@ -62,6 +64,7 @@ struct erdma_cmdq_cq {
>>       u32 cmdsn;
>>       u64 *db_record;
>> +    dma_addr_t db_record_dma_addr;
>>       atomic64_t armed_num;
>>   };
>> @@ -177,9 +180,6 @@ enum {
>>       ERDMA_RES_CNT = 2,
>>   };
>> -#define ERDMA_EXTRA_BUFFER_SIZE ERDMA_DB_SIZE
>> -#define WARPPED_BUFSIZE(size) ((size) + ERDMA_EXTRA_BUFFER_SIZE)
>> -
>>   struct erdma_dev {
>>       struct ib_device ibdev;
>>       struct net_device *netdev;
>> @@ -213,6 +213,7 @@ struct erdma_dev {
>>       atomic_t num_ctx;
>>       struct list_head cep_list;
>> +    struct dma_pool *db_pool;
>>       struct dma_pool *resp_pool;
>>   };
>> diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c 
>> b/drivers/infiniband/hw/erdma/erdma_cmdq.c
>> index a151a7bdd504..c2c666040949 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
>> +++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
>> @@ -89,20 +89,19 @@ static int erdma_cmdq_sq_init(struct erdma_dev *dev)
>>   {
>>       struct erdma_cmdq *cmdq = &dev->cmdq;
>>       struct erdma_cmdq_sq *sq = &cmdq->sq;
>> -    u32 buf_size;
>>       sq->wqebb_cnt = SQEBB_COUNT(ERDMA_CMDQ_SQE_SIZE);
>>       sq->depth = cmdq->max_outstandings * sq->wqebb_cnt;
>> -    buf_size = sq->depth << SQEBB_SHIFT;
>> -
>> -    sq->qbuf =
>> -        dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
>> -                   &sq->qbuf_dma_addr, GFP_KERNEL);
>> +    sq->qbuf = dma_alloc_coherent(&dev->pdev->dev, sq->depth << 
>> SQEBB_SHIFT,
>> +                      &sq->qbuf_dma_addr, GFP_KERNEL);
>>       if (!sq->qbuf)
>>           return -ENOMEM;
>> -    sq->db_record = (u64 *)(sq->qbuf + buf_size);
>> +    sq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
>> +                    &sq->db_record_dma_addr);
>> +    if (!sq->db_record)
>> +        goto err_out;
>>       spin_lock_init(&sq->lock);
>> @@ -112,29 +111,35 @@ static int erdma_cmdq_sq_init(struct erdma_dev 
>> *dev)
>>                 lower_32_bits(sq->qbuf_dma_addr));
>>       erdma_reg_write32(dev, ERDMA_REGS_CMDQ_DEPTH_REG, sq->depth);
>>       erdma_reg_write64(dev, ERDMA_CMDQ_SQ_DB_HOST_ADDR_REG,
>> -              sq->qbuf_dma_addr + buf_size);
>> +              sq->db_record_dma_addr);
>>       return 0;
>> +
>> +err_out:
>> +    dma_free_coherent(&dev->pdev->dev, sq->depth << SQEBB_SHIFT,
>> +              sq->qbuf, sq->qbuf_dma_addr);
>> +
>> +    return -ENOMEM;
>>   }
>>   static int erdma_cmdq_cq_init(struct erdma_dev *dev)
>>   {
>>       struct erdma_cmdq *cmdq = &dev->cmdq;
>>       struct erdma_cmdq_cq *cq = &cmdq->cq;
>> -    u32 buf_size;
>>       cq->depth = cmdq->sq.depth;
>> -    buf_size = cq->depth << CQE_SHIFT;
>> -
>> -    cq->qbuf =
>> -        dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
>> -                   &cq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
>> +    cq->qbuf = dma_alloc_coherent(&dev->pdev->dev, cq->depth << 
>> CQE_SHIFT,
>> +                      &cq->qbuf_dma_addr,
>> +                      GFP_KERNEL | __GFP_ZERO);
> 
> <...>
> 
>>       if (!cq->qbuf)
>>           return -ENOMEM;
>>       spin_lock_init(&cq->lock);
>> -    cq->db_record = (u64 *)(cq->qbuf + buf_size);
>> +    cq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
>> +                    &cq->db_record_dma_addr);
>> +    if (!cq->db_record)
>> +        goto err_out;
>>       atomic64_set(&cq->armed_num, 0);
>> @@ -143,23 +148,26 @@ static int erdma_cmdq_cq_init(struct erdma_dev 
>> *dev)
>>       erdma_reg_write32(dev, ERDMA_REGS_CMDQ_CQ_ADDR_L_REG,
>>                 lower_32_bits(cq->qbuf_dma_addr));
>>       erdma_reg_write64(dev, ERDMA_CMDQ_CQ_DB_HOST_ADDR_REG,
>> -              cq->qbuf_dma_addr + buf_size);
>> +              cq->db_record_dma_addr);
>>       return 0;
>> +
>> +err_out:
>> +    dma_free_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT, cq->qbuf,
>> +              cq->qbuf_dma_addr);
>> +
>> +    return -ENOMEM;
>>   }
>>   static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>>   {
>>       struct erdma_cmdq *cmdq = &dev->cmdq;
>>       struct erdma_eq *eq = &cmdq->eq;
>> -    u32 buf_size;
>>       eq->depth = cmdq->max_outstandings;
>> -    buf_size = eq->depth << EQE_SHIFT;
>> -
>> -    eq->qbuf =
>> -        dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
>> -                   &eq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
>> +    eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << 
>> EQE_SHIFT,
>> +                      &eq->qbuf_dma_addr,
>> +                      GFP_KERNEL | __GFP_ZERO);
> <...>
>>       if (!eq->qbuf)
>>           return -ENOMEM;
>> @@ -167,7 +175,10 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>>       atomic64_set(&eq->event_num, 0);
>>       eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG;
>> -    eq->db_record = (u64 *)(eq->qbuf + buf_size);
>> +    eq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
>> +                    &eq->db_record_dma_addr);
>> +    if (!eq->db_record)
>> +        goto err_out;
>>       erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_ADDR_H_REG,
>>                 upper_32_bits(eq->qbuf_dma_addr));
>> @@ -175,9 +186,15 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>>                 lower_32_bits(eq->qbuf_dma_addr));
>>       erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_DEPTH_REG, eq->depth);
>>       erdma_reg_write64(dev, ERDMA_CMDQ_EQ_DB_HOST_ADDR_REG,
>> -              eq->qbuf_dma_addr + buf_size);
>> +              eq->db_record_dma_addr);
>>       return 0;
>> +
>> +err_out:
>> +    dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
>> +              eq->qbuf_dma_addr);
>> +
>> +    return -ENOMEM;
>>   }
>>   int erdma_cmdq_init(struct erdma_dev *dev)
>> @@ -211,17 +228,19 @@ int erdma_cmdq_init(struct erdma_dev *dev)
>>       return 0;
>>   err_destroy_cq:
>> -    dma_free_coherent(&dev->pdev->dev,
>> -              (cmdq->cq.depth << CQE_SHIFT) +
>> -                  ERDMA_EXTRA_BUFFER_SIZE,
>> +    dma_free_coherent(&dev->pdev->dev, cmdq->cq.depth << CQE_SHIFT,
>>                 cmdq->cq.qbuf, cmdq->cq.qbuf_dma_addr);
>> +    dma_pool_free(dev->db_pool, cmdq->cq.db_record,
>> +              cmdq->cq.db_record_dma_addr);
>> +
>>   err_destroy_sq:
>> -    dma_free_coherent(&dev->pdev->dev,
>> -              (cmdq->sq.depth << SQEBB_SHIFT) +
>> -                  ERDMA_EXTRA_BUFFER_SIZE,
>> +    dma_free_coherent(&dev->pdev->dev, cmdq->sq.depth << SQEBB_SHIFT,
>>                 cmdq->sq.qbuf, cmdq->sq.qbuf_dma_addr);
>> +    dma_pool_free(dev->db_pool, cmdq->sq.db_record,
>> +              cmdq->sq.db_record_dma_addr);
>> +
>>       return err;
>>   }
>> @@ -238,18 +257,23 @@ void erdma_cmdq_destroy(struct erdma_dev *dev)
>>       clear_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
>> -    dma_free_coherent(&dev->pdev->dev,
>> -              (cmdq->eq.depth << EQE_SHIFT) +
>> -                  ERDMA_EXTRA_BUFFER_SIZE,
>> +    dma_free_coherent(&dev->pdev->dev, cmdq->eq.depth << EQE_SHIFT,
>>                 cmdq->eq.qbuf, cmdq->eq.qbuf_dma_addr);
>> -    dma_free_coherent(&dev->pdev->dev,
>> -              (cmdq->sq.depth << SQEBB_SHIFT) +
>> -                  ERDMA_EXTRA_BUFFER_SIZE,
>> +
>> +    dma_pool_free(dev->db_pool, cmdq->eq.db_record,
>> +              cmdq->eq.db_record_dma_addr);
>> +
>> +    dma_free_coherent(&dev->pdev->dev, cmdq->sq.depth << SQEBB_SHIFT,
>>                 cmdq->sq.qbuf, cmdq->sq.qbuf_dma_addr);
>> -    dma_free_coherent(&dev->pdev->dev,
>> -              (cmdq->cq.depth << CQE_SHIFT) +
>> -                  ERDMA_EXTRA_BUFFER_SIZE,
>> +
>> +    dma_pool_free(dev->db_pool, cmdq->sq.db_record,
>> +              cmdq->sq.db_record_dma_addr);
>> +
>> +    dma_free_coherent(&dev->pdev->dev, cmdq->cq.depth << CQE_SHIFT,
>>                 cmdq->cq.qbuf, cmdq->cq.qbuf_dma_addr);
>> +
>> +    dma_pool_free(dev->db_pool, cmdq->cq.db_record,
>> +              cmdq->cq.db_record_dma_addr);
>>   }
>>   static void *get_next_valid_cmdq_cqe(struct erdma_cmdq *cmdq)
>> diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c 
>> b/drivers/infiniband/hw/erdma/erdma_eq.c
>> index ea47cb21fdb8..809c33628f38 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_eq.c
>> +++ b/drivers/infiniband/hw/erdma/erdma_eq.c
>> @@ -83,14 +83,12 @@ void erdma_aeq_event_handler(struct erdma_dev *dev)
>>   int erdma_aeq_init(struct erdma_dev *dev)
>>   {
>>       struct erdma_eq *eq = &dev->aeq;
>> -    u32 buf_size;
>>       eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>> -    buf_size = eq->depth << EQE_SHIFT;
>> -    eq->qbuf =
>> -        dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
>> -                   &eq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
>> +    eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << 
>> EQE_SHIFT,
>> +                      &eq->qbuf_dma_addr,
>> +                      GFP_KERNEL | __GFP_ZERO);
> 
> <...>
> 
>>       if (!eq->qbuf)
>>           return -ENOMEM;
>> @@ -99,7 +97,10 @@ int erdma_aeq_init(struct erdma_dev *dev)
>>       atomic64_set(&eq->notify_num, 0);
>>       eq->db = dev->func_bar + ERDMA_REGS_AEQ_DB_REG;
>> -    eq->db_record = (u64 *)(eq->qbuf + buf_size);
>> +    eq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
>> +                    &eq->db_record_dma_addr);
>> +    if (!eq->db_record)
>> +        goto err_out;
>>       erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG,
>>                 upper_32_bits(eq->qbuf_dma_addr));
>> @@ -107,18 +108,25 @@ int erdma_aeq_init(struct erdma_dev *dev)
>>                 lower_32_bits(eq->qbuf_dma_addr));
>>       erdma_reg_write32(dev, ERDMA_REGS_AEQ_DEPTH_REG, eq->depth);
>>       erdma_reg_write64(dev, ERDMA_AEQ_DB_HOST_ADDR_REG,
>> -              eq->qbuf_dma_addr + buf_size);
>> +              eq->db_record_dma_addr);
>>       return 0;
>> +
>> +err_out:
>> +    dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
>> +              eq->qbuf_dma_addr);
>> +
>> +    return -ENOMEM;
>>   }
>>   void erdma_aeq_destroy(struct erdma_dev *dev)
>>   {
>>       struct erdma_eq *eq = &dev->aeq;
>> -    dma_free_coherent(&dev->pdev->dev,
>> -              WARPPED_BUFSIZE(eq->depth << EQE_SHIFT), eq->qbuf,
>> +    dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
>>                 eq->qbuf_dma_addr);
>> +
>> +    dma_pool_free(dev->db_pool, eq->db_record, eq->db_record_dma_addr);
>>   }
>>   void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb)
>> @@ -209,7 +217,6 @@ static void erdma_free_ceq_irq(struct erdma_dev 
>> *dev, u16 ceqn)
>>   static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct 
>> erdma_eq *eq)
>>   {
>>       struct erdma_cmdq_create_eq_req req;
>> -    dma_addr_t db_info_dma_addr;
>>       erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
>>                   CMDQ_OPCODE_CREATE_EQ);
>> @@ -219,9 +226,8 @@ static int create_eq_cmd(struct erdma_dev *dev, 
>> u32 eqn, struct erdma_eq *eq)
>>       req.qtype = ERDMA_EQ_TYPE_CEQ;
>>       /* Vector index is the same as EQN. */
>>       req.vector_idx = eqn;
>> -    db_info_dma_addr = eq->qbuf_dma_addr + (eq->depth << EQE_SHIFT);
>> -    req.db_dma_addr_l = lower_32_bits(db_info_dma_addr);
>> -    req.db_dma_addr_h = upper_32_bits(db_info_dma_addr);
>> +    req.db_dma_addr_l = lower_32_bits(eq->db_record_dma_addr);
>> +    req.db_dma_addr_h = upper_32_bits(eq->db_record_dma_addr);
>>       return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, 
>> NULL);
>>   }
>> @@ -229,12 +235,12 @@ static int create_eq_cmd(struct erdma_dev *dev, 
>> u32 eqn, struct erdma_eq *eq)
>>   static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
>>   {
>>       struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
>> -    u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
>>       int ret;
>> -    eq->qbuf =
>> -        dma_alloc_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size),
>> -                   &eq->qbuf_dma_addr, GFP_KERNEL | __GFP_ZERO);
>> +    eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>> +    eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << 
>> EQE_SHIFT,
>> +                      &eq->qbuf_dma_addr,
>> +                      GFP_KERNEL | __GFP_ZERO);
> 
> The patch in this link 
> (https://lore.kernel.org/all/20181214082515.14835-1-hch@lst.de/T/#m70c723c646004445713f31b7837f7e9d910c06f5) makes sure that dma_alloc_coherent(xxx) always returns zeroed memory.
> 
> So __GFP_ZERO is necessary? can we remove them?

Sorry. Please ignore this mail. In patch 3, these __GFP_ZEROs are removed.

Zhu Yanjun

> 
> Zhu Yanjun
> 
>>       if (!eq->qbuf)
>>           return -ENOMEM;
>> @@ -242,10 +248,17 @@ static int erdma_ceq_init_one(struct erdma_dev 
>> *dev, u16 ceqn)
>>       atomic64_set(&eq->event_num, 0);
>>       atomic64_set(&eq->notify_num, 0);
>> -    eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>>       eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG +
>>            (ceqn + 1) * ERDMA_DB_SIZE;
>> -    eq->db_record = (u64 *)(eq->qbuf + buf_size);
>> +
>> +    eq->db_record = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
>> +                    &eq->db_record_dma_addr);
>> +    if (!eq->db_record) {
>> +        dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
>> +                  eq->qbuf, eq->qbuf_dma_addr);
>> +        return -ENOMEM;
>> +    }
>> +
>>       eq->ci = 0;
>>       dev->ceqs[ceqn].dev = dev;
>> @@ -259,7 +272,6 @@ static int erdma_ceq_init_one(struct erdma_dev 
>> *dev, u16 ceqn)
>>   static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
>>   {
>>       struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
>> -    u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
>>       struct erdma_cmdq_destroy_eq_req req;
>>       int err;
>> @@ -276,8 +288,9 @@ static void erdma_ceq_uninit_one(struct erdma_dev 
>> *dev, u16 ceqn)
>>       if (err)
>>           return;
>> -    dma_free_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size), 
>> eq->qbuf,
>> +    dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
>>                 eq->qbuf_dma_addr);
>> +    dma_pool_free(dev->db_pool, eq->db_record, eq->db_record_dma_addr);
>>   }
>>   int erdma_ceqs_init(struct erdma_dev *dev)
>> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c 
>> b/drivers/infiniband/hw/erdma/erdma_main.c
>> index 472939172f0c..7080f8a71ec4 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_main.c
>> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
>> @@ -178,16 +178,26 @@ static int erdma_device_init(struct erdma_dev 
>> *dev, struct pci_dev *pdev)
>>       if (!dev->resp_pool)
>>           return -ENOMEM;
>> +    dev->db_pool = dma_pool_create("erdma_db_pool", &pdev->dev,
>> +                       ERDMA_DB_SIZE, ERDMA_DB_SIZE, 0);
>> +    if (!dev->db_pool) {
>> +        ret = -ENOMEM;
>> +        goto destroy_resp_pool;
>> +    }
>> +
>>       ret = dma_set_mask_and_coherent(&pdev->dev,
>>                       DMA_BIT_MASK(ERDMA_PCI_WIDTH));
>>       if (ret)
>> -        goto destroy_pool;
>> +        goto destroy_db_pool;
>>       dma_set_max_seg_size(&pdev->dev, UINT_MAX);
>>       return 0;
>> -destroy_pool:
>> +destroy_db_pool:
>> +    dma_pool_destroy(dev->db_pool);
>> +
>> +destroy_resp_pool:
>>       dma_pool_destroy(dev->resp_pool);
>>       return ret;
>> @@ -195,6 +205,7 @@ static int erdma_device_init(struct erdma_dev 
>> *dev, struct pci_dev *pdev)
>>   static void erdma_device_uninit(struct erdma_dev *dev)
>>   {
>> +    dma_pool_destroy(dev->db_pool);
>>       dma_pool_destroy(dev->resp_pool);
>>   }
>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c 
>> b/drivers/infiniband/hw/erdma/erdma_verbs.c
>> index 23dfc01603f8..b78ddca1483e 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
>> @@ -76,10 +76,8 @@ static int create_qp_cmd(struct erdma_ucontext 
>> *uctx, struct erdma_qp *qp)
>>           req.rq_buf_addr = qp->kern_qp.rq_buf_dma_addr;
>>           req.sq_buf_addr = qp->kern_qp.sq_buf_dma_addr;
>> -        req.sq_db_info_dma_addr = qp->kern_qp.sq_buf_dma_addr +
>> -                      (qp->attrs.sq_size << SQEBB_SHIFT);
>> -        req.rq_db_info_dma_addr = qp->kern_qp.rq_buf_dma_addr +
>> -                      (qp->attrs.rq_size << RQE_SHIFT);
>> +        req.sq_db_info_dma_addr = qp->kern_qp.sq_db_info_dma_addr;
>> +        req.rq_db_info_dma_addr = qp->kern_qp.rq_db_info_dma_addr;
>>       } else {
>>           user_qp = &qp->user_qp;
>>           req.sq_cqn_mtt_cfg = FIELD_PREP(
>> @@ -209,8 +207,7 @@ static int create_cq_cmd(struct erdma_ucontext 
>> *uctx, struct erdma_cq *cq)
>>                          ERDMA_MR_MTT_0LEVEL);
>>           req.first_page_offset = 0;
>> -        req.cq_db_info_addr =
>> -            cq->kern_cq.qbuf_dma_addr + (cq->depth << CQE_SHIFT);
>> +        req.cq_db_info_addr = cq->kern_cq.db_record_dma_addr;
>>       } else {
>>           mem = &cq->user_cq.qbuf_mem;
>>           req.cfg0 |=
>> @@ -482,16 +479,24 @@ static void free_kernel_qp(struct erdma_qp *qp)
>>       vfree(qp->kern_qp.rwr_tbl);
>>       if (qp->kern_qp.sq_buf)
>> -        dma_free_coherent(
>> -            &dev->pdev->dev,
>> -            WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
>> -            qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
>> +        dma_free_coherent(&dev->pdev->dev,
>> +                  qp->attrs.sq_size << SQEBB_SHIFT,
>> +                  qp->kern_qp.sq_buf,
>> +                  qp->kern_qp.sq_buf_dma_addr);
>> +
>> +    if (qp->kern_qp.sq_db_info)
>> +        dma_pool_free(dev->db_pool, qp->kern_qp.sq_db_info,
>> +                  qp->kern_qp.sq_db_info_dma_addr);
>>       if (qp->kern_qp.rq_buf)
>> -        dma_free_coherent(
>> -            &dev->pdev->dev,
>> -            WARPPED_BUFSIZE(qp->attrs.rq_size << RQE_SHIFT),
>> -            qp->kern_qp.rq_buf, qp->kern_qp.rq_buf_dma_addr);
>> +        dma_free_coherent(&dev->pdev->dev,
>> +                  qp->attrs.rq_size << RQE_SHIFT,
>> +                  qp->kern_qp.rq_buf,
>> +                  qp->kern_qp.rq_buf_dma_addr);
>> +
>> +    if (qp->kern_qp.rq_db_info)
>> +        dma_pool_free(dev->db_pool, qp->kern_qp.rq_db_info,
>> +                  qp->kern_qp.rq_db_info_dma_addr);
>>   }
>>   static int init_kernel_qp(struct erdma_dev *dev, struct erdma_qp *qp,
>> @@ -516,20 +521,27 @@ static int init_kernel_qp(struct erdma_dev *dev, 
>> struct erdma_qp *qp,
>>       if (!kqp->swr_tbl || !kqp->rwr_tbl)
>>           goto err_out;
>> -    size = (qp->attrs.sq_size << SQEBB_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
>> +    size = qp->attrs.sq_size << SQEBB_SHIFT;
>>       kqp->sq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
>>                        &kqp->sq_buf_dma_addr, GFP_KERNEL);
>>       if (!kqp->sq_buf)
>>           goto err_out;
>> -    size = (qp->attrs.rq_size << RQE_SHIFT) + ERDMA_EXTRA_BUFFER_SIZE;
>> +    kqp->sq_db_info = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
>> +                      &kqp->sq_db_info_dma_addr);
>> +    if (!kqp->sq_db_info)
>> +        goto err_out;
>> +
>> +    size = qp->attrs.rq_size << RQE_SHIFT;
>>       kqp->rq_buf = dma_alloc_coherent(&dev->pdev->dev, size,
>>                        &kqp->rq_buf_dma_addr, GFP_KERNEL);
>>       if (!kqp->rq_buf)
>>           goto err_out;
>> -    kqp->sq_db_info = kqp->sq_buf + (qp->attrs.sq_size << SQEBB_SHIFT);
>> -    kqp->rq_db_info = kqp->rq_buf + (qp->attrs.rq_size << RQE_SHIFT);
>> +    kqp->rq_db_info = dma_pool_zalloc(dev->db_pool, GFP_KERNEL,
>> +                      &kqp->rq_db_info_dma_addr);
>> +    if (!kqp->rq_db_info)
>> +        goto err_out;
>>       return 0;
>> @@ -1237,9 +1249,10 @@ int erdma_destroy_cq(struct ib_cq *ibcq, struct 
>> ib_udata *udata)
>>           return err;
>>       if (rdma_is_kernel_res(&cq->ibcq.res)) {
>> -        dma_free_coherent(&dev->pdev->dev,
>> -                  WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
>> +        dma_free_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
>>                     cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
>> +        dma_pool_free(dev->db_pool, cq->kern_cq.db_record,
>> +                  cq->kern_cq.db_record_dma_addr);
>>       } else {
>>           erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
>>           put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
>> @@ -1279,16 +1292,7 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct 
>> ib_udata *udata)
>>       wait_for_completion(&qp->safe_free);
>>       if (rdma_is_kernel_res(&qp->ibqp.res)) {
>> -        vfree(qp->kern_qp.swr_tbl);
>> -        vfree(qp->kern_qp.rwr_tbl);
>> -        dma_free_coherent(
>> -            &dev->pdev->dev,
>> -            WARPPED_BUFSIZE(qp->attrs.rq_size << RQE_SHIFT),
>> -            qp->kern_qp.rq_buf, qp->kern_qp.rq_buf_dma_addr);
>> -        dma_free_coherent(
>> -            &dev->pdev->dev,
>> -            WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
>> -            qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
>> +        free_kernel_qp(qp);
>>       } else {
>>           put_mtt_entries(dev, &qp->user_qp.sq_mem);
>>           put_mtt_entries(dev, &qp->user_qp.rq_mem);
>> @@ -1600,19 +1604,27 @@ static int erdma_init_kernel_cq(struct 
>> erdma_cq *cq)
>>       struct erdma_dev *dev = to_edev(cq->ibcq.device);
>>       cq->kern_cq.qbuf =
>> -        dma_alloc_coherent(&dev->pdev->dev,
>> -                   WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
>> +        dma_alloc_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
>>                      &cq->kern_cq.qbuf_dma_addr, GFP_KERNEL);
>>       if (!cq->kern_cq.qbuf)
>>           return -ENOMEM;
>> -    cq->kern_cq.db_record =
>> -        (u64 *)(cq->kern_cq.qbuf + (cq->depth << CQE_SHIFT));
>> +    cq->kern_cq.db_record = dma_pool_zalloc(
>> +        dev->db_pool, GFP_KERNEL, &cq->kern_cq.db_record_dma_addr);
>> +    if (!cq->kern_cq.db_record)
>> +        goto err_out;
>> +
>>       spin_lock_init(&cq->kern_cq.lock);
>>       /* use default cqdb addr */
>>       cq->kern_cq.db = dev->func_bar + ERDMA_BAR_CQDB_SPACE_OFFSET;
>>       return 0;
>> +
>> +err_out:
>> +    dma_free_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
>> +              cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
>> +
>> +    return -ENOMEM;
>>   }
>>   int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr 
>> *attr,
>> @@ -1676,9 +1688,10 @@ int erdma_create_cq(struct ib_cq *ibcq, const 
>> struct ib_cq_init_attr *attr,
>>           erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
>>           put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
>>       } else {
>> -        dma_free_coherent(&dev->pdev->dev,
>> -                  WARPPED_BUFSIZE(depth << CQE_SHIFT),
>> +        dma_free_coherent(&dev->pdev->dev, depth << CQE_SHIFT,
>>                     cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
>> +        dma_pool_free(dev->db_pool, cq->kern_cq.db_record,
>> +                  cq->kern_cq.db_record_dma_addr);
>>       }
>>   err_out_xa:
>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h 
>> b/drivers/infiniband/hw/erdma/erdma_verbs.h
>> index db6018529ccc..b02ffdc8c811 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.h
>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
>> @@ -170,6 +170,9 @@ struct erdma_kqp {
>>       void *sq_db_info;
>>       void *rq_db_info;
>> +    dma_addr_t sq_db_info_dma_addr;
>> +    dma_addr_t rq_db_info_dma_addr;
>> +
>>       u8 sig_all;
>>   };
>> @@ -247,6 +250,7 @@ struct erdma_kcq_info {
>>       spinlock_t lock;
>>       u8 __iomem *db;
>>       u64 *db_record;
>> +    dma_addr_t db_record_dma_addr;
>>   };
>>   struct erdma_ucq_info {
> 

