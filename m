Return-Path: <linux-rdma+bounces-936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081A84BE0A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 20:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802C91F25882
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD9D1429A;
	Tue,  6 Feb 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PR1qDzaN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C81B7F0
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247402; cv=none; b=R+GDHvyuFxdaxst+38amfU+btoNAV9tWTDw7v5FkexfWv0hY17vU+RFnEdC/7jQT7Tt4ABdF5Rbq+FyL/jrvVKvoPKBzHZCCiZT3XddKKyn2wv5mOyEVrwCP3aUBUO4UdFb6C8ZMZJ43NiZly/CpK59EQnla5VlQHZ+KkhGYAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247402; c=relaxed/simple;
	bh=sswoxrUssn/jef7IHB+aJGl0lVigB214C5e5ko47pY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4cMInY8fmH9FCzPnLNNHBAGvw3DguV8y7ltCcYnw+HBjXXMu/ejqE7/EWy8ECteAPutpjvrQyRCGhsCvpglqOjdj4diDe1zUjRu/06As/FXW3X5Gdp+63LxzVw8QiN1BNBnllOnzHFQafsHKF6/eDqsui8QONczda6Fy4Th3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PR1qDzaN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d8ef977f1eso45637675ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Feb 2024 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707247399; x=1707852199; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCsDCFv95XN97gg7lNTZ0+UwYIdgYUGt+4rHD7khrmY=;
        b=PR1qDzaN7OAxU+YD7vLZ4Fhk+EcO7cDP2cXtVSrbcDtXWuMgudW3CSsgZ/lNG/4okV
         /W5o0hTMd7G1EKt/4bCX7HPx516+kevnFivZmGrbDs9Wb7oe6GpkFM3oRkP4SecWDPct
         Vg0KNz0BpENNcnutO6oEgM9RdiPNPdjR7Hjks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707247399; x=1707852199;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCsDCFv95XN97gg7lNTZ0+UwYIdgYUGt+4rHD7khrmY=;
        b=GkRXQW+Ie0cYwwr8LsT9e19AivXTXSJ0k9MZjnq/TY1tzhtKESamy6J8+BAOwszn91
         FTPfhG702jDKA/4b6l/WuoFWVOzKJzXLrhr8kEgiCXdCBPUjw9u2y+XLKBPLBbLqxCvO
         EvmeJDfknKcuGDKoldpfu9XCJhmB85d4Op+uDkB4uuSJuWG1zaNl0FSy+S9J7Oexmvnx
         VNaMm7SghROjLBpXWOjDk4bbytbbn8ogsP6ypKwqiZtjPS4iVd+YgEJQjHKTy49FoVW2
         drJJewL5oibp9f28bQQ7dyvT088k22fSFP5+nHt45+e+NJoPDEViAwsJCsooDTHOYqGO
         TxXw==
X-Gm-Message-State: AOJu0Yz1d+QUt1rpgkHSKVu39Y/7Ywf7QKeJbo7uxxm7fcfZOxx2Z2fc
	jYop+hJrQU5d12sSV/l7INp7SDUqZbwM4zdDYAuDiyvWRQGD1OmqJ6wmrUvirwc=
X-Google-Smtp-Source: AGHT+IHQiCGM5q38MDPZmB/hdO0LYPPBA6d3m+kc9reqUpjHywyfGzMJw9e8lzTNDPmwNTMxXGnUgQ==
X-Received: by 2002:a17:902:dac4:b0:1d7:553d:4e8 with SMTP id q4-20020a170902dac400b001d7553d04e8mr2795644plx.21.1707247398666;
        Tue, 06 Feb 2024 11:23:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVLY2IMIp/92eChdXE9nJGkIct6oo1sdZC6wO4B1gP+VhKP9XMWrOOwNy5CGGZavrgHs2rGUZITSgUW2pCU/YUTVHnVhG11orBWIj/HmLTCAVDYqP9i4ePo2QETvsgD2SG6JXaGIGOtw5uhI4Xqb3UiD0u6gjEUSA4VuXFXfusBuUR0gN5tErkRQ+dsybo3abfFCpgPVTq82cw2VY5u6kpyfuBzUfBHoPyA+GfOvx7b6u7lDNGndOG2cx1aahxjzJ1KLQp3Ww4ImWW0c8l11dcIrbzzPmElNQDMQbI10s0cWS/DGvXtg28Smas4a7jh+WwwoN7fRwj/kaf/JGMRam44kp5FYCxCyzMTOodKSplWopdY16a/RsYk0zk=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090323cb00b001d961ebf31bsm2259768plh.82.2024.02.06.11.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:23:18 -0800 (PST)
Date: Tue, 6 Feb 2024 11:23:15 -0800
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	rrameshbabu@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240206192314.GA11982@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
 <20240206171159.GA11565@fastly.com>
 <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Tue, Feb 06, 2024 at 09:10:27PM +0200, Tariq Toukan wrote:
> 
> 
> On 06/02/2024 19:12, Joe Damato wrote:
> >On Tue, Feb 06, 2024 at 10:11:28AM +0200, Tariq Toukan wrote:
> >>
> >>
> >>On 06/02/2024 3:03, Joe Damato wrote:
> >>>Make mlx5 compatible with the newly added netlink queue GET APIs.
> >>>
> >>>Signed-off-by: Joe Damato <jdamato@fastly.com>
> >>
> >>+ Gal
> >>
> >>Hi Joe,
> >>Thanks for your patch.
> >>
> >>We have already prepared a similar patch, and it's part of our internal
> >>submission queue, and planned to be submitted soon.
> >>
> >>Please see my comments below, let us know if you're welling to respin a V2
> >>or wait for our patch.
> >
> >Do you have a rough estimate on when it'll be submitted?
> >
> >If it's several months out I'll try again, but if it's expected to be
> >submit in the next few weeks I'll wait for your official change.
> 
> It'll be in the next few weeks.

OK, well I tweaked the v3 I had queued  based on your feedback. I am
definitiely not an mlx5 expert, so I have no idea if it's correct.

The changes can be summed up as:
  - mlx5e_activate_channel and mlx5e_deactivate_channel to use
    netif_queue_set_napi for each mlx5e_txqsq as it is
    activated/deactivated. I assumed sq->txq_ix is the correct index, but I
    have no idea.
  - mlx5e_activate_qos_sq and mlx5e_deactivate_qos_sq to handle the QOS/HTB
    case, similar to the above.
  - IRQ storage removed

If you think that sounds vaguely correct, I can send the v3 tomorrow when
it has been >24hrs as per Rahul's request.

> >
> >BTW, are the per queue coalesce changes in that same queue? It was
> >mentioned previously [1] that this feature is coming after we submit a
> >simple attempt as an RFC. If that feature isn't planned or won't be submit
> >anytime soon, can you let us know and we can try to attempt an RFC v3 for
> >it?
> >
> 
> The per queue coalesce series is going through internal code review, and is
> expected to also be ready in a matter of a few weeks.

OK, great. Thanks for letting me know; we are definitely interested in
using this feature.

> >[1]: https://lore.kernel.org/lkml/874jj34e67.fsf@nvidia.com/
> >
> >>>---
> >>>  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
> >>>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
> >>>  2 files changed, 9 insertions(+)
> >>>
> >>>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >>>index 55c6ace0acd5..3f86ee1831a8 100644
> >>>--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >>>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >>>@@ -768,6 +768,7 @@ struct mlx5e_channel {
> >>>  	u16                        qos_sqs_size;
> >>>  	u8                         num_tc;
> >>>  	u8                         lag_port;
> >>>+	unsigned int		   irq;
> >>>  	/* XDP_REDIRECT */
> >>>  	struct mlx5e_xdpsq         xdpsq;
> >>>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >>>index c8e8f512803e..e1bfff1fb328 100644
> >>>--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >>>+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >>>@@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
> >>>  	mlx5e_close_tx_cqs(c);
> >>>  	mlx5e_close_cq(&c->icosq.cq);
> >>>  	mlx5e_close_cq(&c->async_icosq.cq);
> >>>+
> >>>+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> >>>+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >>>  }
> >>>  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> >>>@@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >>>  	c->stats    = &priv->channel_stats[ix]->ch;
> >>>  	c->aff_mask = irq_get_effective_affinity_mask(irq);
> >>>  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> >>>+	c->irq		= irq;
> >>>  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >>>@@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >>>  		mlx5e_activate_xsk(c);
> >>>  	else
> >>>  		mlx5e_activate_rq(&c->rq);
> >>>+
> >>>+	netif_napi_set_irq(&c->napi, c->irq);
> >>
> >>Can be safely moved to mlx5e_open_channel without interfering with other
> >>existing mapping. This would save the new irq field in mlx5e_channel.
> >
> >Sure, yea, I have that change queued already from last night.
> >
> 
> I see now.. I replied before noticing it.
> 
> >>>+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> >>
> >>In some configurations we have multiple txqs per channel, so the txq indices
> >>are not 1-to-1 with their channel index.
> >>
> >>This should be called per each txq, with the proper txq index.
> >>
> >>It should be done also for feture-dedicated SQs (like QOS/HTB).
> >
> >OK. I think the above makes sense and I'll look into it if I have some time
> >this week.
> >>>+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> >>
> >>For consistency, I'd move this one as well, to match the TX handling.
> >
> >Sure.
> >
> >>>  }
> >>>  static void mlx5e_deactivate_channel(struct mlx5e_channel *c)

