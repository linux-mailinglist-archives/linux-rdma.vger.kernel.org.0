Return-Path: <linux-rdma+bounces-21797-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A4USMwy6IWqyMgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21797-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 19:46:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F59E64261F
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 19:46:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OBgNJV1Z;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21797-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21797-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D0C302E78F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 17:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC34C6F0C;
	Thu,  4 Jun 2026 17:40:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59E3451CD;
	Thu,  4 Jun 2026 17:40:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594806; cv=none; b=RC3JcLeyNvO2tusTJaKMygdWSIkIHLPFJ5m5vwUUX7yF7iwvjb1AgRv79uNSJ4j80jpME+R2VVJ7th/cF5WrWsgAflfdX5lI/luhP4WvMMY+d5Ugd7WtzWRQ8GsHpcRf0qhCL1av/qv/vFeg9+6OUG+rj0D7VWj8IZg8LG8tsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594806; c=relaxed/simple;
	bh=M5FurZYYr+ogmJLYkiS4M2lE3hyB69JNV+lrZQXa6WQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rGsy0yTXzpMHaW6s9vMBq0nCRSuHcbk1O2CLOY6raFFpcBn2qxmxXFNaVyGXcNs/lxo5DNZcIlR5dQEjUJQWJ1YJUTG+tUx5oh67ZbMdsiJqoNTYA96SY7oe70CqwPBJmVTr90qODcL3XTqxNqxa2+RWrLIuQetxo4KFDoXxI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBgNJV1Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424411F00893;
	Thu,  4 Jun 2026 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594805;
	bh=6ZsWQZN+ya+YmuE6k50YPowXp+HwvybYQ1casUTdCYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OBgNJV1Zg1zACLMEExuVZzICplBHAGQEcUN2/VHDMBs44d6sUfea8WqTC27IEgccU
	 X9RsYuJIp8HHz58UWiFlKjaYcodASpxgfKRVllvu0IVj8ctpvpm4iQaNDq502PsqTC
	 jm+PtHJfkl9Ti7ymvZQvrX8nEnZkB9oGjUIgTadG6YLiqfnqjCgsEtoLD/i2DAYHne
	 d5dlpIrz+1N5UQeyIi2f8jM05sjtiw627J7H0Pzd27fj/gn6MKBPe4l+mM/njF9S2S
	 EM+FFhm3ICQzWBHCbLq2HbVEDyhGXZxje+5B3F8sorz4yfgW7l1dH4JDjTyFFe1qs8
	 5dxUfdSdWJgMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B143930A14;
	Thu,  4 Jun 2026 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx5: convert miss_list allocation to
 kvmalloc_array()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059480614.2957776.16626630359491214401.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 17:40:06 +0000
References: <20260601193758.626537-1-william@theesfeld.net>
In-Reply-To: <20260601193758.626537-1-william@theesfeld.net>
To: William Theesfeld <william@theesfeld.net>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-21797-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:william@theesfeld.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F59E64261F

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 15:37:58 -0400 you wrote:
> dr_icm_buddy_init_ste_cache() allocates the per-buddy miss_list using
> the open-coded kvmalloc(n * sizeof(*p), ...) form.  The neighbouring
> allocations in the same function already use the kvcalloc()/
> kvzalloc_objs() forms; switch this last one to kvmalloc_array() for
> consistency and for the size_mul overflow check that kvmalloc_array()
> performs.
> 
> [...]

Here is the summary with links:
  - net/mlx5: convert miss_list allocation to kvmalloc_array()
    https://git.kernel.org/netdev/net-next/c/93790c374b9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



