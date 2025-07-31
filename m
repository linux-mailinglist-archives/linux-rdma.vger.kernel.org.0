Return-Path: <linux-rdma+bounces-12561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E0B176E8
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 22:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0896C1AA87A1
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Jul 2025 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49F198E81;
	Thu, 31 Jul 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzPkrWNg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9872F24;
	Thu, 31 Jul 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992228; cv=none; b=LmUAiK33WRNxKcvhJp6m8oZBOor899Dggrsv7NYrNT2AuYRG0yKzssjBfIve7a/DOH6ndt4WzWYNsx6e0i35QohGJ1iBp2g28vh4/ueeu/HyO+6/lPG6dYWPMufOHlZooSTNlszJfcB7Ve1wqtcPmNbmMYozDXNExqYCJ4Eym8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992228; c=relaxed/simple;
	bh=bJ7eke0cxE9Xg/FyOE/NK67TIx6MvQFpjr5fj+9EiKQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MUBkT6Wq/rMoYp+ymw5edi+RwswxNiVni+dKu+WC/g19/fd7YPHREaoioyH1XDN+k+0qtOMwJUjOw8th1z+GmPqVzCx5bskyHRnKStH7hsB8yRVlqDpeV3PNA/evx9PdBacnp7wERj0Hsd1D+DXv9d4MCHIjEeGXavveYO87SIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzPkrWNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B616C4CEEF;
	Thu, 31 Jul 2025 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753992228;
	bh=bJ7eke0cxE9Xg/FyOE/NK67TIx6MvQFpjr5fj+9EiKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jzPkrWNgezR6BYvJIa+BqX6OTbLQv74HYPEehC9fj2HNgbK2CUsIZV0lZicediYz+
	 7WC86A97mhXGgoywEEigmh7zxJPGtfEd62Q2YNlxdHYtbY3sfzSAYoD+vyagygDMAg
	 BWAvFu3upMj4KGxeLw4BGv0uMGS0skuBsxbWfUvwfuGIi9xghN0RD9sAmdFKikHPY7
	 ryabPK40jBCulBWzHaQTT51+3JJkLSTeNT9io+Ly6jLIhaX3/4J5TAi8jT5rp8+4H0
	 fPfAfO9J8CsmQr+FUFbIodAylmZWmm3nP229qExJpUGPaaZpoxcPyyz8YHY0jDulKu
	 O8cGEJi17fOoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34032383BF51;
	Thu, 31 Jul 2025 20:04:05 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250730174523.GA152963@nvidia.com>
References: <20250730174523.GA152963@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250730174523.GA152963@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: ee235923d205c6de73bf5035f3cdcaee22f3291c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ce4de1cdaf11c39b507008dfb5a4e59079d4e8a
Message-Id: <175399224392.3278693.2939362555720409690.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 20:04:03 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 14:45:23 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ce4de1cdaf11c39b507008dfb5a4e59079d4e8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

