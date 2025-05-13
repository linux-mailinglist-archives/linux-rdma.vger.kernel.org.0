Return-Path: <linux-rdma+bounces-10333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18524AB5F93
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 00:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9901888EA7
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 22:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9A21018A;
	Tue, 13 May 2025 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdAb80Ae"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557991E5B9C;
	Tue, 13 May 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175991; cv=none; b=P7Ymj7hicC3EWxEge3JnljgeSwa+tgl2ab/5zCDGoFFZWFsXNGrLdcnBVMgft+t8MMhSwxswEEz+XvIobWCbaGeNRthgXOSy4LEAr3YZP7yds4pcFoV3Dx5n9JYEauVlCEgVgLHC+bdv5lQ51hWOf5y8rkkVzjW37baI3aF3YUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175991; c=relaxed/simple;
	bh=aLktDCzX+0PwAhuyOQmH4ustFfZ3+JKd+qWpKjP1SYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IiI9Cd8JQHR2FW+/kh02+TMk5CA78lI+6h6/zsDuGQ8cjuEwNs6iunewhyTsHM48sL3AECE99kgrEKYuppjwlXO0yeFmktyYGwsG9CPlJSnoMMKHMaPerdoezmKX6BRyOT9V7U4ASnRU0qKIMehTs1a5YHm+ezN2LDpMv2ipinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdAb80Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D5FC4CEE4;
	Tue, 13 May 2025 22:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747175990;
	bh=aLktDCzX+0PwAhuyOQmH4ustFfZ3+JKd+qWpKjP1SYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KdAb80Ae2YCL0N41YWO7jqZpKLM+gXLfTXaCEpyPINwYBVVTbgc5o4Mx2r6qZN26/
	 MpLO+2wEIWQHL86x0Y9JBDNhXzsdsrZD0kyO33mOzxOBrw5O765Ur8ELf5vQYhJ22M
	 G0Qq/e2DSn8FfLDNfC6dRqij6YdGrcEkiA6uU6osqAbt9gyYJIAr/rqlQt7V17vCKA
	 QPz4mt1/JzQ+nUxzfqJTasUx0GgVbFuCGybh79TbOdjO6rAj+C9McX/XkFnOq2lUNq
	 p6RlysCmXF/dWdHoPInA3oz5uTK0AUp56F48mlXKjZFHCRFFjNC0zIHBBbKNtNE+WL
	 5FW1Lk+bJDb/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C23380DBE8;
	Tue, 13 May 2025 22:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Disable MACsec offload for uplink representor
 profile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717602826.1813866.4021390736886437386.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 22:40:28 +0000
References: <1746958552-561295-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1746958552-561295-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com,
 cjubran@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 May 2025 13:15:52 +0300 you wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> MACsec offload is not supported in switchdev mode for uplink
> representors. When switching to the uplink representor profile, the
> MACsec offload feature must be cleared from the netdevice's features.
> 
> If left enabled, attempts to add offloads result in a null pointer
> dereference, as the uplink representor does not support MACsec offload
> even though the feature bit remains set.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Disable MACsec offload for uplink representor profile
    https://git.kernel.org/netdev/net/c/588431474eb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



