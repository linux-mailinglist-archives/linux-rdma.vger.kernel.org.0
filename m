Return-Path: <linux-rdma+bounces-22050-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vbjbHXGqKGrpHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22050-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:06:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F136664E2C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:06:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NXgP41SU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22050-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22050-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 312D5303674D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5078C1F;
	Wed, 10 Jun 2026 00:05:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5490846F;
	Wed, 10 Jun 2026 00:05:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049956; cv=none; b=ivT939NmUtWA2BXi4KqNCkPUv3PWzCU9/G5n0jFT4rpzriXxaC3DBSZIqZfIJx6DegfuU7TZ3QTH/U1Xdwciww6YshkceIC1raUVwM8t60s7QZ4Q6TGl/ZZddHf3FGlIBbEL2BaLi2eYHk9VlXrJw3rZul5D6Bm4cS7yaI2t0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049956; c=relaxed/simple;
	bh=2ZKesxxd3AgyVDtfd/hsg1ZOSvM2yapfRlgx7TeXXEc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IwfMvyJyphOn4NbiBJTH073TVbwIfLgw/Jc16Qv4w1WtNJGNLqkS1/mZpRu9u3QGg/Dve2spugcekV+lq5CubQ9GWBJ7JFjpP2N1QjlQLfqJi2EknLpYs1d6MY7pMCxO2QHTNm+UGHvVCGdRm4iUi+c+GsgZZAzxMHMtrxz6rts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXgP41SU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6961F00893;
	Wed, 10 Jun 2026 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781049955;
	bh=hoYTJV05+NgGeswcLPtzI/oXE2U3eBXPQS3I4ondShU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NXgP41SUWEN7yTAK58spfTgFSumoXCSsY8g2dhdHPDgRM4/mD53H7ToFFth9K+u3H
	 KDBSKfhY7PKSPW21WH9KyoNzTgKkxQQtbTnFNvqTonu5yjVfcEs5t6eEWQnHmmwAxO
	 MLsc5S/hxb5LlfrDDXlRvCIbag72MdNdUlM24pQNA9qG3/ROOGBbseMCNvQLftNVBZ
	 N3bwBlMzXiSTgL5SpkVNbnZTBWyWXbmBE2+zT4jvS5e2E9kEMLyVRMiyMuwQm8GTc3
	 jl4GPTe0ZUJ1Hf2JqpHOsB+W4esa79X1AU4X/UPb+VgJ7Ke1o7KAPveC6dPtLabq+t
	 n7BGINujDqJsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A623930A0F;
	Wed, 10 Jun 2026 00:05:55 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260609125007.GA450183@nvidia.com>
References: <20260609125007.GA450183@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260609125007.GA450183@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 13e91fd076306f5d0cdfa14f53d69e37274723c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fed2efe803e014e5c419bc7592caa8633683603e
Message-Id: <178104995361.2756347.6115932380409505243.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jun 2026 00:05:53 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:torvalds@linux-foundation.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leonro@nvidia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22050-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F136664E2C

The pull request you sent on Tue, 9 Jun 2026 09:50:07 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fed2efe803e014e5c419bc7592caa8633683603e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

