Return-Path: <linux-rdma+bounces-22266-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jVmYHh2CMGrGTwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22266-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 00:52:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB99768A7CA
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 00:52:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MebXbE87;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22266-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22266-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2533F3105E43
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5F3BAD94;
	Mon, 15 Jun 2026 22:50:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B43B7B93;
	Mon, 15 Jun 2026 22:50:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563848; cv=none; b=qn6kH3Ld9E/cp1KSfg1mGaRwj86o6qWYmiZ492rrFgit/38Cuck63AJZ/ENJismeXizQBGG8dOf8qXbFJEyktOEK6ntcgr1c6iFcUjaBT5C1/HhP5P+Z6GcQZYKQVr11XjyUtX6YohHeCJvLqPn60L7/uqxfHyGBzHPXB/6rq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563848; c=relaxed/simple;
	bh=p8FLiU4qRighnOypaY7NR0/5NBWZCGXJwwEpHiUBIyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BFXNN+AvVopM5/MieTUr8X1KwHk8Xcry4YzS2xIWaxskxy/kXbTrCFJYJLm1Drh3ohMzjppISc/26jHjj7ivbd22UFF1YFZaw6X07XQMcvDE1HTITTIvalI/nuUoyAWO+uMPtc93Tx+IXUFYj/M3xMH8gdSuOvrvY3JnVaY1Cjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MebXbE87; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580141F00A3D;
	Mon, 15 Jun 2026 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563847;
	bh=Vs2DnrZ4H4SkTYrCUzIC5NmYMt6Apu2bz64Tjns+tSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MebXbE87MEk5ItJdzYYfzIbDDsEn+JTSQrmmPehb6bQj4VXdHv2h/jv3xfrIK5JyB
	 oF2U8SL1GFQPm+tw6C/ZoYKI50efC5OBTmS84nHDhnOY1eR4G1lPbuyFb2FIYySJT1
	 ra7FNn067TxCKYTKPfQiVLLPhaiO675W7ut5SLyvzLLS41fjoxCCcuvf2/mEYzhM0U
	 UxXpunDZykv4kupWz0bD2krEnwlQcgcu67j1r+G+nBzThlg8xMFhBfRd53eyGle+q7
	 HLRqXZJC0sR4I4lv92xNAkLCOGqwR/gTu4Oylk2hFeG6b4F/AYDDBrbhjd1AMUHLdd
	 HezXjC8Cnv93A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938983839A08;
	Mon, 15 Jun 2026 22:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx5: HWS: correct CONFIG_MLX5_HW_STEERING macro name
 in
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156384213.325968.5723018336061896610.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 22:50:42 +0000
References: <20260613225904.140791-1-enelsonmoore@gmail.com>
In-Reply-To: <20260613225904.140791-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22266-lists,linux-rdma=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB99768A7CA

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 15:59:00 -0700 you wrote:
> A comment in
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
> incorrectly refers to CONFIG_MLX5_HWS_STEERING instead of
> CONFIG_MLX5_HW_STEERING. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> [...]

Here is the summary with links:
  - net/mlx5: HWS: correct CONFIG_MLX5_HW_STEERING macro name in comment
    https://git.kernel.org/netdev/net-next/c/952d66f16dcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



