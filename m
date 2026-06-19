Return-Path: <linux-rdma+bounces-22368-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3cd1FC6eNGoNdAYAu9opvQ
	(envelope-from <linux-rdma+bounces-22368-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 03:41:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5F76A3927
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 03:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="QyC6G/+G";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22368-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22368-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8884E3035278
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7A331EB4;
	Fri, 19 Jun 2026 01:40:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643032D42B;
	Fri, 19 Jun 2026 01:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781833217; cv=none; b=CbnlAkrSs4NyZ01cIlu1lg9CO6fgnKTpPHLbulD1jG456ndsvtB/HRqViyIhDQD8eWRYKHWphCwwk/3pL1eKm4FiZMoWDKL8VbjJ5knL0FXcl66Xh5p7L9MwC7ZIRmIatsVxYxa4XL9A7L8RsassPx+U9U6uk/iz3HPDLp7Q9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781833217; c=relaxed/simple;
	bh=QfCBpncQlOOZXopSotaFNivUVhfGcsnqjDggUYrE81o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uRskHjRzc0p3Jgo589VA+ICJNl3mNWRAAckMeWdVbgUF82rbvhuqNER+vHEdTupQ6vHK0wQccgu91v7o9nInTOA9+qszVgDUOZ6WJKB/wJDD9vjpbwLk0FwxEEMJxTty3vFguaBL8a19DOfK7QcbIh+shbDbYboh4LOEIKtcwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyC6G/+G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9168C1F000E9;
	Fri, 19 Jun 2026 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781833216;
	bh=rKZtTIE0EozqPiewpjLb1LvOAUGg7HQbicSGBApX/L4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QyC6G/+GffRyHoR/dZN1eYrwkNyqNhnTnAkNCpnWy6Ij2zkAzNpL09uhkRI8WL5Mu
	 l0sjyKXHZycTt/kVk1S6e1LXHNMhSIunGfxliDi87fP5eniIqekrjRN81M06d8EQKR
	 49eOA/DHdF5Mta6lsCqQVXbapsA9gtROrX4/OmwKB9sN1ilfKZZMANtapE+Bb0wcOt
	 dINf4ejOr058EKFQqeKnm9RkjgpdkvFredlsudxVeK7v4pTyya9O9BP1oXq0xq5GwQ
	 shEOCO6c2KXz6xB58A3OcDJtz9KWNDF5o2YWDtJaoX5Dz5kl2NT0Z3C2aq4Hjd/Bkj
	 I/P53OLYxYYkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198553A78A7C;
	Fri, 19 Jun 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: rds: check cmsg_len before reading
 rds_rdma_args in size pass
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183320963.3155315.8392610577846056052.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:40:09 +0000
References: <20260617023146.2780077-1-michael.bommarito@gmail.com>
In-Reply-To: <20260617023146.2780077-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: achender@kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22368-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:achender@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F5F76A3927

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 22:31:46 -0400 you wrote:
> rds_rm_size() handles RDS_CMSG_RDMA_ARGS after only CMSG_OK() and then
> calls rds_rdma_extra_size(), which reads args->local_vec_addr and
> args->nr_local without first checking that cmsg_len covers struct
> rds_rdma_args. The other two RDS_CMSG_RDMA_ARGS consumers already guard
> this: rds_rdma_bytes() in rds_sendmsg() and rds_cmsg_rdma_args() in
> rds_cmsg_send() both reject cmsg_len < CMSG_LEN(sizeof(struct
> rds_rdma_args)). Add the same check to rds_rm_size() so all three RDMA
> args passes are consistent.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: rds: check cmsg_len before reading rds_rdma_args in size pass
    https://git.kernel.org/netdev/net/c/e5c00023270e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



