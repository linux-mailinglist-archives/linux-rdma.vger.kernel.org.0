Return-Path: <linux-rdma+bounces-12288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4DB0998E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 04:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C051F5A2FF2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5A1F76A8;
	Fri, 18 Jul 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3/1lhBQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959AE1922C4;
	Fri, 18 Jul 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804014; cv=none; b=DVL7nMmgDTYoyHWKZfHm6lmQWxOr+Qae/yxXrl5ahXmYbwlT5huKegtkcNk9OVNUgkOopUDx0dtdjci9C8MdI5hF4ZSwmnHeZytJ2rtDY9rJpfRAO4nsIT0AAFCErF85gJEh97N5LfuGdy2LEnzO8HzFmbrCG+6Sk9wo6PVUdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804014; c=relaxed/simple;
	bh=JdglF8LKko74PJaUYYcu6QwtzNQ5YqDLg6ee62sCoaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dvy7kAzslTnLoUHY4rYTHS0nrUFa3bCHTr4ikHXkHisgnRQOISrBjq+HPhH95i7LKRJWEymy58CiBvsII8aH0MgYCEKxDXYD/dY23fqrg3L44LcTgAssMqcZHHMyCtYhB1RCXM+FzrQidEoIZJlvjFf7VkFcwhOwOvo6WfvWZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3/1lhBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C885C4CEF5;
	Fri, 18 Jul 2025 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804014;
	bh=JdglF8LKko74PJaUYYcu6QwtzNQ5YqDLg6ee62sCoaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z3/1lhBQRRudT4IP3aVHDqpSallpSsq7NW2CDo9kPbs87Gt5CJt3zh0ySfxHKyuRT
	 vYXnmmC2IH5IR5QFpI3RmXTuzFXnmVTyc+gtL6Exq1E8Tx79srEx+vRS8BiRegG4S3
	 NKwQ7XDwNlLTA7lSbGgTIRR0m7NfEcCHUZ+jTEhj/GKqaFrEX4+ZJemAB7yZeRve8V
	 3kNwCVzffTGX2ZLXtWifFTqxcXYZlPcukHRzXSRiAO8nTSQgS1tVh4UwoQGshj0i1z
	 wOq9sqclMEWoLkPraITNyr7l0PR1fuGEh1rKvfbtPrHirX6sYbsqj6Srunwpnkjj4b
	 XkYhVv21IKelg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339E3383BA3C;
	Fri, 18 Jul 2025 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: Fix an IS_ERR() vs NULL bug in
 esw_qos_move_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280403375.2141855.6021349856885843288.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:00:33 +0000
References: <0ce4ec2a-2b5d-4652-9638-e715a99902a7@sabinyo.mountain>
In-Reply-To: <0ce4ec2a-2b5d-4652-9638-e715a99902a7@sabinyo.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: cjubran@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, cratiu@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 18:01:30 -0500 you wrote:
> The __esw_qos_alloc_node() function returns NULL on error.  It doesn't
> return error pointers.  Update the error checking to match.
> 
> Fixes: 96619c485fa6 ("net/mlx5: Add support for setting tc-bw on nodes")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net/mlx5: Fix an IS_ERR() vs NULL bug in esw_qos_move_node()
    https://git.kernel.org/netdev/net-next/c/49be1e245ea3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



