Return-Path: <linux-rdma+bounces-20034-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCJnHPo2+mm0KwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20034-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 20:29:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C34D2A8C
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 20:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 709FC30CD4C0
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0AD492195;
	Tue,  5 May 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf+O7ma5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C462D5A19;
	Tue,  5 May 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005595; cv=none; b=cM7FVp82qdwAwJrLWCP7j/G6gxrTKEkbabaAAoE2xd8qGq/Z+YjZuYnH/2ANyo6KP/9SxsC8ZmTKvgaNTnYdeAhjAWysbv6UiHNPtNZMCeAl7SDsglLiLTKKa5CmDzB4LeYiicKuOaTitDxiey/33deunGRiH2IPbGnGmWNifnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005595; c=relaxed/simple;
	bh=eSmG1lkVAuk9IotYVlQN7OjG9TWA7zSQ4fj6E7+pxFs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JQkh0pxbWf0W8qpKrSIyQ6AIUMJLOuQXkhc3icC5CftdWherLvXj1HVYbKtd1XbbTaYUesJ2UfcxaFFGI3yP2u4xrElywGH5AxPvRx2ne4mhir+8oYfUG1jlmdz7V+EanwSoi58CEQ8vdxpCuNBjMjaSwoneb3++X3WGlOnPVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf+O7ma5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F282C2BCB4;
	Tue,  5 May 2026 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005595;
	bh=eSmG1lkVAuk9IotYVlQN7OjG9TWA7zSQ4fj6E7+pxFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vf+O7ma51naoayzOivFg26s4pKRdq36XGf6f5DnJ5cBDk3mUL2FC0VmBYrheh4lpu
	 Txtx0/c/RIIdrowHX8PdGKvcZXZIdWii1aASVNFnTNheT4QptQONjhA/ZpA1fsKyFm
	 alIOO5s2ER95HnZRh7jlj2h5aIlmp33XnbUdRTCJEGEQCnsW4CM2DKCE20JWYNxLJ0
	 /x+3GZBVe88oWlpGN1QHKdcFmMZDlWOJwZv2JnT7wbxo9hV3yhtGEglGOst411NY0j
	 dtROPGGmIevYhBnAScJ4aK3pb+QkuxtgL6M9rTCvJsP7hstCaUZSeipApGAOA/Lamg
	 +FBMzD0sEjJAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F863930198;
	Tue,  5 May 2026 18:25:46 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <afoKDicC2EmULhF+@nvidia.com>
References: <afoKDicC2EmULhF+@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <afoKDicC2EmULhF+@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 0c99acbc8b6c6dd526ae475a48ee1897b61072fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9207d47f966be9f4d52e7e0119ac2b7a7e366f3e
Message-Id: <177800554519.2215775.12758755533200283999.pr-tracker-bot@kernel.org>
Date: Tue, 05 May 2026 18:25:45 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 613C34D2A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20034-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The pull request you sent on Tue, 5 May 2026 12:17:34 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9207d47f966be9f4d52e7e0119ac2b7a7e366f3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

