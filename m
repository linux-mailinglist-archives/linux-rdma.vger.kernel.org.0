Return-Path: <linux-rdma+bounces-17650-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LZGEdZ/q2mwdgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17650-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:31:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF32295D1
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8863056D9E
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5349301010;
	Sat,  7 Mar 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfJjYyzQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74002FBDFD;
	Sat,  7 Mar 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847016; cv=none; b=t+TnUjNUW8CMdE9iVkPvGWdLEui/NbtoouWZgKKO29PzlJEzncxUJwU5jG1RTEE8Imy0PZZkdM2CkonKKIRpGDP7bAV+JbCQydchUvT3ENdPmsn1rYio/Xb+OVYMznrydZSI9Xei4mBzq7MVt05ah/BGBHnUPtJUro/rvXwL6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847016; c=relaxed/simple;
	bh=vCxoHh9kefBfUAQ06r10MYU3iAEPlMRyRXRHn54H8Rs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ln/fySilv581qBBcAyvRnP/WPsUZUgt/r/dNUTKgYucwzAsR74XeczaijtZpVP8w7c/kKHEe1IDHx0494vJdgQZKnQ9U0mVJR9LnK2aroqH5HqKn/uc3Ov2K5IXn3sxpdhGnFFUzfADE3hnaPhKqaWhqqi42lMzzpNQ1ghKzW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfJjYyzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65120C2BC86;
	Sat,  7 Mar 2026 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772847016;
	bh=vCxoHh9kefBfUAQ06r10MYU3iAEPlMRyRXRHn54H8Rs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfJjYyzQMsZP1HSyk1HBwmxySaeSf23vy3iCfrzrBjUb5Q8WjGFv4B3qxt+x9ZEGH
	 QXV8EW8tIX+btBxR+JYl5EI3Lvmk8TVdFBdHq/Zs6xtniCrGh6aWYmZlv7fnoRhK8e
	 GGPGGvLhn++qRoOK0hy16YkHABW8XqAp9Mf3yO+DkZ1l3x+Z4m7AWP7yu7EEw9s8EA
	 EvyJOiHRVq5SxUBL2eh7c+H/IFmlmPiOZCCFzJn7808LbCErcqyWVMNPdgNj5AQdcR
	 pKsN+HfttiOFE32SIeqkkpBHLv+OH7wto16fdXCafkAfXDFqOS1CTMrbhuru9Ww28i
	 +kpfTzAR9X1uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0953808200;
	Sat,  7 Mar 2026 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3] net/mlx5: Fix deadlock between devlink lock and
 esw->wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284701530.117391.10276803824511895548.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:30:15 +0000
References: <20260305081019.1811100-1-tariqt@nvidia.com>
In-Reply-To: <20260305081019.1811100-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, moshe@nvidia.com, cratiu@nvidia.com, horms@kernel.org
X-Rspamd-Queue-Id: DACF32295D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17650-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Mar 2026 10:10:19 +0200 you wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> esw->work_queue executes esw_functions_changed_event_handler ->
> esw_vfs_changed_event_handler and acquires the devlink lock.
> 
> .eswitch_mode_set (acquires devlink lock in devlink_nl_pre_doit) ->
> mlx5_devlink_eswitch_mode_set -> mlx5_eswitch_disable_locked ->
> mlx5_eswitch_event_handler_unregister -> flush_workqueue deadlocks
> when esw_vfs_changed_event_handler executes.
> 
> [...]

Here is the summary with links:
  - [net,V3] net/mlx5: Fix deadlock between devlink lock and esw->wq
    https://git.kernel.org/netdev/net/c/aed763abf0e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



