Return-Path: <linux-rdma+bounces-23150-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IxofKFwZVWrBjwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23150-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 18:59:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27674DCE0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 18:59:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GXP3A8eJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23150-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23150-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E1823055551
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F1331EB5;
	Mon, 13 Jul 2026 16:58:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2326E165;
	Mon, 13 Jul 2026 16:58:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961915; cv=none; b=oSg020pHraeMjdk4E13xBhhgnOk7/jbMvxbBrQ9YzoAzGCJo7leboS70IrPliWlxfqEj5CmNaE0ihLqQp+gKTuOPqtJaUIoyYL6aOLwpyRr2d/xX7ksTHvdZOTMirQNETD01fwcqsBuNkbW15Ri00FzVS16Z78WFZIRc5mGcotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961915; c=relaxed/simple;
	bh=41LNvfl7nzywguoI/dIUECYIGy5Q9V7Cjxc3djCPsi8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U0aJqO4K/MvMTji2jmA8BRLYU6WAli4NXFP70yAUAiGPL9w91lp/npib2eQfsxDR6VvhiN13NU8IQ9TGnIJdioTAe6jbEy0ctaA7J1ZD7HMoSKIbwC7EV/p/78Sn4LzYgzQ01j/xD7pttiUVmz9W554xxNnLPjhEjHu4C6Bct5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXP3A8eJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C291F000E9;
	Mon, 13 Jul 2026 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783961914;
	bh=wSejJnyfdLyFdD/lgL1N6KK1dEiBT0efOAQgTJ/QwGU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GXP3A8eJCXJ7lAqQgOPSvptycamZlbay4wCE6/NNwo7fRf1xjByW/PK+5zJpxpAf+
	 VYWEddouDn23pSFYB5YlFr1e5cApZE+CSU6PyIEtyM+X1IdkenO8ZPFaPR4fgmfPaR
	 2vw37DEarUACvs/SyoSASQJZEuYVglGRJP0zCZ4Z4MMQ5T42iIYWDe3cNAoiNkRGCC
	 3dZE7Lvoyx01tIx06lJFZV6N1Ps3yH/4lWPE7oxwRzufLek25tup2Hf7jaSJd8PNnq
	 2KgeL4yHwY7gGtEVnLbFEUdSfRlFsmbtchGBLQf3uynWQxz65CPYDR2rgHEd5bYgPd
	 a1sknU5FzxFaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199CC3924F84;
	Mon, 13 Jul 2026 16:58:11 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260713130149.GA3130810@nvidia.com>
References: <20260713130149.GA3130810@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260713130149.GA3130810@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 3cda0dfe8c651dcbb9e38977905d3d3b1750c4ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fd8b67e27ff7115b98aa09b9a22eb06e5370d2b
Message-Id: <178396188962.2325401.7879971320175383252.pr-tracker-bot@kernel.org>
Date: Mon, 13 Jul 2026 16:58:09 +0000
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:torvalds@linux-foundation.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leonro@nvidia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23150-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA27674DCE0

The pull request you sent on Mon, 13 Jul 2026 10:01:49 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fd8b67e27ff7115b98aa09b9a22eb06e5370d2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

