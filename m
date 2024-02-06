Return-Path: <linux-rdma+bounces-922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CB84ABD2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C331C2322F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47856755;
	Tue,  6 Feb 2024 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ltA9KMUz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4056B64
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184623; cv=none; b=XW6AhcNsP0CHrdre57e5W0HysI6KBxthv41Nd2uu1m7aLDji7SrQajjOl7F+grK+KXU9rgNQQEaavE+f8+fwscNQ5Yuy/8tVPsw7YVbPq4TKOCjlLbvOY+H8gAwP82qQVT/MdboFo9FZlYw5ublfR5LLMW5OcbbDiGS4qo70dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184623; c=relaxed/simple;
	bh=AGGj7Vod8i/cMhIocRRjpJuktqfjt3MGtAOErqqB4RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5zI7KD3ixcgAvTUvbKu45FmZh1CbwdfnEh9JBqmR2YCfpgO8+x3Bat8Tziajn3QosRzp2EgjTpj4+UkECS31KKr7EUPIne0+dzcSTe3kI4RnypwBcXx7iCfPrbVr6jEhfkIQXVoTHBrw5Ii4+GEfbCR95eLLjn50fIowxfITcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ltA9KMUz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7431e702dso42740785ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 05 Feb 2024 17:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707184621; x=1707789421; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RQcHLm5QazOeCq3JvR92kEunC3ZSrNlLeaxZZfWXA0=;
        b=ltA9KMUzeuLgMRjVzDzeOMaw74k9rxYdDq2Xe7tYf3r+Www98/j8JrnAGL6cDFl3/b
         1L1rjYYOO7PK1C7mgse1i9m83nP2iLi6j/t0X6Y1ipQJMZUwaahPph/0w6GQFUimxWps
         b5NdFP4QqGBJ1piPMA//0Q8yzMt/rhskaWwTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707184621; x=1707789421;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RQcHLm5QazOeCq3JvR92kEunC3ZSrNlLeaxZZfWXA0=;
        b=ogAg/ZvsK8prJ6AN5ipxdQjsn7wHLhWDgQmoAx/emwaPamrHT2dCqd1ysf/ypltxKQ
         4cWNEO4EL7F8SHs93PPF/jWOKXfyCeUvKxUInc5h2+uyJpC9pkuMHtkKmb99hPsL5xeZ
         7ZR0ENKgT8fb11wp6sWRF0QpAwWmQXR6SaypEmCunZsrg7Ydy+8PVJcbi3AID55kn3TW
         hyKeB1DGmpP+46QCIGcBZQLIuqIva+XroNJeJYJdoc8dNBy/IaMi5eQHTJ58RvhwTEmw
         kzQcpjOB87quFs45LsPv8uoHKsEBzvu6VtXORjaYxGjKQRXpsegcTSN//HTHyLc82yin
         Jj7Q==
X-Gm-Message-State: AOJu0YyTNlxYmXtmAZtIzgDZ1FgLRdWmffWrEFaJYLyjkXr8cocw7rFl
	zxWmzIS7lywyFjY6fWBqpbDqtcfh3J40xXCGHR3hMQzfg0YvTHfX6WXn4J9FOFEdhruzXCt6NSH
	G
X-Google-Smtp-Source: AGHT+IGFs+QR1LR1g/SgL6DV+s4jv4M3sRSbSYmRfFvgvR0v1IuEhSQTG8Ns1zi+PiHPUMgc4MzHuw==
X-Received: by 2002:a17:90a:fd96:b0:294:4637:7ed with SMTP id cx22-20020a17090afd9600b00294463707edmr934326pjb.40.1707184621159;
        Mon, 05 Feb 2024 17:57:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVBA5wCZeQQujcnRN2if4vYXLgeOnWqpsGt2RhCIP5kNPaGZ1rtE2O7x2BQuY6pRumfAfzgJqNgyPJXwU/vxU4WHg5E+XZVWuEfMZJ8y8STnkZGsZli4R5IsGpvmMIxqbFyPpvMNwW6fdYZJaYQtpUNALTtL4SuToFC7WxNNMUM3blZJuEpmG/NswDe86ACCfPTxB9CX8ITbB2yafBrdoO3WnRELaoXrxPNj103INBFxVzZP306rhguXjK+sRLylOc7AVLPEIW4wKfpT0iqcusN6mA+eluGz9+QTdsL7TITQaNDaAa8PyY=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id fa2-20020a17090af0c200b00296b90d93absm172768pjb.29.2024.02.05.17.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 17:57:00 -0800 (PST)
Date: Mon, 5 Feb 2024 17:56:58 -0800
From: Joe Damato <jdamato@fastly.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240206015657.GA11257@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com>
 <20240206013246.GA11217@fastly.com>
 <874jemml1j.fsf@nvidia.com>
 <20240206014151.GA11233@fastly.com>
 <87zfwel5qi.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfwel5qi.fsf@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Feb 05, 2024 at 05:44:27PM -0800, Rahul Rameshbabu wrote:
> 
> On Mon, 05 Feb, 2024 17:41:52 -0800 Joe Damato <jdamato@fastly.com> wrote:
> > On Mon, Feb 05, 2024 at 05:33:39PM -0800, Rahul Rameshbabu wrote:
> >> 
> >> On Mon, 05 Feb, 2024 17:32:47 -0800 Joe Damato <jdamato@fastly.com> wrote:
> >> > On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
> >> >> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
> >> >> > Make mlx5 compatible with the newly added netlink queue GET APIs.
> >> >> >
> >> >> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> >> >> > ---
> >> >> >  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
> >> >> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
> >> >> >  2 files changed, 9 insertions(+)
> >> >> >
> >> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >> >> > index 55c6ace0acd5..3f86ee1831a8 100644
> >> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >> >> > @@ -768,6 +768,7 @@ struct mlx5e_channel {
> >> >> >  	u16                        qos_sqs_size;
> >> >> >  	u8                         num_tc;
> >> >> >  	u8                         lag_port;
> >> >> > +	unsigned int		   irq;
> >> >> >  
> >> >> >  	/* XDP_REDIRECT */
> >> >> >  	struct mlx5e_xdpsq         xdpsq;
> >> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> >> > index c8e8f512803e..e1bfff1fb328 100644
> >> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> >> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
> >> >> >  	mlx5e_close_tx_cqs(c);
> >> >> >  	mlx5e_close_cq(&c->icosq.cq);
> >> >> >  	mlx5e_close_cq(&c->async_icosq.cq);
> >> >> > +
> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >> >> 
> >> >> This should be set to NULL *before* actually closing the rqs, sqs, and
> >> >> related cqs right? I would expect these two lines to be the first ones
> >> >> called in mlx5e_close_queues. Btw, I think this should be done in
> >> >> mlx5e_deactivate_channel where the NAPI is disabled.
> >> >> 
> >> >> >  }
> >> >> >  
> >> >> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> >> >> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >> >> >  	c->stats    = &priv->channel_stats[ix]->ch;
> >> >> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
> >> >> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> >> >> > +	c->irq		= irq;
> >> >> >  
> >> >> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >> >> >  
> >> >> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >> >> >  		mlx5e_activate_xsk(c);
> >> >> >  	else
> >> >> >  		mlx5e_activate_rq(&c->rq);
> >> >> > +
> >> >> > +	netif_napi_set_irq(&c->napi, c->irq);
> >> 
> >> One small comment that I missed in my previous iteration. I think the
> >> above should be moved to mlx5e_open_channel right after netif_napi_add.
> >> This avoids needing to save the irq in struct mlx5e_channel.
> >
> > I couldn't move it to mlx5e_open_channel because of how safe_switch_params
> > and the mechanics around that seem to work (at least as far as I could
> > tell).
> >
> > mlx5 seems to create a new set of channels before closing the previous
> > channel. So, moving this logic to open_channels and close_channels means
> > you end up with a flow like this:
> >
> >   - Create new channels (NAPI netlink API is used to set NAPIs)
> >   - Old channels are closed (NAPI netlink API sets NULL and overwrites the
> >     previous NAPI netlink calls)
> >
> > Now, the associations are all NULL.
> >
> > I think moving the calls to active / deactivate fixes that problem, but
> > requires that irq is stored, if I am understanding the driver correctly.
> 
> I believe moving the changes to activate / deactivate channels resolves
> this problem because only one set of channels will be active, so you
> will no longer have dangling association conflicts for the queue ->
> napi. This is partially why I suggested the change in that iteration.

As far as I can tell, it does.
 
> As for netif_napi_set_irq, that alone can be in mlx5e_open_channel (that
> was the intention of my most recent comment. Not that all the other
> associations should be moved as well). I agree that the other
> association calls should be part of activate / deactivate channels.

OK, sure that makes sense. I make that change, too.

> >
> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> >> >> 
> >> >> It's weird that netlink queue API is being configured in
> >> >> mlx5e_activate_channel and deconfigured in mlx5e_close_queues. This
> >> >> leads to a problem where the napi will be falsely referred to even when
> >> >> we deactivate the channels in mlx5e_switch_priv_channels and may not
> >> >> necessarily get to closing the channels due to an error.
> >> >> 
> >> >> Typically, we use the following clean up patterns.
> >> >> 
> >> >> mlx5e_activate_channel -> mlx5e_deactivate_channel
> >> >> mlx5e_open_queues -> mlx5e_close_queues
> >> >
> >> > OK, I'll move it to mlx5e_deactivate_channel before the NAPI is disabled.
> >> > That makes sense to me.
> >> 
> >> Appreciated. Thank you for the patch btw.
> >
> > Sure, thanks for the review.
> 

