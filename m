Return-Path: <linux-rdma+bounces-7891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B4A3DA02
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 13:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E38860992
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8431F4639;
	Thu, 20 Feb 2025 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pT5D4IxO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C1F1521
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054227; cv=none; b=noBAJ/A9lkDSoVa6bjegmddH5A/ppGCet4AGuL3xHRTRLU52CO1aZb7WYZ46yVQydr2o2700pWFJwPpCtEWmGLo2yeVecaYA4SC7R00/4ek+mnYFne1X7XlT514M49PjIvirwj4aOrggh9O6Zp9c5HafIiRVtWJPmBiNbdEhK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054227; c=relaxed/simple;
	bh=Nxf/JaItaX+CDnIA1dz1p0Zl1+osaRZpQ0okTYK0Wwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwDJsbEGIKzSRbIM9X6woZ0iJdC3e3if0bzN95sCFT0+nzbm/pSOnTeBl1KvRTSJTS/iiyCOStagF/Uc3hEqY13Gl4wK/wpNtMBJz5pEYpyRjxPkGnr7uFB8ESwpn2pGiwoz4pOb8u32SwN50WiWgK+5VbR53bsFwtSHmZ4JA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pT5D4IxO; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1229cbb2-b7b9-4b47-8276-62bd9c79a7ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740054222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXhJMxvhrKPneluOHj8hPStthqxFTOVnuw1AoXjOvhE=;
	b=pT5D4IxOi03Shu+7BePGEp6KG+K9nHFVQLXM0zqW4s2C+jYgBE+plRrkRkdAL/HtUTfgHa
	le6m0YZLJQZzvyasmgXwosz3jzDH6VhJymAusKIRdAvDEq+d49RcY/F7yc50u8HTKNSaXo
	2FZ79SnzfCWJ35wrO9zDNPfBhyfrLaA=
Date: Thu, 20 Feb 2025 13:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix bind QP error cleanup flow
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
 Mark Zhang <markzhang@nvidia.com>
References: <25dfefddb0ebefa668c32e06a94d84e3216257cf.1740033937.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <25dfefddb0ebefa668c32e06a94d84e3216257cf.1740033937.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/20 7:47, Leon Romanovsky 写道:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> When there is a failure during bind QP, the cleanup flow destroys the
> counter regardless if it is the one that created it or not, which is
> problematic since if it isn't the one that created it, that counter could
> still be in use.
> 
> Fix that by destroying the counter only if it was created during this call.
> 
> Fixes: 45842fc627c7 ("IB/mlx5: Support statistic q counter configuration")
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/hw/mlx5/counters.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
> index 4f6c1968a2ee..81cfa74147a1 100644
> --- a/drivers/infiniband/hw/mlx5/counters.c
> +++ b/drivers/infiniband/hw/mlx5/counters.c
> @@ -546,6 +546,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
>   				   struct ib_qp *qp)
>   {
>   	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> +	bool new = false;
>   	int err;
>   
>   	if (!counter->id) {
> @@ -560,6 +561,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
>   			return err;
>   		counter->id =
>   			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
> +		new = true;
It seems that there is no other better method except that a new bool 
variable is used. IMO, this method can fix this problem.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   	}
>   
>   	err = mlx5_ib_qp_set_counter(qp, counter);
> @@ -569,8 +571,10 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
>   	return 0;
>   
>   fail_set_counter:
> -	mlx5_ib_counter_dealloc(counter);
> -	counter->id = 0;
> +	if (new) {
> +		mlx5_ib_counter_dealloc(counter);
> +		counter->id = 0;
> +	}
>   
>   	return err;
>   }


