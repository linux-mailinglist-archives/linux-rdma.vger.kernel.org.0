Return-Path: <linux-rdma+bounces-2361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E78C09A5
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 04:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAE91F221FD
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9281813C9AB;
	Thu,  9 May 2024 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytvow39Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6A13C3D0;
	Thu,  9 May 2024 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220521; cv=none; b=T/3+ulXbozeYoy4Y/0+xuuZfivHw0JLfAzP04lR2Z+vwkELH6YkNuBK9otUpOllBP4SQf4CxzcV28GyMN1C4MRFIWOtmNn/1V/KTcIHI/voMANlNUb9jUWaa6Y6GpS+LJVewyIqWhvHDQA8onnI0z9oB78tuhVHb2rNieZQBqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220521; c=relaxed/simple;
	bh=wi4UOMXZFrXWhkKLsJ6i0QwTQsRBrXq5/MZM7C2qQ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kep/kokV1yYz4OujSj4Ud7U8xUsy3qCfa1O9jRBjUxvRfkH+8Oua/LL/eDmxuVhS3QD8iHIoTKvpk88PAqczbCxpH6OejP1EzPqSxehGW/jXBH7K9IdUsl0JvVsxfAEYcoWgQcd/wRZobE+Ju+0PyLnQGcf/XTmmBbrUCziebEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytvow39Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A3DC113CC;
	Thu,  9 May 2024 02:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220521;
	bh=wi4UOMXZFrXWhkKLsJ6i0QwTQsRBrXq5/MZM7C2qQ/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ytvow39QPv+f5IZb4WMdIHIUubO3ecosG4yB97vEZHWEKrN/1ynJm8t3OrgFmpJho
	 j9jnGVnHN9/j8JpWzoJuKdE4sqTRT4stt8S6xluELW5A/YfEBGGob02wK+yyneOV84
	 nFVA82BmaWY+Fq8mJb1KhQjtZioqOFytfuUSCJbq8hD16cTzOmLOPP3y9CzIBdeUWd
	 Yw4x4f8NeuevqdvSWpUrPBeZUHFdcFuxZYaivvdrt8GMOTrtgbovAdLQ4JkwzcpcuA
	 gCT/wmEW4QIev2J/OaYjUEtjkVgoIpX6IRcMbqO0U0C+4aKd5DSLVko9sCzF4MyEFR
	 avtfgr1zfqsIA==
Date: Wed, 8 May 2024 19:08:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Zhu Yanjun
 <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <20240508190839.16ec4003@kernel.org>
In-Reply-To: <ZjwtoH1K1o0F5k+N@ubuntu>
References: <20240503022549.49852-1-jdamato@fastly.com>
	<c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
	<ZjUwT_1SA9tF952c@LQ3V64L9R2>
	<20240503145808.4872fbb2@kernel.org>
	<ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
	<20240503173429.10402325@kernel.org>
	<ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
	<8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
	<ZjwJmKa6orPm9NHF@LQ3V64L9R2>
	<20240508175638.7b391b7b@kernel.org>
	<ZjwtoH1K1o0F5k+N@ubuntu>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
> If I'm following that right and understanding mlx5 (two things I am
> unlikely to do simultaneously), that sounds to me like:
> 
> - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
>   priv->channels.params.num_channels (instead of priv->stats_nch),

Yes, tho, not sure whether the "if i < ...num_channels" is even
necessary, as core already checks against real_num_rx_queues.

>   and when
>   summing mlx5e_sq_stats in the latter function, it's up to
>   priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
> 
> - mlx5e_get_base_stats accumulates and outputs stats for everything from
>   priv->channels.params.num_channels to priv->stats_nch, and

I'm not sure num_channels gets set to 0 when device is down so possibly
from "0 if down else ...num_channels" to stats_nch.

>   priv->channels.params.mqprio.num_tc to priv->max_opened_tc... which
>   should cover the inactive queues, I think.
> 
> Just writing that all out to avoid hacking up the wrong thing for the v2
> and to reduce overall noise on the list :)

