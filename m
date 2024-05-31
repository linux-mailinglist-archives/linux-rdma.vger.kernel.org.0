Return-Path: <linux-rdma+bounces-2721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CF8D5795
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 03:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD61C22DB9
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 01:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23875695;
	Fri, 31 May 2024 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AhEk8i5w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AA6139
	for <linux-rdma@vger.kernel.org>; Fri, 31 May 2024 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117656; cv=none; b=LwdGpMrajDYPoDN7mW07k6gJu6P/37o2OuPz0/Cn5DSZVUqPLuTAoBfo3NcBLoOwlpvipV+O/1/ZeF5bvejXYYOumcxFUYrH0gDLrlhPaKxIpcAMtKuv27qaFmJo06ORc7qj3QkRQdEtB0aWQnG1o+LTtdhfx5qDuzQgeuji1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117656; c=relaxed/simple;
	bh=qCoGw48H5JuSeO4/uLKohrazXvqyWkFZ4amkv1FVJNU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyV8oXYzjC/2fQRpuMMdkDuFmfcf58uzrBZKmph5j6OPUm74RNIzpZuFAYspSPiC1jSzEzSrFKtgWP53r0jp1+K7vpNEirtuXqjaTsyUo8nrNstrfEe3HVozzeUuYpz88vYJHmTZoEs9JQm+050Sj+khB/NCufNNLBCadY2qyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AhEk8i5w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70245b22365so158335b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 18:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717117655; x=1717722455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7DdJux/OA+sO1H7974z00i13AM+nm5LXljV0O8GuR4=;
        b=AhEk8i5wkdexFc7yUx99gyWj3Rd79spTea/3galECh7PX96PnKVTFdCrAnRwFg8jWE
         eXRJ/5KLbbSdXxn+aHs56pA0x1tQEmgiKosV/b6+cUnOMF5YSgY29OmjWnHqM4r2SmGN
         TdnFqVrGnyQVK4ElA+/agsfW/JPKDtOip2VNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717117655; x=1717722455;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7DdJux/OA+sO1H7974z00i13AM+nm5LXljV0O8GuR4=;
        b=vHa0JCWAMEucPDOcZHG+4OvjAadBSxlZqp6OVejfAVYk66T3zUx/58Mq3CJCrrBm4g
         KCEhZM/eMPWhfnDGYobOKGfJGXNBGhl/v3E5x7S2Hru6MQgMdzTGu1l0Aw8VZHol6goM
         4+hO67RA8Up+1yISvgWdr54fP13ZQuNSvRwY260as6LzSUBbre12ghHv0On5+pGcvyZk
         Yqz2P9pDHi84NulwyMXs12ISP7YNemuCGH8gfIEztgK+wufIcpvjPmZLKR8LDId/QoHU
         V+Z7pvIxd1cd+bsWuPOoPQ6xLT1t6MyPTvfAb0zKtPbMn55VwhLXunazLrplQ/oEEv2T
         ZXrg==
X-Forwarded-Encrypted: i=1; AJvYcCXuH5wn9x4Vb8mifssA+tbz64oEKwjwcWWQoMgyyvEOM5YNSNK7+T0O3lK6j8RZ5gzu+itI8tbJV707yA0nIuEH/71n0Uig8/tCLg==
X-Gm-Message-State: AOJu0YyZfgnZ3PnmGzmrMpbnBmJUk5dujCnMd4W+nz/6gFHp4MSAuNyt
	zZFtuZ3hGxK1+sJm8w+PcAWC9x3yvvMCeQivi2VLVelDKxc2Uaa/OShpD81V/gY=
X-Google-Smtp-Source: AGHT+IHBB/vkWrCp/NviPAhK8L0ouhKb+3t6sk6t8iuY4CWk4O6G0WrEpp663QBHJKukN865wq8djg==
X-Received: by 2002:a05:6a20:da85:b0:1af:a4bc:1f71 with SMTP id adf61e73a8af0-1b26f204cccmr675744637.26.1717117654608;
        Thu, 30 May 2024 18:07:34 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235f081sm4039805ad.87.2024.05.30.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 18:07:34 -0700 (PDT)
Date: Thu, 30 May 2024 18:07:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <Zlki09qJi4h4l5xS@LQ3V64L9R2>
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
 <ZlkWnXirc-NhQERA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlkWnXirc-NhQERA@LQ3V64L9R2>

On Thu, May 30, 2024 at 05:15:25PM -0700, Joe Damato wrote:
> On Thu, May 30, 2024 at 05:11:28PM -0700, Jakub Kicinski wrote:
> > On Wed, 29 May 2024 03:16:25 +0000 Joe Damato wrote:
> > > Worth noting that Tariq suggested I also export HTB/QOS stats in
> > > mlx5e_get_base_stats.
> > 
> > Why to base, and not report them as queue stats?
> > 
> > Judging by mlx5e_update_tx_netdev_queues() calls sprinkled in
> > ../mlx5/core/en/htb.c it seems that the driver will update the
> > real_num_tx_queues accordingly. And from mlx5e_qid_from_qos()
> > it seems like the inverse calculation is:
> > 
> > i - (chs->params.num_channels + is_ptp)*mlx5e_get_dcb_num_tc(&chs->params)
> > 
> > But really, isn't it enough to use priv->txq2sq[i] for the active
> > queues, and not active ones you've already covered?
> 
> This is what I proposed in the thread for the v2, but Tariq
> suggested a different approach he liked more, please see this
> message for more details:
> 
>   https://lore.kernel.org/netdev/68225941-f3c3-4335-8f3d-edee43f59033@gmail.com/
> 
> I attempted to implement option 1 as he described in his message.
>  
> > > I am open to doing this, but I think if I were to do that, HTB/QOS queue
> > > stats should also be exported by rtnl so that the script above will
> > > continue to show that the output is correct.
> > > 
> > > I'd like to propose: adding HTB/QOS to both rtnl *and* the netdev-genl
> > > code together at the same time, but a later time, separate from this
> > > change.
> > 
> > Hm, are HTB queues really not counted in rtnl? That'd be pretty wrong.
> 
> As far as I can tell (and I could be wrong) I didn't see them
> included in the rtnl stats, but I'll take another look now.

I looked and it seems like the htb stats are included in ethtool's
output if you look at mlx5/core/en_stats.c, it appears that
mlx5e_stats_grp_sw_update_stats_qos rolls up the htb stats.

However, the rtnl stats, seem to be computed in mlx5/core/en_main.c
via mlx5e_get_stats calling mlx5e_fold_sw_stats64, which appears to
gather stats for rx, tx, and ptp, but it doesn't seem like qos/htb
is handled.

Unless I am missing something, I think mlx5e_fold_sw_stats64 would
need code similar to mlx5e_stats_grp_sw_update_stats_qos and then
rtnl would account for htb stats.

That said: since it seems the htb numbers are not included right
now, I was proposing adding that in later both to rtnl and
netdev-genl together, hoping that would keep the proposed
simpler/easier to get accepted.

LMK what you think.

