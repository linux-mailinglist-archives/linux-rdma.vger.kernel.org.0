Return-Path: <linux-rdma+bounces-2383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BD8C19D5
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 01:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634BB1C22CF4
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 23:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA012E1C7;
	Thu,  9 May 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FrWUp1Er"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945912D771
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296476; cv=none; b=ZxSw9kzexBklLnP6cSSc4SDiYA/2zqdyyCB7ZQvnYIkD7x8rwuw5CWiwTBnHy1sVsTCdRKB741bjL9pe7QVms7eCxqfotExOjexFJR4NpoGJbKKgE2da+Ct8+JFUJgJOHT5nSJPZUzHQuWlhfMwH9DsodoX6dPX+NPnPY/xHVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296476; c=relaxed/simple;
	bh=/hSdkj/zKVVX8+0TNGc/GW90rtt6AMMlBIYfdO4+/Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8JWDKFg7w4t6fHYmN03u70NJwKixlELCws99gVtunGxjOYo3QxZXQmY1sSJ/fhY9x5fZyr4IV9yMzanU3g5unfQ7Ru+xxvdzEcFzKJJR3Pk7vJEq0AfDO+sK2YtCUkx+8YWHHUC3U1gtcoW/EsQyo3q6OWJrtnkFDoe7veG1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FrWUp1Er; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1edfc57ac0cso11487815ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715296475; x=1715901275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLZYIaHLhDSaqx9/OkcQLCVuq3j9r/yh/R1YRZ22CSI=;
        b=FrWUp1Er16N/OjoU12wGIz1WAT8xLXcP43eaW63HbzaZrhaT6w+2YHw66lYaLigq/9
         Oxa7Id0209KhfdtGbdycnNQ4CXKi+1K0rt8LNxhjqra1uglRbJtD9SOBDBOVWFqwNk8D
         hmXafG6bV6jemugdsSWmjyaXZYztqJ7cNkoQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715296475; x=1715901275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLZYIaHLhDSaqx9/OkcQLCVuq3j9r/yh/R1YRZ22CSI=;
        b=dvzM9WUWFqztjJbjxMgy/9YNNRVty1auBYLpK6eHxmPFwGc58pmhrW5qmENP4BWCO9
         +N9uvgg5DoIP4wUFRPdBKlv84HvoNyeEzAz69tC2w7E2gxsxGBljUGp94Jc8AN5K+7nD
         WZbFMjnWxsvvnjhfwJhVAc1wEzBuylq6fVOp0WDCtHN5nwUB87G+IRQx3u/HlCke9Ger
         ddpZjKpQYLEhw98MSH2NeJpmKzEtzui3bdZczPAvxrxwuA5v3e8m/DExnYx6avke/PCy
         IUetn3H3b2olBXJcPIcXckLCvm2RDs1BeC58Y6tortztrr5xMxzWOVCQlyzT32dpNKJn
         6hIA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Y1ri7npI5nl1P5CY+R/mume+FAluEf8EFgtlQ5h6gy5L3QcYY+tM+e+owXy+Ib6lGKmTFhgemWQ4Ka2cDxafC+tPzb7ZKGNaGA==
X-Gm-Message-State: AOJu0YxeXr4C1xRhS759FNjBugGLASvyuc0mNgW0S80xWDe96ODLAxCt
	bFhaiBPkzKPwFhZFjDMPBVV3pehOjZn8jP2NyuPT+RQOAhy0Lt5vmKfFbFijp3c=
X-Google-Smtp-Source: AGHT+IGlIAj+FkskjRl2QMPBrgvw3JppTW8ckaZrERxYWbN2ql2PrvtcHGAw8mNF5e4PbU/ArMi1kg==
X-Received: by 2002:a17:902:b495:b0:1e9:470:87e6 with SMTP id d9443c01a7336-1ef43d1853emr11389735ad.23.1715296474690;
        Thu, 09 May 2024 16:14:34 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2565b6sm19558275ad.295.2024.05.09.16.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 16:14:34 -0700 (PDT)
Date: Thu, 9 May 2024 16:14:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <Zj1Y14MeqWWGFwP_@LQ3V64L9R2>
References: <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <20240508175638.7b391b7b@kernel.org>
 <ZjwtoH1K1o0F5k+N@ubuntu>
 <20240508190839.16ec4003@kernel.org>
 <ZjxtejIZmJCwLgKC@ubuntu>
 <32495a72-4d41-4b72-84e7-0d86badfd316@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32495a72-4d41-4b72-84e7-0d86badfd316@gmail.com>

On Thu, May 09, 2024 at 01:16:15PM +0300, Tariq Toukan wrote:
> 
> 
> On 09/05/2024 9:30, Joe Damato wrote:
> > On Wed, May 08, 2024 at 07:08:39PM -0700, Jakub Kicinski wrote:
> > > On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
> > > > If I'm following that right and understanding mlx5 (two things I am
> > > > unlikely to do simultaneously), that sounds to me like:
> > > > 
> > > > - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
> > > >    priv->channels.params.num_channels (instead of priv->stats_nch),
> > > 
> > > Yes, tho, not sure whether the "if i < ...num_channels" is even
> > > necessary, as core already checks against real_num_rx_queues.
> > > 
> > > >    and when
> > > >    summing mlx5e_sq_stats in the latter function, it's up to
> > > >    priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
> > > > 
> > > > - mlx5e_get_base_stats accumulates and outputs stats for everything from
> > > >    priv->channels.params.num_channels to priv->stats_nch, and
> > > 
> > > I'm not sure num_channels gets set to 0 when device is down so possibly
> > > from "0 if down else ...num_channels" to stats_nch.
> > 
> > Yea, you were right:
> > 
> >    if (priv->channels.num == 0)
> >            i = 0;
> >    else
> >            i = priv->channels.params.num_channels;
> >    for (; i < priv->stats_nch; i++) {
> > 
> > Seems to be working now when I adjust the queue count and the test is
> > passing as I adjust the queue count up or down. Cool.
> > 
> 
> I agree that get_base should include all inactive queues stats.
> But it's not straight forward to implement.
> 
> A few guiding points:

Thanks for the guiding points - it is very helpful.

> Use mlx5e_get_dcb_num_tc(params) for current num_tc.
> 
> txq_ix (within the real_num_tx_queues) is calculated by c->ix + tc *
> params->num_channels.
> 
> The txqsq stats struct is chosen by channel_stats[c->ix]->sq[tc].
> 
> It means, in the base stats you should include SQ stats for:
> 1. all SQs of non-active channels, i.e. ch in [params.num_channels,
> priv->stats_nch), tc in [0, priv->max_opened_tc).
> 2. all SQs of non-active TCs in active channels [0, params.num_channels), tc
> in [mlx5e_get_dcb_num_tc(params), priv->max_opened_tc).

Thanks yea this is what I was working on last night -- I realized that I
need to include the non-active TCs on the active channels, too and have
some code that does that.

I'm still off slightly, but am giving it another look now.

> Now I actually see that the patch has issues in mlx5e_get_queue_stats_tx.
> You should not loop over all TCs of channel index i.
> You must do a reverse mapping from "i" to the pair/tuple [ch_ix, tc], and
> then access a single TXQ stats by priv->channel_stats[ch_ix].sq[tc].

OK, thanks for explaining that, I'll take a closer look at this as well. 

> > Adding TCs to the NIC triggers the test to fail, so there's still some bug
> > in how I'm accumulating stats from the hw TCs.

