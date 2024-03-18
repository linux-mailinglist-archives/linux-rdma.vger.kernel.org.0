Return-Path: <linux-rdma+bounces-1479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA02E87EA70
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 14:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3665EB21AA0
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A05A4A990;
	Mon, 18 Mar 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kfiTWVdT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C42C1AA
	for <linux-rdma@vger.kernel.org>; Mon, 18 Mar 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770210; cv=none; b=aArSf4nsgstx0DAP7hrrz565cmKQjgJpDVBCegEHTjHJGw2bk03pzrwpEutFc847pS5cTkjHtHfXSqkTEPv0sOpS+8zbc4Soc9mhm9RAjNhBH9v51NHxCqJlU9ar+gVmXRj5fhMKF8bYNpMWPR9oURECpWlmecMl52KMxipXg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770210; c=relaxed/simple;
	bh=ERVnSpjVdDsO/HGZdby1785ElVvvS6M95VHMrvBbUs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCS1CdocgE20rCsEbt9Ctg6J4/+YeOtPJm/bmqei6SBueRBPe+vurxvYlpb9eEHwy+pm/0PJRi9B1aw/RQ/TJxk2bZzmpJddpr9NRLgSif5S2uspzrndTYt7JhIeFtuWJe1zPxkIW5jvUSdR4UnJmR90JUpNd6QGSa3L+Vxa8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kfiTWVdT; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f0a86cd-dd01-40b1-87ed-39f8d655e18a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710770205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muvpwz7a96M6/2doTJBM5VlsnMcGZ+AFVmWiFaXOnls=;
	b=kfiTWVdT8ReLHqMbkUM8dB16NUYpUQUu9Yfp8lnzUy1+Tt/BID2KvcFeq1kyyd8XZNw+kF
	qBPpBYMR2nJqFecICQ2n+oHEsQPz6kmT96Pf3Wm3CD8l/HvSrrP2hiOdKlKcGuxRd/3fw3
	7hjvwA236ed1PCoUQV/oqXVOJQlnIYs=
Date: Mon, 18 Mar 2024 14:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce
 helpers to create and destroy mana queues
To: Konstantin Taranov <kotaranov@microsoft.com>,
 Konstantin Taranov <kotaranov@linux.microsoft.com>,
 "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
 Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "leon@kernel.org" <leon@kernel.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-2-git-send-email-kotaranov@linux.microsoft.com>
 <7956dd4b-3002-4073-aff7-f85ea436e6e0@linux.dev>
 <PAXPR83MB0557CAF749EE4161E3EE5A31B42D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <PAXPR83MB0557CAF749EE4161E3EE5A31B42D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 18.03.24 10:31, Konstantin Taranov wrote:
>>> From: Konstantin Taranov <kotaranov@microsoft.com>
>>>
>>> Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
>>> A queue always consists of umem, gdma_region, and id.
>>> A queue can be used for a WQ or a CQ.
>>>
>>> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
>>> ---
>>>    drivers/infiniband/hw/mana/main.c    | 40
>> ++++++++++++++++++++++++++++
>>>    drivers/infiniband/hw/mana/mana_ib.h | 10 +++++++
>>>    2 files changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/hw/mana/main.c
>>> b/drivers/infiniband/hw/mana/main.c
>>> index 71e33feee..0ec940b97 100644
>>> --- a/drivers/infiniband/hw/mana/main.c
>>> +++ b/drivers/infiniband/hw/mana/main.c
>>> @@ -237,6 +237,46 @@ void mana_ib_dealloc_ucontext(struct
>> ib_ucontext *ibcontext)
>>>                ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
>>>    }
>>>
>>> +int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
>>> +                      struct mana_ib_queue *queue) {
>>> +     struct ib_umem *umem;
>>> +     int err;
>>> +
>>> +     queue->umem = NULL;
>>> +     queue->id = INVALID_QUEUE_ID;
>>> +     queue->gdma_region = GDMA_INVALID_DMA_REGION;
>>> +
>>> +     umem = ib_umem_get(&mdev->ib_dev, addr, size,
>> IB_ACCESS_LOCAL_WRITE);
>>> +     if (IS_ERR(umem)) {
>>> +             err = PTR_ERR(umem);
>>> +             ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %d\n", err);
>>> +             return err;
>>> +     }
>>> +
>>> +     err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue-
>>> gdma_region);
>>> +     if (err) {
>>> +             ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n",
>> err);
>>> +             goto free_umem;
>>> +     }
>>> +     queue->umem = umem;
>>> +
>>> +     ibdev_dbg(&mdev->ib_dev,
>>> +               "create_dma_region ret %d gdma_region 0x%llx\n",
>>> +               err, queue->gdma_region);
>>> +
>>> +     return 0;
>>> +free_umem:
>>> +     ib_umem_release(umem);
>>> +     return err;
>>> +}
>>> +
>>> +void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct
>>> +mana_ib_queue *queue) {
>>> +     mana_ib_gd_destroy_dma_region(mdev, queue->gdma_region);
>> The function mana_ib_gd_destroy_dma_region will call
>> mana_gd_destroy_dma_region. In the function
>> mana_gd_destroy_dma_region, the function mana_gd_send_request will
>> return the error -EPROTO.
>> The procedure is as below. So the function mana_ib_destroy_queue should
>> also handle this error?
> Thanks for the comment!
> This error can be ignored and it was ignored before this commit.
> I checked the corresponding Windows driver code, and it is also intentionally ignored there.
> I can add a comment that the error is ignored intentionally if you want.

Sure. Thanks a lot.

Zhu Yanjun

>
>> mana_ib_gd_destroy_dma_region --- > mana_gd_destroy_dma_region
>>
>>    693 int mana_gd_destroy_dma_region(struct gdma_context *gc, u64
>> dma_region_handle)
>>    694 {
>>
>> ...
>>
>>    706         err = mana_gd_send_request(gc, sizeof(req), &req,
>> sizeof(resp), &resp);
>>    707         if (err || resp.hdr.status) {
>>    708                 dev_err(gc->dev, "Failed to destroy DMA region:
>> %d, 0x%x\n",
>>    709                         err, resp.hdr.status);
>>    710                 return -EPROTO;
>>    711         }
>>
>> ...
>>
>>    714 }
>>
>> Zhu Yanjun
>>
>>> +     ib_umem_release(queue->umem);
>>> +}
>>> +
>>>    static int
>>>    mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
>>>                            struct gdma_context *gc, diff --git
>>> a/drivers/infiniband/hw/mana/mana_ib.h
>>> b/drivers/infiniband/hw/mana/mana_ib.h
>>> index f83390eeb..859fd3bfc 100644
>>> --- a/drivers/infiniband/hw/mana/mana_ib.h
>>> +++ b/drivers/infiniband/hw/mana/mana_ib.h
>>> @@ -45,6 +45,12 @@ struct mana_ib_adapter_caps {
>>>        u32 max_inline_data_size;
>>>    };
>>>
>>> +struct mana_ib_queue {
>>> +     struct ib_umem *umem;
>>> +     u64 gdma_region;
>>> +     u64 id;
>>> +};
>>> +
>>>    struct mana_ib_dev {
>>>        struct ib_device ib_dev;
>>>        struct gdma_dev *gdma_dev;
>>> @@ -169,6 +175,10 @@ int mana_ib_create_dma_region(struct
>> mana_ib_dev *dev, struct ib_umem *umem,
>>>    int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
>>>                                  mana_handle_t gdma_region);
>>>
>>> +int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
>>> +                      struct mana_ib_queue *queue); void
>>> +mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct
>> mana_ib_queue
>>> +*queue);
>>> +
>>>    struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>>>                                struct ib_wq_init_attr *init_attr,
>>>                                struct ib_udata *udata);

