Return-Path: <linux-rdma+bounces-22941-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ei/SFHZsT2r6gQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22941-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:40:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0B72F0CE
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:40:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZaKy1muY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22941-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22941-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BA003082BAC
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245713EDACE;
	Thu,  9 Jul 2026 09:30:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C99374E66;
	Thu,  9 Jul 2026 09:30:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589430; cv=none; b=fBQ1omU2Skq8UyHok6P/j9vC1KMbVpauctaQS7Hd9o72q4vXYCIKQsNpjeHesDFsorwcaEf/CbdOeEVR8X4sIsQ8I0HK8A5Tsy/vVRyE4qP7CM/KCDV01JroiQlta7b90dR4JjVsWksDosrf4Y8m5wThnKqdfbzAu7g9C4sZoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589430; c=relaxed/simple;
	bh=AVUhXc5gvHYPIuLaVgC6xqjBwF+9EyJkA4GiAuMx8H8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJVGJ4TyP+v0SrcSOMI0ZpUtq/U702mfy1AcpboDHRM2Ssz8nKjViWbhlrA+NSKj/9OScDqSTySutTcVd28iWNpxPpXUAdFl73PMgX7tggDMFDWZQBQjFcIyy/QKyy8U+SBH98KgVQT2Bjo0ec7rMz9wLJ+gPqR4qOT82FwenLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaKy1muY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC5A1F000E9;
	Thu,  9 Jul 2026 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783589429;
	bh=4nmXI1erR1f26Rw4ts+yuWXvBetde7F7kWDg0+7ajt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZaKy1muYWKhkn1npeBHlY0pBO83PiSYAa9fxQvARynnvkC8MqZHmylJi5xi3siLJQ
	 L3uH30ZQ6iQZ9x7uFXbrtCTdKgdoN1ZjjmlcFtUNz7GYpzhmoiZ7O5new96tZEclob
	 RjIPPeuf2HRlZK8v6YhFUq8HOYC9jSKzb5WM63tkVtzI4ADMTaLphqx3VOAN1G3237
	 WUP2cDaSASOVTCr7m7FFcRcJEJprmsXjChKQ1yOr7r9QHBOB0d3a0b/cS/gfonMhCG
	 ZitU8RMSE7DQVsP6L2NH103Sl7OP9nShTsM6nE1K3SmDdkcnLjwv/h4qkm6mMYRfHk
	 07hkXssikik2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BA6393A570;
	Thu,  9 Jul 2026 09:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] net/mlx5: Fix L3 tunnel entropy refcount leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358940809.3364831.6215387935440663585.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:30:08 +0000
References: <20260703141423.1723-1-lirongqing@baidu.com>
In-Reply-To: <20260703141423.1723-1-lirongqing@baidu.com>
To: lirongqing <lirongqing@baidu.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, elibr@mellanox.com,
 roid@mellanox.com, eli@mellanox.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22941-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:elibr@mellanox.com,m:roid@mellanox.com,m:eli@mellanox.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42A0B72F0CE

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 3 Jul 2026 22:14:23 +0800 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> mlx5_tun_entropy_refcount_inc() counts both VXLAN and L2-to-L3
> tunnel reformat entries as entropy-enabling users. The matching
> decrement path only handled VXLAN, leaving L2-to-L3 tunnel entries
> counted after release.
> 
> [...]

Here is the summary with links:
  - [RESEND] net/mlx5: Fix L3 tunnel entropy refcount leak
    https://git.kernel.org/netdev/net/c/c914307e1d41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



