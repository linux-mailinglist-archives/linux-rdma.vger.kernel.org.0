Return-Path: <linux-rdma+bounces-12012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8EAFF730
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 05:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89E5A432B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DF280A3B;
	Thu, 10 Jul 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJk3j+1h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745828032F;
	Thu, 10 Jul 2025 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116404; cv=none; b=eiKyJlYoqODIc1rgrIFZz0ughdY+vfd/yNaVKX5cB0+GY4tEhWb6lWTrFH9IsvoGBajYUMe52/ejLrYOROwSi63Uevz4NcdOWlJo7C5oQZjSYlrF9PsHFiyNEdTx2oYiYQekYWsv9fSdCvPfE5qipNi/hDevZLoUrvu5tztYFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116404; c=relaxed/simple;
	bh=qF61LFwqV78qtNUghxN5VY0G9fKstEjsujOdfb4itBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ur9V22UCCCy9KdpBuynVOj2JPCxq01PBhU1Gium98Gqsr1xUoGfhVSwowW/IpZectCIHPSxBEodkeGOzx2Fo1Wf+KwP7uCD1gPv5L2dSDcqa0E1424I0i+JMrZI4bt5YNBJ7BQHxjE4es0mdIYAkNCHHI2xdeNNxwgHz1mmGhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJk3j+1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD9AC4CEEF;
	Thu, 10 Jul 2025 03:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752116403;
	bh=qF61LFwqV78qtNUghxN5VY0G9fKstEjsujOdfb4itBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HJk3j+1hQQpqzLx0s8Xoze1HH622NId/sWirKKJKfzbN6+mhN0Sb2gznxo9byRtEc
	 CSDZ2leUGZ64Q5pBqcua0ghQlU4hM2HPU6EXkZD4prTe+Qpv/i4/P5BgysmJknhawn
	 mvue9woLZc6PDNt2eJUKs14dvB748ZAlrypQV7RrglLXNa4BfffVTxuvgMfOuDuJgG
	 6sPQEsp3ht+Rrr5m0Qm5q1E0OHqN8CyaG0rGK3SODG3nJBPdZju2Tyy0chhBjuaclZ
	 8LRbkjK9BAcazbv/IKW4hljU9Jey2FxqaVHBbyBgBAxW6fKSasX1cfODvyNIaxV2UN
	 7eAMKqIxUaedQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9CE383B261;
	Thu, 10 Jul 2025 03:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net/mlx5: misc changes 2025-07-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211642578.969691.6312613846083881823.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 03:00:25 +0000
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeed@kernel.org, gal@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Jul 2025 00:16:22 +0300 you wrote:
> Hi,
> 
> This series contains misc enhancements to the mlx5 driver.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5e: Remove unused VLAN insertion logic in TX path
    https://git.kernel.org/netdev/net-next/c/ade89d1f2486
  - [net-next,2/5] net/mlx5e: CT: extract a memcmp from a spinlock section
    https://git.kernel.org/netdev/net-next/c/122d86aa2a0c
  - [net-next,3/5] net/mlx5e: Replace recursive VLAN push handling with an iterative loop
    https://git.kernel.org/netdev/net-next/c/c0ca344d796c
  - [net-next,4/5] net/mlx5: Warn when write combining is not supported
    https://git.kernel.org/netdev/net-next/c/d980f371b134
  - [net-next,5/5] net/mlx5e: RX, Remove unnecessary RQT redirects
    https://git.kernel.org/netdev/net-next/c/a194be578376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



