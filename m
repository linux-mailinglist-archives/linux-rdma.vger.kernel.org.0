Return-Path: <linux-rdma+bounces-21995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LfOvBhd0J2roxAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 04:01:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A813165BC93
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 04:01:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LvHC4PmX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21995-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21995-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9283042258
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 02:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C2360EFF;
	Tue,  9 Jun 2026 02:00:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A91B4156;
	Tue,  9 Jun 2026 02:00:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970415; cv=none; b=W6fN32E0hvsIZ+rQ3mgof+qavawLzJpwRxRRy1UQQUaUw3NmMYpvvMi0lqTdVQ6cWwjMuLI4zu2UA33EoHCr6IQKjAPEzum58fAiKPR4Jb8nMFPMNOC2gc864iE2aj+cXkxUCuvOOid/NcEB6tKc08OHuST2eMyapT3AxBSicKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970415; c=relaxed/simple;
	bh=iUTbxRnznwH9gCWzMJlJQNrfNL1EJPjuleZHkYlThGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdDjgCvsWDqc27hHIFrcR+V0F1TwDDQUEI6H7e+bv9ngD9//eagtqbsqKgr3PVxjgHeVTstai/uNcPU93LyJZQngkQA0CfzvLIDEJdRQrs1yDwvbzhyEqzIE+Rr1sZE+Qw/b6q9SDKLpGtm1w00e6awn/a64XAiK8XQPBiIIbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvHC4PmX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19F71F00893;
	Tue,  9 Jun 2026 02:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970414;
	bh=hkiZ1au4GyhFFSxzneWq8O/zxJkYSkfkORdEmjww73c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LvHC4PmXexYzSjF5Dj1uWTF1Bcp2geQ8zoAcNaiptuiP3Zj1y2XQfIxuaNUvT9r+g
	 nV16jR4D6RJfNorooncjON4+PZ8p8uHx1UPuRf2cpYyY+5gPT6+i1qnbhAOkeYdY4/
	 /qmkERSWy4jKCRBpqx+Mv7MBdX6fKwC5cDkKAmoPkfXaD4wy1oM5KYMiPColBs0Qq0
	 0lt9XGS2HpheKLzwcBjdLeRc4jvfrvaYPGgdVHq3kFtxTfUGVzc2xDGiLk8VXmuUi6
	 jbi/R2t2Qf9mqAJP0H2rtNmaVG5alzPueyN/cOM/cl5N2ndxSWvQc39n/bz5NiQ9ik
	 NOKputsEAEU4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D098B3822D43;
	Tue,  9 Jun 2026 02:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Fix slab-out-of-bounds in
 mlx5_query_nic_vport_mac_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097041239.1753037.13513019286051160726.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:00:12 +0000
References: <20260604135849.458060-1-tariqt@nvidia.com>
In-Reply-To: <20260604135849.458060-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, ogerlitz@mellanox.com,
 saeedm@mellanox.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com,
 cjubran@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21995-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ogerlitz@mellanox.com,m:saeedm@mellanox.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:cjubran@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A813165BC93

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jun 2026 16:58:49 +0300 you wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> mlx5_query_nic_vport_mac_list() sizes its firmware command buffer using
> the PF's log_max_current_uc/mc_list capabilities. When querying a VF
> vport with a larger configured max (via devlink), the firmware response
> can overflow this buffer:
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list
    https://git.kernel.org/netdev/net/c/894e036a24a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



