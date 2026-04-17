Return-Path: <linux-rdma+bounces-19407-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDX5JC234WnxxAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19407-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 06:29:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EA416D9F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 06:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C263830CE99F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 04:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9671EE7C6;
	Fri, 17 Apr 2026 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul7xI9jw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255730EF82;
	Fri, 17 Apr 2026 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400147; cv=none; b=mD/0opfL4pbomGd3iWun1GwG0ljd7Qo6dXNjw20RDOMZu+jFy/pWahAJMJQ5IpJtOes/lWA/H3qSPeoeToDqEjBleBQVTwybGRoDJh1ERW45ehiAD3ncc4RuSR2+JFjInCnG0A22VJWkwqxm7ScxuEVC3omdhh8xhCN1MlouPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400147; c=relaxed/simple;
	bh=IEfe9oki188nLOX4Bd/cL9c4EcqAthvst6DVxATAG5U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RRj6KAN2TMB9wRBzkFcvZwqzMpz+8TcAUJiMaIrkSqqwTOsKceJcV2NqbYcj3Hvg6LsOU5EZNTo1gkEPSGxuqa1wEsLRceJRnvXp8Ss4Iug6tHGf9WW3CZsUhN+GdvaJW+NMuy6bQKtYOODJmJGZSHXeI9NBHeZkj0EMsootvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul7xI9jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E2EC19425;
	Fri, 17 Apr 2026 04:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400147;
	bh=IEfe9oki188nLOX4Bd/cL9c4EcqAthvst6DVxATAG5U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ul7xI9jwMmxIrxBJic0vDQTwwaXj35a80YRdBPSgB56TIG0LAtMv+0i15TWFo0CNs
	 VWhf8FhM9sLtUSKmYeAU0HAFlLnd4lZ8WdT0//VCcW9UTzdWuRR4B19IX377ejVos+
	 8qVZSNv2HyHwk2NCxG+POBQeyqGCycqtTf903cYM0amwTpKKtybd20TdLsnapQbQc7
	 ldWAz+CwkJLyqpniFFuBygJYtOmZFZbaqepgjTmWYxxhWq+6jD9Vj/R351jiNPIbHb
	 3Msr/ddkB1z4FsVYMJBCtdxkc/6q/bluGh8Y6zkSPCxR3XCt0YspKulcflNVsOwqx0
	 mYFNgfAzy/5UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD7F380AA78;
	Fri, 17 Apr 2026 04:28:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull FWCTL subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260416141153.GA1646988@nvidia.com>
References: <20260416141153.GA1646988@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260416141153.GA1646988@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl
X-PR-Tracked-Commit-Id: a55f80233f384dc89ef3425b2e1dd0e6d44bcf29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87fe97a184c000a3941e2b53671742993abb1ddc
Message-Id: <177640011468.3538458.14524320514426798479.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 04:28:34 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Saeed Mahameed <saeedm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19407-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-rdma@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E08EA416D9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu, 16 Apr 2026 11:11:53 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87fe97a184c000a3941e2b53671742993abb1ddc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

