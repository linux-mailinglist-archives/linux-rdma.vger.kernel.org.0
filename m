Return-Path: <linux-rdma+bounces-5510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ED59AED01
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 19:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D161C23009
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74561FAEE8;
	Thu, 24 Oct 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr3i/Xle"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BD1F76BF;
	Thu, 24 Oct 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789182; cv=none; b=fNkiwc7KWqTnZSSNR2qZPN9QTZF+68RAwYUKuggca1Q0JSDN67sTafIlgkg0Frav3uAlHAkhntGpdzPD5Dd2Kx2snUdQIkHdns9LaLeOtea6wh44C1ZELD4zr20zGn2ncdity/ac4w6h30rl18kIAH/FvYNOUS7pW6o8Pdq+Ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789182; c=relaxed/simple;
	bh=hijoaAkA0Q1vuwuxsDMLMH0T3wTBuF66RCAzz/8HohY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nj9nYXaIhWGCawFt7Ku2HZPl5ReamFlDdg64yMM3cPzCAIgNeJMq183i86vKhXI+rjl5euOJ+eZtCQheOck3533R3ERSQHejC9flLIYTMvAd9X7Sg3si2JHMfQS82tiTNLwqPKGnxCyNRDCfbalQlOhxtqtIjJzNS6VjQp8pSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr3i/Xle; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4c482844so762391f8f.0;
        Thu, 24 Oct 2024 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789179; x=1730393979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gu2G2lobjatrPbeH6vXaNXTLwzS6HsUqu9OMwxk35RI=;
        b=cr3i/XleggF7hadYk/4UABFruZr4xWeuY61LG04ECjJlf4MAnkmxgqBgnllm1ts9nZ
         CKu7sa5ZNOqigJSq1Ju/OBDC3kiVG+3gDKF/bp+w2I8/zMvxJyKT5WJAlpLvFjf8ThDO
         uvo2rnFe8Tzf7HWWdWRAoGCGSLkE46shQ91xzrzursAsswFfkOWSG/fjOe3pdGTtu66/
         akq7g6jJYRixREmSAAL2/x80Lm6iKmm7XdikNtG3FxzqTIaw/8hF9D4/4QkmLacYhh4T
         6NhySPFLgEJN0pdTWdEqcIhJW2SVbOnilHjmGUGklkkM2cwDmpPyeaAkUH+M8eFNH+8j
         J54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789179; x=1730393979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu2G2lobjatrPbeH6vXaNXTLwzS6HsUqu9OMwxk35RI=;
        b=IQk82q+FxvG6qGC8NRmw1+zxZD2MokQK53m9AT3RGXv3auxITR9yb3G9lDt/XDYs3K
         9HqCnpDjPBYSJiTk+XvaKnvsZ4+rMSrX7SWYBgx1nkWBJleMRNgVev0hWVMoNIEyvxKD
         Uo29hYeuS1wyTcs3l8IaewrRPLHD9jRILczGOMTgJEd6+cG1bkQUcmIPdgzpeRUiJMkn
         HZnkSh04UDWVpzn5yZ2okZKme5dt/6FOjIWW8atoXOP3bnCgoZULWEfMSmYxWsKmD1Ld
         2li3XShUbGaEcObvhTf2ZDpLq4GAMroZQp//Nbf3zHwa/aDbAaVlqKBnd6BBcoRtkji0
         Pkmw==
X-Forwarded-Encrypted: i=1; AJvYcCVTs3qeA9lpcwrzXmkT/52cgKq0FpWQHwD3afoeoCH6FGwj7gGyV7szTUKOxIl0sd/v7SFoqTkLrYXH0Q==@vger.kernel.org, AJvYcCVW1hMDXCQp746iARew0lvNnD7g7sGHxy/iLA5Z0dFfuKlDC8xSZAvPVAcggeURgTXWeD1tum6loHxHTP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Xc7fRge65iTDus0aqaktZtNK9cSXHhgi4Z7hxg4dhNDl131e
	EYOAW/9yAt7EoOJXDv27CjZ7kXIQ/KEdIhSHcIhngQzBCKw44KcZ
X-Google-Smtp-Source: AGHT+IFB2OdRP4GkB6KDaGovcRDbtaEcBs0vVOwofPqhFV1VR5HWfkL9vlgZb/5+swBXv7WdGH4XYQ==
X-Received: by 2002:adf:cd0a:0:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-3803ac84467mr1940093f8f.3.1729789178251;
        Thu, 24 Oct 2024 09:59:38 -0700 (PDT)
Received: from [172.27.21.144] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b7afsm11753362f8f.59.2024.10.24.09.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:59:37 -0700 (PDT)
Message-ID: <469dfbf5-4b5f-4457-8f88-f180b2c3a8ae@gmail.com>
Date: Thu, 24 Oct 2024 19:59:34 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mlx5: simplify EQ interrupt polling logic
To: Caleb Sander Mateos <csander@purestorage.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241023205113.255866-1-csander@purestorage.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241023205113.255866-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2024 23:51, Caleb Sander Mateos wrote:
> Use a while loop in mlx5_eq_comp_int() and mlx5_eq_async_int() to
> clarify the EQE polling logic. This consolidates the next_eqe_sw() calls
> for the first and subequent iterations. It also avoids a goto. Turn the
> num_eqes < MLX5_EQ_POLLING_BUDGET check into a break condition.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c | 22 +++++++-------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index 68cb86b37e56..859dcf09b770 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -114,15 +114,11 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
>   	struct mlx5_eq *eq = &eq_comp->core;
>   	struct mlx5_eqe *eqe;
>   	int num_eqes = 0;
>   	u32 cqn = -1;
>   
> -	eqe = next_eqe_sw(eq);
> -	if (!eqe)
> -		goto out;
> -
> -	do {
> +	while ((eqe = next_eqe_sw(eq))) {
>   		struct mlx5_core_cq *cq;
>   
>   		/* Make sure we read EQ entry contents after we've
>   		 * checked the ownership bit.
>   		 */
> @@ -140,13 +136,14 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
>   					    "Completion event for bogus CQ 0x%x\n", cqn);
>   		}
>   
>   		++eq->cons_index;
>   
> -	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe = next_eqe_sw(eq)));
> +		if (++num_eqes >= MLX5_EQ_POLLING_BUDGET)
> +			break;
> +	}
>   
> -out:
>   	eq_update_ci(eq, 1);
>   
>   	if (cqn != -1)
>   		tasklet_schedule(&eq_comp->tasklet_ctx.task);
>   
> @@ -213,15 +210,11 @@ static int mlx5_eq_async_int(struct notifier_block *nb,
>   	eqt = dev->priv.eq_table;
>   
>   	recovery = action == ASYNC_EQ_RECOVER;
>   	mlx5_eq_async_int_lock(eq_async, recovery, &flags);
>   
> -	eqe = next_eqe_sw(eq);
> -	if (!eqe)
> -		goto out;
> -
> -	do {
> +	while ((eqe = next_eqe_sw(eq))) {
>   		/*
>   		 * Make sure we read EQ entry contents after we've
>   		 * checked the ownership bit.
>   		 */
>   		dma_rmb();
> @@ -229,13 +222,14 @@ static int mlx5_eq_async_int(struct notifier_block *nb,
>   		atomic_notifier_call_chain(&eqt->nh[eqe->type], eqe->type, eqe);
>   		atomic_notifier_call_chain(&eqt->nh[MLX5_EVENT_TYPE_NOTIFY_ANY], eqe->type, eqe);
>   
>   		++eq->cons_index;
>   
> -	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe = next_eqe_sw(eq)));
> +		if (++num_eqes >= MLX5_EQ_POLLING_BUDGET)
> +			break;
> +	}
>   
> -out:
>   	eq_update_ci(eq, 1);
>   	mlx5_eq_async_int_unlock(eq_async, recovery, &flags);
>   
>   	return unlikely(recovery) ? num_eqes : 0;
>   }

LGTM.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

