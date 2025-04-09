Return-Path: <linux-rdma+bounces-9295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F9CA82787
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D93A8A5141
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544D2561CE;
	Wed,  9 Apr 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwkyqpgR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FD146A68;
	Wed,  9 Apr 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208186; cv=none; b=Fj6mkUgE/PJ3E3ZagK4Fjq88erRNk1ERBwAX302+zObXd/OdafbiNe0476ND5wA2A2ph2iU3HUAM9N9qojYwVHj3Kid4AfMUm2ptjmP+y54R2Utv3ZqitEfxM2gLaP2ZxqsADClFnrYN8iXVi1OlPs83cXxzmtjWpQcLwCcRyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208186; c=relaxed/simple;
	bh=wgBh74AC5PSY0Rhovr3LWr0xFBnpMao88YVPufTq+JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcQy43D97NjBuDTY502EjSZm/VcfMzYkTDbh1b7i5STPnYgUg0GivHN0RKL8HOxylsf3vb4tmVPR4inTXvuyisRJMWg9my/Nb2cWgmS/A/Xk589cQrE036SteVFMgvOnP4Jp7/oXx2BFkxZdalMj4vPI5He4qIHp+Q3zOjjA6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwkyqpgR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so4266000f8f.0;
        Wed, 09 Apr 2025 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744208183; x=1744812983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Su54CZV9ZzBu8ekatyouE8vmUbZWIL/eeN2h4R3olwo=;
        b=IwkyqpgRfhToR/rFZmIydRtK4j3pUk95nFsR9VgPFmTrdG1CzL12L5rENvlo2AfaCQ
         8OnK1qxZ5L10WmUuxLnY+xoK0FoaB4t37Nvg69iwFRaqbTn61NUL15yYheC1ALhckY/0
         mMjzjJ09q4RNKoUxU7/BfT1K0C1pjwM2qnsFvZrAw8eKytw+o8mVDD6KLsVvZiX2xUDf
         /HoXFZUTFHryD0fbZihB+3TZGZTp2IszhzMyiD1wsvEwTRre8CYmQ7SdH9XY6t2m4Qp5
         wClntUAnclKQfb0DNJB5CUDAGmCliMh6+q3NGF1Rr9v7R8Udx0+DBIAytJxl5SCxB4he
         cfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744208183; x=1744812983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Su54CZV9ZzBu8ekatyouE8vmUbZWIL/eeN2h4R3olwo=;
        b=DTBBA3YOPZrIo0IeE4mS8Xk6LzrsEW57z0nuxdfTLlidjgwX747S8beC2f4S/TaTMw
         kriRt9cWoKb/1Xdt0YkSGxr6iChOXYRUJGESg8ofGPzr6XaxjDAIAJMZPct37mhVoV+s
         7dmfvO0JUK7OU1ZOZdajSDzmVyP3rDNmApNEWy+JNfav0A4fAxOs266FQieJ7iPNGd4Z
         YDeMW7UT2BkK8mbo7zO0t2soBDO1aOyCB53YUmMAgW/l3zDUHf1twF/mToCJ+M4cp8dv
         z0VRwGW7KLFmMo0YgxAmQWyYWpHuYC7pmOQCCQgS2RJPd6F4nUVjEypqEU64za1kCipA
         UGvA==
X-Forwarded-Encrypted: i=1; AJvYcCVNVmnMInYXF27qGvkB+hXPa6PMr4gkjLd8YD7SZgY0d7mToBFn/vEeVhsUhA/aT9Bmez/P4Ht6q7/Y9w==@vger.kernel.org, AJvYcCVYBAI37/lVyjsTQrn6Ayx0cjc0CcZuBR45EdJP49uHoaABPMkzfRfYH+YNtYqbNSWgC7A49ERaMjuhFT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCD3umQgIlYCu4twNqPIYcOhRD8FvE/fRpf7bQIAjI03d+n06q
	Ye0obL+K3qiiFSxzICg5C9bljXOpwyFZ2lvcclPMUKtY5Tp1Io4D
X-Gm-Gg: ASbGncsX2MNbvL0Xcw64rXveCQWe8T1/ZfKc9U3fFE1d/tuvTXhuBOCtIX0HEQCy4r3
	5dXvxXOCNwT6snaEIQYDiKeBBv9OHOLzVuuDR2J4/1VJec6/JHyu6NxXVS1gd/gf8NlU5j1LekA
	OcyzfV7gCTDrIw93DJ9FG/rWv9CYtGbk5HM4fzdKG1Q+GoTTadqnpZ8JKT3bEtQpb0g1iSX0w5N
	BjM4Bw9/6uf/Ak7mtyb1bfiJrGSZklAeSPS99H6DW6OtJLcw+FcXro4t5+pp4OI4NYmKAMURl1C
	wiU9ZOFQUWszWdjBOKdiG7u0yMPGjI9AzSgCkf8u75wC+dXFegM5CGx5te89pjMn0NIMRw==
X-Google-Smtp-Source: AGHT+IH5PtvT1Q5mNxJJw8S4/NxblErYAye3a4FJQF4+G3Ub5UhQoKef2OqPv4i57N28SduluX9ZuQ==
X-Received: by 2002:a05:6000:4021:b0:391:1806:e23f with SMTP id ffacd0b85a97d-39d885315b0mr2311897f8f.17.1744208182415;
        Wed, 09 Apr 2025 07:16:22 -0700 (PDT)
Received: from [10.80.20.47] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e90sm17553245e9.38.2025.04.09.07.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:16:22 -0700 (PDT)
Message-ID: <e83ff2bd-1f29-4aa9-bb66-4f06a73867ac@gmail.com>
Date: Wed, 9 Apr 2025 17:16:18 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] net/mlx5e: fix potential null dereference in
 mlx5e_tc_nic_create_miss_table
To: Charles Han <hanchunchao@inspur.com>, saeedm@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lariel@nvidia.com, paulb@nvidia.com,
 maord@nvidia.com, Henry Martin <bsdhenrymartin@gmail.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <0e08292e-9280-4ef6-baf7-e9f642d33177@gmail.com>
 <20250407072032.5232-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250407072032.5232-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/04/2025 10:20, Charles Han wrote:
> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for ns.
> 
> Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 9ba99609999f..c2f23ac95c3d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
>   	ft_attr.level = MLX5E_TC_MISS_LEVEL;
>   	ft_attr.prio = 0;
>   	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
> +	if (!ns) {
> +		netdev_err(priv->mdev, "Failed to get flow namespace\n");
> +		return -EOPNOTSUPP;
> +	}
>   
>   	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
>   	if (IS_ERR(*ft)) {


Too many similar patches submitted individually in parallel by multiple 
authors..

One can easily lose track.

Please gather similar patches in a series, provide cover letter and 
target branch.

Tariq.

