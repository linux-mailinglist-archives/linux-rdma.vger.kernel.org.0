Return-Path: <linux-rdma+bounces-19819-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG7ZGbgL9Gk1+AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19819-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 04:11:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5464A9C0E
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 04:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D99C3009CCF
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B92DEA98;
	Fri,  1 May 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBV5MShY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2221773D;
	Fri,  1 May 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777601455; cv=none; b=UYjE0QuPCT2nJErIIIuCabEPKuspbTZV6GLH3l9v82DzLlyeOUKJo9tf4d0i98+DK5xKYgI3tdbg3OeThi3RjElX2H1+yeGhkhDyx0LINN1yVns0Bgt5ddVcyKwg0mUabmn8BtcCehSS2W+d2DBMhjdwb8M3bSIGLiEIZYSwVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777601455; c=relaxed/simple;
	bh=+eAg/hHOcREg+fqugeQ/LdJIonLrSsy8nh3GSomuT7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RAwyLx/mHsvd5xmTt2l4zVTKuevJmYv8zfjnIpLc/wXNcE7XPbhSsXphl3SwxFhtruBpO/0PPKppRlz4qQIgaTgQAyMPLi4BPgB7jnIQDSBLAV8ORKdRndA5pRKStZBDpvcItChfzOtH8Hs5R5haxoFiaB8ywyIxM/e+9fE9O+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBV5MShY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEECC2BCB3;
	Fri,  1 May 2026 02:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777601455;
	bh=+eAg/hHOcREg+fqugeQ/LdJIonLrSsy8nh3GSomuT7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KBV5MShYfMYzuwfozPtQAEzxgR65yE3eMUxXEtIeb4azZmX5vntPsMwireYJVN897
	 xlCfvoYa9NwlQMPzgOHjMV2mnevQPyjEmW7xC7G9tVPP99na1WYdWHs31r6oDtu1IG
	 YRZHQr1e7TbXspONKQMlZH+07M5kJIlcsUgGtri8NsKplzJwWKIU38gx31PQFpttC0
	 66mBbrFyWGQ11Mesi1yB+NtFanJF+GO+QejVFb1hz1g/kGkYzDSJx2pgdu/DZeMEWo
	 ERjBKnrjNVAnYTAyDgCj6/8g4MpswK+s5Fp2D/09nyNxPhEExbxUWkzdPEUl1tiNLt
	 uKXnezrIZe9nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCFA380AA63;
	Fri,  1 May 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2026-04-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177760140930.3292095.11249811193125646123.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 02:10:09 +0000
References: <20260429212747.224411-1-tariqt@nvidia.com>
In-Reply-To: <20260429212747.224411-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca,
 saeedm@nvidia.com, mbloch@nvidia.com, moshe@nvidia.com, shayd@nvidia.com,
 parav@nvidia.com, danielj@nvidia.com, kees@kernel.org,
 ajayachandra@nvidia.com, jiri@resnulli.us, ohartoov@nvidia.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com
X-Rspamd-Queue-Id: 0C5464A9C0E
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19819-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 00:27:47 +0300 you wrote:
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
  - [pull-request] mlx5-next updates 2026-04-29
    https://git.kernel.org/netdev/net-next/c/4e37987362bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



