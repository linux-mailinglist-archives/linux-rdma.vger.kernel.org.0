Return-Path: <linux-rdma+bounces-19514-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG10O9pg6mmrygIAu9opvQ
	(envelope-from <linux-rdma+bounces-19514-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 20:11:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FCA455F09
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E26F304D1E7
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800D31D371;
	Thu, 23 Apr 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q44zK/K/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAE387371;
	Thu, 23 Apr 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967851; cv=none; b=jWNvQZLt06nT5xIvVaE+M1PEgYY6B7uQ1+NqrE9lEtJtQWTDXlNmQHtMqt/fcQ6n3ALK51EHev3/TmKIvmMzACADHMzh3nVLx1MVcNCfne95HkEO3f0D4k9n8afp0i8wycHkPbau0OBtTpLrtuAzbCBe1tk4N4/IP53WqVsGeyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967851; c=relaxed/simple;
	bh=M2m0lylbcjBqMB6H3osZ6It0h+AD0HrakMeuJekAciE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dWAMWOEmf8MqyIqpYXqSU7Dz9NrPKsd2dXeZ9g7qGq26IKn+IME/CzxWozoQ4EX9XFnMX3qnT7dJv/nVHYjayT88x8Jqd5kGgYZ6XaGdx1j+KNKS7V+bAzh3B7cHL3uCCEFoBGwlbbKr1BmNrfnzELRxx8XaPtOvCnkISt7+Y8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q44zK/K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D979FC2BCB4;
	Thu, 23 Apr 2026 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967850;
	bh=M2m0lylbcjBqMB6H3osZ6It0h+AD0HrakMeuJekAciE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q44zK/K/0gnv7BlnJPfpQgf25n5tDJdX8/4bxkYBeJvfvSe5Aw0Z/FqKNAAv3jtgI
	 PBAcEU4PimfMwzrnWce8PlRONHOJMQU9VAtsdyamAFtMvvwnV/YLzsWGT1CAmN0iVf
	 Sre+Qi7Wtgd4pr/1mi/X1jj1gdr4eQpzMpfR2ySAQaRKQudfo54nNo7Lk/Cfw+uJ6Q
	 WzJ9jj+na5R0GSAi/oBM+yiWmhteoEMyYBI0ub7fbvwoGL4qM9T2jAixaLZs0fMLYI
	 MegJebctEd5sDZ6QTULup+GaSpC3K0mX1dgEkje32ALESiXOmRwiDt7nDgP+q7sy71
	 NVJgzeODOQiFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CC9638111D6;
	Thu, 23 Apr 2026 18:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/smc: avoid early lgr access in
 smc_clc_wait_msg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177696781230.700507.12840295464610058143.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:10:12 +0000
References: 
 <08c68a5c817acf198cce63d22517e232e8d60718.1776850759.git.ruijieli51@gmail.com>
In-Reply-To: 
 <08c68a5c817acf198cce63d22517e232e8d60718.1776850759.git.ruijieli51@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ubraun@linux.vnet.ibm.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ruijieli51@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,linux.vnet.ibm.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-19514-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64FCA455F09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 23:40:18 +0800 you wrote:
> From: Ruijie Li <ruijieli51@gmail.com>
> 
> A CLC decline can be received while the handshake is still in an early
> stage, before the connection has been associated with a link group.
> 
> The decline handling in smc_clc_wait_msg() updates link-group level sync
> state for first-contact declines, but that state only exists after link
> group setup has completed. Guard the link-group update accordingly and
> keep the per-socket peer diagnosis handling unchanged.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/smc: avoid early lgr access in smc_clc_wait_msg
    https://git.kernel.org/netdev/net/c/5a8db80f721d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



