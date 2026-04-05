Return-Path: <linux-rdma+bounces-18997-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIvBDYuX0mlWZAcAu9opvQ
	(envelope-from <linux-rdma+bounces-18997-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 19:10:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB439F1E6
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 275AE3007AE2
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E0931BCAE;
	Sun,  5 Apr 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBXdZzx2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6740DFA5;
	Sun,  5 Apr 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409029; cv=none; b=G67ADxyrSjd9lDPBGRPTdLlOkkOOs1gjH5jQpjeLxtpxTMJx3ZUocJDOYg76RVJW2r+xsR0zw2UbeDFUY5SmTMfSvktgNd4sw8mMvMGTgVyDchD5LHsfyKuFrLNO2DZScPQwUXLNPYEAzlLdsmufXvJbTd84cc9b5sjtmhi61go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409029; c=relaxed/simple;
	bh=kFInyEx8UOHCWThodKB2iqt4arjyI8Q7gSMByXLdcxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LrmaCbAcvnbEjHZ+Ko9+4YcnWQ+dqH5T4MyZqj34Q9dDM2xSAhUbKBk2mpNNtSen2w7Lu9zXATP6IQPrC7qrzVNWPx+xGKvdlAwWGeJ8SBaxbNfk8OIMbotsI2sMIrqQ/Evk/bwPgf+ZqGeuSYxdyo7F4q34SOyr1wRyH5+Ag/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBXdZzx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4B2C116C6;
	Sun,  5 Apr 2026 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775409029;
	bh=kFInyEx8UOHCWThodKB2iqt4arjyI8Q7gSMByXLdcxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KBXdZzx2SqwUwZhXFyU1SjNQrG59WckRst5F0/iaveO1mKWPV4igFOXbPPgfKBnWA
	 4pWlg3ywBLSa4Wuy+hlem71xoirgZ0Be8g8FLbM7IOeENAoE3PperhdH6UMLzM2PFx
	 z4Q5S8I3CSpIuASVxBvApABnhe0VIZeZ0/PWVKNV9LLQQU5ujFREyLtpqfh5NLYE2V
	 q6uHHptqzivIazGOYQvQRBZ7nSle1eTrJ8xfqNyiboRN6uranSy/dvJHazA4jk0TKj
	 +ICWzCFhO0bihdDfFUqld8GpX33/logSE9jZ65/2rkOtvkDQxesJJywlTnOYP41Rih
	 JKJ2qcMZRamKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD683809A22;
	Sun,  5 Apr 2026 17:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2-next 0/4] Introduce FRMR pools
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177540900929.1995793.9036080882840884097.git-patchwork-notify@kernel.org>
Date: Sun, 05 Apr 2026 17:10:09 +0000
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
In-Reply-To: <20260330173118.766885-1-cmeiohas@nvidia.com>
To: Chiara Meiohas <cmeiohas@nvidia.com>
Cc: leon@kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18997-lists,linux-rdma=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,networkplumber.org,nvidia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CFEB439F1E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 30 Mar 2026 20:31:14 +0300 you wrote:
> From Michael:
> 
> This series adds support for managing Fast Registration Memory Region
> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> pool behavior.
> 
> FRMR pools are used to cache and reuse Fast Registration Memory Region
> handles to improve performance by avoiding the overhead of repeated
> memory region creation and destruction. This series introduces commands
> to view FRMR pool statistics and configure pool parameters such as
> aging time and pinned handle count.
> 
> [...]

Here is the summary with links:
  - [v2,iproute2-next,1/4] rdma: Update headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=93368ee34528
  - [v2,iproute2-next,2/4] rdma: Add resource FRMR pools show command
    (no matching commit)
  - [v2,iproute2-next,3/4] rdma: Add FRMR pools set aging command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=26c8bc1e6563
  - [v2,iproute2-next,4/4] rdma: Add FRMR pools set pinned command
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



