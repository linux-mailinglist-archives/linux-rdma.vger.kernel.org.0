Return-Path: <linux-rdma+bounces-6486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056679EFB00
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 19:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25891888CC2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A2223C54;
	Thu, 12 Dec 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUSZcu12"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEF218594;
	Thu, 12 Dec 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028370; cv=none; b=IAsBrQFyVjDHUvix/wX/exZp681a4OGa1YzY0WH9hyjUH/9p2mAtDhKU4kzUhu99fNueRnzSOGH6o2ojJ+jzd0cC78t92m7uxHXJL1abwShgvn1QGn+oGvy2FgNn5OWlA28daD/AhW3VhoktY23p/mC2S8fPWi+me7oiD1X3GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028370; c=relaxed/simple;
	bh=NURB90wRGIQtGvHpZHK8+KtK1idFKaDLMy9I4MPNQNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3ZLZb6OfLo5f3ndkRLyEb6FDOK1eFaKxCYIv435By+8s1KUnRRpoUD7U8aB2FFHNQcElo2qOvoL8HCQFhq0bFp8B8c3jfJFOwvhHmGenR+/Y5zFB6iO08OwT9JJ4hET/y8qrXQs0GYEvfuaV3blA0NqQdgUd8Mnxm1LNqMEXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUSZcu12; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso6554555e9.0;
        Thu, 12 Dec 2024 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734028367; x=1734633167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWktdjl/kWYB1GC6Zg93kea9N92lFMus/9lPyPyncnI=;
        b=dUSZcu12lWOXxZMDNzuyOmkf55RAE8zjTfCkqLg7C03lZv86Ap8isXdl/NdiF0bUTA
         /YV2awEz3qr9kBODsDhufzdwH6EJocSmKyAThjprZN8nIzYZEKLAJjwAaITySkGbW4nO
         UDYf3D6QZZER/OsjcMawWxLwP+vu+xZ5NDpI8brPbtb2NahSKp7nUrtVxlXy+9Fwzf56
         eCOBL+zKscrI/sRgTbe8uOSCR61D8goDP7HDOYrgUA36BZxkHzoPb+dKzJU8FNXh3hzv
         ZpI8SkbyzKAferX+t3Q6SdjjzBwt7VpwxFse6VZGH4kpEG4WSjCtx8nOeoorqBdOntPu
         9FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028367; x=1734633167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWktdjl/kWYB1GC6Zg93kea9N92lFMus/9lPyPyncnI=;
        b=d1MkMwYpVwjWrtEDcvXve4/Z6n4fxpYxjsaLntrPagnG/IUZc9Knxw8qXskfjXAMnV
         5mlizuzYdNSNuNt3oNvZg2btR3NjifPQcddaaAHH6CVl/HktKjTnAiqJsl7kZhwO7Nx1
         oLAz7c681lsuoqTdBJAWnZ0BDQxvdQEVmqGHMiE4f167SQIr1lyXKF1gXzdugLsIi9KO
         aDzZZs6jmEEMpgjSzmhH41vNi/7cZAh6IdAJVzC7pBWECMLcMjklIu2yaxK2qSCR5RJO
         eOYpFHsVauVgZmjjeHBtgZ7VEK/NhX+A3LhaN0zM4lbBXhJFZzI1PtxQJ9sDjbCIQc33
         2ZkA==
X-Forwarded-Encrypted: i=1; AJvYcCUW48jeeOGu3kCKrgAHF3RR6DJvAyVLgWxzkWxBJkl2AnoWHXj6sfO5pkEVKfhxNQAPAf9g6YGH@vger.kernel.org, AJvYcCVXOdtV7hWM/pLpEx/RE4iKcq9esJdYJ+jfs76PbzD5Du0rXSJrWbzR58lw885mxICS0WTRZFic80y/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyynp9BBKDQU8QyfwZnT9UTFb31a5zMfw3DCeBIZB7FMe4Rj/r
	2KRfnCFc6zpGwSxU2A52yw7WM7N921xB/gUTuk5z98vSGFGE9BUi
X-Gm-Gg: ASbGncv8UlH8oMyVcZcXYHdlYz2WX5hf+0GdV+isSXcpkBU0zSzp22gj1j7lICtPus3
	4wy19Z+UdmR/AuWR4flnwOKOmncyrPZ3Qn4LhfExl+b/UZUmCRvGoSvufqE6IWgTOw+CadVpWbB
	mqUU5wHpmmmkuVj10naH+WvDQ144WhRek9kcp7YwOUmHFzWy2PEAAN+oNyXetQmD7qMxOZ060el
	XvcJ8uVLElnObYRRaWauqeu2Q9P0xlYbcyDpS5aWgowt2lblYlPC7nrR8B17Y55FviEdhkqoNSp
	zA==
X-Google-Smtp-Source: AGHT+IFdLztDXFBQj4/ti9O4gJrfl1ie6+YRgfQ+RloUIzBeNQNxqVF/5aLFSsFKFwzLsBO+MlG2yw==
X-Received: by 2002:a05:600c:8507:b0:434:a29d:6c71 with SMTP id 5b1f17b1804b1-4361c411ab0mr61381985e9.27.1734028366467;
        Thu, 12 Dec 2024 10:32:46 -0800 (PST)
Received: from [172.27.21.212] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c66esm24756035e9.14.2024.12.12.10.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:32:46 -0800 (PST)
Message-ID: <5a0dfc70-3899-4dca-b121-52e6bb75743a@gmail.com>
Date: Thu, 12 Dec 2024 20:32:44 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net/mlx5: fs, add counter object to flow
 destination
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-5-tariqt@nvidia.com>
 <20241212172024.GD73795@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241212172024.GD73795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2024 19:20, Simon Horman wrote:
> On Wed, Dec 11, 2024 at 03:42:15PM +0200, Tariq Toukan wrote:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> Currently mlx5_flow_destination includes counter_id which is assigned in
>> case we use flow counter on the flow steering rule. However, counter_id
>> is not enough data in case of using HW Steering. Thus, have mlx5_fc
>> object as part of mlx5_flow_destination instead of counter_id and assign
>> it where needed.
>>
>> In case counter_id is received from user space, create a local counter
>> object to represent it.
>>
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> Unfortunately, I think that this misses two counter_id instances
> in mlx5_vnet.c and the following is needed:
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 5f581e71e201..36099047560d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1952,7 +1952,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>   		goto out_free;
>   
>   #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> -	dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
> +	dests[1].counter = node->ucast_counter.counter;
>   #endif
>   	node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
>   	if (IS_ERR(node->ucast_rule)) {
> @@ -1961,7 +1961,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>   	}
>   
>   #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> -	dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
> +	dests[1].counter = node->mcast_counter.counter;
>   #endif
>   
>   	memset(dmac_c, 0, ETH_ALEN);
> 
> You can observe this with an allmodconfig build.
> 

Thanks, will fix.

> 
> Also, please consider including a "Returns:" section in
> the Kernel doc of mlx5_fc_local_create().
> 

I'll add.

