Return-Path: <linux-rdma+bounces-14050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC56EC0A835
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EDE94EC3C2
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C732DF138;
	Sun, 26 Oct 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTr/t0GQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278862DECB9
	for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482759; cv=none; b=VBrLUH6v6JXUjKf+BEEIO9BvPjzh2mobK2O7Kl7yESyDcbmBMZGQSD13La5lltbU6WuZBYjuH0kC/Fvf+HrQJOghWxB+AmhZ8kdmFsTGNHLl2AGXzn3/5e/ZgfGQazjFTBLILbmKwkjWojCkcZeCwnO1W/0XINa2jmgGa0ahGHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482759; c=relaxed/simple;
	bh=jta8UcMskjWbNypa5z0lHLxUyNsbNK0Nm1519GtFVQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfPiWaCCz9vGiiJ5IogaajYBgK8/edxBVUVeG1ZeqVOrFXEH+/6erbvyMrJE2+BdoBtNFtEDSr8UXfpY++GnxUdsGl022veMhQlQkXP/NKje9QVPEARC6u4dzKH1JT5AUZmZAm2tIC4f0iWlu6xoigZWFwtg074QOdQU43ZWoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTr/t0GQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47114a40161so40839525e9.3
        for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761482756; x=1762087556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q36qJLmrYKmdd1QEVA+Cbqtb2Y9+2l5D3yHSIltOmXY=;
        b=jTr/t0GQOf7ajug5gf3QY2Aj8KRAmAX06kLXbb1J/ToZXE+K+Wx1jXSrW5tHhA17wf
         +TTEK6EZB9s/kU2AjizJLCqFYeR2M1NHgqEiE1j5Sn7yaqJjHroP7LXK5dUy+Nplp/N7
         DMe6byPyBWuWds7SFOG8zmnJ0XgwKbX2VtZYhH/pohzB7YmPewN45oIQo9okt+UcEsif
         xKLt7RTvhe94llewoyqoSA/MOUSo2QRSEfITqEwoCOa43jzZWASCFuCahl4sZwO9I4Kt
         c78i4XYj1qNMmTMyeZnJIVsvEy9TaJ8MqliJp7FcgWYLkAERbzOlpEucZpvoaMTBMohR
         ZM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761482756; x=1762087556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q36qJLmrYKmdd1QEVA+Cbqtb2Y9+2l5D3yHSIltOmXY=;
        b=REiZmqbM69YxZgnUf9sdpVkRDVftIhd5SNFHSf0ouRasQD8hmVIntQJe5nuo+N8QWN
         4MlnKcFhOTUNCwl8LzZ/LRXOZcpGuyMOtBldMYH62KctbVHAhKizZ68AsVNYkbXegFPQ
         AvPjbheGtUAWgseQp6eDTEiBiKDF077UQKzwH/hSwl6l2KohbNXUFoDqnu0PoXqBN/Xq
         g1JBtmhUw2bE41S32TNJMlBB9rCWY4uaH1Xk7ZEc9TcFmB8DiaAtQLm8fZZmEba07HAj
         jmak1ENxFOkdCSjBLGSDCtB7dPEuS8jTcOGLExh8y9N1Ch7gpd/etbhNQei2OHil9e5g
         UXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjch3fDgW9xhxzFOBYNYFSgk+4pBUHW0VsvulkjQ2QbTydqVuMYeEge2OzxW6j/k4NZPtF2jZB6+i@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8dIgTO+LJxfrndirloswReU1/BvTuqXPB5Wv5xaZyy/X3IJd
	MyOq8xkiv6BNv5C6DpoVd5hK2hSsxuiObf+0sWWd8UGBaNb8rFGx3Rwy
X-Gm-Gg: ASbGncvlbvTcn2E/WiZV9CW2GhY9sRW2amn7Sdk/MQU8PbQ/TfC4WiFhWWjJTX4kWM1
	qNp0N9t3SObrIJt0tEyeh9Sa9+Df5I2UO8wjAsN7aKVGr6peDwOb4IUbBxUr8o62Ffh0Tcttb1s
	c0giDElotGExi5itaooDxNmmQ5jebGqCU42BnmNSHXd7zwpeFgJil9yxAgBYX1UdGRzCCligDQb
	Tyr/Q25+AkW3ex5+fUd4fNoFwWR52O2vOUDd2MxQMiLZJvWlT9HaPaSz6Q9EzRau/xyXW9UbIub
	nGnbnN1Qv8f6DirerbeGcl/L6UiaKiwRGFc6bt95qqGBop+IYNOaf9XzIojVEt0Ks26LtK9GlXM
	oDwisoCbVVzjw87z3FhnonRnitjk3ZW+UFBCMot7F983K/nPYZhwZtekg37hD6QP08TzbID3eEO
	H9SYEOwKsEo6tcNee6aNplF7EpK6QvcsL5Hw==
X-Google-Smtp-Source: AGHT+IHt5MAZo995R68Y4k9GXv4DRni8YIVI2eVz6novIi2dRMGcotavRNOIPiF0acEmlMfwdr/5OA==
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr209197245e9.13.1761482756014;
        Sun, 26 Oct 2025 05:45:56 -0700 (PDT)
Received: from [10.221.206.54] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cd5dsm80346105e9.4.2025.10.26.05.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 05:45:55 -0700 (PDT)
Message-ID: <a3807c58-be93-423c-b801-339c657a0bb9@gmail.com>
Date: Sun, 26 Oct 2025 14:45:54 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
 <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
 <aPonYFV1S4N5COKZ@horms.kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aPonYFV1S4N5COKZ@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2025 16:02, Simon Horman wrote:
> On Thu, Oct 23, 2025 at 09:43:35AM +0300, Tariq Toukan wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
>> index 19499072f67f..0b55e77f19c8 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
>> @@ -146,6 +146,31 @@ void mlx5e_tir_builder_build_direct(struct mlx5e_tir_builder *builder)
>>   	MLX5_SET(tirc, tirc, rx_hash_fn, MLX5_RX_HASH_FN_INVERTED_XOR8);
>>   }
>>   
>> +static void mlx5e_tir_context_self_lb_block(void *tirc, bool enable_uc_lb,
>> +					    bool enable_mc_lb)
>> +{
>> +	u8 lb_flags = 0;
>> +
>> +	if (enable_uc_lb)
>> +		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
>> +	if (enable_mc_lb)
>> +		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
>> +
>> +	MLX5_SET(tirc, tirc, self_lb_block, lb_flags);
>> +}
>> +
>> +void mlx5e_tir_builder_build_self_lb_block(struct mlx5e_tir_builder *builder,
>> +					   bool enable_uc_lb,
>> +					   bool enable_mc_lb)
>> +{
>> +	void *tirc = mlx5e_tir_builder_get_tirc(builder);
>> +
>> +	if (builder->modify)
>> +		MLX5_SET(modify_tir_in, builder->in, bitmask.self_lb_en, 1);
>> +
>> +	mlx5e_tir_context_self_lb_block(tirc, enable_uc_lb, enable_mc_lb);
>> +}
>> +
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>> index 376a018b2db1..fad6b761f622 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>> @@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
>>   int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
>>   			 bool enable_mc_lb)
> 
> ...
> 
>> -	if (enable_uc_lb)
>> -		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
>> -
>> -	if (enable_mc_lb)
>> -		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
>> -
>> -	if (lb_flags)
>> -		MLX5_SET(modify_tir_in, in, ctx.self_lb_block, lb_flags);
>> -
>> -	MLX5_SET(modify_tir_in, in, bitmask.self_lb_en, 1);
>> +	mlx5e_tir_builder_build_self_lb_block(builder, enable_uc_lb,
>> +					      enable_mc_lb);
> 
> Hi,
> 
> Maybe I'm reading this wrong, and possibly it is not important,
> but it seems to me that the update above reverses the
> 
> ...
> order of the MLX5_SET() invocations.
> 

The order here is not important.
The FW command is filled in any order and only then FW is called.


