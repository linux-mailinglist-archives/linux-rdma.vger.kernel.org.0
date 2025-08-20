Return-Path: <linux-rdma+bounces-12826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00721B2D266
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 05:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF38B175B61
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 03:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AC272E43;
	Wed, 20 Aug 2025 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usZ43Lvi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5026F2BC;
	Wed, 20 Aug 2025 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659473; cv=none; b=lteF9Bqbc/GdE0fR18ZmQ3kHIoZTEaC9GG6U6q8q3nNLskQwLsJggaTe+dJrpigvdAIEYsqA6l8k/6Znd8cLybS/OaRorSUmMg1pyiniKswIuLynHPrZElmrLqzty6UloRP3+DVeVZUjwWUVV6nYpeEqQyNOc8ow/PqGVYgpL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659473; c=relaxed/simple;
	bh=EylZ6Gx1S3dSK3dRLCOyqFVpCBKoWbAy0I0+he0W1uc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ooO6SOuEyGaFijEc8eoijTinps+AlPwfJNXBML/UBa+s9Opi92bdqEpLIVQ6MjNUpTkj9Yp8yV0wCdmJLIGVa2IdDTGpNCjJFUUEklWHUioJhbVFsw7oF68+en7p5FMbheiR8miepFG7cqIlpWhAwk8aCdBNPM6PmkNbpJolt0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usZ43Lvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0E3C116D0;
	Wed, 20 Aug 2025 03:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659473;
	bh=EylZ6Gx1S3dSK3dRLCOyqFVpCBKoWbAy0I0+he0W1uc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=usZ43LviqekaDCcoOQiiYj4Aa3Lgu36fp/vz02oXzSRe62SUytShd64yzMvnhXTe6
	 XydULoYWSnMo3RjHQArRa6Pa7QszRkS8hEShcYqhVkWHV1mp1j1TPfURmh40dbYSKn
	 Yt3hj3fvHnX0tGA8Tw8+3Ugn06OpuAyTgJBJgcWsx2G1jRlfAZ/SUTSRQclVIedTXv
	 kkrWtjnhmC/0OxedWrDc1B8ad8nLH6SzR3m4/jPsSHgaYWBLbwz6wV3SZbJ7ratkc6
	 c5PFlrNUnoKMU5uM6Hi00lGuWHOb/Alu0Vjs/tjlcurGWmQuKf+SPMJ6BJMnhIvUZo
	 lYPtNvaSxbp9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B67383BF58;
	Wed, 20 Aug 2025 03:11:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] mlx5 HWS fixes 2025-08-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565948299.3753798.5122773830025276653.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:22 +0000
References: <20250817202323.308604-1-mbloch@nvidia.com>
In-Reply-To: <20250817202323.308604-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, tariqt@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 Aug 2025 23:23:16 +0300 you wrote:
> Hi,
> 
> The following patch set focuses on hardware steering fixes
> found by the team.
> 
> Alex Vesker (1):
>   net/mlx5: HWS, Fix table creation UID
> 
> [...]

Here is the summary with links:
  - [net,1/7] net/mlx5: HWS, fix bad parameter in CQ creation
    https://git.kernel.org/netdev/net/c/2462c1b92172
  - [net,2/7] net/mlx5: HWS, fix simple rules rehash error flow
    https://git.kernel.org/netdev/net/c/615b690612b7
  - [net,3/7] net/mlx5: HWS, fix complex rules rehash error flow
    https://git.kernel.org/netdev/net/c/4a842b1bf18a
  - [net,4/7] net/mlx5: HWS, prevent rehash from filling up the queues
    https://git.kernel.org/netdev/net/c/1a72298d27ce
  - [net,5/7] net/mlx5: HWS, don't rehash on every kind of insertion failure
    https://git.kernel.org/netdev/net/c/7c60952f8358
  - [net,6/7] net/mlx5: HWS, Fix table creation UID
    https://git.kernel.org/netdev/net/c/8a51507320eb
  - [net,7/7] net/mlx5: CT: Use the correct counter offset
    https://git.kernel.org/netdev/net/c/d2d6f950cb43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



