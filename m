Return-Path: <linux-rdma+bounces-19443-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BpVFcJ75mkHxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19443-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 21:17:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D316433373
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 779433077E25
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285BC3BFE4A;
	Mon, 20 Apr 2026 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eidY5MXx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1B3BF695;
	Mon, 20 Apr 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712425; cv=none; b=jaR10c7zzNAm5FsJ59blubt+G+4kyDiBDXy2itZxmKjS2bw0MDi1GZ26+KmY0vMzE+DkrADPh0tWqE/gS6qTebS0wdn7Hn3B9Fzh6CSMTVesSafBSnWMLBgsmbAs/CMQS5qgRZ05w0VHV9UyqL+6qAG66gcd3M1ynAdiWM++x2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712425; c=relaxed/simple;
	bh=6+dACo+pSN1xb9U0frc0h3YLRzFmJOc4YLc/Xa13ZDA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OH303dRjb+mRMQ0qdi/hfoemuANZWBBWxBW1lIn2JpyNu24mWDLgjc3svKkaZtyY8nJcg9glt0uXMEMq3+EQbByZpH66UwjPQuZ7iKP2YjRUk0AhlMmDTBl1683rImKT7XjTOewhQ8BOv3gFSd58CTmxYoKQk+Pq6uVj/CB+NuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eidY5MXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DE8C2BCB7;
	Mon, 20 Apr 2026 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776712425;
	bh=6+dACo+pSN1xb9U0frc0h3YLRzFmJOc4YLc/Xa13ZDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eidY5MXxtdtC8GwB73CoXmO2TlMYQDRqtLWqSp77SENwxvMdFGT0U0chNJ7C4vU1M
	 lDHvSw7yvQ3K9sdcMKWUTPS2J00Lxn6GjYNW5rrRTYeA/HY2qu7vUQcauDY1ASHKEr
	 2wAjvEw++PXwqIHvQ10FdvpoNL0EHQkMDlNG8Jm9S27Dcyc1x1Ickw632jaFAEgTeK
	 3TaRvuWm4VV1OQOZEfrrleGaDGn6QdS8p/HbXYnOJ4wMu9le5og8w47qmhYXKT9Lbl
	 Zn7eeTI0AzbOQGJ49A+L5AiWrq3jjjTJJ3oZyBilH1wVrtzJad8V4XI1MhWyg0BNEH
	 UDS3rx7Wf10wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDF13809A22;
	Mon, 20 Apr 2026 19:13:11 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260420121905.GA2902776@nvidia.com>
References: <20260420121905.GA2902776@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260420121905.GA2902776@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 9091e3b59f2bef11c0a841096327565ae0ca220b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b0b946019e7376752456380b67e54eea2f10a7c
Message-Id: <177671239014.1954049.4655837683017857890.pr-tracker-bot@kernel.org>
Date: Mon, 20 Apr 2026 19:13:10 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19443-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D316433373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Mon, 20 Apr 2026 09:19:05 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b0b946019e7376752456380b67e54eea2f10a7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

