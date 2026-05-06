Return-Path: <linux-rdma+bounces-20042-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBEfBBCo+mlbRAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20042-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 04:31:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4D4D5AE8
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 04:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA39302768D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 02:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4A2C0F8C;
	Wed,  6 May 2026 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJhI8GRi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6A19DF6A;
	Wed,  6 May 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034661; cv=none; b=M2D7R9c4s82o2mo7z9/WlMH8l3LDYsQ3YUy7mShoKziKzHFkU3EUtfX+oG2qAVk85f2M5bp0IZgTa38VEfSDRwhdNtsEPhnpQ0JBnEyeusZabJBBkq8PiYyafqjSzEIGHR9EnlGBPWuKklzSBuDTlmCUJ3918J/W9nr9xLqXZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034661; c=relaxed/simple;
	bh=aRNF0MttjKGeMswGVKR1Otyfp+656r3vb961sULCtVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfSCTTv/7NF1cqHpsv1/Ief+TBLQYqeRr8YGi/Yy3tEa/tAUgJl1mr1DIqP59ijPZmkUZPKmf7lPSpk+fcUQjhjLMD4vfkhb9I3n+2NfOtojbDwagugAkQ+nOnkWiYlGH/gYhR5d5MXrvOQgnkr6DXeHsNIDQgE7BmYNjtIkHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJhI8GRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D2AC2BCB9;
	Wed,  6 May 2026 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778034660;
	bh=aRNF0MttjKGeMswGVKR1Otyfp+656r3vb961sULCtVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJhI8GRiDyN94gO0I2xDHM9Irwe/fTNVEAWX4kU97l6i/yzjdX4tSPf2NQl2VOmVB
	 q8ejkQrRlCJPYVphVx1TYPVRggFtXTSjfqsGztk9EvbWp7HbaDQQf8BNc+Q9h7xYrh
	 SADNwhOiZxK5avBB5iX4Co9u5EsrM2toJ7+LXicrpogg4rK6LrF/l7AsXpIBR/0Q7+
	 fU6n9+xEGz5TAaEVoTCa8FnqySkIHrouK+Pr+7XUtnbXI8Zm16Zr+C/VXKB6ie6xD2
	 ltCkOcdrkcCyBkKd094PrSW0aQyy4ywSSTYHwZgtBK1qqpwvjFI2P6MBRRRIzngpvU
	 WLOl+dX+lewkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BB93930780;
	Wed,  6 May 2026 02:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V5 0/4] net/mlx5: Fixes for Socket-Direct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803461080.2357425.13693913770775968233.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 02:30:10 +0000
References: <20260504180206.268568-1-tariqt@nvidia.com>
In-Reply-To: <20260504180206.268568-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, shayd@nvidia.com, horms@kernel.org,
 phaddad@nvidia.com, parav@nvidia.com, kees@kernel.org, gal@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, dtatulea@nvidia.com
X-Rspamd-Queue-Id: 5FF4D4D5AE8
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
	TAGGED_FROM(0.00)[bounces-20042-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 May 2026 21:02:02 +0300 you wrote:
> Hi,
> 
> This series fixes several race conditions and bugs in the mlx5
> Socket-Direct (SD) single netdev flow.
> 
> Patch 1 serializes mlx5_sd_init()/mlx5_sd_cleanup() with
> mlx5_devcom_comp_lock() and tracks the SD group state on the primary
> device, preventing concurrent or duplicate bring-up/tear-down.
> 
> [...]

Here is the summary with links:
  - [net,V5,1/4] net/mlx5: SD: Serialize init/cleanup
    https://git.kernel.org/netdev/net/c/3abcedfdfd31
  - [net,V5,2/4] net/mlx5: SD, Keep multi-pf debugfs entries on primary
    https://git.kernel.org/netdev/net/c/05217e4ffbb2
  - [net,V5,3/4] net/mlx5e: SD, Fix missing cleanup on probe error
    https://git.kernel.org/netdev/net/c/3564222cfdde
  - [net,V5,4/4] net/mlx5e: SD, Fix race condition in secondary device probe/remove
    https://git.kernel.org/netdev/net/c/d466ddda5500

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



