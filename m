Return-Path: <linux-rdma+bounces-334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E980AE2A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 21:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F01B1C20299
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F543B78A;
	Fri,  8 Dec 2023 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYL663Lr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E41944C
	for <linux-rdma@vger.kernel.org>; Fri,  8 Dec 2023 20:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D978C433C7;
	Fri,  8 Dec 2023 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702068320;
	bh=yRVRqAQzerPrL7IolGQXD7ZPkiuu/3qjaW3gIcHoBBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RYL663Lrel9x4K+iecvnywW8nMmD5h4G4/dDV+CIBy+EU+95L9FDPhmewotOuf6zo
	 3AiKhGoAll0S9ls7B62YHsba4UnLFZrJASt/e2hBjmcO/Nz1wU2AkKRVWyAe/ZvHbO
	 DVWltcQCXhEJVcQ4B5fIcmC7NQNm+OOQVNFrYe1D8pSZLpCQ52WGlq3TMooBA5dHBQ
	 +DsBwPNcDevaXcgClDSnD9XVdbCVaLWxi/B8ZzBikj6pPeGMg3eHS+45TPwtJtO8RQ
	 WEYxOiuWUCBCputf4uG2dnx0w8RePJfdJLTkN3f9iWM2fpvgDxHXN170rYzqb6nlT8
	 ddoFPwjxOmRzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58AB6DD4F1E;
	Fri,  8 Dec 2023 20:45:20 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231208141911.GA2934372@nvidia.com>
References: <20231208141911.GA2934372@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231208141911.GA2934372@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: e3e82fcb79eeb3f1a88a89f676831773caff514a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8aa74869d2e9d868b1c4598eecc1a89f637a92cf
Message-Id: <170206832035.6831.1964570469740054207.pr-tracker-bot@kernel.org>
Date: Fri, 08 Dec 2023 20:45:20 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Dec 2023 10:19:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8aa74869d2e9d868b1c4598eecc1a89f637a92cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

