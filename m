Return-Path: <linux-rdma+bounces-2303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84E8BD459
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28271F2763E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51596158A2D;
	Mon,  6 May 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TugZZ1HB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C961586DB
	for <linux-rdma@vger.kernel.org>; Mon,  6 May 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018668; cv=none; b=oXTAf5yf6CARvWCwN3QF9XE1uhu24DyoxJSViU2GDeK69IkB7Z+jd/9aw1+UOM/pbsEaztOLW5CsjhaviZgoidnu0VpDat+gY3MCqT5CTHGckcou8OjE/3oRg7RbUW2KOfMZPSxfY5T3SXUDpFKPAhxBB/7C4P6hk9Xuq0Ult4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018668; c=relaxed/simple;
	bh=cAhKDATngg5XYWtp3wm/gO2bAzCF+ksynWN1+HGqIgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzOVPLbivkUEWIcvpR6NWhnva7MRF+Dr2DWR/5SJWDl0SE2PSN13lCO8YxUYKl0QKsn+kU2RWGFFic6827Bb2iz0I1GHOis1W7CqksKJ64Pnp04LNWXHH+tJAksLj1ucVLIaMxFR9HObfy/vfgYe8hjROlUUhXGE7bm++v/+JOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TugZZ1HB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so1394350b3a.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2024 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715018664; x=1715623464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=te4/Y4Ex1bU5Fl7piJ8mgbBAfhUkYcVHwGSxY1/VZ2Y=;
        b=TugZZ1HBqBbqQJ0K9saySdstreGXiIszyp88wotUwvoyvynHcYwBlsink1K5vY5+vB
         UViW3LprrUOoanxZz4WB+JNvqRb/eZNluV57t/dZMA0dSyZ3e1HgxBhnSdvDT79DOG7U
         hiW9T5mqSVcklTiUifQHdYDYKtPfLnW7lAFhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018664; x=1715623464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te4/Y4Ex1bU5Fl7piJ8mgbBAfhUkYcVHwGSxY1/VZ2Y=;
        b=BxkVKw2ntI2OulkomUbpRBrsvcv32UxebuOTOgL9SSL33WEoqiyxfbOj0RjLUCC8wc
         LRWUv72ywAjQvdqvNUOFNty64ebeICowD3ni4JwBeoU6myPvNx2Twop+krAIgFETQu7e
         XLEfgkrfzHjmg4m0X/Y3lWWlpTTXoL5s2BnUx2sZdGq5MipNyq9hUWnCX0memGOOSnJz
         brF4FRJtnQJfTiWJepVbCak8VA7XXisarS4VtVpSZBmXyAuAIYMKQGrHVD8Pzb5uFXKt
         F4dCt0wuffPB+7Y1CMh8d/CrFk3MxD9neMkQ+GNTD6evtwc83+J3yV5kl+HptuD6O/AS
         FPJA==
X-Forwarded-Encrypted: i=1; AJvYcCVxYvzwC6DkH9fu9DMeCreh6ugdAH3R+LeWOyBrz0/ACTm/hn9BKuHM7WHLMnJMnyLjPEirCPv1w9HSycrG9YXSiHI+kHfSnqp3yg==
X-Gm-Message-State: AOJu0Yx39IMSsJdQK+2pSAzVZUosac7k5ntYHopCZbd1EpCGiJwthQNh
	KwBC+AOb00nMmREmY/HD9aPUBnXbkRvgN37CnMoZNjQGc0KD6BAoocnyS+0X6iM=
X-Google-Smtp-Source: AGHT+IGwppSbySl31uGPw1FvJc3LjfLZLPlCmVQ1KC7Gq3CDOyzgBuo4ezyM24BqAPTlNNPjdcMqUA==
X-Received: by 2002:a05:6a21:620:b0:1af:a4f7:cba1 with SMTP id ll32-20020a056a21062000b001afa4f7cba1mr4246826pzb.31.1715018664422;
        Mon, 06 May 2024 11:04:24 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id p28-20020a631e5c000000b005e438fe702dsm8248238pgm.65.2024.05.06.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:04:23 -0700 (PDT)
Date: Mon, 6 May 2024 11:04:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
	gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503173429.10402325@kernel.org>

On Fri, May 03, 2024 at 05:34:29PM -0700, Jakub Kicinski wrote:
> On Fri, 3 May 2024 16:53:40 -0700 Joe Damato wrote:
> > > diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> > > index c7ac4539eafc..f5d9f3ad5b66 100644
> > > --- a/include/net/netdev_queues.h
> > > +++ b/include/net/netdev_queues.h
> > > @@ -59,6 +59,8 @@ struct netdev_queue_stats_tx {
> > >   * statistics will not generally add up to the total number of events for
> > >   * the device. The @get_base_stats callback allows filling in the delta
> > >   * between events for currently live queues and overall device history.
> > > + * @get_base_stats can also be used to report any miscellaneous packets
> > > + * transferred outside of the main set of queues used by the networking stack.
> > >   * When the statistics for the entire device are queried, first @get_base_stats
> > >   * is issued to collect the delta, and then a series of per-queue callbacks.
> > >   * Only statistics which are set in @get_base_stats will be reported
> > > 
> > > 
> > > SG?  
> > 
> > I think that sounds good and makes sense, yea. By that definition, then I
> > should leave the PTP stats as shown above. If you agree, I'll add that
> > to the v2.
> 
> Yup, agreed.
> 
> > I feel like I should probably wait before sending a v2 with PTP included in
> > get_base_stats to see if the Mellanox folks have any hints about why rtnl
> > != queue stats on mlx5?
> > 
> > What do you think?
> 
> Very odd, the code doesn't appear to be doing any magic :S Did you try
> to print what the delta in values is? Does bringing the interface up and
> down affect the size of it?

I booted the kernel which includes PTP stats in the base stats as you've
suggested (as shown in the diff in this thread) and I've brought the
interface down and back up:

$ sudo ip link set dev eth0 down
$ sudo ip link set dev eth0 up

Re ran the test script, which includes some mild debugging print out I
added to show the delta for rx-packets (but I think all stats are off):

  # Exception| Exception: Qstats are lower, fetched later

key: rx-packets rstat: 1192281902 qstat: 1186755777
key: rx-packets rstat: 1192281902 qstat: 1186755781

So qstat is lower by (1192281902 - 1186755781) = 5,526,121

Not really sure why, but I'll take another look at the code this morning to
see if I can figure out what's going on.

I'm clearly doing something wrong or misunderstanding something about the
accounting that will seem extremely obvious in retrospect.

