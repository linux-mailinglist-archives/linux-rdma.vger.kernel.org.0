Return-Path: <linux-rdma+bounces-20945-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG8ZDnnEC2qWMQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20945-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 04:01:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC815763CB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 04:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78224304D5FF
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 02:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A80307AF0;
	Tue, 19 May 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYCqbc3T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016E2FB969;
	Tue, 19 May 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156006; cv=none; b=p7WeGAzJziu5ziJ4RLxS0GYAGIL1lAqz67oP3nICGDxfg4Ul3osfuqA20zyOr4zkxuUN2TW4z5UV42erAXZ3fvxkDbIbWjr2HHnZly6ymvlXlsvUCrvvWE7y7u+ohlW9iLzG1IMcCgMDro9qLdTU5yzTx/P6haDtzKA4l6jECT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156006; c=relaxed/simple;
	bh=KWvE0n4HLkfgFgaWO1y39G6mfV9oqV5D07CE+uU53YU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3QqKDwmwsgnmfSYG+SOD6nmXDLqNsslE/hBPymuW/rLBbNsO+aqqG4AU/D2DULmTAJerMwXIvfV8JUHbME3qFY87RALTDb/fjsKdfIEkSwxdI8dmTPuyb8KbXgBFoOwsHFPKNDfJ3ds0IUiLJdPDoQmiX/QzIEeiyS2W7rymdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYCqbc3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD43DC2BCB8;
	Tue, 19 May 2026 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156006;
	bh=KWvE0n4HLkfgFgaWO1y39G6mfV9oqV5D07CE+uU53YU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kYCqbc3TFn1CG/MjChsg5WeUIHBvjYdCDxA3O+kvHtv6yP7Ekbpc2y0OXP+D83TBr
	 GU4TP1IQ3SNI4M1+FD1xChz715jWbz/k3UBLPcgrkgaW0rC+7fo2FYiTEoAvDsGOKb
	 uyj1tita3zzK8J5eWjutnqKJyF4LE7tlj3tcft9GxX9lx5mlmFN/dEVmoKawyApUy/
	 i2q7WD+azjtkrlFJN85Dfycn/Gso/mRp80FkSvvcW2zfgxveA5rroD+egO1evX8htN
	 x5ne4ER/ZarktvXowXYxsny93F4Vsk7KkPNGF+1Hle3lMhckrMvZo84A1QZyUJceRk
	 8Q1Iu05AQxiPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6DA493930D10;
	Tue, 19 May 2026 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/mlx5e: simplify and optimize napi poll
 flow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177915601713.2051001.3494173884962273155.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 02:00:17 +0000
References: <20260514111038.338251-1-tariqt@nvidia.com>
In-Reply-To: <20260514111038.338251-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, borisp@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, shshitrit@nvidia.com, witu@nvidia.com, kuniyu@google.com,
 dtatulea@nvidia.com, sd@queasysnail.net, kees@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gal@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20945-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,iogearbox.net,gmail.com,fomichev.me,queasysnail.net,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CEC815763CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 14:10:36 +0300 you wrote:
> Hi,
> 
> This series simplifies the mlx5e napi poll flow and reduces branching in
> hot paths by leveraging existing dependencies between channel features.
> 
> Patch 1 avoids passing the full channel object to kTLS RX code paths
> when only the async ICOSQ is needed, and slightly optimizes the common
> flow in the pending resync handling logic.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/mlx5e: Reduce branches in napi poll
    https://git.kernel.org/netdev/net-next/c/cc199cd1b912
  - [net-next,2/2] net/mlx5e: Let kTLS RX get async ICOSQ param in napi poll
    https://git.kernel.org/netdev/net-next/c/425d0e2df5c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



