Return-Path: <linux-rdma+bounces-10262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05428AB26E7
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 08:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F5B188E0FE
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 06:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB9191F6A;
	Sun, 11 May 2025 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4vN5yQ9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7213CF9C;
	Sun, 11 May 2025 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746944621; cv=none; b=rUHpSpKlwgHpYlupY+Fk2LRTM+x04Mk7ldHv8v8tV1UdowaTXgqG+YuDMBkBe1lPJUnoK+CddzG3C/grSCd90i4xxiQf+6A8QXBLRP0LEMZDM5Qs20+rUJmTvjRDhlh4HbX610nQWc392si50yMUm3dZ1481iY7xMQqBTod7niY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746944621; c=relaxed/simple;
	bh=XRXI1dFWC2evk8VpVxbYbs3Js/dKAUFFwwk2s6QGs1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7JeNcBF01bcUTCPu0/gX4qNSvWURJWmiA6CN4FVUAQkR+s9SY3b+7SJATjp6dmW3hadEvndhhDYeuFfTuKTxN9+Y6aXzrv93sfp9xwx/WMQ/I711J1iS+LRih0qkOyGYR7pOE/8NHaIRg3ue48nKAqthtuX+g1dJSVBipf78i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4vN5yQ9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad243cdbe98so88843766b.0;
        Sat, 10 May 2025 23:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746944618; x=1747549418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1+g4uBPIIPeKp4LkDWHl6XKodFAe4OiLqdzjIJdnxU=;
        b=Y4vN5yQ9adx9hR3Rlvx5Uf5zp5eKyDbE06txI/fFDJDU+2fELtngwpOUr7Vlh7n5Fg
         J2RJdqyB8VJtp9cxWwxf9a8DzeH1/W34q8zwu/wanXGclsFmtcFMjE68PoB0/whQrNQv
         705bdtyEoeNyxBVNcNBKSL7c88l0WNaEnyzAc1qMfiL/iRzyWHCVdQTwuFnN1al7bYoA
         U1C+trL2UcUqiQbKO9oLAcZ0RxEnKsSYUwYT6GER/qdre+l+XY8rw4JZG4tVC0kGIZsS
         OEE7Klcq17feF7fljiQf38leIb3poekeQ8PnHW+puqhzRc8IN3dscFNgC4T3qOxN38bc
         +1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746944618; x=1747549418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1+g4uBPIIPeKp4LkDWHl6XKodFAe4OiLqdzjIJdnxU=;
        b=oAl6JUeTAihNhYTJBlEcEbsz+EKbi9pyv3cH9o66aRi5c80bCMVdIH4TjyNUe3w2zY
         WGNxmuDxbTIxlHd5KJdz5Gmgy/E38KmnAnqG1OIC11k2FAuZA7TR1Vg4JDIx76yTC04L
         3Sn4kDNt5pY0rLulzF5lLKh4+ehJsf9xBLVuqUiBEZ2+KsvjZSWSXX6hnA1mLQR1cvh1
         3FQ9k7sUY2zzmMcpEuR3jojn+iziKpHJSnONiU+S+56lq0NgD3QB/bYVQ+rqxhciJWHv
         cXqBssnaijV3251VyfRa333uZ2SRNOsqmdHHxH6uS1c9Hwh3+GAFgvLljIac8VYSsm3u
         AGnw==
X-Forwarded-Encrypted: i=1; AJvYcCVjduS76c1+5SMaya9TcAelWPfHf/81DGmU/HaEw4rQCk8EmwnW36f7Endc7BhesGEki6NUsYH+FsyaUQ==@vger.kernel.org, AJvYcCWtkAP+I5QD2bwIuIAT/RspgTsrfDBOVUs63Ei46W7r7loRoRQnvLdRLtooRjB4tPPZirMuDcJs@vger.kernel.org, AJvYcCXk8IHbcEnHwqtKoY0oRtgCtWTcQ18WfamUpkuaZH3bvkVKngW2gICmHqR65OSu21RbWyDLiSRO7bdWaBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLG2NDxy4YKgrGbAyCpG4OS/n8Fv7blmrjuESrWHGHqB+h7He
	Put8rHof150sKWoDXtBRBfw9TSy3y3dCS1rzCEG8tOwQmYNqyYtq
X-Gm-Gg: ASbGncuO2y8COJcZ5VLi3+5CzieX/Y1Md2HH1Y310j1xvCf6VYE6Urtc5CR/NGZ2JuS
	XsEeDMH3jtqr3TEg3du+VPjRlkUSTNJyGGcSyKz5rrOng8ZEv0DSeC4n0Dphxs9/Tk1MKUGqLhw
	n4optcG3kWUsrwBpkRO110FJjViq3AfipAYEXERCHKR1yFjPlIB5CclM+onXbWUa4023HLjxrov
	2HSja7b9svkUmKvzE4nJolTMNgyd7d8zjB/FnRZtJ+FDrGyh1SnI2aO48V+v/eF9PcyeUYAo0vk
	VOdUM7QWWmpOefaaVRlxKWyXBOjQ8CCgi2ommXaP+MyPWTQcN9DroaOhf5SAz6K5nsN2yEhi
X-Google-Smtp-Source: AGHT+IF7wGutgUmMKgsG/fSA9t3L5OyQD1LTZMKMEFfP5F/EhCWZrz0sUd8YfeLn6D6lppASSYigtg==
X-Received: by 2002:a17:907:7ba8:b0:ad2:1752:d4e9 with SMTP id a640c23a62f3a-ad218eb9985mr924682566b.14.1746944617973;
        Sat, 10 May 2025 23:23:37 -0700 (PDT)
Received: from [172.27.62.162] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bdd63sm420132966b.154.2025.05.10.23.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 23:23:37 -0700 (PDT)
Message-ID: <7045c4a7-d37c-4249-92a3-3901499ba9b4@gmail.com>
Date: Sun, 11 May 2025 09:23:33 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5: support software TX timestamp
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, leon@kernel.org,
 Jason Xing <kerneljasonxing@gmail.com>
References: <20250508235109.585096-1-stfomichev@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250508235109.585096-1-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/05/2025 2:51, Stanislav Fomichev wrote:
> Having a software timestamp (along with existing hardware one) is
> useful to trace how the packets flow through the stack.
> mlx5e_tx_skb_update_hwts_flags is called from tx paths
> to setup HW timestamp; extend it to add software one as well.
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
> v2: rename mlx5e_tx_skb_update_hwts_flags (Tariq & Jason)
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
>   drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 7 ++++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
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
> index 4fd853d19e31..55a8629f0792 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -337,10 +337,11 @@ static void mlx5e_sq_calc_wqe_attr(struct sk_buff *skb, const struct mlx5e_tx_at
>   	};
>   }
>   
> -static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
> +static void mlx5e_tx_skb_update_ts_flags(struct sk_buff *skb)
>   {
>   	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
>   		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +	skb_tx_timestamp(skb);
>   }
>   
>   static void mlx5e_tx_check_stop(struct mlx5e_txqsq *sq)
> @@ -392,7 +393,7 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>   	cseg->opmod_idx_opcode = cpu_to_be32((sq->pc << 8) | attr->opcode);
>   	cseg->qpn_ds           = cpu_to_be32((sq->sqn << 8) | wqe_attr->ds_cnt);
>   
> -	mlx5e_tx_skb_update_hwts_flags(skb);
> +	mlx5e_tx_skb_update_ts_flags(skb);
>   
>   	sq->pc += wi->num_wqebbs;
>   
> @@ -625,7 +626,7 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>   	mlx5e_dma_push(sq, txd.dma_addr, txd.len, MLX5E_DMA_MAP_SINGLE);
>   	mlx5e_skb_fifo_push(&sq->db.skb_fifo, skb);
>   	mlx5e_tx_mpwqe_add_dseg(sq, &txd);
> -	mlx5e_tx_skb_update_hwts_flags(skb);
> +	mlx5e_tx_skb_update_ts_flags(skb);
>   
>   	if (unlikely(mlx5e_tx_mpwqe_is_full(&sq->mpwqe))) {
>   		/* Might stop the queue and affect the retval of __netdev_tx_sent_queue. */

Thanks for your patch.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>



