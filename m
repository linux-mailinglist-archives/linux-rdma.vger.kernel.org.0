Return-Path: <linux-rdma+bounces-21197-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMZ0M9HUEWrvqwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21197-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 18:24:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636B5BFCB3
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ED3230209E8
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 16:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8831DDBB;
	Sat, 23 May 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU2Q9tne"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0784316197;
	Sat, 23 May 2026 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553422; cv=none; b=dljNb6NaL9Fxt2ddSC6SCVmYQeFXJunb9pzrJl3b3aoF1zY6442df9OKOOrpQ/CxHKi9F5t1CKeezu74fUrqbJ1/PoLjJt+vhxHVehyK0PLoBbQdmiSXq+Gkc0whbgbjFenP09riXW6voRiVZQm24qLG6DgJiZ1J2P/boK6spWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553422; c=relaxed/simple;
	bh=hjeUxWgydteIuisH9JMMnFlLtn70SEIGdiEji/wc9FM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L+IK4Z3haxdH/LPgAxb1q/puVk+V6xdBPQJMJWDM3NEB8oDP5cfhHwGnD2hf3gBAVcT9nZlyknHp44rP1rS2ckVBUjvdS0NRoWHkB+grlornQY+Gu7nlln3E25pz9XO1SQdBM8B7GVQEuX7dA2Jk6Ijco3wWDu9M3hiLtQ4VDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU2Q9tne; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C6D1F000E9;
	Sat, 23 May 2026 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779553420;
	bh=7sK6MkDjM5LgfdJ4F8gEhmf+4NEzTCGHTtHF33yhb1w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CU2Q9tne37PrcQ7ZHAFr2igoFMqYPOl2fzyh1gw3wm71Yni/sedZTpbXhEAtsmxvl
	 enVE3Ehx++pzpRaxEvfJ9dcutKf/yTfjWo1DYI272EdtZCTrBTlCNOCraohn4ZUlnW
	 mjpu4nj6+i7C3c/uMj9kI9ZMqFgo/EQdv3pvm9Y+F4uV6SQNub7YWa1AEleSF30svn
	 QXHeWkXESUfEw13XAXChlsZaJH5MwRYaXP3L793CukFNsiIRvQzNF4UI2KFACn8pHD
	 ZpzWACVr2fmuxPWFiLwz2IRb0QnDn0QvH0lrM5j0aU/kNDw7c+myzeil6zI68yBPj1
	 dvb1A65z6gBWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93DB13808205;
	Sat, 23 May 2026 16:23:49 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull FWCTL subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260522232501.GA1168039@nvidia.com>
References: <20260522232501.GA1168039@nvidia.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260522232501.GA1168039@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl
X-PR-Tracked-Commit-Id: e7537735028c3ad4b0bfc02ff8fa2a1a28aa04fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f53a244224ec0304209917e3f4d68dc83b1967db
Message-Id: <177955342806.1611769.309283381910606227.pr-tracker-bot@kernel.org>
Date: Sat, 23 May 2026 16:23:48 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21197-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3636B5BFCB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Fri, 22 May 2026 20:25:01 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f53a244224ec0304209917e3f4d68dc83b1967db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

