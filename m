Return-Path: <linux-rdma+bounces-9443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC63A89C79
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 13:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF7F16AE76
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDAA29615B;
	Tue, 15 Apr 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLrpNKzV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900842951DD;
	Tue, 15 Apr 2025 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716424; cv=none; b=tKj1MGICgPONBItZKRTs8y1McgSxS/CPRBHZqzgBTylbz4YxUMjz/h92JSdEX2XHBxN4gwAxqNqWScskcKLou9hmGvob3yLNr2ZdcDcz1ik4rQWoKDKtZMvLffd246x1wSBBe9BFs9ojdyRiPqzueMMivBLPrmJ2t8yh7e9TNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716424; c=relaxed/simple;
	bh=FaCD1PkoKrxS9v1U5rFWElyeE6LW8xfKfPTFbahvHaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxEkr8sefGcr+BAK8BVLeZQJ5ezUTGbFg/UPGEEt9Nx7yZPwMNyShB4HjC+HrIELtAPahlj3FcwoRPm7kZcmBSV2l1uDUtxeNR+lvIWkOcjQggsI1lpKii9FIryWJcCjOm8Ro22K4Smw4iiQYYCk/NsOYzJ01BwTzWgc9ULvEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLrpNKzV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-399749152b4so3049802f8f.3;
        Tue, 15 Apr 2025 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744716421; x=1745321221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iNvyUJ84OrchQt/uudTnU275/tZN5oX4rI5S/XVpaE=;
        b=mLrpNKzVGLP9uvOkWH5kFsk1EOvIvB1O9AUR/qQ40X+fYa6qJhblhcyLwnQlxOjltz
         ZwOn4ffPpYhSFIDm/Ljwr8NpfjS2Jl7UXblm0QqNC8NCFRz3V727D1D1OcOIVG+zgbGR
         p+0lcDzHNd8PMuTwZU1a10gnp87jrTD9QL+9tqh47w9bkHouAlhCuBLV1Kzp/xiRj39Z
         6BbMwL2GD/tKQi9WmFmzbjtqthZ84X5hciktmA8urYX+141GduJqdbuN7PGYCSoLpdbo
         r+wGbn3QMmGMsBi88sIpEfjbIAaNYr5j9zR3hUhTy7ZuqQMbyxSrdVO33oy3bZX+X1oY
         n/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744716421; x=1745321221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iNvyUJ84OrchQt/uudTnU275/tZN5oX4rI5S/XVpaE=;
        b=Vyei5mR7TyMBO+A7iSowU09RtUZdyEsR/adZnZWxBUU+GwqDGK9Z6UQEwwHjusyM+k
         1sYzlqol1D7cZjj8BByF0tJgmxeSo5HzTk69yPK1GE41DniCCkLo4NAsshBK2W0dKMXM
         /egvzE/TtJEzfdYsb8X6DB/qa5G7PVUHXRqiftBHDQG82Kv7l0jn3AiP34q8xl131ArN
         ztNuIhTsV9Ze1Al9l/SpXthi4UPSdFejbq+ebCwHdUXhbEtu//PeotQnxJPhdhZK3NvU
         7rsgOFyZHt6JGVpbBMQzjptTWxaLiqRs+jGbnRwuDu4204rK6iXwhN2e/A12f1Kneez5
         wRGA==
X-Forwarded-Encrypted: i=1; AJvYcCUUb4ZWsXy/e1mR25LiCaiLZq2YqSI0Oa5rvzhdTWKkXPgOdN7J5lxZESmG2qe3f7dICnwhYwpX@vger.kernel.org, AJvYcCVByzcNXt+LicCRqZB13g4gNhh8c+HjrOiw3ied5BQOFkHPytJ64NrwPTDf+K1cvbFo7Hc9KoBVJxxv84Q=@vger.kernel.org, AJvYcCXFSsax7knxxLAfm25ArkBs7il90gJxcd1uB/MQzxJSB4lKiufm3Syy3Yg54esDMvphM9rKA3qiqrfJHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRGz799KePKRf5ovnFpoJ/YXU/mnOBcK3Gm+1WaFKnawcPSpr
	UaMYd6BXaL2dBhLMf6nKx4vf4ppfJxxrybbaFdshTVFvFAyA5zMi
X-Gm-Gg: ASbGncte0srJ8tn0fiR6jIN6ap+qlUQEA58FeRtGjVLSYIyfTiv2RofGQlBgvKN5Iju
	c/olKjYLkLalLgorQ0Q6XfCjoG2q5zT/MNOrtqljpkPYb97XJTbKBE3xrog8JBKibdI/HYo1RnL
	OK2DkEtcfx4Tnce8CG0ubfZOHMmJlb7Fq5UcoGxuXmOcSFmRYk84I5chdN5fujmaerxySRYJvSB
	iUWlxDWzIdIxq0aJ84G2/a49upaG8s1aZF1i2BACgbxRaMg1ZYdAHLEeYPPzdAYjE2izzuNMDNW
	F+UppQ+o7EGtmKjCzZwuwVLrN9yv7A0ptmFdKGp3UskOSYyy7sH+jif6R7YZOw==
X-Google-Smtp-Source: AGHT+IGMq12De2oewFtOUPkn4B9s8mMPlc1IAgczwnQeYBI/+GnxWt2tkhjormePlZdXHT1UTfHavw==
X-Received: by 2002:a05:6000:40dd:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39eaaea8457mr11165434f8f.30.1744716420525;
        Tue, 15 Apr 2025 04:27:00 -0700 (PDT)
Received: from [172.27.58.151] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979615sm14294303f8f.54.2025.04.15.04.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 04:27:00 -0700 (PDT)
Message-ID: <c909292b-68ae-4396-8494-aaa555604168@gmail.com>
Date: Tue, 15 Apr 2025 14:26:57 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
To: Henry Martin <bsdhenrymartin@gmail.com>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, amirtz@nvidia.com, ayal@nvidia.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250411131431.46537-1-bsdhenrymartin@gmail.com>
 <20250411131431.46537-2-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250411131431.46537-2-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/04/2025 16:14, Henry Martin wrote:
> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> NULL pointer dereference.
> 
> Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V3 -> V4: Fix potential memory leak.
> V2 -> V3: No functional changes, just gathering the patches in a series.
> V1 -> V2: Add a empty line after the return statement.
> 
>   drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> index eb3bd9c7f66e..077fe908bf86 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> @@ -651,10 +651,16 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>   			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, inner_l4_type);
>   		break;
>   	default:
> +		kvfree(ttc);

Unrelated change.
Not described in patch subject or commit message.
Please introduce in a separate patch.

>   		return ERR_PTR(-EINVAL);
>   	}
>   
>   	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns) {
> +		kvfree(ttc);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>   	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>   			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
>   
> @@ -724,10 +730,16 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>   			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, outer_l4_type);
>   		break;
>   	default:
> +		kvfree(ttc);

Same.

>   		return ERR_PTR(-EINVAL);
>   	}
>   
>   	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns){
> +		kvfree(ttc);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>   	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>   			       &ttc_groups[TTC_GROUPS_DEFAULT];
>   


