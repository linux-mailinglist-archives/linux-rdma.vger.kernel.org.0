Return-Path: <linux-rdma+bounces-2970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851B8FF975
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 03:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D766286930
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 01:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E30C125;
	Fri,  7 Jun 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="D1/n4Mmw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C88363
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717722133; cv=none; b=iwUHZUZRM87cwZjQhswcuFGvEjHDArxhX+9A23iST7YUqlFyJ+SEULxJ8UQCzB2BcM4kGo2eVKWYGFu8VQE/EP99grhDn/DjioW/sfl3kM7xcYlqy8YnVALRuNc58imfrIbpOLZLPbLknahmMiwEDVFwHLCTsg3gimu8mKsqP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717722133; c=relaxed/simple;
	bh=PymsS2+bwa3WplcCpWVaQsEHbhZcs6L5674DPfMY+OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVf6yg4VG1i4ERFZbyFlMs/UutNgbiXAnkUesbMeSOsDur9VTWzXtA0F7wsx8KlqxSkqmil2tNFDWltgrT6vqBrCPtsCLfHygqHxxQYPdYezhUojE9zYPn9UfQD50zNXEtHKFpfCUjnxFAuKFqfDualtHcPKK67DlGVnsrGVoo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=D1/n4Mmw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4a5344ec7so12123525ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2024 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717722131; x=1718326931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUNbkcgn6ZFtJ0WPgugUHBmOtaRPBWaMM6dzuoXYIbI=;
        b=D1/n4Mmw8Q6J5RnHgmTuYnnvFbUYUoCvohemen4JEyYtWVq2uDDoCoEf8T6AOvHcWb
         VaKDQx8RUcUuCLaWnPg/lkYbYC9gQ/1o3IdVxfdesxdke26wYWJk7wR/nE8e3Y6VnkHi
         vMI+6MdyNOVvgtGxdHZs52lr0H3Of/ow7YszY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717722131; x=1718326931;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUNbkcgn6ZFtJ0WPgugUHBmOtaRPBWaMM6dzuoXYIbI=;
        b=bfPOv06IN28yAYAE6RHSki0t4UYsvuCKgz/kHBjdFwNgUhMhxPrMEMoU3q5SCFJouY
         cbY8WeTN8FR7evKujvQh9Puz2RE7a+kXEnVtEcX4hbHNo8k4rnxONmskts0kC285vcnY
         brx5Z2GTRhTZvvOd2PTXpdGS7+SEiWXEnP61hUIzE1N9LFyc7DYEUyKHeOig+kMEFFHU
         ultMOgO8zEWhAujtM7B+35vECsa/SSgUoMCWXXoVnNUe5SIELa1mPP2z7znUneUckUw4
         32lSrCxDTKmFyICUqTDQa9xpuBCfjdQv3PL42CMoHWoFsKTrzvLGTNaKGGP3SyV/+Hjg
         t4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY5s5ms5H68XassOQcTGRhk6CeAV6z7cJqfHz2CVaqc7yRUZza5CX9UDIbyYNmZ5bpwc2CEjXVvNpXD0vPwCPqVhJ4V4LBOOd82A==
X-Gm-Message-State: AOJu0YxLlbHZQ6XXMOrQZz5MkiFpbKtI8kmKsZdEESlEXRyJyaYzTMy0
	fKwzs0ie1t+ypX8ThemQeSg55EnkS+FzxloxRo7Jzlb5Sx10C2ZktzgrJznV5y8=
X-Google-Smtp-Source: AGHT+IFcBgdym20higsdPt+vBoI3sriQzqsZZxnlyi7NoJdl0XPH6dDC05Y4UuIX+LgQAMe7MRTE8g==
X-Received: by 2002:a17:902:d2d2:b0:1f6:6c39:9714 with SMTP id d9443c01a7336-1f6b8f08786mr57694725ad.21.1717722131413;
        Thu, 06 Jun 2024 18:02:11 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76bf66sm21602655ad.104.2024.06.06.18.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 18:02:11 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:02:08 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <ZmJcEM7brxivyDUV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
 <20240604004629.299699-3-jdamato@fastly.com>
 <11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>
 <ZmIwIJ9rxllqQT18@LQ3V64L9R2>
 <20240606171942.4226a854@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606171942.4226a854@kernel.org>

On Thu, Jun 06, 2024 at 05:19:42PM -0700, Jakub Kicinski wrote:
> On Thu, 6 Jun 2024 14:54:40 -0700 Joe Damato wrote:
> > > > Compare the values in /proc/net/dev match the output of cli for the same
> > > > device, even while the device is down.
> > > > 
> > > > Note that while the device is down, per queue stats output nothing
> > > > (because the device is down there are no queues):  
> > > 
> > > This part is not true anymore.  
> > 
> > It is true with this patch applied and running the command below.
> > Maybe I should have been more explicit that using cli.py outputs []
> > when scope = queue, which could be an internal cli.py thing, but
> > this is definitely true with this patch.
> > 
> > Did you test it and get different results?
> 
> To avoid drivers having their own interpretations what "closed" means,
> core hides all queues in closed state:
> 
> https://elixir.bootlin.com/linux/v6.10-rc1/source/net/core/netdev-genl.c#L582
> 
> > > PTP RQ index is naively assigned to zero:
> > > rq->ix           = MLX5E_PTP_CHANNEL_IX;
> > > 
> > > but this isn't to be used as the stats index.
> > > Today, the PTP-RQ has no matcing rxq in the kernel level.
> > > i.e. turning PTP-RQ on won't add a kernel-level RXQ to the
> > > real_num_rx_queues.
> > > Maybe we better do.
> > > If not, and the current state is kept, the best we can do is let the PTP-RQ
> > > naively contribute its queue-stat to channel 0.  
> > 
> > OK, it sounds like the easiest thing to do is just count PTP as
> > channel 0, so if i == 0, I'll in the PTP stats.
> > 
> > But please see below regarding testing whether or not PTP is
> > actually enabled or not.
> 
> If we can I think we should avoid making queue 0 too special. 
> If someone configures steering and only expects certain packets on
> queue 0 - getting PTP counted there will be a surprise. 
> I vote to always count it towards base.

I'm OK with reporting PTP RX in base and only in base.

But, that would then leave PTP TX:

PTP TX stats are reported in mlx5e_get_queue_stats_tx because
the user will pass in an 'i' which refers to the PTP txq. This works
fine with the mlx5e_get_queue_stats_tx code as-is because the PTP
txqs are mapped in the new priv->txq2sq_stats array.

However.... if PTP is enabled and then disabled by the user, that
leaves us in this state:

  priv->tx_ptp_opened && !test_bit(MLX5E_PTP_STATE_TX, channels.ptp->state) 

e.g. PTP TX was opened at some point but is currently disabled as
the bit is unset.

In this case, when the txq2sq_stats map is built, it'll exclude PTP
stats struct from that mapping if MLX5E_PTP_STATE_TX is not set.

So, in this case, the stats have to be reported in base with
something like this (psuedo code):
 
  if (priv->tx_ptp_opened &&
     ! test_bit(MLX5E_PTP_STATE_TX, channels.ptp->state)) {
      for (tc = 0; tc < priv->channels.ptp->num_tc; tc++) {
         tx->packets += ...ptp_stats.sq[tc].packets;
         tx->bytes += ...ptp_stats.sq[tc].bytes;
      }
  }

Right? Or am I just way off here?

