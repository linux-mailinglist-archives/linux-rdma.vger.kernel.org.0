Return-Path: <linux-rdma+bounces-918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2384AB9B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA471C238DC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 01:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873AED9;
	Tue,  6 Feb 2024 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="i3wfo3O7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038ED6FA9
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183172; cv=none; b=imNDfkF6tAspmtaugoMJP89lXlo7VaUJqS+04+RC3sA0LnzBq+q5y21qUBlg8LoqVwkQ/U0N5Rv73YYa63KknHh8p2mAbRPGqFB03vvkoo+019zZtarWb9t6pHQZ6ct/w4XUcJaqxXA6vmQz7XoLqFA6s2N7AADUdfWxDUpE5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183172; c=relaxed/simple;
	bh=pBkCYd7B0CYbCUsFx1V+bQ/EoKILx+Ug6j39eib3yNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecAXwtNyt8SaiZCrevM4w0KWnq9sGzqYUIDIyEwtIryQAh5jgWcnv6h86spdE21CQUZOuKTXIk/M5yQwPQjm/3OsZlod9dNF3U85XosmmIadhxMvgs59DzdztZjnIkI0anmZw3qDr6hRAhbHJ22f2gr4Xw5qaZNjCl7f2nPDT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=i3wfo3O7; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bfdc1c0a2aso821124b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 05 Feb 2024 17:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707183170; x=1707787970; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHuOPEoYQA+w2xuM98mJBf47nO7PTxDkSYQ4f4HqMbQ=;
        b=i3wfo3O7ujfvOnFQ8iUYnkD8BGhx2lz1AIqqU/cDsJwukfbePa+PQJQO8KQtXQVbeo
         NaPbynDWLtb40dkbfq+SqyECXU9PKiN0PTVSewTiDn3KrwGFf2uzUgSYcLCSmTd6flU2
         N0mg/0ynm5IIbfHFg6QwuhnFIp/ifMlrVO5Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183170; x=1707787970;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHuOPEoYQA+w2xuM98mJBf47nO7PTxDkSYQ4f4HqMbQ=;
        b=jApGXZmSTTZi09uXbpOX0N2zu2nyqq/cMUHVspAQ2YYWRJ4X12x393xHsXH14wfp4u
         6vG+UuB0uQSZ+C3CFQWSCmEJ82dD31hKDHktPpAE46X2upjNUgr5Y66vPKQ83Jg7YgKt
         d6Oj6OeqxVtKP1LYax+b3r/+SFVQaQKxaBNYcg7EWaBfqK+uXjFth3QwOPchbzmMq5j9
         bVW73JjXu/LUiH4y7oXYsoujIOxAT1ZAfWuR5jp2BRI/h96LGLyhaoWupJjJJFU5teki
         B4Hv+YeDFQ/qHp5O0WW5VSCMoIl8iowWhMTUR8CbtzUFpix/bbi9ZMLtc7wlg6obNCtT
         pkDQ==
X-Gm-Message-State: AOJu0YwJgxVA5VVTFcI5W5rwFt5cx5fdvLWH5iIF8twcVJBzYPQRQfa2
	0hx021YuRbZClVriZizLRWhfthgQ4Nm6AjOnKKS1QnR0cZuQvtN1MJt5y73unnk=
X-Google-Smtp-Source: AGHT+IEfUdobcaRYKtUSizm1hySV21NrDxUEoJ4N7Mo8m0VLv1K2M5EQHQwZUtLidkFEp9q1hOWDnw==
X-Received: by 2002:a05:6358:719:b0:175:cfa7:953d with SMTP id e25-20020a056358071900b00175cfa7953dmr1872310rwj.2.1707183170011;
        Mon, 05 Feb 2024 17:32:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWztDuxk32cFuyDyhLEKLkKPT490E0I7gmkTVzjmDoSKJnp28RU+Dy8Y5itHl3on59Xm0/r2yd5B83SbO2D9uhReh989XI620M1TSaNFpohO7me7+2C2KuPjuJa7j7I1KiYa9zZyQ/r1vrvtfD2HPXq7jAYDvnmx+4o1mKQrB06cCiHlLfMR48cx2A+nDt/T1ImI0XRo7XBzG1RKrjptLzvSELC/WU9ndVfTrxph4tK076ILZZ9zDhAAScFNE/8DnhFBlSHmCri/g3/lH3aWkMmf67urd/KhgTceFZVXX7KvwMXwKJCH5c=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id v18-20020aa799d2000000b006e0414d7cf8sm554769pfi.95.2024.02.05.17.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 17:32:49 -0800 (PST)
Date: Mon, 5 Feb 2024 17:32:47 -0800
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
Message-ID: <20240206013246.GA11217@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r3ymlnk.fsf@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
> > Make mlx5 compatible with the newly added netlink queue GET APIs.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > index 55c6ace0acd5..3f86ee1831a8 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > @@ -768,6 +768,7 @@ struct mlx5e_channel {
> >  	u16                        qos_sqs_size;
> >  	u8                         num_tc;
> >  	u8                         lag_port;
> > +	unsigned int		   irq;
> >  
> >  	/* XDP_REDIRECT */
> >  	struct mlx5e_xdpsq         xdpsq;
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index c8e8f512803e..e1bfff1fb328 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
> >  	mlx5e_close_tx_cqs(c);
> >  	mlx5e_close_cq(&c->icosq.cq);
> >  	mlx5e_close_cq(&c->async_icosq.cq);
> > +
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> 
> This should be set to NULL *before* actually closing the rqs, sqs, and
> related cqs right? I would expect these two lines to be the first ones
> called in mlx5e_close_queues. Btw, I think this should be done in
> mlx5e_deactivate_channel where the NAPI is disabled.
> 
> >  }
> >  
> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >  	c->stats    = &priv->channel_stats[ix]->ch;
> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> > +	c->irq		= irq;
> >  
> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >  
> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >  		mlx5e_activate_xsk(c);
> >  	else
> >  		mlx5e_activate_rq(&c->rq);
> > +
> > +	netif_napi_set_irq(&c->napi, c->irq);
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> 
> It's weird that netlink queue API is being configured in
> mlx5e_activate_channel and deconfigured in mlx5e_close_queues. This
> leads to a problem where the napi will be falsely referred to even when
> we deactivate the channels in mlx5e_switch_priv_channels and may not
> necessarily get to closing the channels due to an error.
> 
> Typically, we use the following clean up patterns.
> 
> mlx5e_activate_channel -> mlx5e_deactivate_channel
> mlx5e_open_queues -> mlx5e_close_queues

OK, I'll move it to mlx5e_deactivate_channel before the NAPI is disabled.
That makes sense to me.

