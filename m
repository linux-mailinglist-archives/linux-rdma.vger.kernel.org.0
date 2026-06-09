Return-Path: <linux-rdma+bounces-21996-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zgq2HlN0J2r/xAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21996-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 04:02:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50065BCA1
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 04:02:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gyHJVhyu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21996-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21996-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F785304EA30
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 02:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C735F603;
	Tue,  9 Jun 2026 02:00:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CAD1F8691;
	Tue,  9 Jun 2026 02:00:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970423; cv=none; b=A7VtfqrKYxChTgTE4zcFxvty0qsuP1R8OcUEBqvb+PbgIJj0SjCnFotMn32r7sZiq1oEXFdb3mp550T6yyKHrdbOdDQczCa5TVJ1ayENLQopZ1vcHwboqO+Z9s1rvXH6wR/G1OEHPMlbHEksf7y/7ZW7fsrfdljM0WzmliNsHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970423; c=relaxed/simple;
	bh=kBBdcDPOAxnKxwhQjN7dhWhgmG66vNYEZKLWNIbckPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GxganCIbOy0R4fOOtxoJpmZCCScYyFnmsugrfN68EY0uzE+uVQBf08rXWWiuDmz4nSVjDS8nQ91xUSwfMD6Wb42BitBveu7UKJv4lDlT5Mm3hr7EEQ5VA1A6XelNnNdnIMTHJBVpRG4wlA/IU3xNyorWgpxqx7TikO2vwvO7734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyHJVhyu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FBB1F00893;
	Tue,  9 Jun 2026 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970418;
	bh=K9W85i42jxtg/kZRFaScAT9aitV7oNCdTvvtl9/8348=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gyHJVhyu2KUpR4MAhu5YL44g7jK4em4DujnUBpTu1IVZLuvoiNcAUki6KiyRBjkoc
	 /md0sGH9slsoz5Pnip9qR/0Hcyeg5TvBSVsUCKvD1wz6OAT7fHf3vtH7059o9rdEhK
	 S8d6TaZ0Rt/f+1CC7SrxOzOZMuC+6VSgA1m1EWm2o8+6rGKkK/kI5RgCDNsmCvJY7q
	 di3dhjMIGfMt/TJT5aPyN1RxShHwQuidk9RXb2o8EQgU46kfpnrLE7D4C7OmvfoN5E
	 X0Odt/5JcAhmHxB/3eBGz1lakQKHmW9684v2mZXk5htIVEr+cWBFmaIN+Ls5g6OqV2
	 1efT/55QC141A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568393822D43;
	Tue,  9 Jun 2026 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net/mlx5: Simplify cpumask operations in
 comp_irq_request_sf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097041689.1753037.12270781778464508422.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:00:16 +0000
References: <20260605101756.91275-1-fushuai.wang@linux.dev>
In-Reply-To: <20260605101756.91275-1-fushuai.wang@linux.dev>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shayd@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangfushuai@baidu.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21996-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shayd@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC50065BCA1

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 18:17:56 +0800 you wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Combine cpumask_copy() and cpumask_andnot() into a single
> cpumask_andnot() since the function can take cpu_online_mask
> directly as the source.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
    https://git.kernel.org/netdev/net-next/c/32fbe56b3f8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



