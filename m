Return-Path: <linux-rdma+bounces-8456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6931A55DB4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 03:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07538189717C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDEB183CBB;
	Fri,  7 Mar 2025 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDuc9Wg6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06815382E;
	Fri,  7 Mar 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314608; cv=none; b=hFOHl934OcnuSC213kM67NDeD+Ell1x/yBPOx9Z58Fy6ieO7GBV/ilVyolGuu6zOafXeelcvMGYJQ4VbsPaKPRSRY7r9SC5ciAyAnHW/gx2V0NSR0IvaQNLvUX0ipJCW8LlvU4REuepk+ymqW7WFPgxw+ycsruzjbbvMb8trdEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314608; c=relaxed/simple;
	bh=tn3Z1GgSVn9MZE25OAl4TUe3BRvbI67Yak5zmzCjmao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tYZRS8bhybXkqhkeopQnI++BmgVKCfaiVE7XFfKm+gRFjy7UpL9iLDndzFnCo841RjlE8tofMtzljCMhHHzZ0ON5BN16WLTZ5X9MrxVpu7FMCCOtVpw+8qoARriGeGKn8p+5156bRnd9NAIw4iK2jS3I0hIx0E2U+3LXHftM9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDuc9Wg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADF2C4CEE0;
	Fri,  7 Mar 2025 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741314608;
	bh=tn3Z1GgSVn9MZE25OAl4TUe3BRvbI67Yak5zmzCjmao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DDuc9Wg6usaZqyJuY0u9UpSyvd1OwrgUxw5p5L6KrwybVaKC6UgNbKyO5ttuwZ1Er
	 x0oqYlQjNEZnSLdy3j8XWxHFArz1D2orFu5EdVxE/94i3lHxa4RPVt8vZJibC3J2O5
	 dJ5tx0JYRiEQYf3gK4NGsfLg8dKfgpMBxdJFBgcu9oWMLPex23rxcyRSNRJGXILsq0
	 IoAjTFeQS5yAcLrEz3oAxAo9Ln4qJkFHAGBBhL/TL2wz4HFXlrO89p60QXKRi+g1Qi
	 Ct/KkZc/DdGj8YKzCnZHCEc6fLBfu/TP1NVDADGzzvCS6kO7i0iVtYQDGrsvCFWXL6
	 YZTWZHjf7L3mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB9380CFF6;
	Fri,  7 Mar 2025 02:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/6] mlx5 misc enhancements 2025-03-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174131464148.1860023.2397596403061740180.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 02:30:41 +0000
References: <20250304160620.417580-1-tariqt@nvidia.com>
In-Reply-To: <20250304160620.417580-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, michal.swiatkowski@linux.intel.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Mar 2025 18:06:14 +0200 you wrote:
> Hi,
> 
> This is V2.
> Find initial version here:
> https://lore.kernel.org/lkml/20250226114752.104838-1-tariqt@nvidia.com/
> 
> This series introduces enhancements to the mlx5 core and Eth drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/6] net/mlx5: Relocate function declarations from port.h to mlx5_core.h
    https://git.kernel.org/netdev/net-next/c/a2f61f1db855
  - [net-next,V2,2/6] net/mlx5: Refactor link speed handling with mlx5_link_info struct
    https://git.kernel.org/netdev/net-next/c/65a5d3557184
  - [net-next,V2,3/6] net/mlx5e: Enable lanes configuration when auto-negotiation is off
    https://git.kernel.org/netdev/net-next/c/7e959797f021
  - [net-next,V2,4/6] net/mlx5: Lag, Enable Multiport E-Switch offloads on 8 ports LAG
    https://git.kernel.org/netdev/net-next/c/5aa2e6de86d5
  - [net-next,V2,5/6] net/mlx5e: Separate address related variables to be in struct
    https://git.kernel.org/netdev/net-next/c/348ed4b20546
  - [net-next,V2,6/6] net/mlx5e: Properly match IPsec subnet addresses
    https://git.kernel.org/netdev/net-next/c/ca7992f52c2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



