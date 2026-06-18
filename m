Return-Path: <linux-rdma+bounces-22354-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B8jyMBoONGpEMgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22354-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 17:26:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 373036A13A4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 17:26:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fSQrryH2;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22354-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22354-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BED330DE873
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5083FBB6C;
	Thu, 18 Jun 2026 15:22:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A8331EA8;
	Thu, 18 Jun 2026 15:22:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796140; cv=none; b=JA9jbnPWL6gaQpmUfL8kmTyY6M58Z0ZgWKYssAU5XZW0aTTjDDHth0X955NRayvCgi2PgVinbM776YiMaaZxWCFYayZn97D/1Yo99aFJ3rT78SMiYibXltitCCQB+RNGlfXbRMDuDD0Dr60JV1wfkPbyoJO57DR1xaTu3smemvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796140; c=relaxed/simple;
	bh=A2/SsB+0Qzpcq2XjxxrNFWYCvPBAJ58nk++x4EDi4Cs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SlMP5g0NoIiD+b68OCKGJVXngGy0LppqIlYGQ32AIrMxUbxHwEyfJ2+7qB/O/4BvSVvhrB7wT0xNe2ow3jKOUvkYErQvmta60TKt6AsCccav6aXDAKsHyOyF3Cv2BM01vqBiiRLCAS/nauGFhObjVceWMQXjpIAVOaYk2/Ylfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSQrryH2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D013E1F000E9;
	Thu, 18 Jun 2026 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796138;
	bh=W/fNRPgH81+9mJUx6ctlxyFuuF8qaydxKr6RbWsjwMI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fSQrryH2t7+RWejLp9QtdRqxGLVRwlEs9ZLHbeDaCBeXzaHHfmBd2n/HAe/4J6aeN
	 TdUl1mjva79YiVFZac3mkRFw+IzyOkdjYa47eevMzJHnVT2GTvl4VezM1qSDSYaapk
	 +NcazrYYvBUI2u4jlynnyeJeOmNB6Z50FzpINpcJuLxfeQbCIFsm2DqHgoty9Yz/Vr
	 Bcsl3eeGzNqp45Tv9hNaLDPMgPShlwhHtSzN6tUg8SNHPjiQu/EYq5xMPMWSh1YyBh
	 n8JEni1iX2yGqio8S9ZQvv0vawGLU7Cv6XkVCzWq75rTiO03zSSzztHTIVBBcKdFrg
	 /q1RL/oRfRDtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B653A566DE;
	Thu, 18 Jun 2026 15:22:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617201545.GA320356@nvidia.com>
References: <20260617201545.GA320356@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260617201545.GA320356@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: d9c8c45e6d2f438a3c8e643ae78b59454fa0fadd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e7e6633458362db72427b48effad8d759131c35
Message-Id: <178179613230.2947725.16863926065982398550.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jun 2026 15:22:12 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:torvalds@linux-foundation.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leonro@nvidia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22354-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 373036A13A4

The pull request you sent on Wed, 17 Jun 2026 17:15:45 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e7e6633458362db72427b48effad8d759131c35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

