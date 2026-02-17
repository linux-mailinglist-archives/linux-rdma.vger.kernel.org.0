Return-Path: <linux-rdma+bounces-16948-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFmEGaVMlGkNCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16948-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 12:10:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C7514B2E2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0E43301114F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE59330649;
	Tue, 17 Feb 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ0/9Hp8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED22330333;
	Tue, 17 Feb 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326616; cv=none; b=H0ecVa5+5UwJQiiItYTHx78I2jnRWKiWpFZxsrCZSvZDD+cFnTwPvCbQ6BYtOt9E1LVK7vBSdPJLnovbvfhIh1dP69TPbQ7/0Jfv8HKGzyP7xeOoZvAnzvd2wYN4KaLkh6R8iXShn6i7mHWHImDndKzc5qUIS0yPxWpss6EVkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326616; c=relaxed/simple;
	bh=qy0uyh+NpAyUdss18085lL2rGMGHRb6pqYWrC3imaNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nkjzfpkLtdiBLI9xdtIUyQnzkWPsy9NvGkfvYz2ZZh186QC3Utp7eE5F8iCWUg9yTdGt1KRHPGV1ZVQBVEJg5p5623mfvQH3ZRYX/Nsss0xeaRI/Z6/NPDebMzbCSHmpucPAv4aDST/dfmtmibPPMYGqMoMkO2amS7+yBuj+esY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ0/9Hp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D17C4AF09;
	Tue, 17 Feb 2026 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326616;
	bh=qy0uyh+NpAyUdss18085lL2rGMGHRb6pqYWrC3imaNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YJ0/9Hp88casUnPjQRQP0ZmAyTCwtM8ZxWUzqd3GkuLdUDg8RNHzgdZ8iaoQJ3y3q
	 J7gilFqXOBRFyYOpEPa6DSca3KBB4fHYry5UjaSGSswjzewgHNwAq1ez3V+E+AkT/m
	 c/jVX1+/mLosyzrzhCMS648XEx7ijYGz06pU2Mr1a1oKVbJoLsLpP3pUwtvgS7pbcx
	 v/PEjPp6UhxqpvlVv/pASw/aGLhfHjwTp0v5L95tSWAVkFfFfPp6UWHFt/K4+nD18C
	 syHfFa6KW/0U2eKb+mrK7y8aYlwTD3hqMNAzeeTwFYtwfFyD5d/ha4hRlkW3o+q0iU
	 qJPw3qlGjVT4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 48281380AAD0;
	Tue, 17 Feb 2026 11:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/rds: rds_sendmsg should not discard
 payload_len
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177132660782.24996.12583032587537499848.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 11:10:07 +0000
References: <20260213035409.1963391-1-achender@kernel.org>
In-Reply-To: <20260213035409.1963391-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 allison.henderson@oracle.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16948-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20C7514B2E2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Feb 2026 20:54:09 -0700 you wrote:
> Commit 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with
> connection teardown") modifies rds_sendmsg to avoid enqueueing work
> while a tear down is in progress. However, it also changed the return
> value of rds_sendmsg to that of rds_send_xmit instead of the
> payload_len. This means the user may incorrectly receive errno values
> when it should have simply received a payload of 0 while the peer
> attempts a reconnections.  So this patch corrects the teardown handling
> code to only use the out error path in that case, thus restoring the
> original payload_len return value.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/rds: rds_sendmsg should not discard payload_len
    https://git.kernel.org/netdev/net/c/da29e453dcb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



