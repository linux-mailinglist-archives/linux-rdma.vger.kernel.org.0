Return-Path: <linux-rdma+bounces-18933-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGhCIKjOzWmthgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18933-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 04:04:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E754382849
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 04:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7E5D3103B82
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324603264F6;
	Thu,  2 Apr 2026 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6fsdBxB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9229B78B;
	Thu,  2 Apr 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095234; cv=none; b=ZFqouh/P+iVjv3BhfoM5Jx5cjOrGW/UPys+z1gBUVzBCHlQzth/TfKJhV33fbtyZmPMgRCAHBFTmo9CHl+kniAWeqa1gcaMPyM8YE7GHI7wRXs8SH7zL+/5qlIpdDFVdQL8dlzfR+ou9pm0p3Bmh9pAzDZJDarUeC3iUr9gJ3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095234; c=relaxed/simple;
	bh=Xih59V3gH67vQJtzzGf2xs8Vv1KtPZUFpYZoG6RDt8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lu8Mn52JhIoCjCcpHMKY9DNMfUqZ2ptR8qkWyJppxPa6Fwz9EFR6tdq+0id3mPUrj+Kb5mPNtthXrXL39+aQIdgA8K1Wf7sWW3T8v9NyM5GFD3g83FaG321lB3R2A/80Qlgeg2a4ngYO7Wvzpw1OLhflKuhiSww62EfFUf/iXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6fsdBxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93259C4CEF7;
	Thu,  2 Apr 2026 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095233;
	bh=Xih59V3gH67vQJtzzGf2xs8Vv1KtPZUFpYZoG6RDt8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L6fsdBxBD7AhF21laWE9RFcB0mOMfSSl/SDA30Pnqj+92iRQBgxLHLkYCPpc/5r5d
	 V3H4tD2h3ZBbsN5QXrFNn/z0igdRT348pu93/oDnO5tvuq+lupLpbU4zhZ9gU/wAsb
	 Tc8TsXlDUdgkNA0aB2KG1IJCoytWj4szPlduvkOjgv1s6oTs5lIHD/EzsRJGoJPz95
	 /Ur0DWJZvI6SX6LQfHimUHIpPZO8koOyGdcGmoArg8BdM8+pmoT+eBgCH9OD/0shMv
	 IwYDxXK2jUGBrnfI3dhlu3vw9tDczyDkpxeD4WV4fOBqwq85UjOWmBFglzPL9JoUDb
	 MegeOWvhtmXPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE393808203;
	Thu,  2 Apr 2026 02:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][net-next] net/mlx5: Move command entry freeing outside of
 spinlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509521628.3948497.11808048348029175163.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:00:16 +0000
References: <20260331122604.1933-1-lirongqing@baidu.com>
In-Reply-To: <20260331122604.1933-1-lirongqing@baidu.com>
To: lirongqing <lirongqing@baidu.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18933-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E754382849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Mar 2026 08:26:04 -0400 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Move the kfree() call outside the critical section to reduce lock
> holding time. This aligns with the general principle of minimizing
> work under locks.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Move command entry freeing outside of spinlock
    https://git.kernel.org/netdev/net-next/c/2897c697b326

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



