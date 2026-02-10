Return-Path: <linux-rdma+bounces-16707-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI+gLCBIi2lSTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16707-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 16:00:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95411C304
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 16:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57073053756
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8957E3815CE;
	Tue, 10 Feb 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/ZcX4MK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3036E476;
	Tue, 10 Feb 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735610; cv=none; b=CVPAVmw2/6gAtrHVakJkPuYntQQ1D5nHePvFwhqiSkQ6LqFOt00ex3/cEWUtFy9s9YtjSPlnVTmcpMC9pHMnGW9x1A4/pKlRhyTAeHzJmMteVwfKQrAL74AuvADWxxNkunX5UpkOiKQL//+cL25rGZY+ZXhsLAY8HHayPswoEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735610; c=relaxed/simple;
	bh=tKMNJiUTGeWqAqxNWcIQZshtd5oLRcw41cmdLNIwTw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f+ixl9Ss42JcNp73lWCtqDTdoUGoybyVjZfNPN9VBWXDIHCGLK29YcdCgtXzoWMTCEp6Q4dwfIVeq5QMVpM7B9ezroAg7yZarFf6Ka1jTvUHHhFtqoW0Uheul76e0FIUsVPj9+RbLzQLP32Rwzx9CbFa6+rEt6TRptgUpF2SFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/ZcX4MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B21C116C6;
	Tue, 10 Feb 2026 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770735610;
	bh=tKMNJiUTGeWqAqxNWcIQZshtd5oLRcw41cmdLNIwTw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/ZcX4MKiMlrAcZWzEGalYIEP5T3KlUlFXO7uXC+HlW8W3uY57z2Pcjps2/qzo7hA
	 y0eZLmGSNw17eL3DMqZeMv38yzyBQq/rWc8lMpAKrM55Mfnn0zVyRdD6KRqho8WF1X
	 BiGHB65AvqillyjLSU1gOUfiretr0Ypex4nec/jUXun78qA4kZ7nf7wbWIqLgOGMGF
	 y6fXiTyGL50YShSsrHOWZLVuVwp3Tt7bmEFN71duqSBWSm0xwf7mlj/XuCZpV4YxzW
	 qffgfDvV+gqay/kOQwRSDzCtZWKjhc/2mbS3I9VmyCnCsHUkanMXPqrkMxlc8pAa2d
	 vGu0NfRTR/qrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8517139D609B;
	Tue, 10 Feb 2026 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5e: remove declarations of
 mlx5e_shampo_{fill_umr,dealloc_hd}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073560508.3544204.5534906377848723317.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 15:00:05 +0000
References: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
In-Reply-To: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-16707-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB95411C304
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 06 Feb 2026 11:18:51 +0000 you wrote:
> These functions were recently removed by commit 24cf78c73831
> ("net/mlx5e: SHAMPO, Switch to header memcpy"), however,
> their declarations were left behind.
> 
> This patch removes those declarations.
> 
> Flagged by review-prompts while I was exercising Orc mode locally.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5e: remove declarations of mlx5e_shampo_{fill_umr,dealloc_hd}
    https://git.kernel.org/netdev/net-next/c/ad1f18e985cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



