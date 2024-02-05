Return-Path: <linux-rdma+bounces-911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677A8499FE
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F991C22C62
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB81BC40;
	Mon,  5 Feb 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK4QSe3A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05F1BF34;
	Mon,  5 Feb 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135647; cv=none; b=kDbyPlYbJu6JFcyRCP7I0JJQieQynd3d8hQRRcFo4sCznOxjyj9FIFVNxxKqStQBD3mpHgrQdismLdM+cfoXHQ0+wHc09Gk7M0T2SIv03FN7Co4myot5JItgh2AWFsf/uc/c/UziTUZjPR4xmp+U57FwDvwUYQqDOYTeqDa/ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135647; c=relaxed/simple;
	bh=bHW35ioLm2J5j2R7kbi7byP76OS5iC7zRB0gfw3/o/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBLQq1YAEVy2mEDtTiL49r0jqfW1Pedb/K/L5ks2tXX7uW+J0l/YCkySCO68Yz4DKXnNk1EISnZz4JZrfeAM6JhSxi0VthbwQUUr+oJBiR01HR7q/X8zidR+WleWxaXOFn6kUi4S/qejXMe1LLTEN6rK5N8r2oW5PBrSi6119Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK4QSe3A; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so48809471fa.0;
        Mon, 05 Feb 2024 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707135643; x=1707740443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICvDdgt5SEXAfGA/hEOcBLcWTdkKj8IMmZ7QYokp8KI=;
        b=XK4QSe3ANxst7I0fYjRcSV35+1Sf7mdY8w7FJ0w2HZ/c9gqU54oal442/GrJ5YIGRE
         Y8oRLsppx3JBxTGCApd4QCrraPqc3yKRP4pGDo4ZBM4aCVUvqvaacu7uOUmJBTvkel5Q
         6xcwvR173iRVPwCtLaS231zskqKZ+THU6FGiXPVEar0SzrU4svvNmS2Ghri4fOYWGUH4
         4+8zyuXd55wtF/feY1GjGQ17DaYq25PEC3Na6cctNSsEeKRN0keP8JMdQ4J7jDXYEj3r
         qWrTo7JT7Hsc/qs8vQS0ePEWQndK6UDlBgXaxS7OXNt3Frrq5GYfe9IV5ArqsIujLkYa
         vvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707135643; x=1707740443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICvDdgt5SEXAfGA/hEOcBLcWTdkKj8IMmZ7QYokp8KI=;
        b=EtXTz6KLZ6NAiZoOTn+0xuF/fm/ms4kMCU2zzZITp0fULTH7hfJggW/NYWocWv8j5Q
         4kR6s1985a5sUQY6YMKhZnac21V2QAFOK4QuzF2KVS7FnO6XUaqF5RKG8MIZ5l+bAPAf
         0yZU36M0MwbtmJ3Hx0hW6+VmAXXDhNgdPVORdYvXKr9iHSZ/Utsa13f3tDGdhZK1ijUw
         Bt8awvAiP4NLKF4kAuilyrwcI0c62yRdsSTs7u+doMGmoWCknplJa3M/4IBueTFv+vk5
         L3KFqlDcl5gkUvkg3Eh7MonOfQ3r/mgJA9LuJv/OEauTvSlWzGM5f+cGgcGQdPHVemjX
         YAYQ==
X-Forwarded-Encrypted: i=0; AJvYcCXwQzbP1r4IwEM3JN+4xwOlbMQ4jgA7hbty5DuKUV7dxTxvG+UWKjDjkLsHwPq6ZMxeTDQxQGrCVBYMhzUNX5Lh1LCmwjIU72jTC60JrsZdSlZ0mSBfHh+mYDeVWfSpJjWpQw==
X-Gm-Message-State: AOJu0YyUY5gNTi3qzUp8yL1sV6i2knmINXhh0Et+hdTRYSmRY0wM00Ki
	oQw6krG94y1Pju1lfBBifsW02VBqRLVoaHjbEzXC/UB7UQX3SzCtbM58tI5L
X-Google-Smtp-Source: AGHT+IGEWsHGNGdZR+hiFOBeUkdWLqNNBSfe1swyjpW13T81bhyAvcNZOS1a2MJ7pLpbbU8dqUGuQA==
X-Received: by 2002:a2e:8898:0:b0:2d0:a773:e3a9 with SMTP id k24-20020a2e8898000000b002d0a773e3a9mr2771389lji.16.1707135642529;
        Mon, 05 Feb 2024 04:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFk9pUZ1KZI+PtNFo3vvh3PlhJ03LEaVpfrS3EgeJ/l4NR+JjcZC6uQlBNwymku2rzpW9w/vO/qkFW2pYAGb0Zlr9rTEhhPwV3JWcu3/ko3fjD4mLtpVNv+E60hJzSaF7s5ELD95XeVoUKWYJFkP4HgwwcwGTJDqXhXBjmM7AwQnxqOA8jodIwpJ6/nokRAlpM4EL/4CBQZc43ZLjwqa4GlhHygfpbDfQf63s4V/pzAZMYCRC4eHpk5Y4GtHWVOypRBoahC92JCX8GEp/XkD+XVU3ya2NRySVQlQ==
Received: from [172.27.55.67] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402501a00b0056012fe9d4fsm2789239eda.76.2024.02.05.04.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:20:42 -0800 (PST)
Message-ID: <4c01fee3-696c-43cc-90b3-262fd24c1ae5@gmail.com>
Date: Mon, 5 Feb 2024 14:20:40 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-nex] mlx4: Address spelling errors
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/02/2024 13:51, Simon Horman wrote:
> Address spelling errors flagged by codespell.
> 
> This patch follows-up on an earlier patch by Colin Ian King,
> which addressed a spelling error in a user-visible log message [1].
> This patch includes that change.
> 
> [1] https://lore.kernel.org/netdev/20231209225135.4055334-1-colin.i.king@gmail.com/
> 
> This patch is intended to cover all files under
> drivers/net/ethernet/mellanox/mlx4
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/cmd.c        | 7 ++++---
>   drivers/net/ethernet/mellanox/mlx4/cq.c         | 4 ++--
>   drivers/net/ethernet/mellanox/mlx4/en_clock.c   | 4 ++--
>   drivers/net/ethernet/mellanox/mlx4/en_netdev.c  | 5 +++--
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c      | 2 +-
>   drivers/net/ethernet/mellanox/mlx4/en_tx.c      | 2 +-
>   drivers/net/ethernet/mellanox/mlx4/eq.c         | 2 +-
>   drivers/net/ethernet/mellanox/mlx4/fw_qos.h     | 8 ++++----
>   drivers/net/ethernet/mellanox/mlx4/main.c       | 4 ++--
>   drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h | 2 +-
>   drivers/net/ethernet/mellanox/mlx4/port.c       | 2 +-
>   11 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> index f5b1f8c7834f..7f20813456e2 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> @@ -2199,8 +2199,9 @@ static void mlx4_master_do_cmd(struct mlx4_dev *dev, int slave, u8 cmd,
>   	if (cmd != MLX4_COMM_CMD_RESET) {
>   		mlx4_warn(dev, "Turn on internal error to force reset, slave=%d, cmd=0x%x\n",
>   			  slave, cmd);
> -		/* Turn on internal error letting slave reset itself immeditaly,
> -		 * otherwise it might take till timeout on command is passed
> +		/* Turn on internal error letting slave reset itself
> +		 * immediately, otherwise it might take till timeout on
> +		 * command is passed
>   		 */
>   		reply |= ((u32)COMM_CHAN_EVENT_INTERNAL_ERR);
>   	}
> @@ -2954,7 +2955,7 @@ static bool mlx4_valid_vf_state_change(struct mlx4_dev *dev, int port,
>   	dummy_admin.default_vlan = vlan;
>   
>   	/* VF wants to move to other VST state which is valid with current
> -	 * rate limit. Either differnt default vlan in VST or other
> +	 * rate limit. Either different default vlan in VST or other
>   	 * supported QoS priority. Otherwise we don't allow this change when
>   	 * the TX rate is still configured.
>   	 */
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> index 4d4f9cf9facb..e130e7259275 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> @@ -115,7 +115,7 @@ void mlx4_cq_completion(struct mlx4_dev *dev, u32 cqn)
>   		return;
>   	}
>   
> -	/* Acessing the CQ outside of rcu_read_lock is safe, because
> +	/* Accessing the CQ outside of rcu_read_lock is safe, because
>   	 * the CQ is freed only after interrupt handling is completed.
>   	 */
>   	++cq->arm_sn;
> @@ -137,7 +137,7 @@ void mlx4_cq_event(struct mlx4_dev *dev, u32 cqn, int event_type)
>   		return;
>   	}
>   
> -	/* Acessing the CQ outside of rcu_read_lock is safe, because
> +	/* Accessing the CQ outside of rcu_read_lock is safe, because
>   	 * the CQ is freed only after interrupt handling is completed.
>   	 */
>   	cq->event(cq, event_type);
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> index 9e3b76182088..cd754cd76bde 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> @@ -96,8 +96,8 @@ void mlx4_en_remove_timestamp(struct mlx4_en_dev *mdev)
>   
>   #define MLX4_EN_WRAP_AROUND_SEC	10UL
>   /* By scheduling the overflow check every 5 seconds, we have a reasonably
> - * good chance we wont miss a wrap around.
> - * TOTO: Use a timer instead of a work queue to increase the guarantee.
> + * good chance we won't miss a wrap around.
> + * TODO: Use a timer instead of a work queue to increase the guarantee.
>    */
>   #define MLX4_EN_OVERFLOW_PERIOD (MLX4_EN_WRAP_AROUND_SEC * HZ / 2)
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index 33bbcced8105..d7da62cda821 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -1072,7 +1072,8 @@ static void mlx4_en_do_multicast(struct mlx4_en_priv *priv,
>   				    1, MLX4_MCAST_CONFIG);
>   
>   		/* Update multicast list - we cache all addresses so they won't
> -		 * change while HW is updated holding the command semaphor */
> +		 * change while HW is updated holding the command semaphore
> +		 */
>   		netif_addr_lock_bh(dev);
>   		mlx4_en_cache_mclist(dev);
>   		netif_addr_unlock_bh(dev);
> @@ -1817,7 +1818,7 @@ int mlx4_en_start_port(struct net_device *dev)
>   	    mlx4_en_set_rss_steer_rules(priv))
>   		mlx4_warn(mdev, "Failed setting steering rules\n");
>   
> -	/* Attach rx QP to bradcast address */
> +	/* Attach rx QP to broadcast address */
>   	eth_broadcast_addr(&mc_list[10]);
>   	mc_list[5] = priv->port; /* needed for B0 steering support */
>   	if (mlx4_multicast_attach(mdev->dev, priv->rss_map.indir_qp, mc_list,
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index a09b6e05337d..eac49657bd07 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -762,7 +762,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
>   		/* Drop packet on bad receive or bad checksum */
>   		if (unlikely((cqe->owner_sr_opcode & MLX4_CQE_OPCODE_MASK) ==
>   						MLX4_CQE_OPCODE_ERROR)) {
> -			en_err(priv, "CQE completed in error - vendor syndrom:%d syndrom:%d\n",
> +			en_err(priv, "CQE completed in error - vendor syndrome:%d syndrome:%d\n",
>   			       ((struct mlx4_err_cqe *)cqe)->vendor_err_syndrome,
>   			       ((struct mlx4_err_cqe *)cqe)->syndrome);
>   			goto next;
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> index 65cb63f6c465..1ddb11cb25f9 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> @@ -992,7 +992,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
>   		tx_info->ts_requested = 1;
>   	}
>   
> -	/* Prepare ctrl segement apart opcode+ownership, which depends on
> +	/* Prepare ctrl segment apart opcode+ownership, which depends on
>   	 * whether LSO is used */
>   	tx_desc->ctrl.srcrb_flags = priv->ctrl_flags;
>   	if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
> diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
> index 6598b10a9ff4..9572a45f6143 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
> @@ -210,7 +210,7 @@ static void slave_event(struct mlx4_dev *dev, u8 slave, struct mlx4_eqe *eqe)
>   
>   	memcpy(s_eqe, eqe, sizeof(struct mlx4_eqe) - 1);
>   	s_eqe->slave_id = slave;
> -	/* ensure all information is written before setting the ownersip bit */
> +	/* ensure all information is written before setting the ownership bit */
>   	dma_wmb();
>   	s_eqe->owner = !!(slave_eq->prod & SLAVE_EVENT_EQ_SIZE) ? 0x0 : 0x80;
>   	++slave_eq->prod;
> diff --git a/drivers/net/ethernet/mellanox/mlx4/fw_qos.h b/drivers/net/ethernet/mellanox/mlx4/fw_qos.h
> index 954b86faac29..40ca29bb928c 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/fw_qos.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/fw_qos.h
> @@ -44,7 +44,7 @@
>   /* Default supported priorities for VPP allocation */
>   #define MLX4_DEFAULT_QOS_PRIO (0)
>   
> -/* Derived from FW feature definition, 0 is the default vport fo all QPs */
> +/* Derived from FW feature definition, 0 is the default vport for all QPs */
>   #define MLX4_VPP_DEFAULT_VPORT (0)
>   
>   struct mlx4_vport_qos_param {
> @@ -98,7 +98,7 @@ int mlx4_SET_PORT_SCHEDULER(struct mlx4_dev *dev, u8 port, u8 *tc_tx_bw,
>   int mlx4_ALLOCATE_VPP_get(struct mlx4_dev *dev, u8 port,
>   			  u16 *available_vpp, u8 *vpp_p_up);
>   /**
> - * mlx4_ALLOCATE_VPP_set - Distribution of VPPs among differnt priorities.
> + * mlx4_ALLOCATE_VPP_set - Distribution of VPPs among different priorities.
>    * The total number of VPPs assigned to all for a port must not exceed
>    * the value reported by available_vpp in mlx4_ALLOCATE_VPP_get.
>    * VPP allocation is allowed only after the port type has been set,
> @@ -113,7 +113,7 @@ int mlx4_ALLOCATE_VPP_get(struct mlx4_dev *dev, u8 port,
>   int mlx4_ALLOCATE_VPP_set(struct mlx4_dev *dev, u8 port, u8 *vpp_p_up);
>   
>   /**
> - * mlx4_SET_VPORT_QOS_get - Query QoS proporties of a Vport.
> + * mlx4_SET_VPORT_QOS_get - Query QoS properties of a Vport.
>    * Each priority allowed for the Vport is assigned with a share of the BW,
>    * and a BW limitation. This commands query the current QoS values.
>    *
> @@ -128,7 +128,7 @@ int mlx4_SET_VPORT_QOS_get(struct mlx4_dev *dev, u8 port, u8 vport,
>   			   struct mlx4_vport_qos_param *out_param);
>   
>   /**
> - * mlx4_SET_VPORT_QOS_set - Set QoS proporties of a Vport.
> + * mlx4_SET_VPORT_QOS_set - Set QoS properties of a Vport.
>    * QoS parameters can be modified at any time, but must be initialized
>    * before any QP is associated with the VPort.
>    *
> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
> index 2581226836b5..7b02ff61126d 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> @@ -129,7 +129,7 @@ static const struct mlx4_profile default_profile = {
>   	.num_cq		= 1 << 16,
>   	.num_mcg	= 1 << 13,
>   	.num_mpt	= 1 << 19,
> -	.num_mtt	= 1 << 20, /* It is really num mtt segements */
> +	.num_mtt	= 1 << 20, /* It is really num mtt segments */
>   };
>   
>   static const struct mlx4_profile low_mem_profile = {
> @@ -1508,7 +1508,7 @@ static int mlx4_port_map_set(struct mlx4_dev *dev, struct mlx4_port_map *v2p)
>   			priv->v2p.port1 = port1;
>   			priv->v2p.port2 = port2;
>   		} else {
> -			mlx4_err(dev, "Failed to change port mape: %d\n", err);
> +			mlx4_err(dev, "Failed to change port map: %d\n", err);
>   		}
>   	}
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h
> index e9cd4bb6f83d..d3d9ec042d2c 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h
> @@ -112,7 +112,7 @@ struct mlx4_en_stat_out_flow_control_mbox {
>   	__be64 tx_pause_duration;
>   	/* Number of transmitter transitions from XOFF state to XON state */
>   	__be64 tx_pause_transition;
> -	/* Reserverd */
> +	/* Reserved */
>   	__be64 reserved[2];
>   };
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
> index 256a06b3c096..4e43f4a7d246 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
> @@ -2118,7 +2118,7 @@ static void mlx4_qsfp_eeprom_params_set(u8 *i2c_addr, u8 *page_num, u16 *offset)
>    * @data: output buffer to put the requested data into.
>    *
>    * Reads cable module eeprom data, puts the outcome data into
> - * data pointer paramer.
> + * data pointer parameter.
>    * Returns num of read bytes on success or a negative error
>    * code.
>    */
> 
> 

Thanks for your patch.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

I'm ignoring the branch name typo in the mail subject :)
[PATCH net-nex]

