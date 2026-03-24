Return-Path: <linux-rdma+bounces-18551-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFrfFBvuwWkgYAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18551-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:51:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2E1300B74
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304F4304B5D9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 01:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322E37B014;
	Tue, 24 Mar 2026 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMKVc+jY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371D48CFC;
	Tue, 24 Mar 2026 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317022; cv=none; b=swhjTG3u5bwZZaptZFkZrpa4LQ7rpmPhqdil11kDctuD/PaiEE+es82o4dSC7OZw0ZGBkxtULjBg8pwoyrwOjt3SZ1wlv3P7K5vi9mO2bqIdmoO2YJQqpzUv4DvFisc0csZ3gDTugrQ0NJArcrlQEcoqwTILiuELQy5JzRd4rrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317022; c=relaxed/simple;
	bh=n70GUlRlc+3qXd/85B78ellg6YqUJK50jpgsp5FOUqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e9faEP+vX0NWBOR9T05RvWqk7yWjc4aDEADTrjLRxciMr9bzTKeszXNFe4Ngeg/Ke3yQndT4eFyPIRY9G8AyKg8gUGZi7wSymCEeUPGf29GLIFLjyO3mFRTSDY2lHjkqvKVRkNc8+tUnowabdi2BKaB2ZvgEuQ9DWmjzpUGD1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMKVc+jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A34C4CEF7;
	Tue, 24 Mar 2026 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774317022;
	bh=n70GUlRlc+3qXd/85B78ellg6YqUJK50jpgsp5FOUqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iMKVc+jYGW5tHNuJ6iGQ5H0065y6hvM5o9s9f/e46zuzGh5yRQG95IQ36XcMCj4Hr
	 NbHzzGbKlH6PMqCP062RY2eIHa5BlglKq9Iow/rPUofUY2iNLqRR7n+9H0Vm7dAy0f
	 SPht9F6IvYXMVNj25DfnJt/7zVPWN/6pdbmXpLKbPifDBi1va2vHoUSVy3lTgfYGcW
	 4Cg2Xfxt63tvbv/R275qSdlQniGAtezK3so8IGYhIYmZFzVfB4UdJkLx94Rs3zeAbY
	 wL3JAETM7KjjWoqvPrw+qwkhAVhmeqsS+8TGOG2wdkk9AWyXEAIZ2DKJL9cfk3cL/L
	 54ppN/OFiU3tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1F83808200;
	Tue, 24 Mar 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] ethtool: Dynamic RSS context indirection
 table resizing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431701054.413704.17760247587470177196.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 01:50:10 +0000
References: <20260320085826.1957255-1-bjorn@kernel.org>
In-Reply-To: <20260320085826.1957255-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, maxime.chevallier@bootlin.com, gal@nvidia.com,
 willemb@google.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_SPAM(0.00)[0.870];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18551-lists,linux-rdma=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE2E1300B74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Mar 2026 09:58:20 +0100 you wrote:
> Hi!
> 
> Some NICs (e.g. bnxt) change their RSS indirection table size based on
> the queue count, because the hardware table is a shared resource. The
> ethtool core locks ctx->indir_size at context creation, so drivers
> have to reject channel changes when RSS contexts exist.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] ethtool: Track user-provided RSS indirection table size
    https://git.kernel.org/netdev/net-next/c/0475f9e779b4
  - [net-next,v7,2/4] ethtool: Add RSS indirection table resize helpers
    https://git.kernel.org/netdev/net-next/c/02bcb20083b2
  - [net-next,v7,3/4] bnxt_en: Resize RSS contexts on channel count change
    https://git.kernel.org/netdev/net-next/c/57cdfe0dc70b
  - [net-next,v7,4/4] selftests: rss_drv: Add RSS indirection table resize tests
    https://git.kernel.org/netdev/net-next/c/10329ce49285

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



