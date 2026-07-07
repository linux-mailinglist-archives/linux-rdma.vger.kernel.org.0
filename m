Return-Path: <linux-rdma+bounces-22814-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aLwoBPLKTGprpwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22814-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 11:46:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8335A719F16
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 11:46:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=maIQV6fr;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22814-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22814-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06DA1305D82F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB13B5E07;
	Tue,  7 Jul 2026 09:40:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDC23BD1D;
	Tue,  7 Jul 2026 09:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417248; cv=none; b=SsFPUhuyIhXXXRMjR+Qtq0m4lItGvs9j9go376fcorEPD4dj1zccHdgA8X3UhSOOOyVqAcHprZLuxQ1BNbKbHgGintgvyEuzcpe2ELeXY0cjuezgwFUKmcZEiaAktNg0a959R1pxSUXPhQWeNFT3/HGpt2mH5Hoqs0Fq4pxvXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417248; c=relaxed/simple;
	bh=2SvJG9DL3UqCvuRg7Vo6qhQ4H7IzR1naPKn5y4+0hpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UZg3avxRiUeNs4QYADgLutU0pUM6Z3xULRodJ6oHA+ds7L6M6Ne5QN89ut8aT6WVDfnkmuLVafVkBcpfOwRjXwMwmO6DAdR93+IH8Akdigt/4RkPGM8VC9CD9Qjf+G4mmgPMNwbUFGQGfuY86KaN/uzpEoLRloLQXSMRhlzE1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maIQV6fr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8761F000E9;
	Tue,  7 Jul 2026 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783417247;
	bh=6uJPozj/uhbrq91wleQ/hPHYt4I/QFVwHZxnDm65VnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=maIQV6frxWzq57q2+mzWiIBsx546dKVfAEfuRxFY3qTAYTBdavS1NcqcIlgKNF7fl
	 DPhrbrl6/3XvFUDXQ+qQd9yDqZYra3fHxiIVJdd6jKJl5J8E8YPSsypeZitq0lu+Ni
	 jEDtfFnua+72m+Pena7SLoubtroRQFPrX/4UQsyaOEPjopE7RcVi8BbfTqN0SBmApH
	 hqog+vLCxpLf1DsQA2lAvAolJtd7L2WHCEh64aV75WgOzVb0p0AQ33FO0W4qE9PBYm
	 fvf8K9SFL9LpHZ6AEpaQfqIzpIv6ccJHLEyfux4ZJ3DXSDuSSGcbKccvtZJnFI6Ykd
	 8yB3eclpGVDZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CB03925473;
	Tue,  7 Jul 2026 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V10 00/14] devlink and mlx5: Support
 cross-function
 rate scheduling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341722764.1458887.13873598911208666533.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 09:40:27 +0000
References: <20260701073254.754518-1-tariqt@nvidia.com>
In-Reply-To: <20260701073254.754518-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ajayachandra@nvidia.com, bobbyeshleman@meta.com, cjubran@nvidia.com,
 cratiu@nvidia.com, daniel@iogearbox.net, danielj@nvidia.com,
 daniel.zahka@gmail.com, dw@davidwei.uk, donald.hunter@gmail.com,
 dtatulea@nvidia.com, jiri@nvidia.com, jiri@resnulli.us, joe@dama.to,
 corbet@lwn.net, kees@kernel.org, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org, mbloch@nvidia.com, moshe@nvidia.com,
 ohartoov@nvidia.com, parav@nvidia.com, petrm@nvidia.com,
 rkannoth@marvell.com, saeedm@nvidia.com, shshitrit@nvidia.com,
 shayd@nvidia.com, shuah@kernel.org, skhan@linuxfoundation.org,
 horms@kernel.org, sdf@fomichev.me, willemb@google.com, gal@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,marvell.com,linuxfoundation.org,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22814-lists,linux-rdma=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8335A719F16

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 1 Jul 2026 10:32:40 +0300 you wrote:
> Hi,
> 
> This series by Cosmin adds support for cross-function rate scheduling in
> devlink and mlx5.
> See detailed explanation by Cosmin below [0].
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V10,01/14] devlink: Update nested instance locking comment
    https://git.kernel.org/netdev/net-next/c/3bf4c5970ca8
  - [net-next,V10,02/14] devlink: Add a helper for getting a nested-in instance
    https://git.kernel.org/netdev/net-next/c/9f2d908cc34e
  - [net-next,V10,03/14] devlink: Migrate from info->user_ptr to info->ctx
    https://git.kernel.org/netdev/net-next/c/e48abacd6e83
  - [net-next,V10,04/14] devlink: Decouple rate storage from associated devlink object
    https://git.kernel.org/netdev/net-next/c/db078bc2b031
  - [net-next,V10,05/14] devlink: Add parent dev to devlink API
    https://git.kernel.org/netdev/net-next/c/b5f90fd4580c
  - [net-next,V10,06/14] devlink: Allow parent dev for rate-set and rate-new
    https://git.kernel.org/netdev/net-next/c/58132b6fc4a5
  - [net-next,V10,07/14] devlink: Allow rate node parents from other devlinks
    https://git.kernel.org/netdev/net-next/c/6bbd1bce3099
  - [net-next,V10,08/14] net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
    https://git.kernel.org/netdev/net-next/c/f8128b13df66
  - [net-next,V10,09/14] net/mlx5: qos: Refactor vport QoS cleanup
    https://git.kernel.org/netdev/net-next/c/89a0881183d1
  - [net-next,V10,10/14] net/mlx5: qos: Model the root node in the scheduling hierarchy
    https://git.kernel.org/netdev/net-next/c/22d32def3ced
  - [net-next,V10,11/14] net/mlx5: qos: Remove qos domains and use shd
    https://git.kernel.org/netdev/net-next/c/450ed6b182de
  - [net-next,V10,12/14] net/mlx5: qos: Support cross-device tx scheduling
    https://git.kernel.org/netdev/net-next/c/2bc38232047c
  - [net-next,V10,13/14] selftests: drv-net: Add test for cross-esw rate scheduling
    https://git.kernel.org/netdev/net-next/c/b2aa7390967e
  - [net-next,V10,14/14] net/mlx5: Document devlink rates
    https://git.kernel.org/netdev/net-next/c/403ac520e893

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



