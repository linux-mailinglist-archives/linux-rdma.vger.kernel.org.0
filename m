Return-Path: <linux-rdma+bounces-19483-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEnjI7Cc6Wm3ewIAu9opvQ
	(envelope-from <linux-rdma+bounces-19483-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 06:14:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0744CD40
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 06:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCEAE30552BD
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 04:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99463CE4B0;
	Thu, 23 Apr 2026 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzr2Ckfa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11E3CD8CE;
	Thu, 23 Apr 2026 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917455; cv=none; b=sa6Ckr/qv9jHNY83zN6uE+6X/aC1HCofL3z6DeOGJhGsX8JAnUczigUXj3wodKqYoZd6ttlNloKMQ451uLEl9OQnohxvaqQ1QBuKHMntJiLcD1A6Hd0Eh5NRM3Pm1Th/0QyyaSHErAOIeqRt+7Yt4NWs20aL3G8Tvs8KvszkfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917455; c=relaxed/simple;
	bh=JnoSNSp5LUZ5lvo051Sc6/fJSCoROc7l7aTWaA8rpLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hLkLOYuncYxIQ6S5ry3uzwgEYGTGUTAtdCos7BJGb92+DLb16DrQm26SmePe/Fs9EpoaBdlG3Ecs/N9d67MTRX9ghrLKD71cOxXbdeA/sbV+PGnYzoGmergDw/PSxZT0So9bQuUT5VVqloBXdXP4S9hhsPQVrCfxTJFtm+nQ7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzr2Ckfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922C9C2BCB2;
	Thu, 23 Apr 2026 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917454;
	bh=JnoSNSp5LUZ5lvo051Sc6/fJSCoROc7l7aTWaA8rpLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kzr2CkfaXi7at4ScwzrLrfeK6cqTzGBpdN+QdcvTLG2UEGGpkkUTq0cXIGmtzXmfR
	 VrVmjCwl4fRfra7ZZw5Dia/yQsshunioD/jNKFj4OxHDilrGN/gceDTJ0dSSuxlCsK
	 NVnehnB41rDlMC1mB+YgA01AGSssR4bAUzlWA25jc3sgJyBKPVTadO8+KR0SALdBYu
	 qhWu9syhJ7ifnerUJZ5IIVYyPL/JLwBnUUB9/pKp3hpGR28n7ntB8xOmKXBMgvrNea
	 /cjf1AU/cH0xg2aljRuDol3QIFsb2KGnpelyieIJtn/XDcQcLFmanaOR3/Pg3oebA6
	 ppJb94bS9wvoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA4B53809A86;
	Thu, 23 Apr 2026 04:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/rds: zero per-item info buffer before handing
 it
 to visitors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691741629.4152232.6489849358405426037.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:10:16 +0000
References: <20260418141047.3398203-1-michael.bommarito@gmail.com>
In-Reply-To: <20260418141047.3398203-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sharath.srinivasan@oracle.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19483-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46A0744CD40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Apr 2026 10:10:47 -0400 you wrote:
> rds_for_each_conn_info() and rds_walk_conn_path_info() both hand a
> caller-allocated on-stack u64 buffer to a per-connection visitor and
> then copy the full item_len bytes back to user space via
> rds_info_copy() regardless of how much of the buffer the visitor
> actually wrote.
> 
> rds_ib_conn_info_visitor() and rds6_ib_conn_info_visitor() only
> write a subset of their output struct when the underlying
> rds_connection is not in state RDS_CONN_UP (src/dst addr, tos, sl
> and the two GIDs via explicit memsets). Several u32 fields
> (max_send_wr, max_recv_wr, max_send_sge, rdma_mr_max, rdma_mr_size,
> cache_allocs) and the 2-byte alignment hole between sl and
> cache_allocs remain as whatever stack contents preceded the visitor
> call and are then memcpy_to_user()'d out to user space.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/rds: zero per-item info buffer before handing it to visitors
    https://git.kernel.org/netdev/net/c/c88eb7e8d839

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



