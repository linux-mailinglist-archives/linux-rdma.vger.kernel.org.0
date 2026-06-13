Return-Path: <linux-rdma+bounces-22187-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3YwgNV+3LGrdVgQAu9opvQ
	(envelope-from <linux-rdma+bounces-22187-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 03:50:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8267D798
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 03:50:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W1tZq+35;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22187-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22187-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86A903008FE6
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AC3612EF;
	Sat, 13 Jun 2026 01:50:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49914AD20;
	Sat, 13 Jun 2026 01:50:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315411; cv=none; b=TAxciderQl/uwiExcbTNZZwKf5Unt/kGAHKWB40Q08p5GOWg/dVWMGprDNTVHMxh330OoSERV6bcuqRy+c1m/ae/0ZSHrDs3xPHwSgGLwPb1wLeonNoSx3mIc1XGz4Vtu68hgLgRbUosCAg4QrjX982BentSJ0/saP+KdpGen+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315411; c=relaxed/simple;
	bh=Yr6S8fIgmX6vxEnD0wUnAAB0in2o/6zYLTND/bgmMnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qtgIxJoTOODSFpMNdui/M7FnFzmd8ujEu0MMxfjldCcRt6PFbOw5u73GuWn5/p9rzoIzphLhfuZOI1uocEQBjO91PcdTAT6eLE5aHelX6dvgtw2l+SrOVkas2yt0Ipzs+5xDGKAmriu3QHrqUkWspcIvSB0e+Ds8Mc+OdINa4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1tZq+35; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6F11F000E9;
	Sat, 13 Jun 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781315410;
	bh=jv21HSBAOpuW2iqSfNFVJWMIhwVLUAEqSkvvh5Xsn6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W1tZq+35Lb8/oV5V+jzTzzjhLxyaOI2qoCMADrDF916YiSZp/03HSPwKNuIAMP4p4
	 LHpkxW1SCNJ4/uN1neGlkGEeHFaV6BP1XX3EUyum9mEDMgYVnCU5XcMZtJCAJfN+1f
	 BwXu4q2oOs+zzbH33iEORclvO/Bzy926wqO2DujfgNL/7ul+VcjgvNbWfgmbEb0t1n
	 k4X+/kde7nFgDvsMfGwvgnKxRO2OxXWtMHDHMzJLbg9z78WMVZV+NYIYMXCbe/Kmzl
	 k5FBwZ1aZXJr7aPUtTPhIQ6lI4WITIQouuOZqgYfp8jm3yixYVX1KngL1LC/BDmLZq
	 dJbaA9/YADYMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1991C39E9607;
	Sat, 13 Jun 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Check max_macs devlink param value against
 max
 capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131540664.1328827.1311821066255309586.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:50:06 +0000
References: <20260611135230.534513-1-tariqt@nvidia.com>
In-Reply-To: <20260611135230.534513-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, moshe@nvidia.com, shayd@nvidia.com,
 parav@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com,
 ychemla@nvidia.com, cjubran@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22187-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:parav@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:ychemla@nvidia.com,m:cjubran@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBA8267D798

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 16:52:30 +0300 you wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> The max_macs devlink param is checked against the FW max value only at
> param register time (driver load) and inside the validate callback
> (devlink param set). The stored DRIVERINIT value persists across FW
> resets and devlink reloads without any further checks against the max.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Check max_macs devlink param value against max capability
    https://git.kernel.org/netdev/net/c/d7b0413b3571

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



