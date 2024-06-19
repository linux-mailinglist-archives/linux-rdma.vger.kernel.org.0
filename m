Return-Path: <linux-rdma+bounces-3290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F015B90E2E4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 07:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1821F215C3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E157CA2;
	Wed, 19 Jun 2024 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyZ/3FEn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079450A8F;
	Wed, 19 Jun 2024 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776372; cv=none; b=b3VpZZSFvmfyTrC2QHNXs0o75PYFanl5OSM1q7Fu4zaz8Dv2/FHH1K9qWiYUWp5TYFsX0m7MpfKHCEvV9SAdGkuuJWQPCoCD5kZIY3azo0hPtsY89KSd9Q+z/sZNWt7RzIsUqJq2VybmfHfE2LhPWnIV3C/uRuRJPy375zm5Wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776372; c=relaxed/simple;
	bh=Bf6ivIExz8zfAvy49x2nO3xMAeQ19Tjwgj9B7mpxn00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmoaEE67HbfofgvvddqPd6sMi7QNqFX6nT9lznx4QDUAiEs3kC+SaTS4MU5T1Wz5skxLzHvUPxfcCOIMhIuIgLMpEbS4eAh8yxXRaY9BU3Uz0jS8zUWK8SGGnYN+vZmtQzWW8Bm5eaGg12Z3KslYWRcG33mGxevqBD59Kk6CbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyZ/3FEn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so55055515e9.0;
        Tue, 18 Jun 2024 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718776369; x=1719381169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BDjLD+jVj6hHcDyDsyMfGk0MZn6jMSnQ02FIFYQ7WI=;
        b=HyZ/3FEnODIzYv3AmccrNOAhZ474LVdjoeC4xCwCB15JB1j6N6x34MuF6vvIiqV8YW
         2xY36OCjIlV+YIMSgdpOwWnOpSN0hKiQmQz10hhG6wzs+3ctQFok1rS8byYDwa0mgmxc
         uSNEeUTLrbsG+fOOPiCDhzDtaA7DsnfqPlfYwxMWmGsKfx/SdSyKRKEE4w1NXpDTt+ru
         qnHQcmyemX4tEG27gThnYMQUwVnli+fgH5jxrd9OWR8JDIowHezR25wXIKQQ+C54VmFS
         G7OAWpHKMKMCJBK1y3Jap44S1CNzlyrGxfLaz/bNsaTh1QpXqUO8hfZ8FPlGH0FVrGJE
         aeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776369; x=1719381169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BDjLD+jVj6hHcDyDsyMfGk0MZn6jMSnQ02FIFYQ7WI=;
        b=QBx7aQkIxcOIpW0GiXh81ok8tjPg2b8ojcL/PkQ9acGJ6HtgggEsFDH1Py5T74eRoI
         2XbWG/HSafSNp88oGVfoSZWci4vslkjM6x2s5itlU8Q45stgpC3cHyziq0HH+MbVhjsL
         +C+QMdoX1lWfuwE/YbByh3VIWn7Lj9s8kj6xO668VVMZJi8tqJZ/ACc1CGih9m9uzVXq
         TTwWoFT7Wn3cBTqNPvviiLmnfV/SD5L8guc4kSX2Xc7xRVIllYFUaGcaJtJvji42vYPk
         8i+Qzp/3qaEDKLf/k6VvYhAjidUpeoLqMb95R/vr1LQoz6lrrWheveI4+Vlx90SeUEzN
         kRmA==
X-Forwarded-Encrypted: i=1; AJvYcCW25te4fxwFuCCU6ujtpz8q7rTNg71ljWbmTOdMLSLSqmcePB1aLsFm2PgvNLQJJt2cgWreum+mGcZWDDlMbTe1INZoCSCcxbdGDDJhVdBWU89wBW9wLhuQCeJQut11DqVC47GeVd0+TbOtzSeR+nepP158rcaxW9Q3XSdw56Hb3g==
X-Gm-Message-State: AOJu0YxreD37f5nWTbRFayslqsLY3Gemd1oq4H2WBCa5waiqDgJ2YOen
	OsbjYLaJm8eLTDBxmvylQV1KtkZFFGyKp+382qtU7ClLyd05J7o3
X-Google-Smtp-Source: AGHT+IGm8fI7my84UpMbK/79zSNEEwKvqtEUrRePLinfxu0UlWQPN1yKT/N3o6BCqJTRKKAH2U927g==
X-Received: by 2002:adf:e9cc:0:b0:361:a87f:36dd with SMTP id ffacd0b85a97d-363171e2bdcmr1125382f8f.3.1718776369067;
        Tue, 18 Jun 2024 22:52:49 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750acfeasm16107360f8f.65.2024.06.18.22.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 22:52:48 -0700 (PDT)
Message-ID: <dbcfeac8-d3f5-4731-9bd8-fa1857436d29@gmail.com>
Date: Wed, 19 Jun 2024 08:52:46 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Lag, Remove NULL check before dev_{put, hold}
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, saeedm@nvidia.com
Cc: leon@kernel.org, tariqt@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/06/2024 6:53, Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
> is no need to check before using dev_{put, hold}, remove it to silence
> the warning:
> 
> ./drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:1518:2-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9361
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index d0871c46b8c5..a2fd9a84f877 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1514,8 +1514,7 @@ struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
>   	} else {
>   		ndev = ldev->pf[MLX5_LAG_P1].netdev;
>   	}
> -	if (ndev)
> -		dev_hold(ndev);
> +	dev_hold(ndev);
>   
>   unlock:
>   	spin_unlock_irqrestore(&lag_lock, flags);

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks.

