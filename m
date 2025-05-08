Return-Path: <linux-rdma+bounces-10147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDFAAF3B9
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 08:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167EF3ABE18
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303821638C;
	Thu,  8 May 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnu5crRx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DF4AEE0;
	Thu,  8 May 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685767; cv=none; b=jVSAeN3/grsJTkUVjaLNAYXQSD22Ia94IS3EyWOOM7P+/Wr+QgH8Jr2Yft3e+I5ilNNJmk0h0FQRQ/JQpS2BDG4B46SpsxqKhDBSct4WfoY4ZzCxZZ50Sq6Xy42Nimq343BN8g+LegT6ZGYRqrB87a+jkGL6N1eqqCqwxfLOk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685767; c=relaxed/simple;
	bh=EG1jmU9WpDgOgZB7WH7UYDAnD7QTZXwsYx2m8qU4xP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIk8MsilwIOPSqDh+Y6wntttKqJEATpoloGnTViv81Ul+QYicd05Jzb2A/cJpXc4PMQFSGWzbfywV/7n82Oab9x2CXhCsxBMpHZ1qESsmGEOsnwBuinNB77rQ5hDLRR6B5RoUsMHBV9DYSQqlgvb73+alUzjYeTCxeubV8+9mXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnu5crRx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so6180055e9.3;
        Wed, 07 May 2025 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746685764; x=1747290564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjC1nSPgNwPzXESamIJNGNNa5tx1nPWCngnFXt5aqfQ=;
        b=bnu5crRxoUC2d3lzYx60DC29ZsXYQxzjqxHlQpOxpyI4E1Lml5W/7UIb/T7ubu2r+q
         cP8al7VSos9vdP7xA92SK5mqjdg10FOOwcNUwXhasT1cwTootStZ/e5q+78Z3CGRg5mv
         iRm54W8PueDOhgTBfzBKPwZ8maR4YOJguYI2o0qWrNo6lLVhoemwiU9O7fPd/PtsmrKO
         xXhFhtofuuFYCANCX5e3TGd0rTcY1p54GdeNdjpUq1a+hcZhcTvYnW8UQJmsyr1AuG+9
         c0oRzsNg/jW+a1fc1n16YJny8ZWgmCuZwXGxHicnlX1JpUkWHKRaaGrFpIzkMVctW/xM
         M5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746685764; x=1747290564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjC1nSPgNwPzXESamIJNGNNa5tx1nPWCngnFXt5aqfQ=;
        b=ty36lOosvFThfzr6yJ0fXIe7ip9WJzik1E5odzH679ygZKf/hu7Ryl8k8VANbp2lfW
         8+xRJEVEEdk8lYd3Mz/IQLkCzI3gfSadWn5lvptGsbQ80JhY0SE1UpnnLURjEF3tgWEz
         7qRXGs4UNC7ERkTegUQvxF7jK0wMKlkNdEI5tgiOTUP7WrJuZQfo1vSMDk8spFFSCaja
         2YZ0G6o0EPQyx7Thz+JwMmafx6ANFt7GrVjVUjRxsAU9KVMW2dsxZCG8LkdP8HtgYtZh
         e6c1QC3Wj1OD8O4FP53KknJouSqy8kMM0m0Sw82XO0wP67SQOJUF7kMzSH0W1RgW/TF2
         bvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0o+Kz3GSOBeliV1mIYOn+BPTM8ChxapR5Wo9ByDndnMWB2B2MlpA8Un06kuOkf3sP18v7OVKm@vger.kernel.org, AJvYcCWVucKbL9Ie3+a6pCaUbY1OyATodrQXAESBeyY1zd6q4NCCcBMYlJBeGnqELpu4lBdshe+2MwExZqRoFIo=@vger.kernel.org, AJvYcCWYqptQIZUSE3F0Xpn5Kzcb+8H26Uwfsl8QxKSIXRs9pdV7iyv1LChDjmi/VwvpoRQZFelIqe6Xf+AGbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UsDhgMY+9iCTGewjBPSqx+Fba0oy7CWjMHtGm2C+ED1GwsmL
	MiWRaEOhdckVPJsORlkNGdxdZn6zuU8xOEkj5zM4fFCuQ1dKsy1U
X-Gm-Gg: ASbGncvidEUCnueRXLjc6U8vQlBP+8rQsqVPOQmgVk1DEUtAA2nauilCOTd9WHcu1o9
	wtVpl79q2TDQ9Matb0kHAPP+r2zGSv0VUNi1s8FcxMCct0K9grD8Udg/hsoavW34/rCgt2eLHb3
	SEZLLY06uJqI52uhzz7WkjRCW7RQGjocEYYDDgeCfF1k5PXOT6SrsjWXi/SguliVnQpZuh53i2G
	nr9tEcMGVailCULSy8fDSYpsgvxkWvWIFtTobzYZaPh2fB5lAIoc514uwd5ZUjnWn0DRvQcalxj
	QRBVfkcwD3sf17vtjQsmX3o3M6a8vATXbdMlPJoi1igQBsQWWRGK3Qzzd7qAB3Ic/RWMYdg=
X-Google-Smtp-Source: AGHT+IFuTIQEyN6bZu1AGnLlMV4J2XuIAoxQT1Adad+31AHeFae30vNbC29NW1CfTdQuluEI8mNT2A==
X-Received: by 2002:a05:600c:5129:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-441d44dd0demr36073105e9.26.1746685763545;
        Wed, 07 May 2025 23:29:23 -0700 (PDT)
Received: from [172.27.55.78] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d15dd9c6sm55426115e9.1.2025.05.07.23.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 23:29:23 -0700 (PDT)
Message-ID: <1a1ab6eb-9bfc-4298-ba1e-a6f4229ce091@gmail.com>
Date: Thu, 8 May 2025 09:29:20 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: support software TX timestamp
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, leon@kernel.org,
 Carolina Jubran <cjubran@nvidia.com>
References: <20250506215508.3611977-1-stfomichev@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250506215508.3611977-1-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/05/2025 0:55, Stanislav Fomichev wrote:
> Having a software timestamp (along with existing hardware one) is
> useful to trace how the packets flow through the stack.
> mlx5e_tx_skb_update_hwts_flags is called from tx paths
> to setup HW timestamp; extend it to add software one as well.
> 
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
>   drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index fdf9e9bb99ac..e399d7a3d6cb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
>   		return 0;
>   
>   	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_TX_SOFTWARE |
>   				SOF_TIMESTAMPING_RX_HARDWARE |
>   				SOF_TIMESTAMPING_RAW_HARDWARE;
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> index 4fd853d19e31..f6dd26ad29e5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -341,6 +341,7 @@ static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
>   {
>   	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
>   		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +	skb_tx_timestamp(skb);

Doesn't this interfere with skb_tstamp_tx call in the completion flow 
(mlx5e_consume_skb)?

What happens if both flags (SKBTX_SW_TSTAMP / SKBTX_HW_TSTAMP) are set 
Is it possible?

>   }
>   
>   static void mlx5e_tx_check_stop(struct mlx5e_txqsq *sq)


