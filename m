Return-Path: <linux-rdma+bounces-20538-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GQ9EBz1A2rKBAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20538-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:50:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF452D019
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A1E130DB8E4
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743739734D;
	Wed, 13 May 2026 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODT40+2p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93618397E64;
	Wed, 13 May 2026 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643971; cv=none; b=cbUSKDT442OGMVq3ZiXbF+kHs04XxfvHHy3wyEqlq9iwUHCs6K6G+0IGbfc67mdp3/JFbQYlPngPbqQZcnUZlD3UJIgnQp7Aiha3e04eAjXO03I9CBfR69NEcSlyWbMOtH90OvPa9917gllqE+6ghJMFF0hIwQinUuLFTcObKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643971; c=relaxed/simple;
	bh=j/ZWZ6nYtJAegsuNwpg1A7rc1Fkj1DJrX/2XmoQLtPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bZXzpI1ohYk5GWOq+yeoSr7ZvLknBwsNdi5fmWDJpaW8v3xNgfYVLc9a1mRcgrnIvzjlelV1R9rfHwXQ+zRO9iwKue470ZFjiKMrEBEQFJxC6ZZ0eCK/JySW4hTRxoguydLYD3H5BuU7ZU+g5GVZKIXvqohwSb5y7J132o7yhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODT40+2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0268CC2BCC7;
	Wed, 13 May 2026 03:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643971;
	bh=j/ZWZ6nYtJAegsuNwpg1A7rc1Fkj1DJrX/2XmoQLtPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ODT40+2pWoO7xzEp6IsbAr3MUpahEORMoCXnDsAbUW3EPL2cq/wKJApwXxJb+QPxB
	 VjG7YVZtjH3/iFEcXOJv1Bv16zqtv/Y4vTa+uvJHB9Lq4w1Gc5R+1pliwQy2qoky6A
	 ECCNsgQgnp1Zlq50+qoyIASH+2jBwQVy8t0dyFHD8kIlIrSEtEJoC5Y+Xjf7bUQJw/
	 xSNN030I16mRTyMFik/Bs1BM2jThY4nlvhjEZJ9teo2IwhqG1sey/X0TIlqsbFOpAA
	 xUrD6N5nbDKtANmAgCCU6xJkqMywpuXw5XObuJv8F2A/mhzLxe/jhkNUP4j/aDLpxC
	 ZRd5zj1PGByeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E423822D60;
	Wed, 13 May 2026 03:45:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864391679.3173643.11650967377034857635.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:16 +0000
References: <20260510163414.16651-1-n.coccia96@gmail.com>
In-Reply-To: <20260510163414.16651-1-n.coccia96@gmail.com>
To: =?utf-8?q?Nicol=C3=B2_Coccia_=3Cn=2Ecoccia96=40gmail=2Ecom=3E?=@codeaurora.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nicolo.coccia@leonardo.com
X-Rspamd-Queue-Id: 9BAF452D019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20538-lists,linux-rdma=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,codeaurora.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.836];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 May 2026 12:34:13 -0400 you wrote:
> A logic flaw in __smc_setsockopt() allows a local unprivileged user to
> cause a Denial of Service (DoS) by holding the socket lock indefinitely.
> 
> The function __smc_setsockopt() calls copy_from_sockptr() while holding
> lock_sock(sk). By passing a userfaultfd-monitored memory page (or
> FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
> as the optval, an attacker can halt execution during the copy operation,
> keeping the lock held.
> 
> [...]

Here is the summary with links:
  - [v3] net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS
    https://git.kernel.org/netdev/net/c/a3fdd924d88c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



