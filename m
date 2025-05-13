Return-Path: <linux-rdma+bounces-10334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFBAB5FA6
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 00:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBDE4649F0
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A220E01F;
	Tue, 13 May 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGz1q4wu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CC202C50;
	Tue, 13 May 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747176616; cv=none; b=n3GQVaWfYkE3OVFgacfMB7G4cpJDe1UwIMU1ezkrz1iTnZfpGL4BbLCIn7l8akWbcZ6ySPWAJ5C1S4i1ubfVuvZI2yXFAxQSYJQGKpOrbl7fTx1n+XafohoMRG34Yj+/bnDYD15oajyY6uLJVv9ka9wtyL8k1bOUJwzWjODNzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747176616; c=relaxed/simple;
	bh=vHXWoX9AokPCtWu36aJY5K4HLLm9rD1D0nvR1hRVJ+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HC24GSI8f5Hq8oSWvdgG9LAqbIRmIEzaVC1n4HfKRI1O8LtVqHwbZFJ9gpjTeMCQ0t0qoX0/34YP7/PJQeV0T4gB+hzS59LcsThk1UkCE3KDfq3l0EcmGkzRe7SuZbAqsxq7HWzmEfIBptg8T/Q1yOKnXTJ4LjMqIAV+SJ3HIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGz1q4wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8EAC4CEE4;
	Tue, 13 May 2025 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747176616;
	bh=vHXWoX9AokPCtWu36aJY5K4HLLm9rD1D0nvR1hRVJ+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CGz1q4wuZlsX7Ci63/5Oc93u0fnRApFYVSGcP4FvxYf7v0O4nprg7Tm2jTCsXXQtT
	 Hlg+OVhm2HjbrsRpXB6za2QZYLPR3XG5QBSJFeIUK7DljZxoUK+MVNousH+uUNi/hu
	 XoR9Q46xdnO2emfdqdxajMN5ywylj43VPLyZEO9T3rXyefLDLrGWLlImvb6XRDT0ky
	 05GMZDXbtxO4gi175bx3SVNf/Sx3KkPaTL7wPR7djsbIPmrHOsaYDKDbrIPfMSzb3b
	 mG+/yC7m3PQ1hPTcpzRqTA/UzENJ2R/wP+XgQpg3I3lBFajRTrNX0+RkjgTeCB9LsS
	 uWZeqUhqbBClw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7E380DBE8;
	Tue, 13 May 2025 22:50:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] net/mlx5: HWS,
 Complex Matchers and rehash mechanism fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717665349.1815639.5590161791994015034.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 22:50:53 +0000
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com,
 vdogaru@nvidia.com, kliteyn@nvidia.com, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 May 2025 22:38:00 +0300 you wrote:
> Hi,
> 
> This series by Yevgeny adds Hardware Steering support for Complex
> Matchers/Rules (patches 1-5), and rehash mechanism fixes (patches 6-10).
> 
> See detailed descriptions by Yevgeny below [1][2].
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net/mlx5: HWS, expose function mlx5hws_table_ft_set_next_ft in header
    https://git.kernel.org/netdev/net-next/c/d2338a27fcee
  - [net-next,02/10] net/mlx5: HWS, add definer function to get field name str
    https://git.kernel.org/netdev/net-next/c/fed5f4831281
  - [net-next,03/10] net/mlx5: HWS, expose polling function in header file
    https://git.kernel.org/netdev/net-next/c/3c739d1624e3
  - [net-next,04/10] net/mlx5: HWS, introduce isolated matchers
    https://git.kernel.org/netdev/net-next/c/b816743a182f
  - [net-next,05/10] net/mlx5: HWS, support complex matchers
    https://git.kernel.org/netdev/net-next/c/17e0accac577
  - [net-next,06/10] net/mlx5: HWS, force rehash when rule insertion failed
    https://git.kernel.org/netdev/net-next/c/9d4024edce10
  - [net-next,07/10] net/mlx5: HWS, fix counting of rules in the matcher
    https://git.kernel.org/netdev/net-next/c/4c56b5cbc323
  - [net-next,08/10] net/mlx5: HWS, fix redundant extension of action templates
    https://git.kernel.org/netdev/net-next/c/041861b40f59
  - [net-next,09/10] net/mlx5: HWS, rework rehash loop
    https://git.kernel.org/netdev/net-next/c/ef94799a8741
  - [net-next,10/10] net/mlx5: HWS, dump bad completion details
    https://git.kernel.org/netdev/net-next/c/578b856b5e72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



