Return-Path: <linux-rdma+bounces-10501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD5ABFCD2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6618E3B378D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705C22FDE2;
	Wed, 21 May 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MKrwbtkS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740F1A5B86
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852070; cv=none; b=RRauhBUEfMQB2CzKYcz4/2ylUin6NMbGmuSfAplKJf3c1DrWZT2vdEMmUbjlmU49q1fnu8XJrLt+Yd8Z9iqAMtB2TOK8yGM9Admse1+r5wknmG8wBvVMJ4xRGbF+OJnqFdRYFSL863M3eZeXGb2nqOGkRfPBKH12bI8sPAqVod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852070; c=relaxed/simple;
	bh=BzCNz0CPUU9S3DwyryCSULsKsZmUspc1zfAIDjOJKBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWt1OZ1IFcdcd/QYVYz+kYg4YwUwrYuEi94nj0pMTGphMvCJMhWHEnrcFx02w+6x6a0+fRZ8ZlgQLPZM2MCfNh7wPLeBeFuG3azc97iDEE+Xl8tSXY/kzU6NZeNJjF7pRE+0Ow0L3gLfcFBGriG9qZ5kwKCM4G9AkZv6Ze35TX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MKrwbtkS; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac9cb366-ec1b-4331-8d2b-8f6bf7cc556e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747852065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPnBizkQbCK/AK1wSsFC1Brd0eJwxWgmuXCnH4sb0nI=;
	b=MKrwbtkS5AIzivDH7Bf5JS3l3q8N9mEMoxhWyfs82u+CwnKLFUauqLtrn5MD5YNh141mdf
	z11oVcg3R28ucg6hcjt0LG3FU6/ATsGgLiVPuGOKmo733FFvFEQTGr9uWzwv/gO94pgkvA
	sNbvxYZQEUjarDZx8v+/Rb1Nffh35a4=
Date: Wed, 21 May 2025 20:27:42 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Avoid flexible array warning
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <7b891b96a9fc053d01284c184d25ae98d35db2d4.1747827041.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <7b891b96a9fc053d01284c184d25ae98d35db2d4.1747827041.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/21 13:34, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The following warning is reported by sparse tool:
> drivers/infiniband/hw/mlx5/fs.c:1664:26: warning: array of flexible
> structures
> 
> Avoid it by simply splitting array into two separate structs.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

In my local host, I can reproduce this problem. And I think that this 
commit can fix this problem.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/hw/mlx5/fs.c | 58 ++++++++++++---------------------
>   1 file changed, 21 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
> index 251246c73b339..1d67f0ce6b59a 100644
> --- a/drivers/infiniband/hw/mlx5/fs.c
> +++ b/drivers/infiniband/hw/mlx5/fs.c
> @@ -1645,11 +1645,6 @@ static struct mlx5_ib_flow_handler *create_flow_rule(struct mlx5_ib_dev *dev,
>   	return _create_flow_rule(dev, ft_prio, flow_attr, dst, 0, NULL);
>   }
>   
> -enum {
> -	LEFTOVERS_MC,
> -	LEFTOVERS_UC,
> -};
> -
>   static struct mlx5_ib_flow_handler *create_leftovers_rule(struct mlx5_ib_dev *dev,
>   							  struct mlx5_ib_flow_prio *ft_prio,
>   							  struct ib_flow_attr *flow_attr,
> @@ -1659,43 +1654,32 @@ static struct mlx5_ib_flow_handler *create_leftovers_rule(struct mlx5_ib_dev *de
>   	struct mlx5_ib_flow_handler *handler = NULL;
>   
>   	static struct {
> -		struct ib_flow_attr	flow_attr;
>   		struct ib_flow_spec_eth eth_flow;
> -	} leftovers_specs[] = {
> -		[LEFTOVERS_MC] = {
> -			.flow_attr = {
> -				.num_of_specs = 1,
> -				.size = sizeof(leftovers_specs[0])
> -			},
> -			.eth_flow = {
> -				.type = IB_FLOW_SPEC_ETH,
> -				.size = sizeof(struct ib_flow_spec_eth),
> -				.mask = {.dst_mac = {0x1} },
> -				.val =  {.dst_mac = {0x1} }
> -			}
> -		},
> -		[LEFTOVERS_UC] = {
> -			.flow_attr = {
> -				.num_of_specs = 1,
> -				.size = sizeof(leftovers_specs[0])
> -			},
> -			.eth_flow = {
> -				.type = IB_FLOW_SPEC_ETH,
> -				.size = sizeof(struct ib_flow_spec_eth),
> -				.mask = {.dst_mac = {0x1} },
> -				.val = {.dst_mac = {} }
> -			}
> -		}
> -	};
> +		struct ib_flow_attr	flow_attr;
> +	} leftovers_wc = { .flow_attr = { .num_of_specs = 1,
> +					  .size = sizeof(leftovers_wc) },
> +			   .eth_flow = {
> +				   .type = IB_FLOW_SPEC_ETH,
> +				   .size = sizeof(struct ib_flow_spec_eth),
> +				   .mask = { .dst_mac = { 0x1 } },
> +				   .val = { .dst_mac = { 0x1 } } } };
>   
> -	handler = create_flow_rule(dev, ft_prio,
> -				   &leftovers_specs[LEFTOVERS_MC].flow_attr,
> -				   dst);
> +	static struct {
> +		struct ib_flow_spec_eth eth_flow;
> +		struct ib_flow_attr	flow_attr;
> +	} leftovers_uc = { .flow_attr = { .num_of_specs = 1,
> +					  .size = sizeof(leftovers_uc) },
> +			   .eth_flow = {
> +				   .type = IB_FLOW_SPEC_ETH,
> +				   .size = sizeof(struct ib_flow_spec_eth),
> +				   .mask = { .dst_mac = { 0x1 } },
> +				   .val = { .dst_mac = {} } } };
> +
> +	handler = create_flow_rule(dev, ft_prio, &leftovers_wc.flow_attr, dst);
>   	if (!IS_ERR(handler) &&
>   	    flow_attr->type == IB_FLOW_ATTR_ALL_DEFAULT) {
>   		handler_ucast = create_flow_rule(dev, ft_prio,
> -						 &leftovers_specs[LEFTOVERS_UC].flow_attr,
> -						 dst);
> +						 &leftovers_uc.flow_attr, dst);
>   		if (IS_ERR(handler_ucast)) {
>   			mlx5_del_flow_rules(handler->rule);
>   			ft_prio->refcount--;


