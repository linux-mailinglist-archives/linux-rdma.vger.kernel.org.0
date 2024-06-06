Return-Path: <linux-rdma+bounces-2958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5378FF5B6
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 22:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C4E287725
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914673455;
	Thu,  6 Jun 2024 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgcm/jrS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65084087C;
	Thu,  6 Jun 2024 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704839; cv=none; b=HynRlmzM+g69fU+SOL6JodLmgsX7efPwx5dkI9bTBNTvzrrJl5wA3R1Bs/YmR79K2am+C8X8MwR/huG392ewx0HTCayc9oXLHuDa4rap/xh/HhpMG2oW0ZcA65uH4aOtJltDu8z1T6hcJc7q8P+3oIFFb8xxbEdMWqlGcNb4NJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704839; c=relaxed/simple;
	bh=e/k8T23IcfrxvnEY3jF5IDKgD7d9+QvRMd9YF93aCrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qe0MlZexdWgIp8Q29+I1Wjpym/ZnS0Yhyu5yURzvDAA9YbJe40e3XEIF9HUK/Z/EmIHC3hvCBlDblQXfr8ByNIcslebx7oujoXrZR5GTQ8/Sc6p+ndFHnHNzjEcpzWsLcznIwWz9ZcgoM/H+XfrFseELJmjC+Sj3lUINfja2U6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgcm/jrS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b912198a6so1775685e87.0;
        Thu, 06 Jun 2024 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717704836; x=1718309636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6byb3FQ3EWJ8Jrp9C5qUBdjUY8SseNTuUFxwvT1eGA=;
        b=Xgcm/jrSepzRlg9EufKtscxa4o4DQn4qsBpqBEo+chyNhg5tmBZRiMyHOF+jMaryER
         +vnIhDZNX8M32XDGYtJUEJFzVk5I406XeJ0uR6U3EK3BdmKKuCK4KtW/TUAFC05zxtGP
         CNP6YCskU0WSCrYOKAjDGr2wOHexffwPzWwtTfLgUSt4gg+vyfrNgUZMWAjVnZI6fl47
         +1AbrPqpGazVwca/feTwSVDDLqUmvxJ1KUmY00rUXlaciBQjBb/hgZ6A/JlvvptRGLnd
         ZMoZAjKUeAWCw8ALN6KN9c9sE20kJm1VilKwKceygDbofnucRuednpjiy1vq8FtMs95q
         jzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717704836; x=1718309636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6byb3FQ3EWJ8Jrp9C5qUBdjUY8SseNTuUFxwvT1eGA=;
        b=DglKnWpp9BE/kmywFtHfTiinvlqBd0Llj8QMXRHi5Z4yYTHNJHaLvJ6S+76zE9YnaK
         tAstEeuydw5jgtanSqRN7EPX0wlLyfX13Em0QIwNQ+S11SEz7ydKeoep8xuC/vpT/nkE
         882HYBmvMKWocUBfjVH1qvbRYyb+2TDT374xurPFNvskKUKKB4HlOKY4K1WntZKdK0fI
         SlVvNDMUh8kM9Surz1+CSbSfg67srri8Xj5kr3QaoOZ2yLcrDLTgDAGGbF0mp587oEgj
         jFhseAvW0lfpNyqxa0c+BG0sIWGUPyxzOLvIrmp66cAx3lMdca1LGM3zZDKkUId9PluN
         z6rw==
X-Forwarded-Encrypted: i=1; AJvYcCUWQLca7RlycAuIyypedYYP2UahXi9X3hRUSxi8bMLq0WdftOqUz6mDKaI0LnwGeO1uHkWmPOPbEK5xVNTLCSyG8+ffqVkkTtEcY2ApwkNKcaMkQ+llxqvLoT+jMKEV5j3jHEG8mN5FfUHH9F5WtN/fIMb76h3uB7vDZc0hcFLzaw==
X-Gm-Message-State: AOJu0YxgqqceUwd4OhVgSCarIN446NP8iI0i41/0bO2zf1jUevQZ5Yl5
	fh+Qdtw7LsdUgReejLNPUXUXzDJ4C9uiPMXrGY1A1D3EO3UMNtEg
X-Google-Smtp-Source: AGHT+IGGsASs+yGRGOikavcnVUtRQ09wNGnpM686klGUTFEisDih3dGbHw2iNffAqxgjiZhzT0iOcg==
X-Received: by 2002:ac2:4542:0:b0:51d:6790:b788 with SMTP id 2adb3069b0e04-52bb9fdc22dmr470856e87.56.1717704835752;
        Thu, 06 Jun 2024 13:13:55 -0700 (PDT)
Received: from [172.27.33.107] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a544bsm32825635e9.21.2024.06.06.13.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 13:13:55 -0700 (PDT)
Message-ID: <f131e427-0541-462c-bd37-2132acf6f559@gmail.com>
Date: Thu, 6 Jun 2024 23:13:52 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v4 1/2] net/mlx5e: Add txq to sq stats mapping
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
 <20240604004629.299699-2-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240604004629.299699-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/06/2024 3:46, Joe Damato wrote:
> mlx5 currently maps txqs to an sq via priv->txq2sq. It is useful to map
> txqs to sq_stats, as well, for direct access to stats.
> 
> Add priv->txq2sq_stats and insert mappings. The mappings will be used
> next to tabulate stats information.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 ++
>   drivers/net/ethernet/mellanox/mlx5/core/en/qos.c  | 13 +++++++++++--
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 11 ++++++++++-
>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index e85fb71bf0b4..4ae3eee3940c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -885,6 +885,8 @@ struct mlx5e_priv {
>   	/* priv data path fields - start */
>   	struct mlx5e_selq selq;
>   	struct mlx5e_txqsq **txq2sq;
> +	struct mlx5e_sq_stats **txq2sq_stats;
> +
>   #ifdef CONFIG_MLX5_CORE_EN_DCB
>   	struct mlx5e_dcbx_dp       dcbx_dp;
>   #endif
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
> index 6743806b8480..e89272a5d036 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
> @@ -170,6 +170,7 @@ int mlx5e_activate_qos_sq(void *data, u16 node_qid, u32 hw_id)
>   	mlx5e_tx_disable_queue(netdev_get_tx_queue(priv->netdev, qid));
>   
>   	priv->txq2sq[qid] = sq;
> +	priv->txq2sq_stats[qid] = sq->stats;
>   
>   	/* Make the change to txq2sq visible before the queue is started.
>   	 * As mlx5e_xmit runs under a spinlock, there is an implicit ACQUIRE,
> @@ -186,6 +187,7 @@ int mlx5e_activate_qos_sq(void *data, u16 node_qid, u32 hw_id)
>   void mlx5e_deactivate_qos_sq(struct mlx5e_priv *priv, u16 qid)
>   {
>   	struct mlx5e_txqsq *sq;
> +	u16 mlx5e_qid;

Do not use mlx5 in variables names.

>   
>   	sq = mlx5e_get_qos_sq(priv, qid);
>   	if (!sq) /* Handle the case when the SQ failed to open. */
> @@ -194,7 +196,10 @@ void mlx5e_deactivate_qos_sq(struct mlx5e_priv *priv, u16 qid)
>   	qos_dbg(sq->mdev, "Deactivate QoS SQ qid %u\n", qid);
>   	mlx5e_deactivate_txqsq(sq);
>   
> -	priv->txq2sq[mlx5e_qid_from_qos(&priv->channels, qid)] = NULL;
> +	mlx5e_qid = mlx5e_qid_from_qos(&priv->channels, qid);
> +
> +	priv->txq2sq[mlx5e_qid] = NULL;
> +	priv->txq2sq_stats[mlx5e_qid] = NULL;
>   
>   	/* Make the change to txq2sq visible before the queue is started again.
>   	 * As mlx5e_xmit runs under a spinlock, there is an implicit ACQUIRE,
> @@ -325,6 +330,7 @@ void mlx5e_qos_deactivate_queues(struct mlx5e_channel *c)
>   {
>   	struct mlx5e_params *params = &c->priv->channels.params;
>   	struct mlx5e_txqsq __rcu **qos_sqs;
> +	u16 mlx5e_qid;
>   	int i;
>   
>   	qos_sqs = mlx5e_state_dereference(c->priv, c->qos_sqs);
> @@ -342,8 +348,11 @@ void mlx5e_qos_deactivate_queues(struct mlx5e_channel *c)
>   		qos_dbg(c->mdev, "Deactivate QoS SQ qid %u\n", qid);
>   		mlx5e_deactivate_txqsq(sq);
>   
> +		mlx5e_qid = mlx5e_qid_from_qos(&c->priv->channels, qid);
> +
>   		/* The queue is disabled, no synchronization with datapath is needed. */
> -		c->priv->txq2sq[mlx5e_qid_from_qos(&c->priv->channels, qid)] = NULL;
> +		c->priv->txq2sq[mlx5e_qid] = NULL;
> +		c->priv->txq2sq_stats[mlx5e_qid] = NULL;
>   	}
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c53c99dde558..d03fd1c98eb6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -3111,6 +3111,7 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
>   			struct mlx5e_txqsq *sq = &c->sq[tc];
>   
>   			priv->txq2sq[sq->txq_ix] = sq;
> +			priv->txq2sq_stats[sq->txq_ix] = sq->stats;
>   		}
>   	}
>   
> @@ -3125,6 +3126,7 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
>   		struct mlx5e_txqsq *sq = &c->ptpsq[tc].txqsq;
>   
>   		priv->txq2sq[sq->txq_ix] = sq;
> +		priv->txq2sq_stats[sq->txq_ix] = sq->stats;
>   	}
>   
>   out:
> @@ -5824,9 +5826,13 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
>   	if (!priv->txq2sq)
>   		goto err_destroy_workqueue;
>   
> +	priv->txq2sq_stats = kcalloc_node(num_txqs, sizeof(*priv->txq2sq_stats), GFP_KERNEL, node);
> +	if (!priv->txq2sq_stats)
> +		goto err_free_txq2sq;
> +
>   	priv->tx_rates = kcalloc_node(num_txqs, sizeof(*priv->tx_rates), GFP_KERNEL, node);
>   	if (!priv->tx_rates)
> -		goto err_free_txq2sq;
> +		goto err_free_txq2sq_stats;
>   
>   	priv->channel_stats =
>   		kcalloc_node(nch, sizeof(*priv->channel_stats), GFP_KERNEL, node);
> @@ -5837,6 +5843,8 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
>   
>   err_free_tx_rates:
>   	kfree(priv->tx_rates);
> +err_free_txq2sq_stats:
> +	kfree(priv->txq2sq_stats);
>   err_free_txq2sq:
>   	kfree(priv->txq2sq);
>   err_destroy_workqueue:
> @@ -5860,6 +5868,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
>   		kvfree(priv->channel_stats[i]);
>   	kfree(priv->channel_stats);
>   	kfree(priv->tx_rates);
> +	kfree(priv->txq2sq_stats);
>   	kfree(priv->txq2sq);
>   	destroy_workqueue(priv->wq);
>   	mlx5e_selq_cleanup(&priv->selq);

