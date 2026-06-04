Return-Path: <linux-rdma+bounces-21716-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PFO/KIzRIGqt8AAAu9opvQ
	(envelope-from <linux-rdma+bounces-21716-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:14:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4038763C2A6
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:14:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="DYS/K6FX";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21716-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21716-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE6FC300D1FF
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43974239E6C;
	Thu,  4 Jun 2026 01:14:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB447261C;
	Thu,  4 Jun 2026 01:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535688; cv=none; b=NtzEDyuupPG9zR/d3LPjC7fApKw4G/bzFTVKnFgBKXFuGbav3xQzlPI7lyRRt6Rz0Vpnd35WpqtE4fvECEPb3pa56Etu0wQByvKHwNo+QLtcZSt2IefhBUeFIOaSyE3PWgdlf3N/kneBZWKwEM6RS1maNTtRrFV0qFj6c8fec6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535688; c=relaxed/simple;
	bh=H92A5F3Y4PPwZrikNlD0rPmhbJ71THMxDtNMzOKAPjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jJOKvvzMjOfEQKW7jOlJm1QF7jdnWAjCS6QrNnkOYmPXUp887SI4cxwB2OtCsT0HNEOX26gdBA9JR0qnbqLcFbzBAnvOgtc5qTc9xnGbdvPjbtxOfre7uMS2uPEWYd7M8vy8G7SFTMcEiplXCorZt/790tRjPF788jevPqyV6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYS/K6FX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F71F00893;
	Thu,  4 Jun 2026 01:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535687;
	bh=kQm3UOnV22+XowSsIiRdNkGTe1tnxdkGrpnta/e2VwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DYS/K6FXRmdGtD98dEiwVzdD8RkQnA+qgD0+MU7ZXTouQ45Aypb1YQ4nf3drsYgnQ
	 tHYHq21Y9WQDTfAJ8YrKgkpcKwwqUpWt+vH3CwzzSEWkxFWDHBa7PK2rBgY7Doms2x
	 vjqUS2AtfMj44BwKA0DGkfg9nDjbv3Bx+sr8PSLQx8HVlL3abdA9x/Dv/Z6Z5dSv+N
	 VnoIb9horDy3UFtSjS05Z4rjgWUK/LUyxt79/WE//8bAEWxX/nqdIuwwelPbXadFYP
	 msFRq8JJsuHdBkspXnFxO5bpJDmvinwyIH4Nr19+VkcqifolBB4LoJzQUZy/ARrTkx
	 32xphJbqf8rJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD039308DD;
	Thu,  4 Jun 2026 01:14:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/13] net/mlx5: Add switchdev mode support
 for
 Socket Direct single netdev, part 1/2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053568788.2042071.16264807430423613256.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 01:14:47 +0000
References: <20260531113954.395443-1-tariqt@nvidia.com>
In-Reply-To: <20260531113954.395443-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, noren@nvidia.com, ychemla@nvidia.com,
 shayd@nvidia.com, ohartoov@nvidia.com, edwards@nvidia.com, horms@kernel.org,
 msanalla@nvidia.com, parav@nvidia.com, kees@kernel.org, phaddad@nvidia.com,
 moshe@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, gal@nvidia.com, jacob.e.keller@intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21716-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:ychemla@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:phaddad@nvidia.com,m:moshe@nvidia.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4038763C2A6

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 May 2026 14:39:40 +0300 you wrote:
> Hi,
> 
> This series enables Socket Direct single netdev to operate in switchdev
> mode with shared FDB. See detailed feature description by Shay below.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/13] net/mlx5: LAG, factor out shared FDB code into dedicated file
    https://git.kernel.org/netdev/net-next/c/cf6c4c0508a9
  - [net-next,V2,02/13] net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy transition
    https://git.kernel.org/netdev/net-next/c/b48b6308dfae
  - [net-next,V2,03/13] net/mlx5: E-Switch, move devcom init from TC to eswitch layer
    https://git.kernel.org/netdev/net-next/c/2b1ba02c379f
  - [net-next,V2,04/13] net/mlx5: LAG, replace peer count check with direct peer lookup
    https://git.kernel.org/netdev/net-next/c/2ca494dad967
  - [net-next,V2,05/13] net/mlx5: LAG, prepare for SD device integration
    https://git.kernel.org/netdev/net-next/c/14a47f55c8de
  - [net-next,V2,06/13] net/mlx5: LAG, extend shared FDB API with group_id filter
    https://git.kernel.org/netdev/net-next/c/3cbce590b7f2
  - [net-next,V2,07/13] net/mlx5: SD, introduce Socket Direct LAG
    https://git.kernel.org/netdev/net-next/c/3c103110835d
  - [net-next,V2,08/13] net/mlx5: LAG, block RoCE and VF LAG for SD devices
    https://git.kernel.org/netdev/net-next/c/8b9fffb6d38b
  - [net-next,V2,09/13] net/mlx5: LAG, block multipath LAG for SD devices
    https://git.kernel.org/netdev/net-next/c/c3933a7a7f64
  - [net-next,V2,10/13] net/mlx5: SD, keep netdev resources on same PF in switchdev mode
    https://git.kernel.org/netdev/net-next/c/8698ddb07f87
  - [net-next,V2,11/13] net/mlx5e: TC, track peer flow slots with bitmap
    https://git.kernel.org/netdev/net-next/c/786b1d7486b0
  - [net-next,V2,12/13] net/mlx5e: TC, enable steering for SD LAG
    https://git.kernel.org/netdev/net-next/c/9f062b931daa
  - [net-next,V2,13/13] net/mlx5e: Verify unique vhca_id count instead of range
    https://git.kernel.org/netdev/net-next/c/0b1c4495aa00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



