Return-Path: <linux-rdma+bounces-13730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86457BAAF06
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 04:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1034168F44
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 02:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CEB1E7C19;
	Tue, 30 Sep 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upq42rWM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7F86347;
	Tue, 30 Sep 2025 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197618; cv=none; b=tTcqerpMVsu2dl8CoanLNb2RaOIh7iVs8UKfZTshdTwlFVfJ+zQkx/qEpGqbRktCu5MXGHaui2zOBGtJFO6sxxldz4Xg/Rkl7ph+ws9WY+SWIqLC1sIcDSTC3NLh2Cc6grV98lb5pdtbdld7mPt0Ay0l5OcDlaOENsvU+yEHDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197618; c=relaxed/simple;
	bh=WCvfcztGmwRbMjgmpYjMM2ixl6GGHaLNZ2Pacu+vZto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=twRBY0B1/sAzY5z48xDpJycBZL20Py+J7OQF8c3aWUomDEZZ43WB1g+hAO+PXtfeL9Hzcj57cnZ5RZfLKzcWOykgsCxea7s1738HZTLHZyYaYIEf1yqHpAeOILcCyguzQmKr/eAqg08VOm0jtxcN085SeENfwj8dZzTjiCpQdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upq42rWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F4CC4CEF4;
	Tue, 30 Sep 2025 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197618;
	bh=WCvfcztGmwRbMjgmpYjMM2ixl6GGHaLNZ2Pacu+vZto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=upq42rWMlFAunrYbEpJKgTSnW5YSlGVRHZW4QO0yRU9DRvFUnOVTKfT366h9a/5YC
	 wSqr5xItrrtwpjAZLy2nabS8MIp+9DMPBAsUBvnVx2smdHbMTo1rl6HZD1b2E1zKEp
	 iFJA/7+GsGGW80EGObZ/dySPp2peZL0Mw/h80vM3FKpETqsKtzof99aENpVmjLDExG
	 ly+PkLiio5U+pl8Wk54nxRakCkEcJsVQ3AsQRxZZDgAL+GBbyQX2kDrO5AzhCDVyjC
	 3Km7yrGaL1HTuVpglT4ZqTQEF7PHnjdr6il5OMS0nH0aPmescgwAGuvYQIflm9C5tw
	 fvFKga+A8B7FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21839D0C1A;
	Tue, 30 Sep 2025 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2025-09-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919761175.1786573.17524062874473677424.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 02:00:11 +0000
References: <1759093329-840612-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1759093329-840612-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, shayd@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 00:02:06 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core
> driver.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: Stop polling for command response if interface goes down
    https://git.kernel.org/netdev/net/c/b1f0349bd6d3
  - [net,2/3] net/mlx5: pagealloc: Fix reclaim race during command interface teardown
    https://git.kernel.org/netdev/net/c/79a0e32b32ac
  - [net,3/3] net/mlx5: fw reset, add reset timeout work
    https://git.kernel.org/netdev/net/c/5cfbe7ebfa42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



