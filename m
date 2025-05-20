Return-Path: <linux-rdma+bounces-10436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C2ABD6B9
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 13:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B59E1772D4
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB673276054;
	Tue, 20 May 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPUnczY1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A8272E50;
	Tue, 20 May 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740413; cv=none; b=vFXv+7SE6I6ysybdomtPP2JVNt1tNAZFStdokyi/zgHIm4bKejYiPUXJ1uRFi3jWcPUrePL8jymfGfjFJV8TuwYNBJTEtTAHu75+QXmD52i9NMH3YilsPteW4G2C5reRJgwbnrMRzFNk7uc3BcNsLoDmlRJQ7vHET4xSa5nh0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740413; c=relaxed/simple;
	bh=JNKKAVIRdXZkKCbs03d5e+diybFHMv4yKmliktPT6DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4sPK5gYndSHqgdaV2Re0b/9K+XttHTMW8VVTbjujLThX+TJZ3xf7iIXjcUK4uwCeHinYyurQWbr0ybOrMSqtA8JNt+oXLQhsGVMAAlV5tcxvJs6iBNJ5ZlMxCDXw4yT6DqdNfQlKlZ4gqqmoLsvhG03CQNo8vFG+ECmZwiq6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPUnczY1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so60649355e9.2;
        Tue, 20 May 2025 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747740410; x=1748345210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5Nc37UBrybGHAf/E7YcJb9DPLEQjXOem8ihIqVBCYc=;
        b=QPUnczY1FWUAnefLb3sLDCzbSHNU3YfituS7uBbBrCYYSfEz7K+WNoT/ib8VU+NaR1
         wTV5c2KV+jbUH0EWLAlhlJiaRFAmRnrJg8P1ckS8RVp6EtTFPUGRX4dbQ8icz4bVJyxl
         lReGVibBl8DCbH4RyM7LX3MWXnnu6G5LN1HP+cvl8Rg+jQc0BpPMlS0mOs6fq/sSI8Zp
         MVxALKw/KtgzWcFJGu6pASDdZDJ35zhOXS18XOQ5+PC/n/sEgm5WdNjX5UZyEJT4OCq9
         AyPm66P6Gm2BY0PnQ0pUxwzplrwyVbclk5BgS7ARpRM40z+Fy4lGNJj9av33F2/kPU7O
         SgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747740410; x=1748345210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5Nc37UBrybGHAf/E7YcJb9DPLEQjXOem8ihIqVBCYc=;
        b=GJIB8HhvDUSzYVdnazBSvu/hIJ55V+rGQyuVb5S4gwsnP6mTMNsgY50OqASM4GKc4M
         9BnFrla37HshDf9YMsvHJZZUZHbcUjBgFVEPOqjfO8UzOkt+ifydG7ZSQYaz+cLve88S
         9v4QDyYZOP6ohNltvB4eNelISG1N5Lbx+x8AgIMr7NjbwWnbiNAM/hGyD3mENTAQyHy7
         YvnGWPYo+L6oTigA1e/tP5H1RTet5P6fJ1n6uqrWiFc78EjW6NwPyCms/ksx3oXo2wkk
         m+zETeoFvx+QlyV4KU2xwqGr6QiZJfnrbURXCFgo9f2hLIsHsGeuHtVFgKN3nrH4Vqjs
         hUTw==
X-Forwarded-Encrypted: i=1; AJvYcCUFNZPkxH6vdsx3L1VNPcPTG0NI//RW2MoSoQqM6T4OazpVDgHNskL79UddMYPmiY7bU06Y+WqZk+5zOA==@vger.kernel.org, AJvYcCVHuKj5fuW0rtUaxn+64upQhecR7UeVqGCaUZdCo3TU1//szBpOlgGwhZm3nmK6WloHfyC/uvOZ@vger.kernel.org, AJvYcCVthL6pV6Xvvx29TQHYftuiEzbf2zLpkAEYQzXr4aEttYiAqLcAmBcbxcipfL8F4UItHP1WyjId9gkA32Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegD7MVIrvWIq5f83Ozl7SAHWAYhQ3moYdeQ0gDB/YsW7ag6kz
	wYD2hT0HT3WP2/2YjvsXHoy1KNU624PP9gu5N385Awe3fKIbFlps7ObG
X-Gm-Gg: ASbGncs2t2REyDGunF2MuJPnGdk43GtPjxdTDSC9jXLYg5wGduSWIJK0yzzDgv7dUG5
	AuHnAtxBvKCxh26lm9Sq/XQeVMWg+M+vEbDSUaX6fR6qezsdx9ESe75lrUeBXL/0MCC0hQ8wd0P
	aCE+b+HWOk1URtHb6WT5od9s9l6kyhDJz9hn/TXwKESoHpsQB+IweF8mPXFlIINEvj0VFESlAel
	OOlUaxjkPLUUNAvgi9HlKq3ni3iZ1zyxuzaXJx7pL+m5SXcNJWyWj1bF5WNRu+5XRyCXFo2VfVy
	19BMsyJH2zFosnHVV5S0XbWF3OOk8sSq1V4B1jtx80bhMlUfXCMrNXvX64GhE0ne9vR7n+rt
X-Google-Smtp-Source: AGHT+IETchTqJQYCpkxocqHC30GbhPL8WmbfAe6Z9vDHltLbEq8r4oVZQ9nofp5uV9mZgT/R1HC/Bg==
X-Received: by 2002:a05:600c:a016:b0:441:d2d8:bd8b with SMTP id 5b1f17b1804b1-442fd622c81mr161905795e9.8.1747740409681;
        Tue, 20 May 2025 04:26:49 -0700 (PDT)
Received: from [172.27.21.230] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4a3csm28194905e9.22.2025.05.20.04.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:26:49 -0700 (PDT)
Message-ID: <2d96b30a-8da4-4bca-a366-bbc4bec257a0@gmail.com>
Date: Tue, 20 May 2025 14:26:45 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mlx5: vport: Add error handling in
 mlx5_query_nic_vport_qkey_viol_cntr()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250519090147.1894-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250519090147.1894-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/05/2025 12:01, Wentao Liang wrote:
> The function mlx5_query_nic_vport_qkey_viol_cntr() calls the function
> mlx5_query_nic_vport_context() but does not check its return value. This
> could lead to undefined behavior if the query fails. A proper
> implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Remove redundant reassignment. Fix RCT.
> 
>   drivers/net/ethernet/mellanox/mlx5/core/vport.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index 0d5f750faa45..ded086ffe8ac 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -519,19 +519,22 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
>   {
>   	u32 *out;
>   	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
> +	int ret;
>   
>   	out = kvzalloc(outlen, GFP_KERNEL);
>   	if (!out)
>   		return -ENOMEM;
>   
> -	mlx5_query_nic_vport_context(mdev, 0, out);
> +	ret = mlx5_query_nic_vport_context(mdev, 0, out);
> +	if (ret)
> +		goto out;
>   
>   	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
>   				   nic_vport_context.qkey_violation_counter);
> -
> +out:
>   	kvfree(out);
>   
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_qkey_viol_cntr);
>   

Same comments on similar patch apply here:
https://patchwork.kernel.org/project/netdevbpf/patch/20250519090934.1956-1-vulab@iscas.ac.cn/


