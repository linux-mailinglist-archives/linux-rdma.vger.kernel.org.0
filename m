Return-Path: <linux-rdma+bounces-22749-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pjglCZz2R2qtiAAAu9opvQ
	(envelope-from <linux-rdma+bounces-22749-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 19:51:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B6704B70
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 19:51:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lu5Zs+90;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22749-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22749-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D5A4303B156
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D050305675;
	Fri,  3 Jul 2026 17:50:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46A2E65D;
	Fri,  3 Jul 2026 17:50:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783101037; cv=none; b=cY7Wm/lJA5LlBEp5k/VBNzp3C0qFbYWuZXnlTH8VkanxhCbe+pSaVhmz9I8ZF1rzbjmMf6kSZbfUFuVo9tjRRWvMU75JnlSTcAruJD2QthVYGCXcS8fWNw635xFhpB8E0pAxAi4+4decuCFDxyY24+i1WyCVCbAJHJ+uwVw9rI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783101037; c=relaxed/simple;
	bh=e8ROssInUC8cAOJY8FlT/EeEUg67NelAmFdP67IdmDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nYSU5BYc4fVPMurFzrp+lyJ2KProL2stKgtpSF7RbD7/dRjx7K+29qU0gKVZPs5sk/SfysZUlsa8oS0IWGQGEtDDirGZ5By/cGU45ek5XKdMlAr1PLRGH81d5rfTZLNddBZMB+nlQIitUtw8MRrctB5tJrMmf9ZM0zX3rzU4dBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu5Zs+90; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948ED1F000E9;
	Fri,  3 Jul 2026 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783101036;
	bh=UXY9f3144yNMxxvr45Rv9SY5qq28xWdbWONKKiDTI6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lu5Zs+90zQqRAiiStB3tbMWNOBMfwPFbftC3XLW2PE2d284cP7XMWKQJCbejHqTEG
	 /iQ1Soxz9zrzPx63M4CogMR2ev+mBTWWcYJXbUbg4vigROn9zu3NluaPU4C7OwAqLY
	 HZ7O42NZMawqr7kPhalT+/TRTQ1MgAoi7Em4xVw2RYtMuAhtc7IVPwqRhEPVNIkgQN
	 HxMe2TWQLLqlzqRBL7XTPsJbqKV146rFZla2yKDVY7cn+YarnP4+jC74RFBI31ROm9
	 1ZjxiriQ+Y/MwwEqW7tu/9xkOW78T8sp7vyogbwKJ3OF0p2+mPtRoQ/w0BfuGM+6JW
	 gvtpG6pG3Fdnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19CE3393935A;
	Fri,  3 Jul 2026 17:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V4 0/3] net/mlx5e: Fix crashes in dynamic per-channel
 stats and HV VHCA agent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178310101889.3259859.10475454048684619212.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 17:50:18 +0000
References: <20260630115151.729219-1-tariqt@nvidia.com>
In-Reply-To: <20260630115151.729219-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 cratiu@nvidia.com, eranbe@nvidia.com, feliu@nvidia.com,
 haiyangz@microsoft.com, lkayal@nvidia.com, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, mbloch@nvidia.com,
 noren@nvidia.com, saeedm@nvidia.com, gal@nvidia.com, alazar@nvidia.com,
 horms@kernel.org, cjubran@nvidia.com, kees@kernel.org, eranbe@mellanox.com,
 saeedm@mellanox.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22749-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:gal@nvidia.com,m:alazar@nvidia.com,m:horms@kernel.org,m:cjubran@nvidia.com,m:kees@kernel.org,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 762B6704B70

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 14:51:48 +0300 you wrote:
> Hi,
> 
> Since per-channel stats were converted to be allocated and published
> lazily at first channel open in commit fa691d0c9c08 ("net/mlx5e:
> Allocate per-channel stats dynamically at first usage"),
> priv->channel_stats[] and priv->stats_nch are filled in
> incrementally during interface bring-up. This opened a window in
> which the various stats readers - most of them reachable from
> userspace via netlink/netdev stats queries - can race with
> mlx5e_open_channel() on another CPU and observe partially
> initialized state. The HV VHCA stats agent, which is created
> before the channels are opened, hits related problems of its own.
> 
> [...]

Here is the summary with links:
  - [net,V4,1/3] net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
    https://git.kernel.org/netdev/net/c/25f6b929c7e3
  - [net,V4,2/3] net/mlx5e: Fix HV VHCA stats agent registration race
    https://git.kernel.org/netdev/net/c/89b25b5f46f4
  - [net,V4,3/3] net/mlx5e: Fix publication race for priv->channel_stats[]
    https://git.kernel.org/netdev/net/c/5a799714e8ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



