Return-Path: <linux-rdma+bounces-15294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D840CF1412
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60AC6300C5D7
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0FE2D7D47;
	Sun,  4 Jan 2026 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgj/y7KD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215572D9798;
	Sun,  4 Jan 2026 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554173; cv=none; b=Y2V/vgTKzDIgHEBdEJelqiPi8RxoQnHPNPReZ4xWRErFsfk3/7nlyJdXB0l7YTT/3nEWEKb7bOXXvw+QpsdhFWDtviytOd4+ZeebT0G2jCZBIsdokC6zeR2gGxTZ0+PWqyn5fLStEGK2qJlJXsQs0X1LjGcjEpch1baCvzt/ex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554173; c=relaxed/simple;
	bh=06UAB/+9ksl07ucJV7TbdFJ0AFg11BW1XXIMKMFutbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hrfU38DngoMBKyvPJl0M5z3rbvQsSklJkb0ZMZbHDyS9/BTzwoZt2+4q2skB/ZCiAQNR4/SFDfoBqG7v2d2S4P5yeDwPeUWuBU/EdLUS9NL27BcT0QMkpbKsIhfhOMej4UZ4Alv0pw4K/iNRfn47VAkoyBg6lyFC7Vc5k8XO7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgj/y7KD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4EEC4CEF7;
	Sun,  4 Jan 2026 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767554172;
	bh=06UAB/+9ksl07ucJV7TbdFJ0AFg11BW1XXIMKMFutbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgj/y7KDCYY4Zlk7GenUZL20g8bh97hiCDj41Sjxeu6RwH7aIBSnkJrVJ4pXG6S7F
	 aK1v6FqIIeCLQAcZZcmi7kjilN7/2BpgKxcIj6ygkPdID39MtdjgnXJj0nV4wL10vv
	 0Y40QZelbx+JrTZirLI1Ss+Fsqn5FGBnkQkdJGRHsTnbPZvIwOxG84GonMSOdyMsRa
	 pdN7rrX/GlyNLmB7EUNsvIaxRtUNm4KA3Lt6emZuVW3b6Xbhg5eK95DAOCzq87/B2N
	 RkRVgBCNT92PI2QH/llNMzXaSraJ9KxU/uI35jeRtF8cOWDFDBd6fvCJ6AVNpdmnp+
	 5luTsTL6poD6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5ABA380AA4F;
	Sun,  4 Jan 2026 19:12:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mlx5 misc fixes 2025-12-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755397157.149133.4026611546913701191.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 19:12:51 +0000
References: <20251225132717.358820-1-mbloch@nvidia.com>
In-Reply-To: <20251225132717.358820-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Dec 2025 15:27:12 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Alexei Lazar (1):
>   net/mlx5e: Don't gate FEC histograms on ppcnt_statistical_group
> 
> [...]

Here is the summary with links:
  - [net,1/5] net/mlx5: Lag, multipath, give priority for routes with smaller network prefix
    https://git.kernel.org/netdev/net/c/31057979cdad
  - [net,2/5] net/mlx5e: Don't gate FEC histograms on ppcnt_statistical_group
    https://git.kernel.org/netdev/net/c/6c75dc9de40f
  - [net,3/5] net/mlx5e: Fix NULL pointer dereference in ioctl module EEPROM query
    https://git.kernel.org/netdev/net/c/7d36a4a8bf62
  - [net,4/5] net/mlx5e: Don't print error message due to invalid module
    https://git.kernel.org/netdev/net/c/144297e2a24e
  - [net,5/5] net/mlx5e: Dealloc forgotten PSP RX modify header
    https://git.kernel.org/netdev/net/c/0462a15d2d1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



