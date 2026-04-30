Return-Path: <linux-rdma+bounces-19761-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBFsNhWq8mm8tQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19761-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:02:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67E49BE3D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 254E03025A5E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87D222425B;
	Thu, 30 Apr 2026 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG/RnQ+4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40D1C28E;
	Thu, 30 Apr 2026 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510858; cv=none; b=mp4B5wVUTNhBF+6Ff7l1HJlM9Zf+ZDqPVx5t6bzSqq6vYwNwKoGp3TTdMGSH0FQQ4ybP+v0N6mgs66IaiiN9YBfvza5iUXenVwYsMGCGUCO+zyHeAJXRz5/RzMijXRV7FZMcPokox9HNWdpoNf1Zi3jTz7HTaUP7Zm47k04Gu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510858; c=relaxed/simple;
	bh=mecOdSgVKPkbWXaWPf66CrtxpWFpJtUvn40eTyEgAQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lCTm6nLwk/OZ5Nupwdr/lVhzEyHhJwSY4z38/OY2un9bIIUHJ1UKnBE56ckzAQS2LVApZdmGFkReT24/1efhtf+D5jjlvcOyxiubz7FubcPkYgKp5lNzBvi8aVfbJBjHysPq+KBpnLy0iD/M+m3ZzEOz0dnqYe7/hj9B/9gIspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG/RnQ+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D5C19425;
	Thu, 30 Apr 2026 01:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510858;
	bh=mecOdSgVKPkbWXaWPf66CrtxpWFpJtUvn40eTyEgAQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FG/RnQ+49fB+v8h8056qWGA9/qQ02KyUh0+KVkmH/VUWchR5sxdhn1dx80OgD0ffA
	 r2Y0yY9C0I3ZExJxpV7beh7IaPYS5etpLpVvWXvb2tc/HGNkHqC4fYhvuX3av9X5Vp
	 mFsxwLw0HSwWKFMXC4jGbNE+69GY1/uuvRsBP/gsqM/KbN0mu86AaB9ogRqbGJCflp
	 bOkusARUPpeE01C/7/n94xtbqa09jR1+Yjlqa1Oz51UHNytsYGjOnJVYnQx0S/USN7
	 niFvp3WOwp1tPYfw64lIOLAX8RVxMjy4yBnyq07Bwhc2qY/ADBmPyqvlRs6M8Ufcjf
	 t9dDVwm/3O4CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F1E3809A33;
	Thu, 30 Apr 2026 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/3] net/mlx5: Fix E-Switch work queue
 deadlock
 with devlink lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751081355.2244169.9369329388278811671.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 01:00:13 +0000
References: <20260428051018.219093-1-tariqt@nvidia.com>
In-Reply-To: <20260428051018.219093-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com
X-Rspamd-Queue-Id: 4D67E49BE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19761-lists,linux-rdma=lfdr.de,netdevbpf];
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

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 08:10:14 +0300 you wrote:
> Hi,
> 
> See detailed description by Mark below [1].
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/3] net/mlx5: E-Switch, move work queue generation counter
    https://git.kernel.org/netdev/net-next/c/f950ddb57ce4
  - [net-next,V2,2/3] net/mlx5: E-Switch, introduce generic work queue dispatch helper
    https://git.kernel.org/netdev/net-next/c/2a110ee54e89
  - [net-next,V2,3/3] net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq
    https://git.kernel.org/netdev/net-next/c/6a92fe1956d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



