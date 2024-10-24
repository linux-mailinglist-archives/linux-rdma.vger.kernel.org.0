Return-Path: <linux-rdma+bounces-5511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950BC9AEE8E
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32266B25516
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC51FF03B;
	Thu, 24 Oct 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YAjHAuJS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE671FC7F2
	for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792130; cv=none; b=pJ0lVX3KphW7/xpBQ+db2Td1Plll1fVfpyW9boMnDrQngX9Cx2pdyLJQkVf3fI1kfTGdprvDyusFx0qhrHG0g+JBURSmdAg/F+EPyKkZah+tx/K3F1bK1MrJ/tZHjRYmA99RlQ/zRDLrGr4CoanuruUxIYKWTbGMj2q2dmKSxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792130; c=relaxed/simple;
	bh=pFKw41pXAynIYjwxABtQ8FjYx8I4OP5LGQ3s0G9Xp0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjhCCFrkRkgK2fhqbbzbxeXcGdtxjo9mecZrme+a2kZkCHXqxYpPtNWTueohOTB9HZHOLXtTUJDF96GtpaUF3tHEMvQhLx2Ft1TDgPhJvxcHBealmF0FZLM6zFO6pfnOiPVgNiyejRuKhygoSvdEFnJjAo2jLPfr0JqqDpJ90Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YAjHAuJS; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38b31782-6ab1-43b0-9e6e-6fc06b0060e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729792125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyA0L7ceTn1ePZ3yPtQhRvS4Y7ujHQoMvMW+3G25TZw=;
	b=YAjHAuJSNUrVCTz4E9U67UF1MVVSqh/nIFnHxwzRLwXalTlAlFsppVtolctromv6OjjNKJ
	VcxEZSr2PG1Z9jGvrwRlTpySiB5iHKvnlR7fsxxbza/fXf4Gx1JytoAKtofz5I4n9R8DcH
	ZclJRw9Up1pjLkPf+DDu55nH2rFO+AE=
Date: Thu, 24 Oct 2024 19:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 for-rc 2/5] RDMA/hns: Fix flush cqe error when racing
 with destroy qp
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
 <20241024124000.2931869-3-huangjunxian6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241024124000.2931869-3-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/24 14:39, Junxian Huang 写道:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> QP needs to be modified to IB_QPS_ERROR to trigger HW flush cqe. But
> when this process races with destroy qp, the destroy-qp process may
> modify the QP to IB_QPS_RESET first. In this case flush cqe will fail
> since it is invalid to modify qp from IB_QPS_RESET to IB_QPS_ERROR.
> 
> Add lock and bit flag to make sure pending flush cqe work is completed
> first and no more new works will be added.
> 
> Fixes: ffd541d45726 ("RDMA/hns: Add the workqueue framework for flush cqe handler")
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>   drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  7 +++++++
>   drivers/infiniband/hw/hns/hns_roce_qp.c     | 15 +++++++++++++--
>   3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 73c78005901e..9b51d5a1533f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -593,6 +593,7 @@ struct hns_roce_dev;
>   
>   enum {
>   	HNS_ROCE_FLUSH_FLAG = 0,
> +	HNS_ROCE_STOP_FLUSH_FLAG = 1,
>   };
>   
>   struct hns_roce_work {
> @@ -656,6 +657,7 @@ struct hns_roce_qp {
>   	enum hns_roce_cong_type	cong_type;
>   	u8			tc_mode;
>   	u8			priority;
> +	spinlock_t flush_lock;
>   };
>   
>   struct hns_roce_ib_iboe {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index e85c450e1809..aa42c5a9b254 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -5598,8 +5598,15 @@ int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   {
>   	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>   	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
> +	unsigned long flags;
>   	int ret;
>   
> +	/* Make sure flush_cqe() is completed */
> +	spin_lock_irqsave(&hr_qp->flush_lock, flags);
> +	set_bit(HNS_ROCE_STOP_FLUSH_FLAG, &hr_qp->flush_flag);
> +	spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
> +	flush_work(&hr_qp->flush_work.work);
> +
>   	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
>   	if (ret)
>   		ibdev_err(&hr_dev->ib_dev,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index dcaa370d4a26..2ad03ecdbf8e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -90,11 +90,18 @@ static void flush_work_handle(struct work_struct *work)
>   void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>   {
>   	struct hns_roce_work *flush_work = &hr_qp->flush_work;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hr_qp->flush_lock, flags);
> +	/* Exit directly after destroy_qp() */
> +	if (test_bit(HNS_ROCE_STOP_FLUSH_FLAG, &hr_qp->flush_flag)) {
> +		spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
> +		return;
> +	}
>   
> -	flush_work->hr_dev = hr_dev;
> -	INIT_WORK(&flush_work->work, flush_work_handle);
>   	refcount_inc(&hr_qp->refcount);
>   	queue_work(hr_dev->irq_workq, &flush_work->work);
> +	spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
>   }
>   
>   void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp)
> @@ -1140,6 +1147,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>   				     struct ib_udata *udata,
>   				     struct hns_roce_qp *hr_qp)
>   {
> +	struct hns_roce_work *flush_work = &hr_qp->flush_work;
>   	struct hns_roce_ib_create_qp_resp resp = {};
>   	struct ib_device *ibdev = &hr_dev->ib_dev;
>   	struct hns_roce_ib_create_qp ucmd = {};
> @@ -1148,9 +1156,12 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>   	mutex_init(&hr_qp->mutex);
>   	spin_lock_init(&hr_qp->sq.lock);
>   	spin_lock_init(&hr_qp->rq.lock);
> +	spin_lock_init(&hr_qp->flush_lock);

Thanks a lot. I am fine with this spin_lock_init(&hr_qp->flush_lock);
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   
>   	hr_qp->state = IB_QPS_RESET;
>   	hr_qp->flush_flag = 0;
> +	flush_work->hr_dev = hr_dev;
> +	INIT_WORK(&flush_work->work, flush_work_handle);
>   
>   	if (init_attr->create_flags)
>   		return -EOPNOTSUPP;


