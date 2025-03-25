Return-Path: <linux-rdma+bounces-8935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDCA703F8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ED21897850
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104325B677;
	Tue, 25 Mar 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whw2amIY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4625A350;
	Tue, 25 Mar 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913598; cv=none; b=Wew6N3MUugO7OSdr+vtFNLpYjY5Gk42DnOCvGd/ceQfau+wm88nCwvAG+EMuoSVhGZxh8dmawNJ5+6wirLB83j1tHB5Qe4vTMnRtFcc5Y11cKrNwQ8FUjcB9S+/gjuXGbEIXutciIrOLu4KGpeylwqH1x0s1recW3XAPv7NMU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913598; c=relaxed/simple;
	bh=oSIxgxWHSnCuXyPzauYk9K0XrvZWwq3e9FzV+AsbbFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FdnYwwsOFeFU83RjEO2+ip6YvVkGVOgt/Ts5VvgTPn31d1Ju5ReHkDlEYXG/vO6w3MdNvPgMAHKjDLN2frX5Aw1bZMqleE/x4cS44sq6EgODmUVBRJjiUw0sfnY2FkaHb82/diUqcv7xREkngZT7m5R+xYbp1sl/Vb/Hje1vyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whw2amIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AB3C4CEE4;
	Tue, 25 Mar 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913598;
	bh=oSIxgxWHSnCuXyPzauYk9K0XrvZWwq3e9FzV+AsbbFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Whw2amIYZ0Ps58gmL29Ut7b7aouwcRiW+mfQXIfoKrvHSuYq8O+YCybBwnnB203YY
	 f3h5yBIc+wM+aNr6W3IUcjwfKsvQF+g50fCNV1iJq8D+FBS0dbG3OMOf0u8adYKTmI
	 AZIRJY/73Axrm7g35u1WXBSqMn+1fs8r5/G2tMJ2Ptxa6ibRZ3h7VmUBm5bX15PU/C
	 r00P/NxDBznpnxzhNEod29mwXv+UEdgcIyw7kAYDNKY9cVVqCSGfhuyd9v+IfRwIa/
	 lTklndOz9s/bB5SvGJaPS/jBE+Zp1m8pi0cE4TvmbIJRHIVmYWRSAPWV/6ALVvGxyY
	 yZyVFRknjzv7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF2F380CFE7;
	Tue, 25 Mar 2025 14:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlx5 misc enhancements 2025-03-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291363452.598629.7996885033125997504.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 14:40:34 +0000
References: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 16:02:58 +0200 you wrote:
> Hi,
> 
> This series introduces multiple small misc enhancements from the team to
> the mlx5 core and Eth drivers.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5: Lag, use port selection tables when available
    https://git.kernel.org/netdev/net-next/c/16ad8394bf31
  - [net-next,2/5] net/mlx5: fw reset, check bridge accessibility at earlier stage
    https://git.kernel.org/netdev/net-next/c/ade4794fe893
  - [net-next,3/5] net/mlx5: Update pfnum retrieval for devlink port attributes
    https://git.kernel.org/netdev/net-next/c/91e7398e0603
  - [net-next,4/5] net/mlx5e: CT: Filter legacy rules that are unrelated to nic
    https://git.kernel.org/netdev/net-next/c/0fe234769ea6
  - [net-next,5/5] net/mlx5e: TC, Don't offload CT commit if it's the last action
    https://git.kernel.org/netdev/net-next/c/56617e11bd6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



