Return-Path: <linux-rdma+bounces-12481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E9B120E9
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470165A51CB
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4092EE5FA;
	Fri, 25 Jul 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOpamd8r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3BD2376FD
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457221; cv=none; b=PO7GQyBelIhJmGZtDSoNwhpfO6ksUdGLifYc4Q+ude1+hhzClhLj/nosJZSHn4Fv8PxYU/tNENQVKH9a+Tz64Uepc+b4epDZjzyPBn5Vk4PdjgiWXUpAIqJH5OnGdvmEVs0OizTrHSAtWzcg1jybaOUD+E4neARs2VIyBeA2DlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457221; c=relaxed/simple;
	bh=/ABf+NZbV94UOe4fZ1WW33iHqFp9yJH2TGl+SPFbozM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txdpfiM6bqBYflUlvYlZ9Etk7oYCTJ9Rk8lguBQvdFoIqhz0XGyxG58d1RxUAbKBzF0BzrO+WZBz42m8sn7lw+irlmAl4fLn1XsXzmHwk1M85y82mZPyW2dLQPW6Q2Zv9LQG8HwE9ZAYH2wTso573BawMFm3znZS6XzuKtHD530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOpamd8r; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <151434e7-449b-4a8f-a203-78da1b12ecdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753457215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Qc5qqSxe1nqUbX1q2qQFF8sKW3ry68WWaADSA6l3Uw=;
	b=bOpamd8r0CWes3Qb0hoP8uoxHVaG9QdjQZ6ANpznj93yJKNW7mGDZX+ynAHney445FXIH0
	8xI6J5tyxr4OS4FUtJ4xyhKfk+c7lR4ICnbdIrptgopW641tPLwFPPZK7Jxq7l1qT99/ae
	JC9AmrUocJgPzOQA/NPgUQMld3BI1Ds=
Date: Fri, 25 Jul 2025 08:26:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/3] RDMA/erdma: Fix unset QPN of GSI QP
To: Boshi Yu <boshiyu@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
 kaishen@linux.alibaba.com
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
 <20250725055410.67520-4-boshiyu@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250725055410.67520-4-boshiyu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/24 22:53, Boshi Yu 写道:
> The QPN of the GSI QP was not set, which may cause issues.
> Set the QPN to 1 when creating the GSI QP.

In 17.2.7 MANAGEMENT MESSAGES

"
QP1, used for the General Services Interface (GSI).
• This QP uses the Unreliable Datagram transport service.
• All traffic to and from this QP uses any VL other than VL15.
• GSI packets arriving before the current packet’s command
completes may be dropped (i.e. the minimum queue depth of
QP1 is one).
"

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> Fixes: 999a0a2e9b87 ("RDMA/erdma: Support UD QPs and UD WRs")
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> ---
>   drivers/infiniband/hw/erdma/erdma_verbs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 32b11ce228dc..996860f49b2f 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -1022,6 +1022,8 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
>   		old_entry = xa_store(&dev->qp_xa, 1, qp, GFP_KERNEL);
>   		if (xa_is_err(old_entry))
>   			ret = xa_err(old_entry);
> +		else
> +			qp->ibqp.qp_num = 1;
>   	} else {
>   		ret = xa_alloc_cyclic(&dev->qp_xa, &qp->ibqp.qp_num, qp,
>   				      XA_LIMIT(1, dev->attrs.max_qp - 1),



