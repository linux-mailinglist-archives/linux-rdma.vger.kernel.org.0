Return-Path: <linux-rdma+bounces-20434-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHcWLc50AmrjtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20434-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 02:31:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08907517DF0
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 02:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8BA6300A5B7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E220D4E9;
	Tue, 12 May 2026 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H144ehuD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0C1FC8;
	Tue, 12 May 2026 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545863; cv=none; b=rO77AmPsiFDErrM4IAmDmctALS0W1mOOu+zHGzp7PX5xjmUOmmhybj2n2SHyvuYw7YJXrm3fMHJ3QxH0Vs3srYQDsVsRW7r5AZQ0Y8AIW9A1XcSbDYkze3gtgAEFLcbFdgW8EnE0n3+Gz9RLiYDqWD0oSPeg9GN6eYILVssr394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545863; c=relaxed/simple;
	bh=yl9F6mhjAIvWCPRWfwkvBy3FQLwpxTW9BclcmXpyNxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rLCAxLbva7LsHjTte7XCBgdSMRh6LWbb7wrj50GISWkUaB4rj5VtEu2Fy4tdpRbsU29LnHUVpNsAVglcDMsHm0hSJpI2V8nGRvgrISB9TN0sCt/DpZXQrV45+KbgTAScKlQ030BzOzrGeRR7vCXnfJd2w/w7JGI+iA2QVOloFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H144ehuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85234C2BCB0;
	Tue, 12 May 2026 00:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545862;
	bh=yl9F6mhjAIvWCPRWfwkvBy3FQLwpxTW9BclcmXpyNxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H144ehuDfyE4mnp/PDjxIpgUXg/giTGanZlUzk7PO5qp/NsBPguACRIXqIoGaVGVJ
	 Ie1DUAxOYoazfqUQwcfhXhKbuDlkjNucuun7JGSTjSTA+ASCXG8ZzayO6faNpqRjqS
	 nSXwBngR/SLIrWTd7v4WanoPQ3FL9U83pSc5dKIJrQFE1+nTlzziLyfoQLfgxIRkF2
	 pTji6qatQpIucNxTydW0ihpuxys7WYppPKe3Oh5B0sEgtxBikPIfO3HAekuHdWPQWf
	 1a2YQjRMRn2eIhyl6C25zAm8TF33KIuDmJ8xOWM0XeOTVFZLiRb5G78LUmzdY2K66o
	 ldzLUq/9FXToA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC1539308CC;
	Tue, 12 May 2026 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net/rds: reset op_nents when zerocopy page pin
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177854580905.2522385.6953058135136988109.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 00:30:09 +0000
References: <20260505234336.2132721-1-achender@kernel.org>
In-Reply-To: <20260505234336.2132721-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org
X-Rspamd-Queue-Id: 08907517DF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20434-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 16:43:36 -0700 you wrote:
> When iov_iter_get_pages2() fails in rds_message_zcopy_from_user(),
> the pinned pages are released with put_page(), and
> rm->data.op_mmp_znotifier is cleared.  But we fail to properly
> clear rm->data.op_nents.
> 
> Later when rds_message_purge() is called from rds_sendmsg() the
> cleanup loop iterates over the incorrectly non zero number of
> op_nents and frees them again.
> 
> [...]

Here is the summary with links:
  - [net,v1] net/rds: reset op_nents when zerocopy page pin fails
    https://git.kernel.org/netdev/net/c/e17492979319

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



