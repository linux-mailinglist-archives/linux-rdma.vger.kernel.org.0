Return-Path: <linux-rdma+bounces-2720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6898D5766
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 02:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403751C22A18
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A54C8F;
	Fri, 31 May 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AYFBMKat"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEE2595
	for <linux-rdma@vger.kernel.org>; Fri, 31 May 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117017; cv=none; b=GfXZm/xlJOU3aClwmVH8ZXX7Aghsw0cCKS7gH+GOgM17MvKCt0uxUK6yqs7nQLjRfx04AmRkTXbT11K61KJzciK3p07NG2qm3D9XbEPkPFSyeg3rY8h+4BtC6nl7ZMDVu2T89oFj+bv5oppXRw8Iju35uPIzJq5oqvgPGpZKcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117017; c=relaxed/simple;
	bh=utUjPf+CxVjInNUZOIhI0gR+mCYUEfMhM7sF+HObOLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amLrTs+iNae96NgsAfAGX2z+RRVj909MJUehtRiYV9uEnWtCsGHLL2Y7ePPNp38Vbw4/aG/XwEjpVWVTKU2cF8BcfeHmMx8+CCXFrRfkIRzmpNfVLLldk7dbnkYhkmfRsdR1xpxh8ApmlHfA+yOQqJPr69qqfkDGxfwOzb9fe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AYFBMKat; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6262c0a22so5841445ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 17:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717117015; x=1717721815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b10Tm7oRJPRuDfKU1e8ItJ5vWrTyaVOp+4gtgHNCzus=;
        b=AYFBMKat4pEbjDffJmKzvweIca3z86K8fKPF7fezGjP3P1M62hy7Nj4/ibo9Apa1S3
         Z4u/V0VKRRueO/205+7rAKcpAnLV0u7ktJzp35V/P6Vk0/Cn5o+EtHqp6iHcJhmIpLkh
         p2ia49XoJlHNJGW05m4WcqhmjfFPka8ZBdlzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717117015; x=1717721815;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b10Tm7oRJPRuDfKU1e8ItJ5vWrTyaVOp+4gtgHNCzus=;
        b=eaGX7rgGM3Rwm/VZU9OMym/NFu4G2mswSHXUTJ4IQFNxBIAykkNTn3Rf2o20j66+1n
         qW78MlCj+6LkjW3AcDKd33BQFRPQXcbEEZnmhs+mngv7SgBVag5U+wj4syH8AKVFW0nB
         Ge7Y8POmEE4ITDCo3ttDfPalFn+2jmh6yFg07elV6iQZnLK8XQcdjgb82uyKe6ajmZl5
         bzjjKBtO8eX25Rcl2gyXWybScJ1Gl/17yh1AGrFS9g9FgPM/umPHc03y8IxeUxIupzPw
         Ivtx+DrgelS1Tu9/3OwpA3teNhiMoNn/fPNqZ2tYm/rBUCBmCwENzG3CfDXVTbbGc0xc
         aGCw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVbEkK7oZsMaZK9vbzOj9Yu5sTL16KDD9GgeqYnB23IX1IvOXic3JvjS3JE4sSBcL+B/P16SO9wcY213kEZRHN2gdZrT/iVFocA==
X-Gm-Message-State: AOJu0YzlU9XyrZkIlWWFZ2JWjxS+nGIkZU/V48XeU+Q8OIwaYKFwIj3o
	aF3pXQIzBAZJsJXjFQeyFdUPjifIPWTuqB5BLYESoHKJcyfKp5fuZgWdEdZ19Ms=
X-Google-Smtp-Source: AGHT+IHIQqq87FLOuCkXsun/b85HAp4T8gxNpAE6sXxtG7+A9leHJoAHvH9pQLR4ro8iOsSxPHm0gw==
X-Received: by 2002:a17:902:ce01:b0:1eb:6cfe:7423 with SMTP id d9443c01a7336-1f6359eaaaemr8685885ad.19.1717117015183;
        Thu, 30 May 2024 17:56:55 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f635abdec8sm2026815ad.163.2024.05.30.17.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:56:54 -0700 (PDT)
Date: Thu, 30 May 2024 17:56:52 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <ZlkgVJbRpkzx6rTI@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240530171128.35bd0ee2@kernel.org>
 <ZlkWnXirc-NhQERA@LQ3V64L9R2>
 <20240530173902.7f00a610@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530173902.7f00a610@kernel.org>

On Thu, May 30, 2024 at 05:39:02PM -0700, Jakub Kicinski wrote:
> On Thu, 30 May 2024 17:15:25 -0700 Joe Damato wrote:
> > > Why to base, and not report them as queue stats?
> > > 
> > > Judging by mlx5e_update_tx_netdev_queues() calls sprinkled in
> > > ../mlx5/core/en/htb.c it seems that the driver will update the
> > > real_num_tx_queues accordingly. And from mlx5e_qid_from_qos()
> > > it seems like the inverse calculation is:
> > > 
> > > i - (chs->params.num_channels + is_ptp)*mlx5e_get_dcb_num_tc(&chs->params)
> > > 
> > > But really, isn't it enough to use priv->txq2sq[i] for the active
> > > queues, and not active ones you've already covered?  
> > 
> > This is what I proposed in the thread for the v2, but Tariq
> > suggested a different approach he liked more, please see this
> > message for more details:
> > 
> >   https://lore.kernel.org/netdev/68225941-f3c3-4335-8f3d-edee43f59033@gmail.com/
> > 
> > I attempted to implement option 1 as he described in his message.
> 
> I see, although it sounds like option 2 would also work.

I don't really mind either way; from Tariq's message it sounded like
he preferred option 1, so I tried to implement that thinking that it would be
my best bet at getting this done.

If option 2 is easier/preferred for some reason... it seems like
(other than the locking I forgot to include) the base implementation
in v2 was correct and I could use what I proposed in the thread for
the tx stats, which was:

  mutex_lock(&priv->state_lock);
  if (priv->channels.num > 0) {
          sq = priv->txq2sq[i];
          stats->packets = sq->stats->packets;
          stats->bytes = sq->stats->bytes;
  }
  mutex_unlock(&priv->state_lock);

And I would have implemented option 2... IIUC.

