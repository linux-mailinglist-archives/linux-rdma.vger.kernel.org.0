Return-Path: <linux-rdma+bounces-16174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGv4NmrpemkV/gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:00:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67307ABC42
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CACB93006825
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BC26CE32;
	Thu, 29 Jan 2026 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCoUs/C7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242972634;
	Thu, 29 Jan 2026 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769662821; cv=none; b=lcyql2Y+JDl62vBMVxZrH1VpGEFNNyLVY8nhs+V1+xJGeJV9aUNvlHM7+NhAb4ThnQWJTUezaPe+f0XKFoKppQB0hkE+gDjZPQ9OZfz78Rh0WQXfwtjm4KE4ney6LlpJUdiZFMisExi7kxMtQmCH97eBPpKzZ5XFh8DrXA+RK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769662821; c=relaxed/simple;
	bh=eIGSLH9LnjZI03Hz2zkiahhthvbBZijztdpDMjguHPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0v9aLYoDUyAk9jzaNrk+rEk7rQYRi4rJVLndlnayS4Kf0A2s0tyFgj4FmUuFr7JrAS6ml6IZa3m5cVd/vRbh4AMIsZf4s8AmFrqE6dd+TVUiDoQp+iR8xV3PJk/dd3nxizI9vxTU7muDJl6wuTnr3A8xHFHynlFGTMJQRHGjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCoUs/C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D04C116D0;
	Thu, 29 Jan 2026 05:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769662821;
	bh=eIGSLH9LnjZI03Hz2zkiahhthvbBZijztdpDMjguHPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UCoUs/C7XgL4MhQiJ2k50bAsmfnCH835kG4opAk8pdj6gDx6rqHQz7oCiQojKZA7B
	 kM4ZpEl2MzCeiBpLsnF+s9Ec8/fZbIUZkmvm2uRv0aTYD7ieeRP86NbT6na1DjWqDV
	 C8jeuZ5TaX8811yyFXlAqd/PSQgVN5mbEiOM9sbr2IqRDc3B0Nd6qifosQhA1NRSnH
	 +ORqQi0O+3Scew9TUd2NaKVY/VdV+Di6XgOh8IW9OCHH6A0tIH3zerTDypKxNDttat
	 HG8+7c918mE74CLV7O/NHMu7hx2ziKks5LQ5jrWBNUJKcxO58t958QRl+doeannlxF
	 nvqKJOnaOlgow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBF2380AA69;
	Thu, 29 Jan 2026 05:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 0/4] mlx5 misc fixes 2026-01-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176966281410.2353118.7838493607749129728.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 05:00:14 +0000
References: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, horms@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16174-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67307ABC42
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 10:52:37 +0200 you wrote:
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
  - [net,V2,1/4] net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect
    https://git.kernel.org/netdev/net/c/2610a3d65691
  - [net,V2,2/4] net/mlx5: Fix deadlock between devlink lock and esw->wq
    (no matching commit)
  - [net,V2,3/4] net/mlx5: Fix vhca_id access call trace use before alloc
    https://git.kernel.org/netdev/net/c/a8f930b7be7b
  - [net,V2,4/4] net/mlx5e: Skip ESN replay window setup for IPsec crypto offload
    https://git.kernel.org/netdev/net/c/011be342dd24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



