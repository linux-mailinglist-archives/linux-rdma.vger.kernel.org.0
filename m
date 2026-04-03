Return-Path: <linux-rdma+bounces-18956-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPUMLc4Tz2nXsgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18956-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 03:11:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DEC38FDE7
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 03:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FB1E3077DD6
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FF26E142;
	Fri,  3 Apr 2026 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFJGtB4q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A122FF22;
	Fri,  3 Apr 2026 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178624; cv=none; b=RCeiqMVdhiHoV6SMUFKnPmwj8JGUOkKAcAGJ1Wm91nEgTtu6LrxUy89KKhw+ls6PwNDLaIsdDeOtXkgbYEXcN0LEIH4hbHP9JsonNicrnP3YAYEEaQn4Ya++6fo+WVkn27BjWdQ8CKkPdwZMWTmMOjvMtLPyNNQKNDQNBQuf51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178624; c=relaxed/simple;
	bh=kJMeBYBU2u7nbOPGNT4CKbku/i6jZ2oUV8sTJgxsT8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bv+2HdJ0E+eR/14De+HiVII1nqsc6/PSVlEwwcRZFLbs2mJCFtWf5Sedplxe6TYSa1s1FzyhMekYQ5z6fMnqRBdH2art6tumpzpxv0Sk/UA05Cw7pu7NyJeYdafLP1E+OUWn5nHBpHEsTERuaj6YQPgZmTYpdCnuDBcinn0zjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFJGtB4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D6C116C6;
	Fri,  3 Apr 2026 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178624;
	bh=kJMeBYBU2u7nbOPGNT4CKbku/i6jZ2oUV8sTJgxsT8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eFJGtB4qs5wWDuP10UkqAiyu274o4HY1n2uyIEBRIimEJR730YM1iVKRjNL3Abs1q
	 tt7x6+CladIyDSzEXWh59eY5WKxmSWsYz0btYL7HX82WntloK9TbFXxqY2enviin5R
	 iG2kUgh6ZOLD+tYSOGuyIBHMluHATMJUGMlR1/xmN6ou0n38IqXLhxAwYwOZ9SNlk5
	 NtnrwUV8hkpikQ9DWhin1bJyoeIb80zYTG8R0BTKajkiy6Nxo/RWdgqosNvQxKgw4g
	 vLQeDH/bCbv8oxx8kRkqY7aClecL8ZB2JbAaE3umN8el4oisG/EAeVANl6s2fD0V0B
	 txdzPjXY4sLRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD423809A09;
	Fri,  3 Apr 2026 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update email for Allison Henderson
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517860604.685228.10282111743382602079.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:10:06 +0000
References: <20260402005833.38376-1-achender@kernel.org>
In-Reply-To: <20260402005833.38376-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-18956-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72DEC38FDE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 17:58:33 -0700 you wrote:
> Switch active email address to kernel.org alias
> 
> Signed-off-by: Allison Henderson <achender@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: Update email for Allison Henderson
    https://git.kernel.org/netdev/net/c/e9c9f084cd78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



