Return-Path: <linux-rdma+bounces-9013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5069A73E28
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15162189E2A4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8521C19B;
	Thu, 27 Mar 2025 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwhdkRJQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981921C173;
	Thu, 27 Mar 2025 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101401; cv=none; b=ndw9h4pzxfZhXgvQZFn4Jc/szaEvWyoPsvjBGVIwW5WV1LiDhp7K8WY+0v58eH8ZFlin8kS/nz9nlz85t2GHQno4yAuaewNFqW5jMjP+hUTXENT4sxeqIvTXEHcLn9AdfSvLp42M07Mr+pYPjOPGJop1ID/O6zbp+xOj/9F+B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101401; c=relaxed/simple;
	bh=i9ttwfjxLHk/93YQdRF7sOvvdU5I5iYr5pOTqZY6zTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PJXQCOwP+f9aWbn3bKnFRsNdeRDPgRtNPzQpdNEDMVhPCoSKP69HUCxlA5PRnmpxcEl4oEWY+0U6TliVwoZftaC4q7o0KdYdns+wxK15hrEtg8weO6JO3iG7LRPRec4S4B6gJD76tAd7dVwSZvkmI78EVwZNvElg72pWPwhZHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwhdkRJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD108C4CEE5;
	Thu, 27 Mar 2025 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743101400;
	bh=i9ttwfjxLHk/93YQdRF7sOvvdU5I5iYr5pOTqZY6zTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CwhdkRJQf0/ZJjSUYhX/R9UdxJk9fwBXPNc7kSKr7HdIgFUmZtb9sCmDn6wqo80zM
	 P2t0r3RUyhetts6kP4ZirmHMzsjPG+GX6IvrGhsaZVfM2VMA8Pqtw13axdBDAoiIfO
	 f4gXyx/JZh8trcBtyxTE0lYF2J6jN2t56DuwT00Fmhf9oyFLf6eIbdIlGUEhebVVXj
	 9+SzJj+6AOyxaLnEkOB6bAiFlI4qmbFP2G0Q2fGEFKSqUgDBbdLv0GAcjjObmKwW98
	 Q4HeLTQH4CypxBenh1FwgPzzRrbDJHUiniepT8ivXSSsEMY4zn3lSOzJiAgAZuuaB7
	 KUnJGQJ90g9LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D99380AAFD;
	Thu, 27 Mar 2025 18:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] rtnetlink: Allocate vfinfo size for VF GUIDs when
 supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174310143703.2165614.8256610982374403236.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 18:50:37 +0000
References: <20250325090226.749730-1-mbloch@nvidia.com>
In-Reply-To: <20250325090226.749730-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sd@queasysnail.net, kuniyu@amazon.com,
 leon@kernel.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, markzhang@nvidia.com, msanalla@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Mar 2025 11:02:26 +0200 you wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Commit 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
> added support for getting VF port and node GUIDs in netlink ifinfo
> messages, but their size was not taken into consideration in the
> function that allocates the netlink message, causing the following
> warning when a netlink message is filled with many VF port and node
> GUIDs:
>  # echo 64 > /sys/bus/pci/devices/0000\:08\:00.0/sriov_numvfs
>  # ip link show dev ib0
>  RTNETLINK answers: Message too long
>  Cannot send link get request: Message too long
> 
> [...]

Here is the summary with links:
  - [v2,net] rtnetlink: Allocate vfinfo size for VF GUIDs when supported
    https://git.kernel.org/netdev/net/c/23f00807619d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



