Return-Path: <linux-rdma+bounces-20940-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK5HD/6gC2rrKAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20940-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 01:30:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF6574FBA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 01:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA2F6301389A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE96330B09;
	Mon, 18 May 2026 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrd3JVPC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9029B228;
	Mon, 18 May 2026 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146998; cv=none; b=jKEC/WSWiYEyqno21wGZ6+LZa4Q48ItYkZR45u64tdTJ9b5Uv3BuwZywZ6WnnIRNzD1OASzcy+5pwVwqehM50NoWqXc+6pU0pUjTR5gzgGhNE9t6WV/PqFfD8/fcwd4qjJXvFSlrSDJ4Qo5K3/uyvSGCxBT/WtJA0ik+DiuMBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146998; c=relaxed/simple;
	bh=DacEXxb9B1ymepJcH3QWAXaKhWL1QO6ShTj1d9qy/VY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e39GHZsTaBIu9eLwekPWWaUNKJ451E2ZuOHGxAUbhVApCMc/2GRb2ix11hTCue/LPOQ77RdOcdc27QcMSv5+U3tv6fkZ0KesSjZisgfTILHKRxc1QGJE/HY6ppTnneANKHd6ZtocuaLRnDn9EcIaIAqSZ6e9Lyf/vljIwEyRRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrd3JVPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8383BC2BCB7;
	Mon, 18 May 2026 23:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779146997;
	bh=DacEXxb9B1ymepJcH3QWAXaKhWL1QO6ShTj1d9qy/VY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zrd3JVPCbSbb82U89sBkRijdI1axILSwXGClnCx8NoXRGFCNDUOMt7zb6mhQfcCzc
	 kTnuQGttIlFjSg/tZnzvqFB49TOr9gp+zSCBcp12abCap0RyPhy83croDTPw8Rr/uD
	 u6ZlicZ5cZN9sS8tGa4yXG6x7ssQiODVW0B7w377Vn0h0pXVH9nPrzX+ID5bV9nUzD
	 jXVd+0/XzekTtpZjyyuKpQ2qh4wMBKB7LshwaB6ux2UriKtbRyNZT3iA9uNbr/NH0s
	 JeQ0czc8vnSxNQboNcvyYPZnu7NaTw65cIv5duMgJmsG/ow9Ti5KeW6MzUyqgyVPGg
	 I1hBPBSK05KtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198863930CBF;
	Mon, 18 May 2026 23:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/mlx5: frag buffer improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914700897.2009822.15421572826777145558.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 23:30:08 +0000
References: <20260514104925.337570-1-tariqt@nvidia.com>
In-Reply-To: <20260514104925.337570-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 noren@nvidia.com, dtatulea@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20940-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AECF6574FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 13:49:23 +0300 you wrote:
> Hi,
> 
> This series adds observability for mlx5 fragment buffer DMA pools and
> improves the default NUMA placement policy for fragment buffer
> allocations.
> 
> Patch 1 adds a debugfs interface exposing per-node DMA pool usage
> statistics for mlx5_frag_buf allocations, helping with debugging and
> visibility into pool utilization.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/mlx5: use numa_mem_id() for default frag buf allocations
    https://git.kernel.org/netdev/net-next/c/0e222299714f
  - [net-next,2/2] net/mlx5: add debugfs stats for frag buf dma pools
    https://git.kernel.org/netdev/net-next/c/9fe78db3ad17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



