Return-Path: <linux-rdma+bounces-14581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0DC66C4B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 02:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E8E0F2997D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 01:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83527A444;
	Tue, 18 Nov 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoW0pZbL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F720013A;
	Tue, 18 Nov 2025 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427647; cv=none; b=o74Qva8SB9ognS8NYhhQfqNr29DB4Ru9kOqpc0F53jajeml2SeHmbl0YbfAxSj3yFEDG0IjoqlZrotopO6zdvw7LQBr940XweVxhyDCpVavVAjIO6RsR//g78J2klLNqVj6O+Xdes6gp/xLN7RPo3DzgoZvyzJbC1aOyQenv1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427647; c=relaxed/simple;
	bh=D9iHKq15w7/XQm6HET1v9lrwf/Jby4pd2JTMOJaOrr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tdjv+0Iheg88b7dNSwfvkKOypuh7nVKtx9EGoWhW3XhS1faZzle+G43/ABpvxfiug82WByypWPZrwYoylZaQN/SImSzJwdyiYYyUfQ8FJ09jX5yIYNkFp91OMnWrh25VSXnbo7YPYpA9WJiJOVQfreBzWn2Zyit1Q5kBW0kq4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoW0pZbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A4C4AF0D;
	Tue, 18 Nov 2025 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763427645;
	bh=D9iHKq15w7/XQm6HET1v9lrwf/Jby4pd2JTMOJaOrr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZoW0pZbLDra569ZuOgDAWN1LyMy+ZKiyPZJLe3GMarsF4GUrUk9zJ91IlUxuVRDhz
	 vqkio/B739VAMSZis9FiJh+hRqhdpvD3DtG32VJosEu6KcAhqxD+mMyoe/u3NX4ZSA
	 oMDAN0VbDpTfJsaYCPWd5PlQ0zeOSf4oU42ynbNfKeNtTj7+rh9nh+1cFOnq8jll0i
	 jpYCRl8gBnjan+r3T5/1lrZvrUvZ0R2QSknYEjH47QZDJ5WcqSV/+iFERTeT5BYrIQ
	 lmE/ACARzjpt9rPyiwicN4yAd4pe7Kuiwz9B4JobMh4XLjGu8sVPxCwL+ZGBSKU2Br
	 GspjmoSrsDcig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF5B83809A18;
	Tue, 18 Nov 2025 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176342761151.3532963.1333019747310925631.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 01:00:11 +0000
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
In-Reply-To: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 08:46:02 -0800 you wrote:
> This series migrates the mlx4 and mlx5 drivers to use the new
> .get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
> ethtool: add get_rx_ring_count callback to optimize RX ring queries").
> 
> Previously, these drivers handled ETHTOOL_GRXRINGS within the
> .get_rxnfc() callback. With the dedicated .get_rx_ring_count() API, this
> handling can be extracted and simplified.
> 
> [...]

Here is the summary with links:
  - [1/2] mlx4: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/467c3f008d0c
  - [2/2] mlx5: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/945499665f63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



