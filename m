Return-Path: <linux-rdma+bounces-20747-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPQXDvh5BmqFkAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20747-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 03:42:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E908C5487B9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 03:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCF0E30684D2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DECD37F015;
	Fri, 15 May 2026 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvPGwMZI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF837F72D;
	Fri, 15 May 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809265; cv=none; b=iHQjGKqZtq93/+r0OAHfR8yfOwRZ083X9s1PVFluBDYBD5Y9WtqLQJBBUobQ1Rik7D45CFp4RCpJWPYNddhm/LlD+ZYPDRNbryymE7KzJnPRt9spUQutymgqIrhGwFBaQiIwCrOXLV2KRGaSuEcHjIm4D7fCm05OA+BtLPtxMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809265; c=relaxed/simple;
	bh=oEUaMmvcADAdYPlMPQctBp65BNDzmtVOpgPDJ3CMfxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T6VJjniB1Gj3bno1PTDwDy5w0M16mUjxOwaLJ5pyHPw4rp0Gh91S2HENAwxRx1Xf6JlMdL6ophOiHEpB1/26V0JfYu3h72NH0Cc59MuRjdfTigNWDN/h4AEvZADgG33ZVf7EnLxwEiNNSV/e/9OhwH6XXfjVx2kH9xCud8ZlOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvPGwMZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC856C2BCB3;
	Fri, 15 May 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809264;
	bh=oEUaMmvcADAdYPlMPQctBp65BNDzmtVOpgPDJ3CMfxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fvPGwMZI5vO39diQXILPnwHSj2PIIupSG8bc8tjmeN5C/MC9CsBPGjU6yHggp5IkN
	 8c5dRgy8gzdE2gMsiNKW6l5YxEbkPIgfM/cDG5TmDE6we8TjbqwjLJP5cMGy9uVvx/
	 fdw29KqoHW7h0IZcpO2lFsc1Lf8rqHw+7W7tqfMLKWH+rRQpHskOJToH+Tp5/XiXFP
	 ynpV3FpQ+wQ53f/er6VrECk31yNBD+ONSXV4F5MUvUJ2A2pfa/u6pYJdHeSN/9l/Oy
	 BcBcIWEBN0Zk+ZIJmvCbcQg2eQG3r+QtNxHTv4+oIhFIJ8ETDDVtHYkn92JYugJIE7
	 PDnqnQHTqz7Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDE739E4DB8;
	Fri, 15 May 2026 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Do not restore destination-less TC rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880920904.156468.11629126127893686276.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:40:09 +0000
References: <20260513063302.333761-1-tariqt@nvidia.com>
In-Reply-To: <20260513063302.333761-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, cratiu@nvidia.com, jmassar@nvidia.com,
 jianbol@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com
X-Rspamd-Queue-Id: E908C5487B9
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
	TAGGED_FROM(0.00)[bounces-20747-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 09:33:02 +0300 you wrote:
> From: Jeroen Massar <jmassar@nvidia.com>
> 
> After IPsec policy/state TX rules are added, any TC flow rule, which
> forwards packets to uplink, is modified to forward to IPsec TX tables.
> As these tables are destroyed dynamically, whenever there is no
> reference to them, the destinations of this kind of rules must be
> restored to uplink, unless there is no destination for that rule.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Do not restore destination-less TC rules
    https://git.kernel.org/netdev/net/c/8d0a5af8b1ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



