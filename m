Return-Path: <linux-rdma+bounces-17420-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHoGMNfQpmmgWwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17420-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 13:15:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243A1EF2AE
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 13:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56F7D306C137
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA4433F5BC;
	Tue,  3 Mar 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9hbdB7s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DF33F5A0;
	Tue,  3 Mar 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539805; cv=none; b=FUieCwgKdAmIFfOBfmrClYfUPOock6Zg9160z0QQab5H1ptJiCnbZ6aKNquo65XWYQw1dcEs5DFNAdLI+MczGQhnMIapw+C/9N3y1OSBZbjxX8l3Uol/i+0xtl6cyqUgTQhCKbXqQyxJM07UZwYRro+FlDzExnxgSjgqEFM+LkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539805; c=relaxed/simple;
	bh=ctKYpajZwHCISKbEUvBdK9vmWotNgZJKU2Jv87Azau4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TNq7TEJUbcu9JwESib6zpPKikQbkgvxrPlzsoX2YPLOs06cLkbN/0X++l6cFUgc8585mi98dyLV4Ao5X+JVzZP5HpHpxdlSIGZV7h94hI/yvgHH54gzOj72pQAoS6CJkX803+7Pd4SAQWht1GX0b4BBDljLqxIPMSVxTxRbnJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9hbdB7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CB5C19422;
	Tue,  3 Mar 2026 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772539804;
	bh=ctKYpajZwHCISKbEUvBdK9vmWotNgZJKU2Jv87Azau4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9hbdB7s+RDcDpWw6lZUNbg5lsKdjt2gFVy7mAIrM/aDrqjYRem/YlIXyPBr1jVxr
	 SzfoIQXkFpDttf9mqWALPxDCkTtsduTbHCxHJ2/gnEFPK4tOr7YPgTk2KBZE1WJC4f
	 3bY/fB8K9Pnjt/3EFJfUKIKMZZmVLvPVOJo5ESCHiOOkWwwKnBLlKiOL3TpMDRD3g/
	 9WJrVi4rKdYnQ9KueSdn1OeKhYhMr8GByAIk7fS/uDmO2A27R2aBJjZ//2Ys0l2MU9
	 REUmavQDLlmaYYTmlIpMBxir1wSvCYV+dM2EFxIs3a38a1OjaaaCvcmmTZj7TD9yhT
	 j1NbDqYXo/XfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB5380A965;
	Tue,  3 Mar 2026 12:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/rds: Fix circular locking dependency in
 rds_tcp_tune
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253980580.841923.11409589067259781986.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 12:10:05 +0000
References: <20260227202336.167757-1-achender@kernel.org>
In-Reply-To: <20260227202336.167757-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 allison.henderson@oracle.com
X-Rspamd-Queue-Id: 8243A1EF2AE
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17420-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 13:23:36 -0700 you wrote:
> syzbot reported a circular locking dependency in rds_tcp_tune() where
> sk_net_refcnt_upgrade() is called while holding the socket lock:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> ======================================================
> kworker/u10:8/15040 is trying to acquire lock:
> ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0},
> at: __kmalloc_cache_noprof+0x4b/0x6f0
> 
> [...]

Here is the summary with links:
  - [net,v2] net/rds: Fix circular locking dependency in rds_tcp_tune
    https://git.kernel.org/netdev/net/c/6a877ececd6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



