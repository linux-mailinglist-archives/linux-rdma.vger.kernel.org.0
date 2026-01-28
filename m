Return-Path: <linux-rdma+bounces-16112-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGgUMWFyeWn2xAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16112-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 03:20:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDE9C2FF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 03:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C6D13014871
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57952286D4B;
	Wed, 28 Jan 2026 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g66Kjybo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7317A2F6;
	Wed, 28 Jan 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769566815; cv=none; b=kOH3hf3OVBWYRfpXtaJlly+2xX3PAHudANTGnLdZ16Jz5YWQlJOzuQa1pJ4taEnNKz8maA2rrU2wBIfCF6IP6Re/Ay0BN/MskU479MWGI7SBL6Y03WbcwreuDJl/oKErw/4ajlDavW6+eDu6R1g9a1J5MHxNm3Df4tvVZXBaq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769566815; c=relaxed/simple;
	bh=AeaQNbWgsz34Q4p0O0bSHwJ/t55TH3AfsKAu2YEubMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qgBg3/UwW/fa2k6nOL4cKtSpp7WbWZDsZ8PsjaKAriIHOX0ByufSQg1aUiC/XQMDFeH2LiK/hhrLYcCcNPatgxGz43x3P6r+NrltH8eqyLC0GcEsus0sXRs8mn+qq1mLptuWnbfA6qZQC8npV4nvP9TQxQUl8EQIK4PN5YDOYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g66Kjybo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B0C116C6;
	Wed, 28 Jan 2026 02:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769566814;
	bh=AeaQNbWgsz34Q4p0O0bSHwJ/t55TH3AfsKAu2YEubMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g66Kjybo21OX7ZiMX4w8vQhRwgMf3ygS+bUnl+vtRA7PoNykezMpmCumZLoYt2Via
	 WiaQX0tSo34/TsBn+i1x8xZASFRxiPUGgDvOmUp2HoS9F7BqDkTl96izfPolx4nv7s
	 2bLJd/Vw9DqX2Co3b4UXj4OzbaArZemkw/5IBbpOX+NhxlwOcQRbO1fC5bnhigzRxB
	 i5rhFAm+eoOz6HGi09wD1MF4IalwyHjA8UMURc1jvN7Ql1QzbM2Osntdl/xasT8vg/
	 tkRBvxOZkpZvK6OblXLe5UqT+73m35wSdtwHYqH42KexbG8c/f/QCakXsmJLx0Plk4
	 RnoM2p4yUj+Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBE6380AA76;
	Wed, 28 Jan 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2026-01-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956680835.1480056.4410381028333071735.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 02:20:08 +0000
References: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16112-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81EDE9C2FF
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 09:14:52 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: Fix Unbinding uplink-netdev in switchdev mode
    https://git.kernel.org/netdev/net/c/2ae8c7edea87
  - [net,2/3] net/mlx5e: TC, delete flows only for existing peers
    https://git.kernel.org/netdev/net/c/f67666938ae6
  - [net,3/3] net/mlx5e: Account for netdev stats in ndo_get_stats64
    https://git.kernel.org/netdev/net/c/476681f10cc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



