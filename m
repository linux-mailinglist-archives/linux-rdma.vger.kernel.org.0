Return-Path: <linux-rdma+bounces-2719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF98D570B
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 02:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FDA1C21992
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00004A32;
	Fri, 31 May 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giV28BoS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B954C6D;
	Fri, 31 May 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115944; cv=none; b=oAUga5X/QgpdsTliYPURK7KZ2Pn5ZqIu2CqEmMdYQPJFqpvw4oqzrQeIVL9DQ3rDhfyHYIG3f7yTrORM5sMM9GaA8VTmWobcm30FrPz9R/SXYA/RdQXZap/i5e629K3oj9X2ZpEb+LSoIPSjYbLnvopyY1TmNYZ2Yd3ySfWUpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115944; c=relaxed/simple;
	bh=jz3uNt0ungI64vdcOBPvDDK2/oZ7fHMTLKoFD/qP59c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrfF0yAhDQCixG5mFxOUcvVsLIFypjLTJyGCYXenANpK02COBTN88Efl4i6Ongm/ehPhgEEOnns/ykxpBUwEe5eYKOVNgUOCTStGw/6/VpXybnWQTisY/kVRvHmqh8Ni9JdbbcSSdAqmcCD76yCWHVjR10QwPFMWat7vKSiHbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giV28BoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAF6C2BBFC;
	Fri, 31 May 2024 00:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717115943;
	bh=jz3uNt0ungI64vdcOBPvDDK2/oZ7fHMTLKoFD/qP59c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=giV28BoSnq+WkGdlsUZ2v7q3wbUwkzvm1r13itdZk5Hxcf+NUAhhCy4ALwgqAKLW2
	 UXE5axb8WsEyx3qjCsIBzuyQkk6EcskV94ijqaVejCn+8barpbcYOztB0KZoZCRX3f
	 QniJYLQ3nCWj1hDHv4KDQRrdThNnOIfz1vcl48mS8e6r3aP9grmplZL518i8Ea1Vhh
	 cYe2Gu1c3eaCOLPyw4NnvVkaRBPm+o+vKMDYBxp87KssjYBtLnyeMlHnn2cyXZy3Bg
	 tzjQqmDJxaY+zuTer2OL5jFBXa7UXM7rrkWPO8ekhfx9PfRf9ywB7Q3PncwZlbvY6/
	 ab7scJI8aGDlw==
Date: Thu, 30 May 2024 17:39:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>, Saeed Mahameed <saeedm@nvidia.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <20240530173902.7f00a610@kernel.org>
In-Reply-To: <ZlkWnXirc-NhQERA@LQ3V64L9R2>
References: <20240529031628.324117-1-jdamato@fastly.com>
	<20240530171128.35bd0ee2@kernel.org>
	<ZlkWnXirc-NhQERA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 17:15:25 -0700 Joe Damato wrote:
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

I see, although it sounds like option 2 would also work.

Saeed can you shine any light here? I'm worried Tariq is already AFK
for the weekend and we'll make no progress until Monday...

