Return-Path: <linux-rdma+bounces-21257-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IORLGb66FGoiPwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21257-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 23:10:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01555CED05
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 23:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77F8430058DD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E48B382F39;
	Mon, 25 May 2026 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuV5kqM5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E93563DD;
	Mon, 25 May 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743416; cv=none; b=RnBVus4nytFeyHMifKJzXleEXDdiM7jWZ2cd7by+87neibLtjZO4Zt70m6+O19BDnKtN3XEq83ii4diUn3qqUbESRKuUGyXu/StGz5+SOtaQBeQ+P2+U9KdRKIQXZ4h2XMu30+eGGJwAHjKWcWVhaZcKE40wCrwoVuowCijpvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743416; c=relaxed/simple;
	bh=z3wY83YnJ7vyJObEV21QFr34vTxeXrGXC9u7vpxKj3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T1wQ9xOCHWy4fhHsa9HhQXDm3ggTefjx6ZiBvQAbhU9wQK8DiWOXQcBfxulY/0MhEJLWN7AKMYXaFFS92aznrvVAiigxircAfapAOC7JC2fKIyAzN6QRlKYGt2dBXMJshkZE2OSnm1Wl8vkNzMO47FVrXKUPemnkyDgt2//paA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuV5kqM5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859D81F000E9;
	Mon, 25 May 2026 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743415;
	bh=5uh8lvF59dy6GEkZyD8DYh+bApbz7m+16hj4KkJ9sRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TuV5kqM5SGQSd/6wkBejj8UC22m5W9Utq4DF4EAAbYV4IYG17uHBfwAlBuTSRZ8n+
	 HU/GndBvvmEpftw+YYoFHeGd4ThlWh+WRaM9wbsDgKbDWAcmGkQoSRdKgeoCZWXlrr
	 pXPsL+F2ZOmcesbZakW6uBUxPSY4Fj1bzBnslQfVwuwEAYD/dBELFv89pSlv+xwgi1
	 D67K6lT+Fyf9Qon0GLjzraET1i621v226bVqYC9DemzIKhaslEvqSxmqY861DH8c54
	 ps3/y7uXSl/aRIwvU4d59aifa/1yL/BO/SkknfEc6knRY6JFwE3vVR6sDxm8teQyHK
	 4aXfj/fIWZb4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56994380AA76;
	Mon, 25 May 2026 21:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] net/mlx5: Add satellite PF support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177974342189.3116972.17192014468998795064.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 21:10:21 +0000
References: <20260521110843.367329-1-tariqt@nvidia.com>
In-Reply-To: <20260521110843.367329-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, horms@kernel.org,
 ajayachandra@nvidia.com, jiri@resnulli.us, moshe@nvidia.com,
 ohartoov@nvidia.com, shayd@nvidia.com, parav@nvidia.com, danielj@nvidia.com,
 kees@kernel.org, cratiu@nvidia.com, cjubran@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21257-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B01555CED05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 14:08:31 +0300 you wrote:
> Hi,
> 
> See detailed feature description by Moshe below.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] net/mlx5: Add satellite PF vport support
    https://git.kernel.org/netdev/net-next/c/ed9671b8bd4f
  - [net-next,02/12] net/mlx5: Introduce generic helper for PF SFs info
    https://git.kernel.org/netdev/net-next/c/69978da9bb71
  - [net-next,03/12] net/mlx5: Initialize host PF host number earlier
    https://git.kernel.org/netdev/net-next/c/171b7fb59f8d
  - [net-next,04/12] net/mlx5: Initialize satellite PF SF vports
    https://git.kernel.org/netdev/net-next/c/7aed78522df2
  - [net-next,05/12] net/mlx5: Support SPF SFs in SF hardware table
    https://git.kernel.org/netdev/net-next/c/beca1cd919e0
  - [net-next,06/12] net/mlx5: Expose PF number from query_esw_functions
    https://git.kernel.org/netdev/net-next/c/0b43d2b76cc2
  - [net-next,07/12] net/mlx5: Map SF controller to pfnum for satellite PFs
    https://git.kernel.org/netdev/net-next/c/90a6aabb74a4
  - [net-next,08/12] net/mlx5: Register devlink ports for satellite PFs
    https://git.kernel.org/netdev/net-next/c/e020a7067295
  - [net-next,09/12] net/mlx5: Register SF resource on satellite PF ports
    https://git.kernel.org/netdev/net-next/c/ac338d8011c0
  - [net-next,10/12] net/mlx5: Support state get/set for satellite PF ports
    https://git.kernel.org/netdev/net-next/c/425ac0e7a6a0
  - [net-next,11/12] net/mlx5: Add FDB peer miss rules for satellite PFs
    https://git.kernel.org/netdev/net-next/c/652be53b37d8
  - [net-next,12/12] net/mlx5: Add SPF function type for page management
    https://git.kernel.org/netdev/net-next/c/ea0dada7194e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



