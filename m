Return-Path: <linux-rdma+bounces-19262-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INraOfUT3GnYMAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19262-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 23:51:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBBB3E63AD
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 643AF301F9E6
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC023318EC9;
	Sun, 12 Apr 2026 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MILKKq/H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82F21CC71;
	Sun, 12 Apr 2026 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776030657; cv=none; b=KhkKUVuxXQd+O5DnnkETSXHgrcoGGGrby6QJLM17l3cCmislqeLfCz3LjAn6ZvUBrz8YNRV2JN7gWBGnOK9ZJ9GIrqmt6WNnk4raf/n68TkePsdcEFrGgZxNJC8Rxa2eMYUdAEU94COlaISayAWkRnXhSlFsbUo2+i356B/d/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776030657; c=relaxed/simple;
	bh=2unedcp4QVEz504Sor1qZLz9fgHVioo3+2+wnGBLvr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y/RpKYWrO71US9t41r0Q6B+CAxbmotR6Aq8JKEel5etwyxt3lw9f1c8H3R9tnhsg03EX72xwbHsHrBjy2BObChxDf4Wrw9UKgej2X8jDhWQfW3SwFOq22LyF2BNQ2Zwq4JsCZAf+gMukeRaL2D9nluHyclMAhuYA8RDKl49plAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MILKKq/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D3C2BCB0;
	Sun, 12 Apr 2026 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776030657;
	bh=2unedcp4QVEz504Sor1qZLz9fgHVioo3+2+wnGBLvr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MILKKq/H1iYjA1nK/koKI5zRjSLElo7dseIj3TlBEYIZJhprQ4ciSpdi8L891jvIS
	 1itNkA7jvGGHFB5B3ZkQt143Kn83+/TyGdBWSHmoO8Iopm/7/1HyTlJnSA+BaKzkkM
	 qc7tlhuT3TdJD2TssKtEZ5y7h+RwROYJMIDRtxHZps9vCRoaIg8StxY0hK0CCzUpxV
	 nzvNUL42b2wA4rZBREV6YKUPz3z6c5me30DkawQlOV6f3wGVmdrT1RE1gS27ToAou2
	 50G7yQgjDCHKqDqN4i/P1s2Rr0ts5uppiUxrcEl9QvQTp/ZQ7wQIuYoikC8oHXArrY
	 t9lreqVUjaimQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DC33809A8C;
	Sun, 12 Apr 2026 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2026-04-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603062929.3833036.15590195095817856526.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:50:29 +0000
References: <20260409110431.154894-1-tariqt@nvidia.com>
In-Reply-To: <20260409110431.154894-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca,
 saeedm@nvidia.com, mbloch@nvidia.com, shayd@nvidia.com, parav@nvidia.com,
 joe@dama.to, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-19262-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8DBBB3E63AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Apr 2026 14:04:31 +0300 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2026-04-09
    https://git.kernel.org/netdev/net-next/c/f05b619d0fb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



