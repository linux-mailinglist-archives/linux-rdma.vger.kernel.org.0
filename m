Return-Path: <linux-rdma+bounces-12209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46FCB06DDF
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 08:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4114E1125
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 06:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A562882D8;
	Wed, 16 Jul 2025 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNz9sDPy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FE2882C3;
	Wed, 16 Jul 2025 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647140; cv=none; b=oZiNqJA1Y//J9YzxejDdl0NdWi30FUrhhuvEPkHXBQpwW05y1r6usQ1KPkE2Ip5DIEOvv8aFVEEN/Mk9HDzfxicBm2VS+tchdmvaPWg0dp8rLPM4jtVC8arLV4E8cyRR8X5u/5p/yMp6PKem4m8NRmWpd4imjtxzVY+hWtBTR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647140; c=relaxed/simple;
	bh=CXZJNwcV9g4cCWofAPhw1/dzNXLMspHjTFDCbICIxf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piZPnIDkDj8PZKwh5UGyFBIuTStcGK0d43XkONVogQema2HdglJ+UfQWE5WBQv6QH+FyNJLVMe/9Sa4Wc79Trw0hm7Ha7IcKrjKTvNLKGr17ErqqkcHbaKsB7RJZjuJslUdmC3St7I49pvzvQJOK8GywvjgC8xi1SR0YhD2qh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNz9sDPy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45348bff79fso71349965e9.2;
        Tue, 15 Jul 2025 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752647137; x=1753251937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRZBKbHE/70C7J1yRSTOwPBNDDrsyZ8B0bPbXOABTIY=;
        b=JNz9sDPyTbgT1OASZxGWI8n7010i2v1Aw01lc85DcbT0/lNi41VA2SHV4cL6RriBo1
         TIGUcYWklRnwdNXueHoScyuXm7X0q1DCfajvXTjQJ9MdqguPigQ7EuMeaaMhm1rz3SOX
         KDBnr4oixU37hYFye46a6G5gsIFOi2FgBJrrvNL7C8pAmIe4spXZwvJyol1ZkJmcC9n0
         5xVTPt0N69fHqNxZ0gul3ERQaEmRS1QSGi7H1jiZZkjXIMMB6oudDIFAN6RFXWyhJ2S+
         BqTsEF/dgu0f++UwserjQ6JrWqY2oOF39UzhNl0cNv+V1aNb6lLbL56e0OYdoh2wqHY7
         GnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752647137; x=1753251937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRZBKbHE/70C7J1yRSTOwPBNDDrsyZ8B0bPbXOABTIY=;
        b=DJ++NdXmPJyKNt/+QIKX6eNSkXwl3l0Tn+rKjUSb25tjpso6mEzYTqRjt3NZvSOUcw
         yZW2WVbB4r1NIpUm+yrM5I8EeEVQdh9/WhLn/NMvBzH5Gq15/SIfrjCfmFCnvpDrmmZV
         8xl5y04dSmj2JTno8pAbvvutquq7Ksi9FHVhWZFu15+/zHawrkpecG9DM2h8s1QmtTT0
         8w3QhFt5OlWoUOuR0g7OZgtQFX4aYVlAiO0HLWv952l9WImx5jCYgu466i6v0v0P0UEk
         1cRnkgQckaeSP7krB8NsVF1vUt38xr7dKNmvnAN7RzRvL6z1RZQzW3gFQCyipo0GYUq4
         RRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0RWIUqAvSjt4/O+iyZIPdDEiYt/k6oVqHb7+DvCarkIPjJJUhZ7mH+GCBnsRqok9L6m0nXG6N@vger.kernel.org, AJvYcCUfCHxBGqLhZkS2HCk5/RIuzDpzfu4NRwNSg+s11TUcRxZW0NGX96mirmzQhBjH9XGKZs3su72bvZqt26BWGWc=@vger.kernel.org, AJvYcCWOfxDA+MfLwyZ6cOe4FLbq6F28sL5fuGhXsYaRd5Le73Zw9R8W0hAR+TPoVPTirEsT+gQSniOpo5vYQaNO@vger.kernel.org, AJvYcCWtBKkc0ANdjPl8RYfFMuU6YeDney7Ra9ZMkK4VVGliPhI1ymnFgbvIYaPctEL895iUhYVmlp2YndZGfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvldI3Thz9uQ94OgKRPjBkl7UJqDEhSq4drxzlKGJuXDydW6Ca
	xL2dlf4Cut2vw+U6x2QsTla1bSwKokP34dvwBox/Nf+57MrqOgkQBN+3
X-Gm-Gg: ASbGnctMfYUyYT8yNlFk+XbQKEeU2bcZHc/Idc8YR2Zs8cxGQJwCQkkwTZYvMMLSkLY
	bdvo9aI2RFbIIwuwlktq3R9LJlKZs9Hx0eEWmLPxOcnSJWbKn90HFIJoKkKmWLAyZ5kmLHlTsMW
	SS8RehiVatHlP6fnr5QNqhG5JFAmJHYJrN6XadiBGmhPPs8GAIeB+g5oUsY+XCYGi9E0lCdcR5+
	JV11ZIx1BGDQHFq5I3/maFulNFMyZGfqJ5A8rhP+di1E0Lt3X+ZgksnuLkJbafsw62qGwZ8HgUx
	cw5CxOYbY9GoZim5NF5fwAk04u6RCWmoxczBhv2hEQFYgHNGcow+KndB+vO3kEuILCqbWOrXGSq
	MfcVpKcwk8/GbZVmS+knvZHeooA83nktgUC1URzPwF8tE/A==
X-Google-Smtp-Source: AGHT+IErWcCruAU8JOeELAqiyXcJgxqfIC95um24KJrHPc0qCG5TlnBhgWNImkGOoPwXAmI0BFHIRQ==
X-Received: by 2002:a05:600c:4ed3:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-4562e3cac86mr11875435e9.30.1752647136271;
        Tue, 15 Jul 2025 23:25:36 -0700 (PDT)
Received: from [10.80.16.197] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8075d6sm10653015e9.16.2025.07.15.23.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 23:25:35 -0700 (PDT)
Message-ID: <83adce36-0c4c-41c0-bcd6-bc4dc93b5667@gmail.com>
Date: Wed, 16 Jul 2025 09:25:33 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Fix an IS_ERR() vs NULL bug in
 esw_qos_move_node()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Carolina Jubran <cjubran@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <0ce4ec2a-2b5d-4652-9638-e715a99902a7@sabinyo.mountain>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <0ce4ec2a-2b5d-4652-9638-e715a99902a7@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/2025 2:01, Dan Carpenter wrote:
> The __esw_qos_alloc_node() function returns NULL on error.  It doesn't
> return error pointers.  Update the error checking to match.
> 
> Fixes: 96619c485fa6 ("net/mlx5: Add support for setting tc-bw on nodes")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> index e1cef8dd3b4d..91d863c8c152 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> @@ -1405,9 +1405,10 @@ esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
>   
>   	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
>   					curr_node->type, NULL);
> -	if (!IS_ERR(new_node))
> -		esw_qos_nodes_set_parent(&curr_node->children, new_node);
> +	if (!new_node)
> +		return ERR_PTR(-ENOMEM);
>   
> +	esw_qos_nodes_set_parent(&curr_node->children, new_node);
>   	return new_node;
>   }
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

