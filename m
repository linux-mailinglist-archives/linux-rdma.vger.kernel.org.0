Return-Path: <linux-rdma+bounces-7858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F96A3C3A3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33132188253B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EBC1F4617;
	Wed, 19 Feb 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV1cWps5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE6192B7D;
	Wed, 19 Feb 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978911; cv=none; b=QgFFUNnzLRWtpA+mtmkUzeVdvHuQIKqFZB9Lxq32Arpe8s++Z8EzP85jk2kpvj+T+PpsWo+PVPZPn7s3RxkbFHbwBZ0MwsXjCKyRH8U3EfR7mjria0UyZiRZxmBvtIVeouPVParP9I+tmGLy7q+8MSEf+glwsBbkRT68nsyPtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978911; c=relaxed/simple;
	bh=koCDnET2y6KAkKz8WcffMBGsGTKIacz6/eUShFZ1Wpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvcrLuMAW40qOe0gzy3xCroLJa6625xTfBzE57I0wt5TTkyotYGm6zy9n5xqp1QsIYHFmXL2VMbqcURiqkPEbr8lvJKlQ2jrQ1zWweTQOZvA6ENBSrZYeu3XDEJLjk/LwlvYeS5LWxyWbuBjfH7EZ8ecYDVUizAfIPFJMmk7QSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV1cWps5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1742CC4CED1;
	Wed, 19 Feb 2025 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739978910;
	bh=koCDnET2y6KAkKz8WcffMBGsGTKIacz6/eUShFZ1Wpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BV1cWps584sL4k+xf9HjnsHZLWSptPTaeBcJMw/9VqSgFxEZJIP3oLHSTKwbScTx1
	 hzwyM0gqsNaFJ8TzwyEF5eXx6dmK4o6ca9+a16caZRZOvZu3CZzXG+fq7TzBGEv2gm
	 C4nKMl4F04LBWBx75w1/Hd94VbPE3LbLKoSySG7j8S8ww6NRsHHfkfoyGzyncAA1rf
	 BaY56OzmHehMQlOj/Q8vRLHc3q4stqzs9r36a9t1Os4LK9Jin1/6xnWXGrDQ2jeQ5d
	 fgCgHipFXcpI2KnafBQOJQNFp1nKgKFh6ayNt0Nq8F919w5+OfuMJBxUkx8SUxPILF
	 2yCBx1cQfgfow==
Date: Wed, 19 Feb 2025 07:28:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add sensor name to temperature
 event message
Message-ID: <20250219072829.21ee1cfc@kernel.org>
In-Reply-To: <8369b884-71c9-495a-8a1f-ab8ca4ee5f59@gmail.com>
References: <20250213094641.226501-1-tariqt@nvidia.com>
	<20250213094641.226501-5-tariqt@nvidia.com>
	<20250215192935.GU1615191@kernel.org>
	<20250217162719.1e20afac@kernel.org>
	<8369b884-71c9-495a-8a1f-ab8ca4ee5f59@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 15:00:57 +0200 Tariq Toukan wrote:
> >> If you have to respin for some other reason, please consider limiting lines
> >> to 80 columns wide or less here and elsewhere in this patch where it
> >> doesn't reduce readability (subjective I know).  
> > 
> > +1, please try to catch such situations going forward
> 
> This was not missed.
> This is not a new thing...
> We've been enforcing a max line length of 100 chars in mlx5 driver for 
> the past few years.
> I don't have the full image now, but I'm convinced that this dates back 
> to an agreement between the mlx5 and netdev maintainers at that time.
> 
> 80 chars could be too restrictive, especially with today's large 
> monitors, while 100-chars is still highly readable.
> This is subjective of course...
> 
> If you don't have a strong preference, we'll keep the current 100 chars 
> limit. Otherwise, just let me know and we'll start enforcing the 
> 80-chars limit for future patches.

Right, I think mlx5 is the only exception to the 80 column guidance.
I don't think it's resulting in more readable code, so yes, my
preference is to end this experiment.

