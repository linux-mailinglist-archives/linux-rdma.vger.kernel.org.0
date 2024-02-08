Return-Path: <linux-rdma+bounces-983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1884E8C3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 20:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1688D29465B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA413613D;
	Thu,  8 Feb 2024 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FngW70EH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33D36135;
	Thu,  8 Feb 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419613; cv=none; b=p0a6PhncTvR2byMcip2AmxLdGZUhqe4+CtXCarI+/zeTAkWISD89ENYUVLX/g6VCcRvo3+Bf/xkpnQhHC74Q73Viv0cwg5SNu8UK+H3ikQ6YPGFXu7bQHeqmX/wqStvX2UFM4GyX6sM4WHG8WjC0IStnFc5KmbssTi2+MUa4XJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419613; c=relaxed/simple;
	bh=ovZDng+f/vHeCIzq6U1R9kC9DqAVybcrZB884WwhFuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW17zKbsWhN9ggm74bWAo7T+feNx5YLC5y9nQyTtvygFzOUOgeFkhWah7tzTr2Uj9YOOVDH9I4hAmFKfAKjlLC2NLD3O28hTjCQg/OZlySOumAygGI7df77jWN6y1H9CBKH41AgQ/oEmIX6HGXpepETr4et65MAOkhYmXLNRoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FngW70EH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-511234430a4so240344e87.3;
        Thu, 08 Feb 2024 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707419609; x=1708024409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Z2Tgq+yhFEGtSct2g2RKezuAvdTXR2joIPN6UJv5oY=;
        b=FngW70EH9nqLClUmr+L/W0otRgsdu7zMtRYD81FiO7vPd6U4xRlh+LJJTRnMfE7R54
         uwDnH4zhUOBXmPXHnYR9ySaqLvKd9oOYO7ACjLQ/lPjWOEXNsXCzURA2KRG/HKuxoYx/
         YK7zzsWZhblsvFNWCedznvHLGH5WgjfCdOwr3YaIQr4q+xEgYXAMpbTt7dICcq6VBR9o
         EnsTZd+XwI/N+B1b9VdmPjDW87K0jmaHRuCXT67whkyBzk8hKzfII7+rmWbYdEae8S69
         B8+5kk4A1eo0KVuZxdFEOIbhdwLKKPgOt4vwg+kH5cRaD+FUNBlsPIfGMSzWLxGjHHGU
         5waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419609; x=1708024409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z2Tgq+yhFEGtSct2g2RKezuAvdTXR2joIPN6UJv5oY=;
        b=bbvNdbBtMOjSep4T2AplFN5vLiyjjJlpvqWlpKRrW10w7kfOhSUjcM1MqxiLcWBrUX
         LiWYld1NNGVCC1rHm8/nWHoQpLXB7w/KsQvS7rK7hnL//a0ad1PsTgVq43Z43g9xjTRR
         SUrlqcE/ClEBGqqKV5iMy7cfW8nLaqmESOUBbzkhsU9ploJCMyxMbgb4vQOt7d/Qb+pN
         xAcCaQpUWVubTXeiDp2w8DSNrvn2EWXtc90q9fqPJY2STpOI003I5SlFAEMYioAQ5B0h
         Hg+01XizpF2W9a6R/sSMNuKdwAMVQUwdxwpgCGXtxPtI6ooTYuLPHPh8lBFyzMbF2pho
         9W2g==
X-Forwarded-Encrypted: i=1; AJvYcCVFQR5CWWx3QC+Wgx+rn1mQvd/SN3XB9Y5PFIpXduTgfg9bRsJk6EPAQdL69LpXORBVtlWa0ZPXquEMgoylP4Nuproz45f9gI6cOKg2PrdtITHwUtEI5yE/yEXGnvVRQs+r2dn9vBVbTCEhXte/TMqR0O1c0dzqJbg45TQHTLhm/w==
X-Gm-Message-State: AOJu0YxPo63bNYVq6mB3JSNPWwqFXjsDNvp3gvBAc3RIf4zZz6lxSSeX
	0MrW3GKJYs8wbK8k0TgBdcPsQY4SL4e+M+fSU8Sv/KFSxAllkwrKthJHf4/K
X-Google-Smtp-Source: AGHT+IG6dVjdWC91sREU5P2lPymWB21BsWD4YkaniTfQpYg9w5KAHPC0OOb2o35JP9txZM9Mq/kCHw==
X-Received: by 2002:ac2:5b02:0:b0:511:3a13:158 with SMTP id v2-20020ac25b02000000b005113a130158mr139563lfn.35.1707419608522;
        Thu, 08 Feb 2024 11:13:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWP7KTbYpV3kKHJPEOQWgT+nFLxrcnL0QM+KfA8WEUQYezUAXs6PKmTOaOGDMoNKrL7YtBwazKF9JMRTGujMe3+EsMcg60IT9f8jElWCI9OIcAdgtTJDE8POn9KISVkHAhbpUJb9dtDczns8eqwIzNOEAQTLeTd4dk+7p0gsf0jkXNldTsW5/fXgY59/BvVQdfFis42v050gHIKro1a/9yrd7t6ymTMynoiLzSRBSCEIOkJnE2zhFsG251HruSGOtKMy1x2wI6b3uL3q4U1vzKodghjLi3NWEFMWDh3yTDQ2k6X5IVVGqTTApGtSr1AtDrYmnDzHLtqTCJoMUAS6Vv+44ARmDGRDAO2QPdgchrTO+hsmmKVG9LBiZzE9FcD+9Ewdk6jgUK2ZqJhn7sbwE7fsjf8iPOlg1opULkZ9Vvs7iyTXMTAV4y/0WrJuHRzMQ==
Received: from [172.27.55.67] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v5-20020adff685000000b0033b3ceda5dbsm4214681wrp.44.2024.02.08.11.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 11:13:28 -0800 (PST)
Message-ID: <8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com>
Date: Thu, 8 Feb 2024 21:13:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/mlx5e: link NAPI instances to queues and
 IRQs
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: tariqt@nvidia.com, rrameshbabu@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Gal Pressman <gal@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240208030702.27296-1-jdamato@fastly.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240208030702.27296-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/02/2024 5:07, Joe Damato wrote:
> Make mlx5 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
> v2 -> v3:
>    - Fix commit message subject
>    - call netif_queue_set_napi in mlx5e_ptp_activate_channel and
>      mlx5e_ptp_deactivate_channel to enable/disable NETDEV_QUEUE_TYPE_RX for
>      the PTP channel.
>    - Modify mlx5e_activate_txqsq and mlx5e_deactivate_txqsq to set
>      NETDEV_QUEUE_TYPE_TX which should take care of all TX queues including
>      QoS/HTB and PTP.
>    - Rearrange mlx5e_activate_channel and mlx5e_deactivate_channel for
>      better ordering when setting and unsetting NETDEV_QUEUE_TYPE_RX NAPI
>      structs
> 
> v1 -> v2:
>    - Move netlink NULL code to mlx5e_deactivate_channel
>    - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
>      irq, after netif_napi_add which itself sets the IRQ to -1
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 3 +++
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> index 078f56a3cbb2..fbbc287d924d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> @@ -927,6 +927,8 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
>   	int tc;
>   
>   	napi_enable(&c->napi);
> +	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX,
> +			     &c->napi);
>   
>   	if (test_bit(MLX5E_PTP_STATE_TX, c->state)) {
>   		for (tc = 0; tc < c->num_tc; tc++)
> @@ -951,6 +953,7 @@ void mlx5e_ptp_deactivate_channel(struct mlx5e_ptp *c)
>   			mlx5e_deactivate_txqsq(&c->ptpsq[tc].txqsq);
>   	}
>   
> +	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX, NULL);
>   	napi_disable(&c->napi);
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c8e8f512803e..2f1792854dd5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1806,6 +1806,7 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
>   	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
>   	netdev_tx_reset_queue(sq->txq);
>   	netif_tx_start_queue(sq->txq);
> +	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, &sq->channel->napi);

Might be called with channel==NULL.
For example for PTP.

Prefer sq->netdev and sq->cq.napi.

>   }
>   
>   void mlx5e_tx_disable_queue(struct netdev_queue *txq)
> @@ -1819,6 +1820,7 @@ void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
>   {
>   	struct mlx5_wq_cyc *wq = &sq->wq;
>   
> +	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, NULL);

Same here.

>   	clear_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
>   	synchronize_net(); /* Sync with NAPI to prevent netif_tx_wake_queue. */
>   
> @@ -2560,6 +2562,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>   	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
>   
>   	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> +	netif_napi_set_irq(&c->napi, irq);
>   
>   	err = mlx5e_open_queues(c, params, cparam);
>   	if (unlikely(err))
> @@ -2602,12 +2605,16 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>   		mlx5e_activate_xsk(c);
>   	else
>   		mlx5e_activate_rq(&c->rq);
> +
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
>   }
>   
>   static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
>   {
>   	int tc;
>   
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> +
>   	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
>   		mlx5e_deactivate_xsk(c);
>   	else

