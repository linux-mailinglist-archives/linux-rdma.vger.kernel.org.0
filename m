Return-Path: <linux-rdma+bounces-10435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB92ABD6AB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 13:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EEB176D4C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EFB27A12E;
	Tue, 20 May 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG26BpoY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3452741A9;
	Tue, 20 May 2025 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740276; cv=none; b=imqXD2RrK5AWdQ8DSswdlawZQtlvq2vbcJLCBNgjZB3AuYFM5ZSx5827gYKfz0XD+FlM3IMlhcuyxpkK2A1mgoiWwqNfi6w+8n2ci90dmCDTMdHp1/01CA6p3VKxUoXK+0luW5DHIrftP5HgBRboyXAmt99lU8I6eRisQdUDNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740276; c=relaxed/simple;
	bh=uekzMaZ2X12t/zfefgkihTJWl19rME1e2Eux1eOqhhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UV+POx5rtGYq/EvFKNRiCwb9ZJMdGhioBETAqKEUrah/Mavvufr1a0OC60MMKMKGW3KbB3KaQMeZRySQHE1CmX9AC6EkUa5jVmtzug47rgL37VLzbFZZYm+mjjq9c3uLoFxXdb+/nEAjmhWHInvZ+IQQKASXS/M/XgEUl9We77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG26BpoY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a35919fa8bso2113671f8f.0;
        Tue, 20 May 2025 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747740273; x=1748345073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzP2zEzKlxlWUEgDvsH1MOAZoRJxjWkomVsFFlFJowU=;
        b=DG26BpoYD6fgvik24b8X2P0+fD6xRq5h+JZCDdCxXURb8vRMlcY9zKmDiaY5bg/71k
         RLtm9uYaWztqhWDl7haYUIp9xGiDYOTOVbA5vYgjR0ijMd6NdfTqxcFCin2t0NSJ4yqN
         asl8QuR1/+W2FmIIRPhEDB5urKxb/fLyQ1z0M4YxIivb4vNaGt9eGcigG3MHuFWgSKZs
         AWPYH/+gQsH4OV2P1lEdkhrSoPjACTilHO6FfZ+kZlJrDQbJ447gXPDgv/0nYbt5oVwu
         t/5rPBQlT/rVoVmr8Kvb2X/6f94IndHAT90ysyZOcsDfTFczi2H4DPw6lhblSy691e5H
         J7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747740273; x=1748345073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzP2zEzKlxlWUEgDvsH1MOAZoRJxjWkomVsFFlFJowU=;
        b=uLErMJvEFozE332V4me5aoBS7dbQqUbT9VsytzVi+dioThMitAmSCIReRsXkJ4OAER
         HuOybvfqd3cWUmH/MZ+jsEghl5VIrGqDsQ+f5x7Hora38MRWtGHkEJ/rPRxhHVk8+prt
         4Tlz8I5UQOS2Tco1F0fUYFP6fDlGuS8CGFKG/dBS/b7fe1mCY1nblUby3HVI0tPUifKK
         o2QeEN9FKn9moELRcyhlDv0DWoYqxG3dx3MPqtBCnlv5bAOzw29257UPiR+/1k2qrJE8
         4W99Sb1bnpDgTkpX4tJBC/KlCeQMeL0PJrn6PsGdQNSecdxCw6hCdZacr+F40as4cMMn
         s40g==
X-Forwarded-Encrypted: i=1; AJvYcCUCNllqVkGRwLrbMoB8146tjtUYJJWRdM2Bg+DvNpcAPnMx0ZgRs+uvXoM23aG5fWVjm76XdBafZZ6QQg==@vger.kernel.org, AJvYcCV0vDXZmy7MbKDzLef2rfS5vCNai2xmAjcAJ3Aevc3HusTZHmNF02aU1Zupa4kRNI3jT//2HVg7@vger.kernel.org, AJvYcCVn2I1UZMGNEi/HzKf8k193GJt7hHtIqTlHPiOVc+rYXl25V7vEa8e46GRHlIXgiN04mE4fJ4xjgTP/73M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SSE/eoI84QF01YYGceIouMGMPM5vweidMOPjZAFHFyQLlwBW
	FtcN+1+9Tiw8DVUSSVogjiPip5FzDe9t/2AwKOEE5iE+Ez8/m4yjbEfa
X-Gm-Gg: ASbGnctiGcs0mIbC+MbXiGQ4vmXgbvQmAYqvPGTM2mCIi07wdkUBTpCo/nCDXp6fgCG
	5YDeNlcH7Pw/6ohbKAnwuz7aRVEzChKyyQ3TwR8KdvseffZqLLpRssA2rrQMyC1LuoOcqcJHZSg
	Iwr5VxRS2JyZDTf1C2o2cCVbLPIawYhEab//tHLuM5texoiFRpoQaI3FRcn7QPueI+UKCJfIFvj
	lXnF6FHt5iNGCmbm2D3x4gWzqcD7CxJZJGmdivyA0e9Jebx0z0ikxZLEPa21qaxv4To3P0esd/B
	RicwnvsoKisA6U0aHWiq5iVglnIxAxxN6bCtF6x0fyeXXf4rImmpfHl6bC7qpnmv8Gqyl2CP
X-Google-Smtp-Source: AGHT+IFbt6ddIOndtm3/Lla6xrWUETZElRQcmHsqPtTVbbF0e7Y0OObM533dcU1ZAo/ZzOjWbv/SoA==
X-Received: by 2002:adf:eed1:0:b0:3a3:6584:3f9f with SMTP id ffacd0b85a97d-3a365844b60mr8479378f8f.43.1747740273244;
        Tue, 20 May 2025 04:24:33 -0700 (PDT)
Received: from [172.27.21.230] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d2ddsm15915498f8f.7.2025.05.20.04.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:24:32 -0700 (PDT)
Message-ID: <fc1308e9-c150-452e-81b3-21537930cc0a@gmail.com>
Date: Tue, 20 May 2025 14:24:29 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mlx5: vport: Add error handling in
 mlx5_query_nic_vport_node_guid()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250519090934.1956-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250519090934.1956-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Prefer 'net/mlx5' prefix for mlx5_core patches.

On 19/05/2025 12:09, Wentao Liang wrote:

V2 respinned too quickly.
Please hold at least 24 hours between respins.

> The function mlx5_query_nic_vport_node_guid() calls the function
> mlx5_query_nic_vport_context() but does not check its return value.
> A proper implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Explicitly mention target branch.

> ---
> v2: Remove redundant reassignment. Fix typo error.
> 
>   drivers/net/ethernet/mellanox/mlx5/core/vport.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index ded086ffe8ac..8235fa6add03 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -465,19 +465,22 @@ int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
>   {
>   	u32 *out;
>   	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
> +	int ret;

Let's be consistent with existing convention in this file.
There are many similar examples.

Use local variable 'err', and label 'out'.

>   
>   	out = kvzalloc(outlen, GFP_KERNEL);
>   	if (!out)
>   		return -ENOMEM;
>   
> -	mlx5_query_nic_vport_context(mdev, 0, out);
> +	ret = mlx5_query_nic_vport_context(mdev, 0, out);
> +	if (ret)
> +		goto err;
>   
>   	*node_guid = MLX5_GET64(query_nic_vport_context_out, out,
>   				nic_vport_context.node_guid);
> -
> +err:
>   	kvfree(out);
>   
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_node_guid);
>   


