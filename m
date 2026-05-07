Return-Path: <linux-rdma+bounces-20175-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKSMG362/GkNTAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20175-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:57:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB84EBA31
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD56330E8242
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697CE44D02B;
	Thu,  7 May 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeyhtkNd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F903DCD88;
	Thu,  7 May 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169070; cv=none; b=QQA/sjykVSrvkX+qpJV2/AxDIAhLNucTukS/MOqaVvtQUNZ/QoM3oHBbhEQBh320b8E6YtUg5NyjKtaRD91s98Yvj+229wHo3lvOHwPV9UouPQvCOn5f0b7JHBtRjOmBAfHDfzSwVOYFars9TVzuj+BnrelBKI9h6l7/lKrLUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169070; c=relaxed/simple;
	bh=LOQ6SFDpjgE2bkR0GJjTh2yBhhI7Aq4dhLFOtC46QoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cIwpNfyiCzhZbggJbEymQaMoRC8gIP/8BCsssQBJEDDcVRwIpr9Phs2XnfU7KNJJ3tmhBpfjgGAEWjs6BWNdJMhIqywe9Y09qOtwFyE93vZ8UsDKVL1CDeArgq6+tSfcS98ig/xtnqb+IjT17WTjlc5+TnTjjmGkVR69gMb/0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeyhtkNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C961C2BCF4;
	Thu,  7 May 2026 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169069;
	bh=LOQ6SFDpjgE2bkR0GJjTh2yBhhI7Aq4dhLFOtC46QoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KeyhtkNdmakJED9lyYS3xy3Xf0wI/aRicTf/ZxtuzjD8cBEiOrmiHZ8+H99udjbzr
	 mTxuI0Coh2eCSvV8NEbd2HqjL//zevWsjJXMH++GgIycYA/Z6w+Y6adUyHMUdxEB/y
	 aOGff+pqDxD/yjEtVAwSXTdLRbgkQoOSYN3crfgG9tC5CrbQTaEITvw3bhqFtpShjY
	 I8mE09i5/RtrnAqeC2h5zyphwaGF5OBHTlN65oc1SLsj15SQD/pLNE43zQogeIUS00
	 iAtgf7EId/oRtvFDcMh5wE088OrosrJt6rsI3dPSFgAaHYkdnpwd1LFEopr2+oj/Dt
	 1O04BaJhRFaPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D023930909;
	Thu,  7 May 2026 15:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix missing sk_err when TCP handshake fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816901854.4048611.5262399132285287692.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:50:18 +0000
References: <20260506014105.27093-1-alibuda@linux.alibaba.com>
In-Reply-To: <20260506014105.27093-1-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com, kgraul@linux.ibm.com, mjambigi@linux.ibm.com,
 horms@kernel.org, tonylu@linux.alibaba.com, ubraun@linux.ibm.com,
 guwen@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, oliver.yang@linux.alibaba.com, pasic@linux.ibm.com
X-Rspamd-Queue-Id: CDCB84EBA31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20175-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 09:41:05 +0800 you wrote:
> In smc_connect_work(), when the underlying TCP handshake fails, the error
> code (rc) must be propagated to sk_err to ensure userspace can correctly
> retrieve the error status via SO_ERROR. Currently, the code only handles
> a restricted set of error codes (e.g., EPIPE, ECONNREFUSED). If other
> errors occurs, such as EHOSTUNREACH, sk_err remains unset (zero).
> 
> This affects applications that rely on SO_ERROR to determine connect
> outcome. For example, higher versions of Go's netpoller treats
> SO_ERROR == 0 combined with a failed getpeername() as a spurious wakeup
> and re-enters epoll_wait(). Under ET mode, no further edge will be
> generated since the socket is already in a terminal state, causing the
> connect to hang indefinitely or until a user-specified timeout, if one
> is set.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix missing sk_err when TCP handshake fails
    https://git.kernel.org/netdev/net/c/9032f7676935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



