Return-Path: <linux-rdma+bounces-22675-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zCYtIjYaRmoqKAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22675-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 09:58:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6366F4811
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 09:58:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H0ksU1lx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22675-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22675-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DC7E307C807
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 07:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C443A9DB2;
	Thu,  2 Jul 2026 07:40:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D139F19F;
	Thu,  2 Jul 2026 07:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978024; cv=none; b=J9PROXtnrZmZ07cD1Vf1FhUQGPh8twdWkp1fAnLiR3VToJUo7C7bIgs6bz9C44KYhzOvpE9Uh9/c/z++axCC1pz3qw88xYLI9NKv7I9vh+rj6VhM61MKmqiQJF54UpUIy1nSy70V55zUq5H/SAYIDqLYA2BluIeXoRQuQlSLoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978024; c=relaxed/simple;
	bh=OLBo26MPL86PDfA7e8HH+TgVpcot15s/Og4apy0rSyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PFQ37MpBkBDJRK58YAC09W8rqbgJmauxI+C+woqW6BJLfmXjgVokd42/MY9IqmkXJkVKEyy5hoUAXX2Cd9koGxHstTrx3LCJbTZ6V5cTGEWvGU+HydkBKSEZmcq9a0FUs2ADHnbVEFHK+0LRtSpEc2d64ASE4vUTm5+zbRCs+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0ksU1lx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FDE1F000E9;
	Thu,  2 Jul 2026 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782978023;
	bh=BjkaoU2WgrIbo3FTqjcKnmkv2r6llBu494GSVwWkcT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H0ksU1lxL6wt93PRPsQmi+u3tzWzC9XX65vRDVw9IqARueMuyfPm5Z/NTUCCtOuES
	 vTuz5MjRi/EiiO1vbR3DM16qIBavyPpuxfp9D4IDcpv64qAxgTWOPsX9GAuSu4deCs
	 Hl0hm49oluvVtlAl5SjD8IYaRfkkIy04rwsm2ey4UVIrooY/oCrS+v4bYUYx/gJbW3
	 Uff77FrWsSwRX3VUN1S7NFLlNqxhRvxF8v9KgFH6QuA4h0dPn5YXB1WkTrOe0FsM05
	 lScNeR8TtQKb6nQF+Abg2sGkpzsfB0Q27C+WCCtMfqQC+jZE/RuWAgoSEV3pvLNKua
	 hAX0Rqtx3449A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 573BA39263BD;
	Thu,  2 Jul 2026 07:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: HWS,
 fix matcher leak on resize target setup failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178297800589.1493055.1247899710790412138.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 07:40:05 +0000
References: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kliteyn@nvidia.com, vdogaru@nvidia.com,
 horms@kernel.org, kees@kernel.org, stable@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22675-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kliteyn@nvidia.com,m:vdogaru@nvidia.com,m:horms@kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA6366F4811

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jun 2026 14:40:49 +0800 you wrote:
> hws_bwc_matcher_move() allocates a replacement matcher before setting it
> as the resize target. If mlx5hws_matcher_resize_set_target() fails, the
> replacement matcher is not attached anywhere and is leaked.
> 
> Fix the leak by destroying the replacement matcher before returning from
> the resize-target failure path.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: HWS, fix matcher leak on resize target setup failure
    https://git.kernel.org/netdev/net/c/bb09d0e64eca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



