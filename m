Return-Path: <linux-rdma+bounces-2717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF318D56CC
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 02:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6607284D9A
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB515C0;
	Fri, 31 May 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="V9sq7c6a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA95A3F
	for <linux-rdma@vger.kernel.org>; Fri, 31 May 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114530; cv=none; b=CGPVvD7DUC09V2bfaxDVlesOSUon8gYM5buDlC4fpVzWxoVI4vFnmP4nlM9rJhU8w0K+j21aBtBmpzqe+rQEAiSVToC81JCEt5fDEb42UKIwf5HlfxfihTuq6DQphKOeqy1jpugK02si6t7UlvIHieDvVzrJC4kapmQWX7v/6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114530; c=relaxed/simple;
	bh=7nKP05IzWghTs+/Gw47J0KfC5h+/qykfWVcjDmjOfu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlHXMGy2JaLlBi4TQe77XO0xTC2FrHFXv0qfNNXBbWGgbDLZ3SW6Z8+RBGGZBBcaPlULzO0LAeqnILM1SsYgg3Za1mhLdEK/8vojkfUDPkDD5XnZB3AVeg8g3SXigMLRv9E+IUhMSYiIZe0h3PvqHUnlAlyxLtH6h3DITdgnxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=V9sq7c6a; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-702492172e3so48706b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717114528; x=1717719328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ly6Hg6fq3SFJdw/SABaUUxx1i9TM3ssbdYm2uvWA8wY=;
        b=V9sq7c6aAJFu0FRUa9ZGFMt/wWFYjH4y19K+ZzI9Megkm+kTIt2rpje98pCQSkgHIt
         ZwnAxDJVpkUPyAIYxANwgtj2az6hcokddH8XJwEZya0SbdYUJsnnEc2Qg24SciAysxBe
         9o+dY0jV5IWXg427KI3l5I54hvi9HpPTIGmPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717114528; x=1717719328;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly6Hg6fq3SFJdw/SABaUUxx1i9TM3ssbdYm2uvWA8wY=;
        b=eUiS5zINhNiLd6po/pfnceenIg0W9xihvLMNF3Nh+WQMWiYDoVX1Glm2XtynwHTH4G
         uRX9RTxqGkxW7ivvf9Gdp8EWko40E1PQ03XylLax45pqdZ8Z74pr6rXVoBiwA9Q9k1R8
         nutdyeFSKVQV3QHmbC0XmsQcYNGjgOPeM7ahovocs2AfDOYDhIGCAq5VueTnRd4+r/9Y
         s3jaCjmot7hJW1FFrwb2r9oS4FV8AoOz8/w+c6pQ8/sI5CHrl8UiY75DSimgplXFNHXH
         2zmctXYSy8WPconEqnWeW+VJ/RnXcEWHIAC20HJScdCVmwfB1bKYYokPVIfvk3+bngH3
         srmg==
X-Forwarded-Encrypted: i=1; AJvYcCUzOLYNkghB17Fp5vg8ZJRf6nDXBPKkkll0fbyP4c2RkMcAtfBeI/hHkuqgM52JYgu8dJALRQ33xVP8fU+65sVIMBIxpOn0KalOJA==
X-Gm-Message-State: AOJu0YzDmHj9RB0amuWkM4Srtc1U70gKhxsDdkX89MX9ynUdDHoEK39L
	PrAsO7Mgh9NRb3xRr/Au3l2N2pwZEwwhz0cEwUrgZ5uSnuMC1MyUA5MrfFU3uAU=
X-Google-Smtp-Source: AGHT+IHeb2aBfkXVR2aVMGQWVHLHXhM/2FGmIHVkBpGH3BSzIwhsyflA8mjCjhg/M2bV3TLxm84qyg==
X-Received: by 2002:a05:6a20:748a:b0:1b0:2826:9e2 with SMTP id adf61e73a8af0-1b26f16e5a1mr699040637.31.1717114528237;
        Thu, 30 May 2024 17:15:28 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b0554csm308321b3a.170.2024.05.30.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:15:27 -0700 (PDT)
Date: Thu, 30 May 2024 17:15:25 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <ZlkWnXirc-NhQERA@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240530171128.35bd0ee2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530171128.35bd0ee2@kernel.org>

On Thu, May 30, 2024 at 05:11:28PM -0700, Jakub Kicinski wrote:
> On Wed, 29 May 2024 03:16:25 +0000 Joe Damato wrote:
> > Worth noting that Tariq suggested I also export HTB/QOS stats in
> > mlx5e_get_base_stats.
> 
> Why to base, and not report them as queue stats?
> 
> Judging by mlx5e_update_tx_netdev_queues() calls sprinkled in
> ../mlx5/core/en/htb.c it seems that the driver will update the
> real_num_tx_queues accordingly. And from mlx5e_qid_from_qos()
> it seems like the inverse calculation is:
> 
> i - (chs->params.num_channels + is_ptp)*mlx5e_get_dcb_num_tc(&chs->params)
> 
> But really, isn't it enough to use priv->txq2sq[i] for the active
> queues, and not active ones you've already covered?

This is what I proposed in the thread for the v2, but Tariq
suggested a different approach he liked more, please see this
message for more details:

  https://lore.kernel.org/netdev/68225941-f3c3-4335-8f3d-edee43f59033@gmail.com/

I attempted to implement option 1 as he described in his message.
 
> > I am open to doing this, but I think if I were to do that, HTB/QOS queue
> > stats should also be exported by rtnl so that the script above will
> > continue to show that the output is correct.
> > 
> > I'd like to propose: adding HTB/QOS to both rtnl *and* the netdev-genl
> > code together at the same time, but a later time, separate from this
> > change.
> 
> Hm, are HTB queues really not counted in rtnl? That'd be pretty wrong.

As far as I can tell (and I could be wrong) I didn't see them
included in the rtnl stats, but I'll take another look now.

