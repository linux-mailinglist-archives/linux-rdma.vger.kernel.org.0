Return-Path: <linux-rdma+bounces-15269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF106CEF538
	for <lists+linux-rdma@lfdr.de>; Fri, 02 Jan 2026 21:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32153037CE6
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jan 2026 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57992D12F3;
	Fri,  2 Jan 2026 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd5IBZot"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B52773E9;
	Fri,  2 Jan 2026 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386374; cv=none; b=jU4spwSbnCI+YFDqs2ZoBMJPkKuXi0i4rCoyaIMD0qUeOhHfHak8kJtFEZbmxIG7fJ8MMrEGCuX5IeJBCUtNLGKBeNgcIDK7BcVlWw5agnZ5GuNlKBvaW65qMVL9CnBvVtexPtFUF9Qg2XuPSteBtxFWI/Wbw5ZoM9vqBrKLdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386374; c=relaxed/simple;
	bh=A/Q0pRAj3YzTJYDYCPS1rYkOEftOG2/lq9t0kPXKmZk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MYT2BMd95b69ryaBWrSvetz/gw9hxgCEWSbyD6eMec7inQXUTM6fsjHVrcsc/Mt83571PKb3jXH7POdTMR1vGZDGLRdbnA+vpg4/odE/tpQMSMWp65Sts2dzJkF1itPB/mPnPJWKh9OCOn6zTfUL+Pf8MtKKg/qoQVFAwAW8eSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd5IBZot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC3C116B1;
	Fri,  2 Jan 2026 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767386374;
	bh=A/Q0pRAj3YzTJYDYCPS1rYkOEftOG2/lq9t0kPXKmZk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hd5IBZotnoi+riXijyKyapYcDxnxs1oMDFUacN3AFEawC0hc8vbQtmyQh58E7nZE2
	 jRzFK+X+A+7qZVE74MIz/8+TZgnThZaMu8WBfOznJWOtPMNS9v/Iiqb2cXXY6DLbpH
	 JtbX/b/ANT5h98becacYCRH6raDo83Bmll1/v1iQ1RdlKFe7kdKqO5dF8PDTpqKxp8
	 g1zdn+0hP0UCuIxYJ3L/tnX/wwXV8I/Ds3haOIezWjguKVf9EamD2pHcfk9ihLd5PT
	 FG/SgGCxe3skIoQceUzS09fUZ1CtLzF3/eGfn1VYXM/vxP9vgSoNV2zmqfqIH+v3xj
	 x6LCgdfS/2/rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8F3380A962;
	Fri,  2 Jan 2026 20:36:15 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260102181612.GA188355@nvidia.com>
References: <20260102181612.GA188355@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260102181612.GA188355@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: fcd431a9627f272b4c0bec445eba365fe2232a94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ce4d44fb0ca00644756c7e857166d12ffb4b833
Message-Id: <176738617383.4003266.18204191715989260682.pr-tracker-bot@kernel.org>
Date: Fri, 02 Jan 2026 20:36:13 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Jan 2026 14:16:12 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ce4d44fb0ca00644756c7e857166d12ffb4b833

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

