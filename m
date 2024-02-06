Return-Path: <linux-rdma+bounces-933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A484BBA9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AEC2837BE
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 17:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416B79C4;
	Tue,  6 Feb 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="w85xzmud"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624716ABF
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239526; cv=none; b=uRLWYNIcRTBIqyRNw0X9fkmQr8+i7qRG104mrVbBtdowbpaHVwFVPo6/12f6DUB4EthGkmJyzLs27uPq2NRMoij/0k/kBpwVD9zDAmQv9xEVIH4E+KqbqV3ItuQ8qupKpla5sn9pgZpVApeCmRcWu7v38aeQjxlLpT8VHt2UU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239526; c=relaxed/simple;
	bh=udwk8gkp2gItjLFFyN+0LjX+L2AaB7Z0ACySQafe79Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0tns88OwQobOGtTbJtfKNWKUmpHUHGMC6U1yB1nfW71OZsON6cC65aZX1u6UfpGdjLd3hGjs8QOK3/OaWEtMfjPWDljj33DgbSwjurrut8NT7gixAWOCwWTeouYg3qk2m72esZiPOZpR1WEAbWcrMrgMXasUww/cETarwiMCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=w85xzmud; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d918008b99so44752415ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Feb 2024 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707239524; x=1707844324; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CldblDMAlebalb5iiDPGGktolx1oR4ruKO4COeXHSk8=;
        b=w85xzmudwnF2iNK5vpHYW7Mn7dtzYgzhc6RrwtR6um0ny4mW7oVNGiDGHXlDgOOYRG
         XzFMiguVkXLiPzbrVAVE3YOC0xLSZn5B1m/YBSPfvcUywAXYj2CpkBPypo3FP6I0CQ/F
         5TxSJ/ApR/KT2/HWlk1W1SfSxolwSeYJbgJdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239524; x=1707844324;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CldblDMAlebalb5iiDPGGktolx1oR4ruKO4COeXHSk8=;
        b=qnY6/mRGm3Qsr7Z9Mfsu0AShaoXiXHwzy44WwhAx/WTEe9WkdP2qh+DZs1NO3Yau2t
         zuJPTHLKolNNf8Yutm/JU63eTjzZdb4YN7RiDdKh9hDyNTOYQzHxVgQOOa/ZgbcPfztz
         K9kVxH97moa91oLD2x0sS5lWjBn7mmi+ms702CSMNrXPrANh0PyMlUm1jGPhFSSCPUN2
         f9P2rHEoOTxb9DU3WUQhLMIkihsNcJjJnza5+W/SGhiGincf+OOjYlYL7dNQOrt/PIvl
         fx01Odg1RvrobrKw/hILMRKVsv90yk5NRstqnRdEbWLcruf7BDCMYmdqv/pQi18n3rSd
         1wBw==
X-Gm-Message-State: AOJu0YwGtwuF4zCpJeZ1ZSAcOeMe7M4QmfSZtYru8LLuyTNJKJwM+bHs
	9+oeVJLkxlCHu5qYhcxlMsXcKzUzap4UGRdXvrsA3hnkayc/DgfxDXg3Hzqf63w=
X-Google-Smtp-Source: AGHT+IH5WvOaU75WLDm51dcSu+n4M28I0YcP7YgAbDLBSHRa8AGItFSIR2hOfeubimVXzgpAHZ4roQ==
X-Received: by 2002:a17:902:c20c:b0:1d9:c2c4:c61a with SMTP id 12-20020a170902c20c00b001d9c2c4c61amr2248084pll.18.1707239523686;
        Tue, 06 Feb 2024 09:12:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUe8JnVkJkj2WH/Mo1AlT5+oRZICMK2rBSPsygipayB+l+44RVrar5aiC0GyfceQkazA3TL5AvjOqwd2FbXDV9S2YBXTgEgjF6mgRgcySjbtd5QRmSt7QZ/4lC8QkQ3ILQB3rPwkzTSmmqGYlDgJLsCgT3XYh4vC6AS3dReT9zLRTGoa7D8w80hk6gM34Ki36Ai8zrLv9M7GVtD3LmKQ47qknZRRJBZqEHSYIhsW7l8wflyz/l9SNLR48A8Kny/8+b9edP3hrXHlPTys+hl9tMviuDI4jGz6hjCDmYBBD2ckclLpfJNI5TTPTps/ojaOG0cEeZILHh3quD6A/IKFBCOcJHT7sxFH5tKGahTAOLE
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902c99200b001d95909478dsm2129848plc.75.2024.02.06.09.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 09:12:03 -0800 (PST)
Date: Tue, 6 Feb 2024 09:12:00 -0800
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, tariqt@nvidia.com,
	rrameshbabu@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240206171159.GA11565@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Tue, Feb 06, 2024 at 10:11:28AM +0200, Tariq Toukan wrote:
> 
> 
> On 06/02/2024 3:03, Joe Damato wrote:
> >Make mlx5 compatible with the newly added netlink queue GET APIs.
> >
> >Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> + Gal
> 
> Hi Joe,
> Thanks for your patch.
> 
> We have already prepared a similar patch, and it's part of our internal
> submission queue, and planned to be submitted soon.
> 
> Please see my comments below, let us know if you're welling to respin a V2
> or wait for our patch.

Do you have a rough estimate on when it'll be submitted?

If it's several months out I'll try again, but if it's expected to be
submit in the next few weeks I'll wait for your official change.

BTW, are the per queue coalesce changes in that same queue? It was
mentioned previously [1] that this feature is coming after we submit a
simple attempt as an RFC. If that feature isn't planned or won't be submit
anytime soon, can you let us know and we can try to attempt an RFC v3 for
it?

[1]: https://lore.kernel.org/lkml/874jj34e67.fsf@nvidia.com/

> >---
> >  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >index 55c6ace0acd5..3f86ee1831a8 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >@@ -768,6 +768,7 @@ struct mlx5e_channel {
> >  	u16                        qos_sqs_size;
> >  	u8                         num_tc;
> >  	u8                         lag_port;
> >+	unsigned int		   irq;
> >  	/* XDP_REDIRECT */
> >  	struct mlx5e_xdpsq         xdpsq;
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >index c8e8f512803e..e1bfff1fb328 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >@@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
> >  	mlx5e_close_tx_cqs(c);
> >  	mlx5e_close_cq(&c->icosq.cq);
> >  	mlx5e_close_cq(&c->async_icosq.cq);
> >+
> >+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> >+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >  }
> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> >@@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >  	c->stats    = &priv->channel_stats[ix]->ch;
> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> >+	c->irq		= irq;
> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >@@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >  		mlx5e_activate_xsk(c);
> >  	else
> >  		mlx5e_activate_rq(&c->rq);
> >+
> >+	netif_napi_set_irq(&c->napi, c->irq);
> 
> Can be safely moved to mlx5e_open_channel without interfering with other
> existing mapping. This would save the new irq field in mlx5e_channel.

Sure, yea, I have that change queued already from last night.

> >+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> 
> In some configurations we have multiple txqs per channel, so the txq indices
> are not 1-to-1 with their channel index.
> 
> This should be called per each txq, with the proper txq index.
>
> It should be done also for feture-dedicated SQs (like QOS/HTB).

OK. I think the above makes sense and I'll look into it if I have some time
this week.
 
> >+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> 
> For consistency, I'd move this one as well, to match the TX handling.

Sure.

> >  }
> >  static void mlx5e_deactivate_channel(struct mlx5e_channel *c)

