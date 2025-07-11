Return-Path: <linux-rdma+bounces-12060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BBBB01F53
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jul 2025 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7B3766DD2
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jul 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF02E7BB9;
	Fri, 11 Jul 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/RF5Ui9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A72DFA2D;
	Fri, 11 Jul 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244799; cv=none; b=BUhrmkhEJJsR9oaLNS8fB55M3alDIzvcS1HZlnz3WqCeb4OGkA1bNCDtCr/ET62CXm9cKYrtBmPJzTReTZn+Z7IhwXOiQYJUi+xJZ6Y3CR8BPHDGiMHgR7e25gXuhNaHy45tiPmJ9ajGx1FMV0djRm5EUr5qIqzNJAY6b5LPtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244799; c=relaxed/simple;
	bh=pbBx0BTrgfM3YrBbgUaFthDxIg7U7WUmoyVer8F0jf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=srLrP22yZB3jAzoAqg4M0jQOyYyqtZHNk/5xPmxXX7S5lZ250dVYhaXC8Seq/W4nrWg477S+aungCN049/YeztI3JVSEm8xIzr9XL4B0C29i5VfXypP4NPjz5+PIZ40C32MXf1NoJo9CFHXpNEEnpnm02FIZD3qmK70+N1/oTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/RF5Ui9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5C9C4CEED;
	Fri, 11 Jul 2025 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244799;
	bh=pbBx0BTrgfM3YrBbgUaFthDxIg7U7WUmoyVer8F0jf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L/RF5Ui9LxCNYe+vCbMbXs+us3CFwSrpTNyQGCMYL2sjAPCgYCWw6DHhtOwmdNv3Q
	 g6FE9K1sZVhFNQm10RW+6N87s5PtI8EukOTjYbJ4UjGG9BHtXLj/yWbklGf9fb2/1W
	 rFvTLk1m85epNdIIPOLU4r2Zv7nP2lMS4GJ96xmuIFhzy4j+5xs0H70Pp9uYVwfMT1
	 MYFp6cd5WNzfEaKd8Ux8Pohh6J/W7RwS0ZoeQQNLQRzC8bntz6K7Bo/oZOylKEMEKL
	 t9BvEeo3fCCvZu/wr3pBw49wcokPhbZd5td4jx01C3jP4OJsxlsauTvsOK6b5QpcLY
	 C8Vzpfz1mw6Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B18383B275;
	Fri, 11 Jul 2025 14:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2025-07-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175224482124.2294782.15289070298034532895.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 14:40:21 +0000
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeed@kernel.org, gal@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 16:53:41 +0300 you wrote:
> Hi,
> 
> This small patchset provides misc bug fixes from the team to the mlx5
> core and EN drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: Reset bw_share field when changing a node's parent
    https://git.kernel.org/netdev/net/c/f7b764668940
  - [net,2/3] net/mlx5e: Fix race between DIM disable and net_dim()
    https://git.kernel.org/netdev/net/c/eb41a264a3a5
  - [net,3/3] net/mlx5e: Add new prio for promiscuous mode
    https://git.kernel.org/netdev/net/c/4c9fce56fa70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



