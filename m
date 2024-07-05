Return-Path: <linux-rdma+bounces-3674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCB928707
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 12:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8ADB2111D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 10:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F29145FF5;
	Fri,  5 Jul 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfIKMMmS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B514430B;
	Fri,  5 Jul 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176491; cv=none; b=eMu1EogdyYgP++dLzWQozAbTYMc4ezjJZEktZrTqRTkYBAJMXwhK71zQ8fNZXwrgLOSKUqxsh5dPu3xMFeBXqtm7FgA1nCWUTIiNeWvo0T8fmd5adQWBbwySezK86c9H2bA0apXkKh6mXStUC3NJK1JSj+Jm/lrOUsPXgYIHang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176491; c=relaxed/simple;
	bh=Ab1xlzhy1Ig+pGrZFHN6XUqu6zwAS58NZW5eVj9hP/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gy1MLPL4j0joAkeO5rhEuAOK7862Vw1/+C/VXbUp4oBA5snRnFJLPUs39yhOPZR2D/A55w8LjK24PLyARuOEGSD81yn0gsI4UFFRW/ngG1xWXG2a3t0q92ILZI8MTCvxGJ5ZbDtkkCsMy2OZ1AM6vijwO9x/4Ok5/0AqUrGqABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfIKMMmS; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: huangjunxian6@hisilicon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720176484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmdqLmpJIiwpuWarBamAIOeZDRcEU1Leayh1fhTIwLo=;
	b=xfIKMMmSjzQ1iV6/6j20050eGS01jS7IlRCf0krdEgG1FOVinIMbefSrHn3ypbKwOhzj4Q
	h5jRDHGyC7qBhIungDa7464VEicJJe+pV0tNQcFIYauy3Sk6x6z1PlQ53TBjmDdyCiiVoa
	gAi2wF0PiOlrnjfw6MI/ToT8Td/bk5s=
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linuxarm@huawei.com
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <aa0acabe-567a-45d9-ad0a-69e85e6c300a@linux.dev>
Date: Fri, 5 Jul 2024 18:47:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc 3/9] RDMA/hns: Fix soft lockup under heavy CEQE
 load
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-4-huangjunxian6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240705085937.1644229-4-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/5 16:59, Junxian Huang 写道:
> CEQEs are handled in interrupt handler currently. This may cause the
> CPU core staying in interrupt context too long and lead to soft lockup
> under heavy load.
> 
> Handle CEQEs in tasklet and set an upper limit for the number of CEQE
> handled by a single call of tasklet.

https://patchwork.kernel.org/project/linux-rdma/cover/20240621050525.3720069-1-allen.lkml@gmail.com/

In the above link, it seems that tasklet is not good enough. The tasklet 
is marked deprecated and has some design flaws. It is being replace BH 
workqueue.

So directly use workqueue instead of tasklet?

Zhu Yanjun

> 
> Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>   drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 88 ++++++++++++---------
>   2 files changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 05005079258c..5a2445f357ab 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -717,6 +717,7 @@ struct hns_roce_eq {
>   	int				shift;
>   	int				event_type;
>   	int				sub_type;
> +	struct tasklet_struct		tasklet;
>   };
>   
>   struct hns_roce_eq_table {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index ff135df1a761..f73de06a3ca5 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -6146,33 +6146,11 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
>   		!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
>   }
>   
> -static irqreturn_t hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
> -				       struct hns_roce_eq *eq)
> +static irqreturn_t hns_roce_v2_ceq_int(struct hns_roce_eq *eq)
>   {
> -	struct hns_roce_ceqe *ceqe = next_ceqe_sw_v2(eq);
> -	irqreturn_t ceqe_found = IRQ_NONE;
> -	u32 cqn;
> -
> -	while (ceqe) {
> -		/* Make sure we read CEQ entry after we have checked the
> -		 * ownership bit
> -		 */
> -		dma_rmb();
> -
> -		cqn = hr_reg_read(ceqe, CEQE_CQN);
> -
> -		hns_roce_cq_completion(hr_dev, cqn);
> -
> -		++eq->cons_index;
> -		ceqe_found = IRQ_HANDLED;
> -		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CEQE_CNT]);
> -
> -		ceqe = next_ceqe_sw_v2(eq);
> -	}
> +	tasklet_schedule(&eq->tasklet);
>   
> -	update_eq_db(eq);
> -
> -	return IRQ_RETVAL(ceqe_found);
> +	return IRQ_HANDLED;
>   }
>   
>   static irqreturn_t hns_roce_v2_msix_interrupt_eq(int irq, void *eq_ptr)
> @@ -6183,7 +6161,7 @@ static irqreturn_t hns_roce_v2_msix_interrupt_eq(int irq, void *eq_ptr)
>   
>   	if (eq->type_flag == HNS_ROCE_CEQ)
>   		/* Completion event interrupt */
> -		int_work = hns_roce_v2_ceq_int(hr_dev, eq);
> +		int_work = hns_roce_v2_ceq_int(eq);
>   	else
>   		/* Asynchronous event interrupt */
>   		int_work = hns_roce_v2_aeq_int(hr_dev, eq);
> @@ -6551,6 +6529,34 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
>   	return ret;
>   }
>   
> +static void hns_roce_ceq_task(struct tasklet_struct *task)
> +{
> +	struct hns_roce_eq *eq = from_tasklet(eq, task, tasklet);
> +	struct hns_roce_ceqe *ceqe = next_ceqe_sw_v2(eq);
> +	struct hns_roce_dev *hr_dev = eq->hr_dev;
> +	int ceqe_num = 0;
> +	u32 cqn;
> +
> +	while (ceqe && ceqe_num < hr_dev->caps.ceqe_depth) {
> +		/* Make sure we read CEQ entry after we have checked the
> +		 * ownership bit
> +		 */
> +		dma_rmb();
> +
> +		cqn = hr_reg_read(ceqe, CEQE_CQN);
> +
> +		hns_roce_cq_completion(hr_dev, cqn);
> +
> +		++eq->cons_index;
> +		++ceqe_num;
> +		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CEQE_CNT]);
> +
> +		ceqe = next_ceqe_sw_v2(eq);
> +	}
> +
> +	update_eq_db(eq);
> +}
> +
>   static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
>   				  int comp_num, int aeq_num, int other_num)
>   {
> @@ -6582,21 +6588,24 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
>   			 j - other_num - aeq_num);
>   
>   	for (j = 0; j < irq_num; j++) {
> -		if (j < other_num)
> +		if (j < other_num) {
>   			ret = request_irq(hr_dev->irq[j],
>   					  hns_roce_v2_msix_interrupt_abn,
>   					  0, hr_dev->irq_names[j], hr_dev);
> -
> -		else if (j < (other_num + comp_num))
> +		} else if (j < (other_num + comp_num)) {
> +			tasklet_setup(&eq_table->eq[j - other_num].tasklet,
> +				      hns_roce_ceq_task);
>   			ret = request_irq(eq_table->eq[j - other_num].irq,
>   					  hns_roce_v2_msix_interrupt_eq,
>   					  0, hr_dev->irq_names[j + aeq_num],
>   					  &eq_table->eq[j - other_num]);
> -		else
> +		} else {
>   			ret = request_irq(eq_table->eq[j - other_num].irq,
>   					  hns_roce_v2_msix_interrupt_eq,
>   					  0, hr_dev->irq_names[j - comp_num],
>   					  &eq_table->eq[j - other_num]);
> +		}
> +
>   		if (ret) {
>   			dev_err(hr_dev->dev, "request irq error!\n");
>   			goto err_request_failed;
> @@ -6606,12 +6615,16 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
>   	return 0;
>   
>   err_request_failed:
> -	for (j -= 1; j >= 0; j--)
> -		if (j < other_num)
> +	for (j -= 1; j >= 0; j--) {
> +		if (j < other_num) {
>   			free_irq(hr_dev->irq[j], hr_dev);
> -		else
> -			free_irq(eq_table->eq[j - other_num].irq,
> -				 &eq_table->eq[j - other_num]);
> +			continue;
> +		}
> +		free_irq(eq_table->eq[j - other_num].irq,
> +			 &eq_table->eq[j - other_num]);
> +		if (j < other_num + comp_num)
> +			tasklet_kill(&eq_table->eq[j - other_num].tasklet);
> +	}
>   
>   err_kzalloc_failed:
>   	for (i -= 1; i >= 0; i--)
> @@ -6632,8 +6645,11 @@ static void __hns_roce_free_irq(struct hns_roce_dev *hr_dev)
>   	for (i = 0; i < hr_dev->caps.num_other_vectors; i++)
>   		free_irq(hr_dev->irq[i], hr_dev);
>   
> -	for (i = 0; i < eq_num; i++)
> +	for (i = 0; i < eq_num; i++) {
>   		free_irq(hr_dev->eq_table.eq[i].irq, &hr_dev->eq_table.eq[i]);
> +		if (i < hr_dev->caps.num_comp_vectors)
> +			tasklet_kill(&hr_dev->eq_table.eq[i].tasklet);
> +	}
>   
>   	for (i = 0; i < irq_num; i++)
>   		kfree(hr_dev->irq_names[i]);


