Return-Path: <linux-rdma+bounces-20109-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBivKRHw+2kBJAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20109-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:51:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F724E21A8
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E1AE301DDB7
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3F2773EC;
	Thu,  7 May 2026 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp36mgts"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E154654;
	Thu,  7 May 2026 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118666; cv=none; b=pSyF4DKEv8noFE7DFAlGBtJkGgdo8Bs6sWQaV5ZxbCWwl4u7KqhkUECReIGmFRl0TOYtW+IZXp6Rh7Wgp0V2d4AYoWMsOvXhsEnaJOSBGAZZhr1ok8gdwMbBD/YeDs7FRxlAjmGGuyzMGfY1pBh9RwH7M9Q+yB6GlQUnbP/AKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118666; c=relaxed/simple;
	bh=AXOXuSdkJvwp5xLWfyL3fW+mT+60jXSHxCo9agzeu9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VbmoU+3D98+SFn5BSoC2JPsrl40H32yh3zTuwEd4Dg6BF/3ak5VqOoxESnABQtd7hOm59Ntt24DiACrhLSGS7hNkXNTpIa66CeETbBl6ujPd1f8QgG3PMUFGXpDMUOJ/c9wOtsDntrMgSIZwd4dCOSzJa6UcoDwijCBWzcIrz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp36mgts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1132C2BCB0;
	Thu,  7 May 2026 01:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118665;
	bh=AXOXuSdkJvwp5xLWfyL3fW+mT+60jXSHxCo9agzeu9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pp36mgtsq9r8lH4alDWnt2X3E68dZCcG/xGn8B09gt10KRSY8NedXHzO/V9GFIPTr
	 rpXW+2M6hMXys1TUc5EKmDf8l0AqywN27dcZY+TT3c8ekZX44GH5/2a62Dozt0sRTo
	 6lKIHJvOjQ2zL45ZVCiahXjiK7+4dJIEmdQlG8vXAP51J3+KtcYcN0Gor1M1f8XdnE
	 zn3UBr+0OfzzzI6He8Y1EMa6TAhsVu/LzIz/h8+xm0GYGmYi7kL7aYFBWcpJE66FNj
	 G/ICUOx2Mc/AZ+5dE667TL+AmwRqB8wNP4DlEIsLA6IpJ2e4WuUnFjX5UGH5ub8U77
	 QwyyQzN+pIncg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEEB393089F;
	Thu,  7 May 2026 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/5] net/mlx5e: Report more netdev stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811861529.3297406.17717520902430268279.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 01:50:15 +0000
References: <20260504183704.272322-1-tariqt@nvidia.com>
In-Reply-To: <20260504183704.272322-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com
X-Rspamd-Queue-Id: 20F724E21A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20109-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 May 2026 21:36:59 +0300 you wrote:
> Hi,
> 
> This series by Gal extends the set of counters reported in netdev stats,
> by adding:
> - hw_gso_packets/bytes
> - RX HW-GRO stats
> - TX csum_none
> - TX queue stop/wake
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/5] net/mlx5e: Count full skb length in TSO byte counters
    https://git.kernel.org/netdev/net-next/c/de58db5f0d95
  - [net-next,V3,2/5] net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
    https://git.kernel.org/netdev/net-next/c/38e7e4a209c2
  - [net-next,V3,3/5] net/mlx5e: Report RX HW-GRO netdev stats
    https://git.kernel.org/netdev/net-next/c/97b96c3b47d1
  - [net-next,V3,4/5] net/mlx5e: Report TX csum_none netdev stat
    https://git.kernel.org/netdev/net-next/c/d8e5b2f7a5c3
  - [net-next,V3,5/5] net/mlx5e: Report stop and wake TX queue stats
    https://git.kernel.org/netdev/net-next/c/32b7e50e284a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



