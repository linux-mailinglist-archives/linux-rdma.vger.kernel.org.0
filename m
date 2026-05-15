Return-Path: <linux-rdma+bounces-20742-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PQcORdnBmrOjQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20742-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:21:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04016547F55
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDA3A300E4AC
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 00:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBAE2222A9;
	Fri, 15 May 2026 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxC0HewE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168D21A447;
	Fri, 15 May 2026 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804463; cv=none; b=ClNxYTmrAssyvgqOX81GlOmfWQJyxBkNPp+GTWG2Hkz0qzgN6slZJc/PIdy+Ooo1FCJrOhp+WkRxOgfLP70GDtq9ttbSUq12nGMeQJgSnTEV+XO2aduR4DsMULZLlF2xvrRxrYRocIj9znUTLI3RlyEOcM8y+Cg/wceVZkoRPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804463; c=relaxed/simple;
	bh=gU9VhBBF6B82CQGM+/Rzi2fldWvbjFwpm5F3HZyAt+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s6836d6Ot1aPLQdmnUXX1tEOzaI1j69pBAN8iXFvIlIn1Knh6i6RdgaQGTLMcf1Ww4NbkgEtGWQzG2z96Em2ZvVU4dbIdG6V1GevuXGLeC2dNoDG64B++PvacKo+LH1ws4/ckrqMEsK5YPBJOhweQ3DeSyn8T4f9mPXk/nTpj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxC0HewE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4806C2BCB3;
	Fri, 15 May 2026 00:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804463;
	bh=gU9VhBBF6B82CQGM+/Rzi2fldWvbjFwpm5F3HZyAt+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gxC0HewEoGHY5QTb1p1f6nT5gNak8Bi/8FvI0KQdGrxvIw7JnCFbGdSYlw9hvlfpP
	 FBXYr3OeV8OI1zMmsNKgq52DeoeYXLBAfGlqaJkOsTsH7vvFvdbz+d/R/irycZ5gRw
	 pM+0L6wNYm6Lbyxi73iHoPLUjRYOYAKty02s3uAgfcK7wpo0256Lh/69+d6DBjHOPL
	 74htdcxcvsa6EjwXRKW9K8wn+H6R9QhOzQFkmINbZyu5gV0GF4P5U4+L3EL1g6BdAV
	 /moHdvprpH4ZnZcfYU0um818lzmskQrdgX49vV3EP65cV3ZXqAZLFk6p0X9EYsYtt7
	 YZFNRMwzuDwbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D7F39E4DB3;
	Fri, 15 May 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rds_tcp: close NULL deref window in
 rds_tcp_set_callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880440754.134878.15132250364386263832.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:20:07 +0000
References: <20260512142807.1855619-1-maoyi.xie@ntu.edu.sg>
In-Reply-To: <20260512142807.1855619-1-maoyi.xie@ntu.edu.sg>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org, maoyi.xie@ntu.edu.sg
X-Rspamd-Queue-Id: 04016547F55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20742-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 22:28:07 +0800 you wrote:
> rds_tcp_set_callbacks() links a new rds_tcp_connection onto
> rds_tcp_tc_list under rds_tcp_tc_list_lock. It releases the
> lock, then assigns tc->t_sock = sock outside the lock.
> 
> rds_tcp_tc_info() and rds6_tcp_tc_info() walk rds_tcp_tc_list
> under the same lock. Both dereference tc->t_sock->sk without
> a NULL check.
> 
> [...]

Here is the summary with links:
  - [net] rds_tcp: close NULL deref window in rds_tcp_set_callbacks
    https://git.kernel.org/netdev/net/c/d2bfdbb69cf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



