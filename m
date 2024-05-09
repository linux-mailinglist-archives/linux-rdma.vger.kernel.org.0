Return-Path: <linux-rdma+bounces-2362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F421E8C0A5A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 06:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD16282A08
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 04:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477011482F1;
	Thu,  9 May 2024 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ruZqvsCK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702FD26D
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715227900; cv=none; b=mfevV0gReqTBLijZLeeE4AjJEUF3kyyKcVRAtWO/E1ETaMtQUmikUUxH/7UDKfJZOI0IemrbFIybFLaK1rKrVuWWaT0TVXYgPrGhbZVH9g0cvorpPRi2ooWWJ4OOk6wp0loayHhi6j6bxgMN7NYbqEbu20Y24N8KRnoD95XTpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715227900; c=relaxed/simple;
	bh=EuD5rGws0oPE0xiAPheoEoxDAQyOqvEFoxH7b515VT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuOpg740PtuUYxT55lmHm0o7qkUbquO1MaxkPojaT/7wqu7MJ/m1jXc8Xws1oLrETL1H88Zgu2rh1O316pXSACvdpmi+CrgwXWepDWcpl5t+uGaFMo865tQqqD5fHNvANyl3VgUjB8S1kFWWYteZ66+z9oP4rzTrtQb4IqJyRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ruZqvsCK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so455429b3a.2
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2024 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715227898; x=1715832698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BquM86FdyvTwrPBmMgArwClBgJHZfCecZ2xsyzp4mrw=;
        b=ruZqvsCKtYkD71cVib3ALNpeZZ8cim29EZ+2akNN0Aty4Y7tMceiuhGvuZ5AenT4r4
         PsW7nSht5KsJahYja+PKkwPcdLSLCnlwMU2n+cF2j57aD/P5dvJ5VSX47CvUjimhtXmi
         znq/rCDZyj75mI9Vr7CDIHagU9J5iPhIpaYFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715227898; x=1715832698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BquM86FdyvTwrPBmMgArwClBgJHZfCecZ2xsyzp4mrw=;
        b=FXdQNQ18PGav+eH1iLNgPjvphIjQJJC2z7mi/frbMdaG+h2xHgqOIhR/zllHqnldaM
         X/gIUZAc+RrrPCbtXO+OzyHZe5u62bkReTRw1YfbVi/OS27/8jj4JvKa6HEJuI278fZy
         BcQk1YKvXBJ1USlNNbTyOeORj1HOjbkeFmK/OP8ClLB/t2NQbSti4Xr9KAC/wmsPH4Cp
         gthHsXy/TRQdyUox2M/WBWaO4dE58Dc2jSOT+p2aiCrY/Kx6/9rTuaFpGNYQZ5WgPthr
         +/mJyQZ+k1Ss5sgDXKwBhQR5tyizo9qC/hVzNMz6MS2mbG8BeNDKQioX6kzexJzFAH6I
         TMIg==
X-Forwarded-Encrypted: i=1; AJvYcCVWRVA5YV6Bcit8x5OjGqLoGx1oBiVLNGOSR8Ht3KA7zS3nPgkMdF+/kIzJMHIyUFHwnF7lUSAR503wP20j5LIIRZ0U/0HSqYuzxA==
X-Gm-Message-State: AOJu0YzLIqctQRPEyQCF7KUU7BWigSXdiVIL3yMaXPuQGjcDQIs3xl3F
	GTJUlP6AVeeiIZW9r97umyC0LlWJjkDzlDSLoovKgWOmhYpfmORM14ffmeopyOk=
X-Google-Smtp-Source: AGHT+IEeW5kcZzuh3q3xss0tmlvWIeShGXPqLqYpMy8O9b5kYA5qoS5aLHM33knk0PbdcH07cxN0OA==
X-Received: by 2002:a05:6a00:2d88:b0:6f3:ee9a:f38b with SMTP id d2e1a72fcca58-6f49c206b5bmr6352615b3a.6.1715227898075;
        Wed, 08 May 2024 21:11:38 -0700 (PDT)
Received: from ubuntu (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a86a2csm367073b3a.78.2024.05.08.21.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 21:11:37 -0700 (PDT)
Date: Thu, 9 May 2024 04:11:34 +0000
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjxM9i1yFDRQ2f/s@ubuntu>
References: <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <20240508175638.7b391b7b@kernel.org>
 <ZjwtoH1K1o0F5k+N@ubuntu>
 <20240508190839.16ec4003@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508190839.16ec4003@kernel.org>

On Wed, May 08, 2024 at 07:08:39PM -0700, Jakub Kicinski wrote:
> On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
> > If I'm following that right and understanding mlx5 (two things I am
> > unlikely to do simultaneously), that sounds to me like:
> > 
> > - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
> >   priv->channels.params.num_channels (instead of priv->stats_nch),
> 
> Yes, tho, not sure whether the "if i < ...num_channels" is even
> necessary, as core already checks against real_num_rx_queues.

OK, I'll omit the i < ... check in the v2, then.

> >   and when
> >   summing mlx5e_sq_stats in the latter function, it's up to
> >   priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
> > 
> > - mlx5e_get_base_stats accumulates and outputs stats for everything from
> >   priv->channels.params.num_channels to priv->stats_nch, and
> 
> I'm not sure num_channels gets set to 0 when device is down so possibly
> from "0 if down else ...num_channels" to stats_nch.

Yea, it looks like priv->channels.params.num_channels is untouched on
ndo_stop, but:

mlx5e_close (ndo_close)
  mlx5e_close_locked
    mlx5e_close_channels
      priv->channels->num = 0;

and on open priv->channels->num is restored from 0 to
priv->channels.params.num_channels.

So, priv->channels->num to priv->stats_nch would be, I think, the inactive
queues. I'll give it a try locally real quick.

> >   priv->channels.params.mqprio.num_tc to priv->max_opened_tc... which
> >   should cover the inactive queues, I think.
> > 
> > Just writing that all out to avoid hacking up the wrong thing for the v2
> > and to reduce overall noise on the list :)

