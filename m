Return-Path: <linux-rdma+bounces-8475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AEA56D41
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 17:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA263A88D6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43BB226D10;
	Fri,  7 Mar 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3upr7sA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7F13C682;
	Fri,  7 Mar 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363897; cv=none; b=FfmbuFh3nC/0Y70P1FixElUmfnUpyHU/H6aX2thlv+Hlq50ufCXZMi9gCIYJusplc8g3hzUsCZ6eJIYDt+IObKYGNMADiBQYl5ZRsWGVz0UvG7EzXlbgFmmETDW8Ozf1GtG0QSxWjGGO1AtsfjZxzO3Fy3ZPaLjM5aOG2HeA6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363897; c=relaxed/simple;
	bh=t6BOxyb2Dk7hsHVQIZzbAjCa8vONORkxg7wy6l0pdpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWVndLWKTuC9J/9fmAyG5vsL4CrhjANbBFDLcZslPlKXa07etDVp4V7ZD9YOaRNPxcBmkOJ9aTIXyki1Yo0PUIYBpfihlO+SntFJpiclleCLWf+G7JIjANCaaa5wo0FUuPf54zl494v3y0clvN9cv7XLeDTL1Yz+cjcBON6L+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3upr7sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70671C4CED1;
	Fri,  7 Mar 2025 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363897;
	bh=t6BOxyb2Dk7hsHVQIZzbAjCa8vONORkxg7wy6l0pdpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3upr7sAF19W363UCQc0PLLfpTTCzB8RgR2AAXJdafwh0NXcxW6bR+yYfnHrN1oiI
	 bf9GaolNS3sCZXFv6xD3gcjD2rLag7YCekhoYW0ucFXrb37R4AeV7rbJwqxsRYyukn
	 /4Uo5raA0BKyI6vjPFWQGjU5zoGw8xLJaqhfBytDt9qy9RSzhtkG74bH3uFdsIu/1r
	 9wO2Vl6KR88FS4Dgkqi17BbUTa3/dP00TUf0Zgc0mPdD3GriK0f3sInEdfduknFsZx
	 cZ6ZMMK9KF547rPlMgv+BcrFzZ90oJfK6r9ONqo0tYbS5QxJ5XGcFkvzK+WhfGpnqi
	 9G+yUmy/GKAzQ==
Date: Fri, 7 Mar 2025 08:11:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Yunsheng Lin
 <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next v2 2/5] page_pool: Add per-queue statistics.
Message-ID: <20250307081135.5ade6e37@kernel.org>
In-Reply-To: <20250307115722.705311-3-bigeasy@linutronix.de>
References: <20250307115722.705311-1-bigeasy@linutronix.de>
	<20250307115722.705311-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 12:57:19 +0100 Sebastian Andrzej Siewior wrote:
> The mlx5 driver supports per-channel statistics. To make support generic
> it is required to have a template to fill the individual channel/ queue.
> 
> Provide page_pool_ethtool_stats_get_strings_mq() to fill the strings for
> multiple queue.

Sorry to say this is useless as a common helper, you should move it 
to mlx5.

The page pool stats have a standard interface, they are exposed over
netlink. If my grep-foo isn't failing me no driver uses the exact
strings mlx5 uses. "New drivers" are not supposed to add these stats
to ethtool -S, and should just steer users towards the netlink stats.

IOW mlx5 is and will remain the only user of this helper forever.
-- 
pw-bot: cr

