Return-Path: <linux-rdma+bounces-15582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92639D24284
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 12:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E60F309DEBA
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4902D94BA;
	Thu, 15 Jan 2026 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZW8082L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C9378D92;
	Thu, 15 Jan 2026 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476231; cv=none; b=Bx8GOTKSQSX0M50dKOVriMrkUKofTmF5tRhzEpeE5X3t/7rt+iUNx72mhDwIdoQrFvyrSifnivV/sGcxgSKACwRvNRCIHipp7sfCY6cP7nCeXMnkHqQ1iDGef6gAADK/HwD1Femm9oqhtKJXXZwDbFHCzvdNwIq9/W7l+dDYjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476231; c=relaxed/simple;
	bh=gtlgvLUsEtZJi/twRrj5c6tR0zgVtZk/PavWCUVc1sU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/vwZxHKo/m7SBzL2bViy/AnNPwUykuyY6gzJ1tUGnVjBMfjlKFuv+oywit9kYG60WFELGkF8WougKtZ425U/mMK4ZFrsLoBpgCHKjn9ZtxUTDYvN0NwF+9R/hwOAffAPyqLuJyZEduil33NqqwmicJpkqOFNL5Hyz4NQ80SaS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZW8082L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF08C2BC86;
	Thu, 15 Jan 2026 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768476231;
	bh=gtlgvLUsEtZJi/twRrj5c6tR0zgVtZk/PavWCUVc1sU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WZW8082LpQAm05TFyIckVvy52NORkhhVrY/d6JDlPXzYfeKaTLUHDze4As7ndPObP
	 MSUaTVTbklbA8nOokzqV61f0zbQZnIIB4+IGqTvvCeBunnvtuD7BWFssfTgLkhQu9P
	 U2fYasr4ELQDpmCGmtJvihO1eFxk4vj1jMsMhqXOCjh58xFrDXFmGHLGNGnZyjIBJI
	 65zBtKrgw4nbmSTHJboMXk4vwKAAeW52RdEuNmoOH80jSKHNlvs5FjeqTjpP9H7c5D
	 blqkqrm6XA09iUlaDihaK1pJxeDvMDkUhyj/EQC4AJs8NbGnMhldtfS79C2dm09tVH
	 pzyaMJUo2tO1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789853809A3D;
	Thu, 15 Jan 2026 11:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/mlx5: HWS single flow counter support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176847602302.3949842.12035884179729347633.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 11:20:23 +0000
References: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, kliteyn@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Jan 2026 11:40:22 +0200 you wrote:
> Hi,
> 
> This small series refactors the flow counter bulk initialization code
> and extends it so that single flow counters are also usable by hardware
> steering (HWS) rules.
> 
> Patches 1-2 refactor the bulk init path: first by factoring out common
> flow counter bulk initialization into mlx5_fc_bulk_init(), then by
> splitting the bitmap allocation into mlx5_fs_bulk_bitmap_alloc(), with
> no functional changes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5: fs, factor out flow counter bulk init
    https://git.kernel.org/netdev/net-next/c/96e89982a68c
  - [net-next,2/3] net/mlx5: fs, split bulk init
    https://git.kernel.org/netdev/net-next/c/6a6c4dd7c019
  - [net-next,3/3] net/mlx5: Initialize bulk for single flow counters
    https://git.kernel.org/netdev/net-next/c/1c8910f50350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



