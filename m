Return-Path: <linux-rdma+bounces-8773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3FA670A1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 11:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A581885E1D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B320767E;
	Tue, 18 Mar 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4soWvsH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC61F09A4;
	Tue, 18 Mar 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291999; cv=none; b=fiR/MxR9lg6EnjJ1gNAeZJ0tiopspg2rcQLac9qD+vOeAiYkYy0DOFP1AxIOKDIgY+qSu7xY5mdD++PBjXSQxjm4V4e1otOdQLpkuISYRks49iEwWEDP4PZ+JgiCDLcJkcyS+fsRt8YGdRbqwQaftlJeTnjzdcDiv17RMkJADK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291999; c=relaxed/simple;
	bh=sjBdj+E7CPHxXSLZf0BwU6+dedatlTyzn6RiwjHiIkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vGklrkbd36WwTnjv6LBhmqIBgTlJ51Vmy7vSrl/PFVHCUte7efAViTHCpcroP98RdvaohJQgbAcMUKy2D/g9nL+DfS1lzHNklL9uOingEhLVUKJtKMnzEKQPNGcdiLTPaoa/H3Tw57EcsSjNgPi5AP9f40NxH51Ynev4lFyFzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4soWvsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08F0C4CEE9;
	Tue, 18 Mar 2025 09:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291998;
	bh=sjBdj+E7CPHxXSLZf0BwU6+dedatlTyzn6RiwjHiIkA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M4soWvsHZUtBMsv0g75jJnucT+a8w7PUBX925C2Oj/tq3t7ccKKsiHdL3i3mkg5MP
	 fbtozPd6V4KrZT6ASOEul0SNUoWW1EnQdZT/Al8O4evBvC8Zb76GgEDxnRV//HVuze
	 xkg3UM1IFreyvrfembpItI21Tfw0GoIlQaZMFdMfmmA5JpWNN+1T6Pw89EUxB2YG8L
	 mVImsvQSpn8HKXR1KalbKXp1OrCnrv698C4eSfopOhE1ewLiVyLuKoPTeOUVFmOU4O
	 7uVtmwSn/zvO/xjF0EYcKtvTcBX+YFtJ12E8grK30fUrnzvhMQLY0WmcwD5/wrfspH
	 9cKI96nRn+8rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E66380DBE8;
	Tue, 18 Mar 2025 10:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mlx5: Support setting a parent for a devlink
 rate node
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229203426.4107925.231656924217131352.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 10:00:34 +0000
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, gal@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, saeedm@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, cjubran@nvidia.com,
 cratiu@nvidia.com, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Mar 2025 23:26:52 +0200 you wrote:
> Hi,
> 
> This series by Carolina adds mlx5 support for the setting of a parent to
> devlink rate nodes.
> 
> By introducing a hierarchical level to scheduling nodes, these changes
> allow for more granular control over bandwidth allocation and isolation
> of Virtual Functions.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/mlx5: Rename devlink rate parent set function for leaf nodes
    https://git.kernel.org/netdev/net-next/c/b407b4b804cd
  - [net-next,2/4] net/mlx5: Introduce hierarchy level tracking on scheduling nodes
    https://git.kernel.org/netdev/net-next/c/498bd79cb92b
  - [net-next,3/4] net/mlx5: Preserve rate settings when creating a rate node
    https://git.kernel.org/netdev/net-next/c/f88c349c75e3
  - [net-next,4/4] net/mlx5: Add support for setting parent of nodes
    https://git.kernel.org/netdev/net-next/c/9c7bbf4c3304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



