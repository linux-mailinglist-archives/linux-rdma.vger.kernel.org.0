Return-Path: <linux-rdma+bounces-16000-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAceOFWgdmmOTAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16000-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 23:59:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F86F83053
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 23:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABE9A301E9A5
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB631B108;
	Sun, 25 Jan 2026 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCEKjFin"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD930FC36;
	Sun, 25 Jan 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381413; cv=none; b=UwOiHX5BexhUXl+GQKB4j34Ic84fUj7z83kfeTEyTf4zt11spJzQWILcrKDF26WX+E1VuS5t2dHVqupSo8UYVjRQfu1r89V28fR1rxFBWL1Kvr6+ukg8X0un7PaS0UQsuDK+JEawHsHWMzKzFdaIWHFMDbxs/KyazEm1vO+6VEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381413; c=relaxed/simple;
	bh=cNmzYiKba4/WlVixkgjErlLX1dVrWHxdW72hgi1uId4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bxQJMj4QN8GMtzBSv8t/PpKjlyJpP8m7Mrx+batoJVH+mXYDiq+gFVw8nTD0yiqDRwk57ph/IZygnHqw/odG9uRY3ZtLwaekABuzyTN5QbbDA8OYsbL7R/mai1jd8y/fQuB4Ux6Xlrf9OIHUnacaJ7Pgr6rDTJ0b1n79FcDV9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCEKjFin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6B1C4CEF1;
	Sun, 25 Jan 2026 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381412;
	bh=cNmzYiKba4/WlVixkgjErlLX1dVrWHxdW72hgi1uId4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BCEKjFinQurWrgMC8Q5sE5TClA6d6znVxdIfliAEKRQ2nAu9sdKyXUy0Hgn1VZdqM
	 +r68605Q8EibXc2YrCPg4eDIiUFrpbNO/uw1UmwkV4oaQP1boGKWlYmocS1Go8Hm4D
	 xMluKJqQlBxZQyuVN4hZMYYHSZ3rDllTi40FJRZI6+6LYaM1dofszFX1KnkGkKzBLK
	 nBibj/acT9MK7SHo+e05MhznYfTf5trr/bP0tVBtk/g1p2Vh+He2oOndQLvSpwtLqS
	 dawrQdVeeGS0GKpLpi+ybwAnf3bdL99UjJ5zpbz20or/Ilf+91zjz37PXuM8bxfz10
	 eD8CPdZmbgLQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BAB23809A15;
	Sun, 25 Jan 2026 22:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938140735.4002147.442926192309734143.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 22:50:07 +0000
References: <20260123085749.1401969-1-zeng_chi911@163.com>
In-Reply-To: <20260123085749.1401969-1-zeng_chi911@163.com>
To: Zeng Chi <zeng_chi911@163.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, feliu@nvidia.com, parav@nvidia.com,
 witu@nvidia.com, ajayachandra@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, zengchi@kylinos.cn
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
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16000-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F86F83053
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 16:57:49 +0800 you wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> The function mlx5_esw_vport_vhca_id() is declared to return bool,
> but returns -EOPNOTSUPP (-45), which is an int error code. This
> causes a signedness bug as reported by smatch.
> 
> This patch fixes this smatch report:
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
> warn: signedness bug returning '(-45)'
> 
> [...]

Here is the summary with links:
  - [v3,net] net/mlx5: Fix return type mismatch in mlx5_esw_vport_vhca_id()
    https://git.kernel.org/netdev/net/c/ca12c4a155eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



