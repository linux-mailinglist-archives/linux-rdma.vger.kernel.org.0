Return-Path: <linux-rdma+bounces-19860-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKSgCkBB9mlYTQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19860-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 20:24:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBB64B3326
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 20:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDCDE303A91B
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F2388397;
	Sat,  2 May 2026 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUHBbgCh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA73876A9;
	Sat,  2 May 2026 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777746078; cv=none; b=Xo3MaxVhtaOryVKQpgRXaEkrek/WJXDglMHbgHQmWu+q0riBkKgGaIRyV6P/SG9ayHvO2RjzCZDBGGYGy4fKi/7blmXBurjxYjtABS+rMRMT+0tR0Zv2xU9L9LYg3dFEZX+PpHCIFssIS/Y2bchTndAEBZYaPNlO6c/C1T42Mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777746078; c=relaxed/simple;
	bh=bVOZK9Mo21hpEl651U46SE5lBm9+7itxGfP1kgqIbgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vzx08ulIkGoj1etuj4AfcdhLXUDeNLALJqnWtulzvtZYhb9Kcvh6f+zJyIIgehdmTRTqDbeqpw86T5b8NHRhAjBWqWTTuC0dmcL4LQYv3H4Gt5bjhmN9ngVMJNBuQR898kw1pzE9fblEg6bxcbd87kZVyRKsMR0uRqEGWEztrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUHBbgCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74443C19425;
	Sat,  2 May 2026 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777746078;
	bh=bVOZK9Mo21hpEl651U46SE5lBm9+7itxGfP1kgqIbgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUHBbgChEGnAOufuqgODrVGZtBKeyW4XwFfxktggUdY4UiBBd94C/l628auOZIDmT
	 tW3YgeQv7ti8TALdyj2+dvy+1vskB9FskRxYHLExKeS8ZDslivF8oWKw/4QONkEBGM
	 Ua+UQmfEKkj2JmBg9F0fh7wI3aQ6FJBdPO+1TUbycy3fJeXu/UiyjC+IoGGrD2f8ic
	 qbd7Cz/83peg2vRDKBRNrID2SzZQLqaGqXiCycpFR2evGTy2BgWZk+iXPrht3zGWqZ
	 hT1sMIFdJtCWw085cv7NnzKS1cm5zWWJ4IhcIzxhuK9TIZWjLN/7vF2pD2n7KrOhXh
	 UthkD/F4aTNuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D0A380CEFF;
	Sat,  2 May 2026 18:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: Add vhca_id_type support to IPsec
 alias
 creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774603055.3903048.10928743349173579298.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 18:20:30 +0000
References: <20260430061958.225245-1-tariqt@nvidia.com>
In-Reply-To: <20260430061958.225245-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, phaddad@nvidia.com, jianbol@nvidia.com,
 kees@kernel.org, dtatulea@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 leonro@nvidia.com
X-Rspamd-Queue-Id: BBBB64B3326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19860-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 09:19:58 +0300 you wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> When creating an alias FT for MPV IPsec, if alias creation with
> sw_vhca_id is supported use it instead of using the hw_vhca_id.
> 
> This in turn allows IPsec to work properly after live migration,
> in case a VF was live migrated and his hw_vhca_id changed due to
> migration which can happen if you migrate to a VF with a different index
> than yours, IPsec would fail to start post migration, this patch
> resolves the issue by using sw_vhca_id instead which doesn't change post
> migration.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Add vhca_id_type support to IPsec alias creation
    https://git.kernel.org/netdev/net-next/c/c8300af614b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



