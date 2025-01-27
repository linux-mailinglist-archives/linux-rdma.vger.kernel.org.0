Return-Path: <linux-rdma+bounces-7254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F263A20091
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8DC7A23D4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B21DACA1;
	Mon, 27 Jan 2025 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPiCXb+7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657151DAC81;
	Mon, 27 Jan 2025 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017011; cv=none; b=lWPrBmu95MjuwNomn9i7Uupzey/yGTy4CxD1Hq6ZFHqhK2vqkdnVrlZj5aMAXI5RZODy/t4YSRzXavurmphh2qpzNbfhdSFFQ/sUNzZgHR1KVF6Zja1gT39dyin+wa6OQHCdMy260goNJiTmjR8d8JlL8ZxIJGjhJj4r3zBW8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017011; c=relaxed/simple;
	bh=MdPsZ5UZtudSz4Wpx++FeSr4eGuTNKnfYGDGC28Tkok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DWNMcl/zOfL7Ag59PRJjc1jCSWzhcaQcZmtBbBoTn6ZwFchYBROKrYmhM3kYOAYnHaEsbAF10EtNVOL7Si11RGl6//fwyLicUHpR4ZOyOzuGYH+XCLQSv4fS4bkhGIF50Nq3Ji3btdMqOZy0m41anCFSXJkVY7gp3LQDvr5+RJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPiCXb+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE263C4CEE3;
	Mon, 27 Jan 2025 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017010;
	bh=MdPsZ5UZtudSz4Wpx++FeSr4eGuTNKnfYGDGC28Tkok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BPiCXb+7oS0RRDAFjEV+x/o+ITkZXQXjSeLoEE53QL0vMgg6lgk9+LveXTU0hj4p0
	 /vnZEntbR/FoUx4oPijGhaOZBvPiN6bM99ScOy+OaNLUnvSm50e+albD2flKGUZHQd
	 1MxSY0gqUVbLag8R/8mKo77XkfsZ/txeB3Do0+RUa8TLEj6j5wortEKxOLL523+GmR
	 FNExD36qMapT3XaleyYDQy+iQ47cnUnEOnKCiUoBz7Ly58L+Z1XszhJWLPQA5XD0f7
	 rMfXb6G59YZRL0bdfcW/V+cwKp3KCa+z8nFAArNHisUYAmhoB+SajhxRvrseexpGm4
	 nC35eSBqvFmfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE040380AA63;
	Mon, 27 Jan 2025 22:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: add missing cpu_to_node to kvzalloc_node in
 mlx5e_open_xdpredirect_sq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801703651.3242514.2748673226443124182.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:30:36 +0000
References: <20250123000407.3464715-1-sdf@fomichev.me>
In-Reply-To: <20250123000407.3464715-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 witu@nvidia.com, parav@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jan 2025 16:04:07 -0800 you wrote:
> kvzalloc_node is not doing a runtime check on the node argument
> (__alloc_pages_node_noprof does have a VM_BUG_ON, but it expands to
> nothing on !CONFIG_DEBUG_VM builds), so doing any ethtool/netlink
> operation that calls mlx5e_open on a CPU that's larger that MAX_NUMNODES
> triggers OOB access and panic (see the trace below).
> 
> Add missing cpu_to_node call to convert cpu id to node id.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: add missing cpu_to_node to kvzalloc_node in mlx5e_open_xdpredirect_sq
    https://git.kernel.org/netdev/net/c/979284535aaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



