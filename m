Return-Path: <linux-rdma+bounces-10922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC2AC94B6
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1735A8000D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F322367AF;
	Fri, 30 May 2025 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbRrAgwJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D27260A;
	Fri, 30 May 2025 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626080; cv=none; b=ZCogmlC98yc73QKpwdNjGSZ+HYnJBMtly6qpRHDaTpKsOLod4JzKCIMVIpy+i3yTwlKpGGtXPyOCPb4YJJUBb7ZJeUwQDuQP8210Sf+fxiUHZBxYOCY7OvL7QEo6LkXRUDsIWJM1VdZu7M7awn9IEsLpraScQN63XsATXJb13j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626080; c=relaxed/simple;
	bh=QImpCFod3f4n+1s0DpU6nr1UzDM33FhlDlCdbi4vt9I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pZKInGEs9HX961Q5XnOPw0C4ajDxS01bvQgfMwgjLEDgiVa8jtBPGbXHvshlKKckqkLO48UBuH+mwwp01rUXVbtLV/Dqmjq8e6WGkQHwtAW+o22b5jlENAQM+bHZWgL4SXDToTVXYq9qbDKqqPJAJJTR/TZL8nZUCglteDRbT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbRrAgwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB68C4CEE9;
	Fri, 30 May 2025 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748626080;
	bh=QImpCFod3f4n+1s0DpU6nr1UzDM33FhlDlCdbi4vt9I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qbRrAgwJqo0O7qHRNxvTVvZEUePbm1JTuNUSFF4aMaDO3QdjcgzjCdAG5TrybkBYf
	 HzeseAfblHIE7EDxMc27eEcVILdrJqR4sBcjtL+RI5x/+1d534LU71VdISLMOwhNQ1
	 TFk/lUkqsA6TExEvrunxPJ5BgQ4+ce4yLHTi0HB+IHtIE39ORPPAElmrHk+ylofQoZ
	 yZ+U3QG5LS8Bf2MoVYJJNEN/geZacftviDZT6RsPkJt6FKe6zfwymLHGCx9x4yGgku
	 uLIN5iXUFl5dMohqtB++Q2tu+LjPIoPs1wW00oyWqL5iLFCu1jpdMLbuNAbDSNApMp
	 uob+Ka63YG0JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02439F1DF2;
	Fri, 30 May 2025 17:28:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250530144213.GA294859@nvidia.com>
References: <20250530144213.GA294859@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250530144213.GA294859@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 92a251c3df8ea1991cd9fe00f1ab0cfce18d7711
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd91b5e1d6448794c07378d1be12e3261c8769e7
Message-Id: <174862611337.4033976.11450096697382345618.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 17:28:33 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 May 2025 11:42:13 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd91b5e1d6448794c07378d1be12e3261c8769e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

