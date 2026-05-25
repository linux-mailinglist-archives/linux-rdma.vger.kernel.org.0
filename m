Return-Path: <linux-rdma+bounces-21251-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIoCAqKeFGoLPAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21251-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 21:10:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C115CDF25
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C81B301F9C5
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DCE37F72A;
	Mon, 25 May 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5D9LSPZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7B385D79;
	Mon, 25 May 2026 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736203; cv=none; b=RyIcXhJmicxAZVPVDFwaf0TGEAqhJagXGJ179PA59DN+/iua8SEwRTPUS+OO4tdgRqZrdmskOzOfGEHYjCXuYcoWGVoFKZifr5FqDs391m3hjrpzBf4XD91EwUG6v5F5BMQM5+m4ny5tzZ/tr4Qh32B9QEGjkI9JD5TexYuZCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736203; c=relaxed/simple;
	bh=CQIwo/+uoUtf6GVcsy+r/PrVniU8YCURG5WOj0wOpEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eXIYpdKvjBmFlG+9RCurGK5Ml2bY4e4JPuNVIIDVjBZ4W+LLuoFtKDIQaT8gNG2Fx9qLbIVlP6L+3mE46p0BGo0yLwzmmcPUqnuIVn3ZnE4pnJmcd2o2PMXdSFsEccTOSvbjydlshm8w/FpZwq9HWa2AgSkSeL1hM7rGgF4zun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5D9LSPZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BFE1F00A3A;
	Mon, 25 May 2026 19:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779736202;
	bh=tqaOp+ZDWDC3UIxDELAWihuKv/0z0wgKTmEF36hX5l4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n5D9LSPZRsPv//pGSYjiLeWYNtOCH81lQy+NqHQSOpWjmSvbr/ULQNl/BKW2jg5QN
	 d3QRIDy/IjvU8j/QkTw/xS3/0Hi8aO7QbynMR6OqeJYdw46kKzjqRmyRjrmjPWw8YQ
	 1OVtIJmp7zk7mdZenjYiFexo0QUEcG/H+dYu1X/CZ0cfLCNaHyRaXDxVzoTUJ9hM+F
	 109SU240rXpYKpPm3qjkQ5kLd02zgO9qIGwlKPUAKeLdZk2I5b7QkPel5GqS7DsTJX
	 CcWQD3NCfSNaL0GHg3Nr6O363mWS1TwK2gvDdlGAZrMeJyVg0aCdDbwZaTRfml81vM
	 Xr9OPXbsf7acA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56F5E380AA75;
	Mon, 25 May 2026 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rds: annotate data-race around rs_seen_congestion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973620889.3087812.8566427149825736484.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 19:10:08 +0000
References: <20260522011621.304470-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260522011621.304470-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
 syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com, achender@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andy.grover@oracle.com, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21251-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,fbf3648ae7f5bdb05c59];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 78C115CDF25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 09:16:20 +0800 you wrote:
> rs_seen_congestion is read in rds_poll() and written in rds_sendmsg()
> and rds_poll() without any lock.  Use READ_ONCE()/WRITE_ONCE() to
> annotate these lockless accesses and silence KCSAN.
> 
> Fixes: b98ba52f96e7 ("RDS: only put sockets that have seen congestion on the poll_waitq")
> Reported-by: syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a0f8d94.050a0220.6b33c.0000.GAE@google.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net] rds: annotate data-race around rs_seen_congestion
    https://git.kernel.org/netdev/net-next/c/67636cab273e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



