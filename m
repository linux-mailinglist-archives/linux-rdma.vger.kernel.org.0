Return-Path: <linux-rdma+bounces-21988-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nLEsNB9FJ2q1uAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21988-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 00:41:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C41DB65B064
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 00:41:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZDR4CQ3D;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21988-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21988-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10EE7302525D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9483B5302;
	Mon,  8 Jun 2026 22:40:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843B3B42C4;
	Mon,  8 Jun 2026 22:40:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958430; cv=none; b=Y5LVktoGOqlxJbWv3eRtnmZ1W3gX8eHsI5JJYi1zXxuZWKDuod6MBn3Uup1qfD2RMeJH5+8ES2yP1RmkNklJhyyBB56COZ2nh6M/Aw59yDt1ED9yH+Cv+C4fpNkfdshUG+fCiqRnwLX/jTlZpcLLs3/KXQVLf97uxottQtf2O3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958430; c=relaxed/simple;
	bh=WfnZGuuHbXyO1yTdOPaF6vPnp4GT9f4eEr3nub+n/Eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BdV5PI+l1P6BgM3fCSpCt5Fy+albXFfODpgZWsL4UmgpKRHmi34zg5SJPQ9UkeAuKRf4h5uS/oxbAfoF8KQGzZvMSy87AewIujRpN+e05xKqhAwgRpKyBv+d5jCV2wF5yi3XNKEL4zVrm110Wn0dWqebwsJMSRSw8v5ByxX99R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDR4CQ3D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255BC1F00898;
	Mon,  8 Jun 2026 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780958429;
	bh=fQfQFv6/WzGMUKOzEK25pov0DPtrTdODou4at+fFukk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZDR4CQ3DINMCN8OaRQCt1dnwMA6I8KxAS4mThx6V+iEW+kxs878SGpBh8IeB2D1Lr
	 ewPb4KMmAgkYgrNPZoOuHzqXKEfLiDmpqXbtzZjHfeTaAhUO9DrU4TB1hggdytPiUG
	 28AYWML6cttKkrZFFDGxknTI9T2+WKr4OzOATxoudda0CKCsrkhUUdAqGXuaXA/NJl
	 R+5Wmleo1h+Py9cN+l/MCTYX5/Fr8xqhP1Z9VmyXCrKXN6/1XdcbJCFmjGhJ3X2Npt
	 dFjelqd5QvwIS74Iursx6znZDjzDKz/WGtRYc36LDIbHN9pIWSA6faN0fGNAOwOv1P
	 KIMdub5WRUTvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B53812FD9;
	Mon,  8 Jun 2026 22:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2026-06-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178095842764.1698449.11301804131440980167.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 22:40:27 +0000
References: <20260607111157.470978-1-tariqt@nvidia.com>
In-Reply-To: <20260607111157.470978-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, moshe@nvidia.com, shayd@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21988-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C41DB65B064

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 7 Jun 2026 14:11:57 +0300 you wrote:
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
  - [pull-request] mlx5-next updates 2026-06-07
    https://git.kernel.org/netdev/net-next/c/199f6b9a1603

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



