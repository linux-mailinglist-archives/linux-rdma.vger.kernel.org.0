Return-Path: <linux-rdma+bounces-3140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6519A907E66
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 23:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3540285091
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692414A623;
	Thu, 13 Jun 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gihTkSdK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE781474B6;
	Thu, 13 Jun 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718315899; cv=none; b=GZSV78+vNw9tu+lB0jL2RS44ELwHwG1va5Jq9ocsFhFjO+TTdmHGyYT1fi3yAAidH0/ISVxFzUCKM9l0EOfs6B8g8hGBLP2jKAkQzZM/DGs3OD464ZtJEP3nAuhL97mnAs5JNT5BXyOG/j35q2G99cuESPIaBTPbY2G/7J7/tEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718315899; c=relaxed/simple;
	bh=gX3Qzc7qT51hYwbuXBEZnmR3vbNuIwDFQYQsZnxs00k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5iSnkSzMr3Zr/KR1YV10SVD6CGGytWATqfyVV5/NcLbaWMqC/z1vGyPjOcmiLdB4PgZhT9nV9aqKpRV/ixz8eYW4gm/qNv0lG/BKz0zatBPiHhpVW2WFbeRrYdhfTvyeQ/aX+0zYcVP0ljPJBecoVk8Shn3J4/fXngOHpomkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gihTkSdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F619C2BBFC;
	Thu, 13 Jun 2024 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718315898;
	bh=gX3Qzc7qT51hYwbuXBEZnmR3vbNuIwDFQYQsZnxs00k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gihTkSdKbRHOhA7iJjrx1hoE3uB/rL+9upVLH4QeT8DbgRHvv39cK7FCq7T+RnoLR
	 QmkiWFC37RE4qFjAFwoxWArxEuqWdVjPCfqMnUsL9M7Uq/ebrSaHduXHzhFxX9n6J8
	 WemTAW4/UXJ9vo7IGRpJKyCUb4JR+331WIjOqYWHIUHAAR5Zja8yE7dJI0Uo+FwW8c
	 sHBKoxrrkJVtauzKa7hZXtLxsVQwspMyVWSroeNjjEy51yh/oB1mMYedJDHXLJu9K/
	 8tlmWPe4oR4caiX6cghPmCPAnZ2t4i3E8LVBaPTW9jDEz95CxbmQKr9S4iTVjMEXf2
	 q+mXL9crwqEfg==
Date: Thu, 13 Jun 2024 14:58:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: Re: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <20240613145817.32992753@kernel.org>
In-Reply-To: <0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
References: <20240612200900.246492-1-jdamato@fastly.com>
	<20240612200900.246492-3-jdamato@fastly.com>
	<0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 23:25:12 +0300 Tariq Toukan wrote:
> > +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {  
> 
> IIUC, per the current kernel implementation, the lower parts won't be 
> completed in a loop over [0..real_num_rx_queues-1], as that loop is 
> conditional, happening only if the queues are active.

Could you rephrase this? Is priv->channels.params.num_channels
non-zero also when device is closed? I'm just guessing from 
the code, TBH, I can't parse your reply :(

> I would like the kernel to drop that condition, and stop forcing the 
> device driver to conditionally include this part in the base.
> 
> Otherwise, the lower parts need to be added here.

You'd need a stronger (and clearly explained) argument to change
the core. If you're saying that the kernel should be able to dump
queue stats for disabled queues - that seems rather questionable.

