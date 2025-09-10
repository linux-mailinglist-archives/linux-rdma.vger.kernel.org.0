Return-Path: <linux-rdma+bounces-13216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01088B50B07
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 04:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E83B9C83
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 02:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528182153E7;
	Wed, 10 Sep 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMu73/Jx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A119D8AC;
	Wed, 10 Sep 2025 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471411; cv=none; b=TAW5BXxr+eFUhKpJimoB1jBnI4KnA3U164lFqCMxV8v8SlSZDn/UqfnhPox9/KsoOOepNw1jVXLbEERjFkIU/wFAuINfKJDApKplcARDsJPmzwzlw+SHiStSpn6G72p0NrfHGrterNGVrrLGQKz5yxMyLXeCYYI5ff4RZ9oA4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471411; c=relaxed/simple;
	bh=f42uKL7muikKt8i17Y8V5ypDbGKRVNJBBDLHVh1JR9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q0m42r5VaS7217Ci50ZgtLcGvpxfaxj1OHDzQV+WodOjtnTgEDhozrQ9O+tGn7bgNKWlcF45pTCDPEYjnVrmoSVpzq8yZUhqkDH43XGhb7lW0W4bQnYinLYNOimjSyahxVOO5RME/YFHk3/oYT5hirdN05FHLEMm/AaMU9gwtoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMu73/Jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA26C4CEF4;
	Wed, 10 Sep 2025 02:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757471410;
	bh=f42uKL7muikKt8i17Y8V5ypDbGKRVNJBBDLHVh1JR9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMu73/JxUcG3Jj+kQUky5EGbd6w/hyeq/bN23bo4ob36njCw/CIInxXJXAm4IJgLT
	 /EvvLiyZbjCCoUod8GDP/4HVc9Mm/70vNVC84hzo/Z6+VjzAbcKwSeekruI1/JcTpP
	 NNKmYRI91whSB7042OytkQaBkCe4UMry/W1wWYpt7zB2A3PeX2F0D80Re6IFNnQBvi
	 jF+YdkmIHya1OaiQUjSJZh5Ocvm+8VefM67e5vXntPtUvlhRN9GnKIN+BjuLRsU3vZ
	 MYtPH7LdDvzQSg6gjTxM/qNdFSo6JyOOa7UeE+sDusk3qQ+JjvbZeSE4/kGug5BUsu
	 E/t77xYwh9spw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFA8383BF69;
	Wed, 10 Sep 2025 02:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/mlx5e: Add pcie congestion event extras
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175747141350.881840.9602387660242823143.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 02:30:13 +0000
References: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, corbet@lwn.net, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 7 Sep 2025 12:39:34 +0300 you wrote:
> Hi,
> 
> This small series by Dragos covers gaps requested in the initial pcie
> congestion series [1]:
> - Make pcie congestion thresholds configurable via devlink.
> - Add a counter for stale pcie congestion events.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/mlx5e: Make PCIe congestion event thresholds configurable
    https://git.kernel.org/netdev/net-next/c/f4053490a6f6
  - [net-next,2/2] net/mlx5e: Add stale counter for PCIe congestion events
    https://git.kernel.org/netdev/net-next/c/cdc492746e3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



