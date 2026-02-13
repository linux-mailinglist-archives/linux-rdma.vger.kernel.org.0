Return-Path: <linux-rdma+bounces-16800-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNTzAjN8jmmJCgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16800-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 02:19:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A11323C5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 02:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE89E30DC403
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F96723BD1F;
	Fri, 13 Feb 2026 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLJYS0aN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603F224AFA;
	Fri, 13 Feb 2026 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945526; cv=none; b=KFO6N149x78HCFRtOVDTiTQ2pWtQEjJcBrAFKSvbvZp0wrthZV16ae+UmfX/J7pecbA4zlUJg0/1N57wk+BWIMItsNGjKZYM/NkVQT42AyujMjUJ2YWF7qRbFjd0oRAInQOyT630rD50CGigNqFS9N86AKlpb/zU+csxNWq9mmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945526; c=relaxed/simple;
	bh=xKPTG2mO2FEbwCwUNogHrGXJ/mhnIeAseDVAxd5XgNs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BhgbZA3P5Y3R5PCaf5Ro4UKU9j8dG3YN8QSoBGhrodCkxrpOYkT1OwLa7f0flndQxpKa0vf57u/xS+LTXzeLjqM/fh80/fhscjNWIuqyeX76B8fKWkc33VhMsfMWkBYFpBLTnHlzR7O/xfNZhBF7XF163Jbrr/iS+bYD1sutpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLJYS0aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BD3C19422;
	Fri, 13 Feb 2026 01:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770945525;
	bh=xKPTG2mO2FEbwCwUNogHrGXJ/mhnIeAseDVAxd5XgNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TLJYS0aNlxcP3q2KQQSNnnfuYk0IZUROLVO5fHQX5Guzmm8IGP9VwfHxxdCzO0WBH
	 TMv/Z2YC9qdm0H7TcImqaZozcjvyYGnWSQoZQRPwpl10ZByxetd9rNk2ThD+tDnihq
	 E8bEJ28vyzoFG9AUTxNNRsi3qNf/VUxN5y3GMBXEXlc9JaJ4mF4h8ZVcqFCaJaDSHy
	 D1Jgpzpns3eT2/WAKR4LlCzodP2JzrAO+dIcLwVTFUC5/YzvsTBO3RKKBL21EsCRHa
	 wEZqPgCkX3pKtPjQ833Y8LbGBEyuoDG/RF3UxOLjcFkZsrx7qdGT7lpTKm41uxf/h6
	 bydy12+f6MMYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 480DD393108D;
	Fri, 13 Feb 2026 01:18:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260213003420.GA1062479@nvidia.com>
References: <20260213003420.GA1062479@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260213003420.GA1062479@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: d6c58f4eb3d00a695f5a610ea780cad322ec714e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 311aa68319f6a3d64a1e6d940d885830c7acba4c
Message-Id: <177094551994.1792804.1378842482319486390.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 01:18:39 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16800-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 840A11323C5
X-Rspamd-Action: no action

The pull request you sent on Thu, 12 Feb 2026 20:34:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/311aa68319f6a3d64a1e6d940d885830c7acba4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

