Return-Path: <linux-rdma+bounces-5485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507849ACE5D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C71282732
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D91B4F23;
	Wed, 23 Oct 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzn/dP1j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE51A7ADE
	for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696440; cv=none; b=HIsm0Iw7oaZj/LlMiD59ftmA2zxGPF3nSp1yxxC1x7EjHvowTRvPs4LQO/MKhNihsR3kJYbeHgjXjErzcCk5Lb87v/5eZBymINMJ9Kyudmb2mFCHkJ/Umh4GZI29E4KEN0B7KQW+HGlGeJaNBgFIZZoEnERokcsW3fczmfdfWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696440; c=relaxed/simple;
	bh=C1l56v3HMyOoYB5Hj6ka0yLfHWLITvZBAVXhHbTMyuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFVwfvTcscGP61/dm1nnel0vAsxyJpMBgu9lQVGUPFX9OmCjqEUjYUuEgzwX8Kd+JYyWSCnOdxiwhA2HuPb0ImVfQANfEgpdlonCYcLnMoLUVxyz6AQhNtCH7yMKvq1vABq8+kz450c0hO9Su/sYatCBlsrp4PBuEw9t0IXk7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzn/dP1j; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8ab33e8-cba8-48f9-b438-7e6f09f3b068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729696431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QShPcvbnlf3AY+IgNeQhWdpvwedI8/s0p3vJE4J8yQ=;
	b=rzn/dP1jb/m1DsNvtBJNECwnFg5GQPlY/On+S943JW4glQtX+rBi/tum1hyw25KADruARB
	1g/6F92UUsWdUAgzv+2dRx0P90Q7ovXdvGPPYr1e8Kxu3SpkSlgc56gcPRq0e6GpZMORfJ
	AyD07fmA80xuImjGobpJyWlz28AwP/E=
Date: Wed, 23 Oct 2024 17:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc 2/5] RDMA/hns: Fix flush cqe error when racing with
 destroy qp
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
References: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
 <20241022111017.946170-3-huangjunxian6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241022111017.946170-3-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/22 13:10, Junxian Huang 写道:
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
>   drivers/infiniband/hw/hns/hns_roce_qp.c     | 14 ++++++++++++--
>   3 files changed, 21 insertions(+), 2 deletions(-)
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
spin_lock_init is missing?

The spin lock flush_lock should be initialized before used.

Zhu Yanjun
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
> index dcaa370d4a26..3439312b0138 100644
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
> @@ -1151,6 +1159,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
>   
>   	hr_qp->state = IB_QPS_RESET;
>   	hr_qp->flush_flag = 0;
> +	flush_work->hr_dev = hr_dev;
> +	INIT_WORK(&flush_work->work, flush_work_handle);
>   
>   	if (init_attr->create_flags)
>   		return -EOPNOTSUPP;


