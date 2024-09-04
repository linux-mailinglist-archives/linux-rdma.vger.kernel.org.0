Return-Path: <linux-rdma+bounces-4729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BFF96B0E4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 08:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A56028784A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BDD84A22;
	Wed,  4 Sep 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OUterwV8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760639B
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429766; cv=none; b=dWo6SMrVwL3SIVpUoamjIjwk3XcPFH/gvsrazw3O/GYoer8X0gPpQzoGKRH/5Tl8cPKrC2pAKCfHloY67KG7WcpqfoTM7Eoq98UAlpSzgPMF4rrYFLjckKovocYJ/T4S34NZwPEyXRtMbMIxAxphX/GbarvQNSn7m1/h9Dgp05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429766; c=relaxed/simple;
	bh=HzEvWlKvksN/zPt68FjMHxvx+sIX0Y+awhwXofG4Ipc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bncgGzpT0IFaKRG22+9mSuRcI/mpRJAUlt3nF2uMxwgXmTL/PnypSuAa1SBuxjmL25Qta7qkXywVf0Jct/XhX6Drp89QHmKFTe/YYD+evK+oCXelgXkbL1MIU6o71dsIHcUWq0Qhx4xB1B/ZPN5OP49g85wnJwsWxfFWf/CFX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OUterwV8; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725429762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VplJowlwUHkxbOtIka1lBspa4LGEnbwTD6GYsRWVesA=;
	b=OUterwV8m+D7FoeupQ/cGiky34F5U8VcTLoTJBta+D03U+8EzCGHbFfqq9HxR9cLesstuw
	akfjXXbzoYPkAWnaEBI7a/PEqDln4UnL/2NV0f7tIyi09Sn8yyRyoKuo9qUs/RDqOY4Xp1
	fUKN+r/IeoBHBboX4msIHxdmY68qzPQ=
Date: Wed, 4 Sep 2024 14:02:32 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
References: <cover.1725362773.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <cover.1725362773.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/3 19:37, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series from Edward introduces mlx5 data direct placement (DDP)
> feature.
> 
> This feature allows WRs on the receiver side of the QP to be consumed
> out of order, permitting the sender side to transmit messages without
> guaranteeing arrival order on the receiver side.
> 
> When enabled, the completion ordering of WRs remains in-order,
> regardless of the Receive WRs consumption order.
> 
> RDMA Read and RDMA Atomic operations on the responder side continue to
> be executed in-order, while the ordering of data placement for RDMA
> Write and Send operations is not guaranteed.

It is an interesting feature. If I got this feature correctly, this 
feature permits the user consumes the data out of order when RDMA Write 
and Send operations. But its completiong ordering is still in order.

Any scenario that this feature can be applied and what benefits will be 
got from this feature?

I am just curious about this. Normally the users will consume the data 
in order. In what scenario, the user will consume the data out of order?

Thanks,
Zhu Yanjun

> 
> Thanks
> 
> Edward Srouji (2):
>    net/mlx5: Introduce data placement ordering bits
>    RDMA/mlx5: Support OOO RX WQE consumption
> 
>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>   drivers/infiniband/hw/mlx5/qp.c      | 51 +++++++++++++++++++++++++---
>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>   5 files changed, 78 insertions(+), 11 deletions(-)
> 


