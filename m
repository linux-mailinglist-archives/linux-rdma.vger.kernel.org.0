Return-Path: <linux-rdma+bounces-17105-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMXiMLhwnWmAQAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17105-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:34:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FF184AD2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B70312A307
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FED36C0B2;
	Tue, 24 Feb 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1GW3YGv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBC36BCD5;
	Tue, 24 Feb 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925400; cv=none; b=pNlhPqVQb0NiME4P4uc41whgNYHSYbBtG7MSRQOnYxOmMCnw7Wv374pbUbJXsROCCpdBjDNEStQJ0E8fZ5qwSghabtY81UTIazKVM65qYyHMZh19YvuN+fNlvTLbAo2ON756BKzSNAt1DU/G4/KfljnB/5DaJ+rWjVGACtUXXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925400; c=relaxed/simple;
	bh=JAI0OR3VuXdSn2ZKBVSC+tlsKlgsrnppoSbksVlkOpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cGDpk8dutcW+b9nJPZetZap0TgHCq1f5FrJefeyGXg/Bo1qCTz1ZpcSnfkQ0pxrNpQe6ngA4txPclsWFMpYHWVl9JbUrGXtBko9FXTFKZxo4lvRbX4CEfFzP6gjhxI/OqhcE9lCy9Qak2pUGGwrGgQe83jWHVfwE8b3T4Y6V83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1GW3YGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED945C116D0;
	Tue, 24 Feb 2026 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925400;
	bh=JAI0OR3VuXdSn2ZKBVSC+tlsKlgsrnppoSbksVlkOpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l1GW3YGvn6d6dfImSOtV9JG7mIncKElc5sgDmxi2yYcAy3I6xwmoMy4SHwde/VjU7
	 viMfva/no6S4e1IUYln7R2JuuNItEZlsXi9j7BUan35Qt/e7BKdDyUwoUqUYAKt1hs
	 hQdRrxPq+uXP0nR2m4repGKJye3mHvRnuTKxkvygs8kX+9WsRoL3IvkhztzDaSBWBP
	 a5xA4A3F0ln6B+KH2FSKEtsvdSGpbShs9DuL32wURE4BfXSl/AfGjjAO7JuIUeAE3/
	 8BaSmx1JFh38Nw4SN120x4Y3tUpOK9sHZ/DMJTug60r85MSpNJDDqEFJYoUQ/BY7up
	 H4Km/29m2BFQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DFF3808200;
	Tue, 24 Feb 2026 09:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177192540555.3410242.14094838767425800227.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 09:30:05 +0000
References: <20260219075738.4403-1-fmancera@suse.de>
In-Reply-To: <20260219075738.4403-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, gerd.rausch@oracle.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 allison.henderson@oracle.com,
 syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17105-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 183FF184AD2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Feb 2026 08:57:38 +0100 you wrote:
> syzbot reported a recursive lock warning in rds_tcp_get_peer_sport() as
> it calls inet6_getname() which acquires the socket lock that was already
> held by __release_sock().
> 
>  kworker/u8:6/2985 is trying to acquire lock:
>  ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
>  ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
> 
> [...]

Here is the summary with links:
  - [net,v3] net/rds: fix recursive lock in rds_tcp_conn_slots_available
    https://git.kernel.org/netdev/net/c/021fd0f87004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



