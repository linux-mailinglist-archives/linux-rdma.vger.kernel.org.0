Return-Path: <linux-rdma+bounces-8099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4AA4515B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 01:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E1C189CD7B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515940C03;
	Wed, 26 Feb 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec+JTauw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF047F4A;
	Wed, 26 Feb 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529202; cv=none; b=XsEqXwTcC5V4n3Nfeth++qVakS+gLV96puzyE2zbcP5wBAS/Uua4lC4EpOq8QLVcklwGTvCACZxyT6glJYDOvXO/YKlULdqC8eDrbdjJcZt33Dg39u9zLe/Nc16d190uoEOFBCutayDRuYbyDSnZ+S9pPSvGDurf0sJPrD8sVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529202; c=relaxed/simple;
	bh=R5w9HSa8JfJx6MrcgY+bd5/ecukvj/vwIuqQFd4C4YI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V3sXXjN1Ux4MbcvxZvpsjhXatgiRpFAtoiwMMNGTxm0xFalWAmsq/0Lajb+ca9cDvYYOD88uRFDsE5ma17xT8GDjEzMCx4gCXsxyTxi1k2pZjQ3ofrSA7zig7+HP/YMr+/jGo1fuVhiltYdHW1gG5t/XAYpLPbISowHpISTk3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec+JTauw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F76DC4CEDD;
	Wed, 26 Feb 2025 00:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740529202;
	bh=R5w9HSa8JfJx6MrcgY+bd5/ecukvj/vwIuqQFd4C4YI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ec+JTauw7/ZPFNbxzGtrg5NfoKgrgsgiI38fXLNOP13uyiUp2maIxSYccs0k/4Jo0
	 3Q80AUU9DyBMThdGKjP3GBtZKRS1ar5TzDlJ6+vumRjGXSa0ahGA3ybDtRNXK2z41R
	 mz+Utq/m5Yk2lLwocssjpRukhrUXRUSbGB3p5EzbcoWi9mPHIbB6JTFFlQJaW131Z+
	 qAmtlFYmtlAB+2Cu9vVJfGPNcuUyD9uZg2oErlFcFFZkwoJSD283sgyohngB66xPgZ
	 xRt88AIN4vsMYHr4O4g4wH57cDF0Nbb5VvxnMt2Zm1quqJ99KCu8SbbvijpXo/E3pt
	 TkIfEmlX+Zoug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EFF380CFDC;
	Wed, 26 Feb 2025 00:20:35 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250225192249.GA637700@nvidia.com>
References: <20250225192249.GA637700@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250225192249.GA637700@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: b66535356a4834a234f99e16a97eb51f2c6c5a7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
Message-Id: <174052923404.175592.14963006876546718593.pr-tracker-bot@kernel.org>
Date: Wed, 26 Feb 2025 00:20:34 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Feb 2025 15:22:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

