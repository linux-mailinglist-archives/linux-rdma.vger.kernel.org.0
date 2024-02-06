Return-Path: <linux-rdma+bounces-928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DBE84AFAC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 09:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE2EB22ECD
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B812AAD9;
	Tue,  6 Feb 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSJvVd+G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA5129A77;
	Tue,  6 Feb 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207095; cv=none; b=nCasxB7gYF4Uy1nkLNOtFyQM8GL+yt8ATEFAUgBDNFO1iPMehCHs84AHwOFsUgoKaVWbBbdvVe2BwMq7vbwivNGQZUUCIt1Cl9IX483KdRUYxsWEy0JsledzgClHuhoDo0YWqGnL7uFw7xv+W4Go63wO8c6BOS4sA+J+OfvoMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207095; c=relaxed/simple;
	bh=bzaP4tS/Ihj8LOtcdwRdIJBniTBCeSCXqbR0BrYvcI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR8fhS5GxRSJaaPstOI5rie5P1dwjw6rSFSWtzWudV81ZqUhC46loa2HrBflCJ5ZtmgDo/2z574v/JirClPtNsdNP5a9T3CTrdUjn6A4WKbo0dhUxeVF5A/xTDxPTShCIg9Dlq0lyKTsNtxgEmrd1okEhPWwrbBAdoredmpwR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSJvVd+G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114fa38434so724997e87.0;
        Tue, 06 Feb 2024 00:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207091; x=1707811891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gcF4s0kU7RHAT/txtIoRwLQVX+W9y2wHrbaZEyuOrY=;
        b=TSJvVd+GtkY9urhRWUuWW6Vk3DV5Q4UCy/Y5O2TfDQmOS2zjxE4fOHDb+VjcqFVKM8
         ghyAQToo2RUvTjZmaftgqPv4VD04h8z4QU5T12hUZpkOz6BO6nZVmSpXYP3nfLgI90pH
         AkVY0z6YqqHmvNh25NxAt62qoyLBrshYGgm2xfy9oIe5Je2uIQEJLKVdEH7JUG9X4cry
         Un7StFNw0thoxVFibCjKqD2y6F1gT4mnmFKk9ImsPNjHV1j6pUtFBdVQKmv9R/6Btkb+
         NqJZIZKfxWT/fUaF9KRo9O0knnecPW5kpQbOBZ9UduGMqpjMRtCwOA5v65Rj9uPbHa/h
         Sbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207091; x=1707811891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gcF4s0kU7RHAT/txtIoRwLQVX+W9y2wHrbaZEyuOrY=;
        b=NYJNgvuvVMkGDVAMCpmX24b7352R+rS0pPP5LRjTPCpAwuWezjkPascwURv+LrNInM
         GNn6wL+7E/cBZzCTK4OHSzynF/MBEIIbNHIKu/XF2X9vND7Qt05u9EOOdhwTg6Bhbnid
         I/izP0pvYA2DDvEFGv3hNz9XsLag7oqNVROsVn464ka0thXLqrNBA61/Nj5HOVJan/no
         dBh8ppullA+nx2fMqP6ff53UVqQfDgSo4oNHXCcQ6apyQGBIzCzFB/fG0Vn3aLS9kz2/
         1bbNqDPm+pac7+0YcH1JStj4j7A1fjDvfi7Fx/PUVoMUG/A3JjwKMf5OUZAt9b+Kt/dy
         ySfw==
X-Gm-Message-State: AOJu0Ywjx/pc1HSsP6/B+qtH4vwkFdcHTAS7ic8p/nlXgXeOvu0yE8lD
	r09P6/QEe7Rs8avuiZxMh+JrVArpLIvDldz8mNUBXjBDSL5t17bn
X-Google-Smtp-Source: AGHT+IFHw6eoEuoqTi2YiCwoM3MF79h0S/QvtI+RHeekpeDQDm2GrgBgmMZus27A/ylIr1LmGLHbBA==
X-Received: by 2002:ac2:52a3:0:b0:511:3164:3f3e with SMTP id r3-20020ac252a3000000b0051131643f3emr1296691lfm.29.1707207091035;
        Tue, 06 Feb 2024 00:11:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVGAMplA8ghrbV48Vq6tuyeriAdjNTE6ipxuwt4ZAmzfj9j91M09euhIn8Nl5tJdJfvyOjGnF1o3oZbz/GACmdP7FzWWCci941xhSIDPxkXy0J0ezfL/1ibR9vOPoBPJme+uLl8olNwB3IGvmPKz16+bspVi+qYxi0IwQOx6DT+hfpoB6Cd+dzFXOQ8tfSkmVGSwaGIGCgM43AVQ0KF6aYYoPq8+hz9eMIIwanzvl14bh1aDnitNdAbj6Hrn/dMCpZG+vRH8kD/QH90rrgNQ4TG2Vcua5TEoBdYutO0rl6lsOWj1TvWCi/VaiEKhOHQ5Oaov/sdKetx5TQr/mjs0RneTFBe6N455b4G+Y2CfWE1EN26QSy4G6gZEM=
Received: from [172.27.55.67] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b0040ebf340759sm1151605wmb.21.2024.02.06.00.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:11:30 -0800 (PST)
Message-ID: <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
Date: Tue, 6 Feb 2024 10:11:28 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Cc: tariqt@nvidia.com, rrameshbabu@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240206010311.149103-1-jdamato@fastly.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240206010311.149103-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2024 3:03, Joe Damato wrote:
> Make mlx5 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

+ Gal

Hi Joe,
Thanks for your patch.

We have already prepared a similar patch, and it's part of our internal 
submission queue, and planned to be submitted soon.

Please see my comments below, let us know if you're welling to respin a 
V2 or wait for our patch.

> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 55c6ace0acd5..3f86ee1831a8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -768,6 +768,7 @@ struct mlx5e_channel {
>   	u16                        qos_sqs_size;
>   	u8                         num_tc;
>   	u8                         lag_port;
> +	unsigned int		   irq;
>   
>   	/* XDP_REDIRECT */
>   	struct mlx5e_xdpsq         xdpsq;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c8e8f512803e..e1bfff1fb328 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>   	mlx5e_close_tx_cqs(c);
>   	mlx5e_close_cq(&c->icosq.cq);
>   	mlx5e_close_cq(&c->async_icosq.cq);
> +
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
>   }
>   
>   static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>   	c->stats    = &priv->channel_stats[ix]->ch;
>   	c->aff_mask = irq_get_effective_affinity_mask(irq);
>   	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> +	c->irq		= irq;
>   
>   	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
>   
> @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>   		mlx5e_activate_xsk(c);
>   	else
>   		mlx5e_activate_rq(&c->rq);
> +
> +	netif_napi_set_irq(&c->napi, c->irq);

Can be safely moved to mlx5e_open_channel without interfering with other 
existing mapping. This would save the new irq field in mlx5e_channel.

> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);

In some configurations we have multiple txqs per channel, so the txq 
indices are not 1-to-1 with their channel index.

This should be called per each txq, with the proper txq index.

It should be done also for feture-dedicated SQs (like QOS/HTB).

> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);

For consistency, I'd move this one as well, to match the TX handling.

>   }
>   
>   static void mlx5e_deactivate_channel(struct mlx5e_channel *c)

