Return-Path: <linux-rdma+bounces-2716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA448D56C5
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 02:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE728287816
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D3A3D;
	Fri, 31 May 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY5l94zG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDE291E;
	Fri, 31 May 2024 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114291; cv=none; b=Nj0XfAnbxi+v1ATte762YCgJPe/xEwqh9+AAiYzVexlYVuAQt/Cs8OkUEUP17uxW6IsFQQKBJHBXSSN84peFED922DB61GSQg95ZQVTlBkQHXYtb/4tP2GpT7X4Vht8RQmBV6RGDfjvnaE6u24sSgRD1smu2hBPfVx4QPnt8O+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114291; c=relaxed/simple;
	bh=OTzwBlYP1KJ3xYENMOirCAwoMQNst4smvTkXup2Eafo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0Vk1CQCF3s3eGeEoFvuNEL1zmphK/hxhoRWJvk65K6A5ddljNwpwNFn+YrH40NLXDAsaUCv3cipOuzA4dlce5HKfmQ/CbJG/dSjtr8dMIuXGQ3iID4j98diCkK5yt9pQe0J6/mR4jMPtaxC6QWnJe1VUem8kdsw00dnS2IijQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY5l94zG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C180C2BBFC;
	Fri, 31 May 2024 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717114290;
	bh=OTzwBlYP1KJ3xYENMOirCAwoMQNst4smvTkXup2Eafo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dY5l94zGm4JDLYNgcmoG9Tc/GOBzM03fz+CH3KOKpIDLm0pzsk8czuh2SN3pU553l
	 3pIlQkSeGdrKs0MoRfBqCu/iJD+dxC+RQ6QhaFWCURh1aku2NPS2Ah4I83DYZ9idjA
	 3TKkZX/IHv68ijcSxb7ZO4YfXbjVegHYDAQVrjitOlIIvLGrqipsqnnLv/H1a+m/1y
	 yN/aZQI7J9xNJLClPt0nzGfiSGK7v+VAXmKhleM6Plgj16lnOegjSgvWe8Y/evaoFc
	 g92EChP4cfdrXemzexTDJl6pa/dr/+Qb4No6MqVDWLdcHIzBwsaGOerJEXThU01ZdZ
	 rlEyFKy2utXYg==
Date: Thu, 30 May 2024 17:11:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver), Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <20240530171128.35bd0ee2@kernel.org>
In-Reply-To: <20240529031628.324117-1-jdamato@fastly.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 03:16:25 +0000 Joe Damato wrote:
> Worth noting that Tariq suggested I also export HTB/QOS stats in
> mlx5e_get_base_stats.

Why to base, and not report them as queue stats?

Judging by mlx5e_update_tx_netdev_queues() calls sprinkled in
../mlx5/core/en/htb.c it seems that the driver will update the
real_num_tx_queues accordingly. And from mlx5e_qid_from_qos()
it seems like the inverse calculation is:

i - (chs->params.num_channels + is_ptp)*mlx5e_get_dcb_num_tc(&chs->params)

But really, isn't it enough to use priv->txq2sq[i] for the active
queues, and not active ones you've already covered?

> I am open to doing this, but I think if I were to do that, HTB/QOS queue
> stats should also be exported by rtnl so that the script above will
> continue to show that the output is correct.
> 
> I'd like to propose: adding HTB/QOS to both rtnl *and* the netdev-genl
> code together at the same time, but a later time, separate from this
> change.

Hm, are HTB queues really not counted in rtnl? That'd be pretty wrong.

