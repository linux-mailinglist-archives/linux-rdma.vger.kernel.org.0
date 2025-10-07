Return-Path: <linux-rdma+bounces-13791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0CBC1691
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Oct 2025 14:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66BA734EFC9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Oct 2025 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F62DF3FD;
	Tue,  7 Oct 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPDo3GUT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF517C91;
	Tue,  7 Oct 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841422; cv=none; b=pMrVsM9tEr2HVIqy87gqzKC5JAA5XjkWRYsft2vnfHs7DIOxFKUtnIIOTVpGcj9JmqyBVaevSipl1F+lpa+yYMP4ROK/2ZaheLO/vkcUjotO4xSK+5maDMIB6TtxRYFk0qEc5yTYjj1lAgK4f/h7x90dPVfCtr/uuy7fhmplgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841422; c=relaxed/simple;
	bh=A/m4zs0K8YnLbS88ViLhtm5ahaKgRDfC5LduiNaaPGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EJzBeb/HMT2LBEIUnFYJGeOFTZbVCC4Ui7Y4u0Ffp8Ij0AodR4E/YOW/ng2iyE92qwiJ37YH+sQXzuKvQ2h7TGH6yOF/ZH3+Y/8TY5mnDtXbTAlTdBT/XM4oT5aBYXCKJZog3vVDojrZCQ1b6WuN+DDQ45pOiusnUo7Fb4W5eB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPDo3GUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3EFC4CEF1;
	Tue,  7 Oct 2025 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759841421;
	bh=A/m4zs0K8YnLbS88ViLhtm5ahaKgRDfC5LduiNaaPGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VPDo3GUT+AKxSU4d1zVUNzivkV5HMUvD2I/9I38GNDtndn5pMLhQJYt8f4R5+z77d
	 i7pCC4Y7g3Bq4WREUF8GHAp6wMRsuMsnkx+Yac1fvQr1fMf7QLzNvZ5WpluIYbZDul
	 q6k6RJUL2BYrPbkUGklBdyuNElpDOhX50dXunD5a2z1BAGH8Qzol2pOmvwIYo1C0wG
	 x35QlB2QQT1o1VV562BuDnqYLgWgtAC3G0+Em1G23GJorgOcTI1oUr6Ae2vSXRiiPH
	 v8+8I7f45pjpKSurwu5iifDSgnDswpDp81pxO2BJgyn0ECvE7En+J3J1JtD9vNRtDt
	 yrZAw6VADVueQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB44D39EFA66;
	Tue,  7 Oct 2025 12:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2025-10-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175984141076.2242311.3420628871601969254.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 12:50:10 +0000
References: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 5 Oct 2025 11:29:56 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: Prevent tunnel mode conflicts between FDB and NIC IPsec tables
    https://git.kernel.org/netdev/net/c/7593439c1393
  - [net,2/3] net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed
    https://git.kernel.org/netdev/net/c/22239eb258bc
  - [net,3/3] net/mlx5e: Do not fail PSP init on missing caps
    https://git.kernel.org/netdev/net/c/8e87b3edd078

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



