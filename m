Return-Path: <linux-rdma+bounces-1991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3A08AB639
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 23:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C133B1F2211E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3372BAFA;
	Fri, 19 Apr 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO4G3VRL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9910A3B;
	Fri, 19 Apr 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560853; cv=none; b=H09nev+AJimNWOrHpscYJhBPt+pK7a+6TSEfWzzxaskxBcQz/XoEBK99R810YkknEwWJrcq+qwb7e6QMkCsAgKzNeOxIxL8ijqe51BGrt58SQlI2Vws+Dug7p6/8dd65JGEr3n+6lUqOgCC21X+muxjgQ/+6UYBG80nnayoZ228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560853; c=relaxed/simple;
	bh=iMsllzIxzYpYvWWTLWPaRmZGqROeJLGGWyEez5rTZZw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nuGMzXNReaj3Y8K/e0/LbKR5ZCRH3w2lZQj1CyKTggaw1mhZeaBG+G8F4chCx+TDzs8HDi0SBdXv9SWZdVIh+BAL/dzswpQ2xaLnyOJ8l/SIeJJmNrCzHqrA9yP4jejePsgtGLGz9bTMMbhw5tX/3p4hXZEnWOk1xeOJ2M9auF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO4G3VRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB35AC2BD11;
	Fri, 19 Apr 2024 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560852;
	bh=iMsllzIxzYpYvWWTLWPaRmZGqROeJLGGWyEez5rTZZw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oO4G3VRLOyutVBsY04QFUHexKH4GFaeo8AQ+KBaKJ95auvqRxjbCpfQgvkTpMQ+d5
	 9jxHMV6qhp03b3pr9et6L8PGyxdSoG4TmT1W8JhZgdDT9s5FXbcH6mr0TXxBVXw1Q8
	 OokiDbZ1EoG25NFcoUJGlVWXcR9+tbHe+5r7WTlzxaYSR2qfnPbk/Qdydg11GW5clm
	 G9fwgUJnLOS2ooOqvyxg5saS4T8U3m4uJEKbarE/Y/YPqcTHCDXcV5Wu/gL6Tb89Cd
	 ZaSO8nXEfX0p3IVA5/TB4hXRrELmEOo+Zb/0ifn5uIX/GHTuTs1LTmODRQrL+n5U0b
	 LazQCeHdoK0xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0D1EC433E9;
	Fri, 19 Apr 2024 21:07:32 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240419171909.GA3787433@nvidia.com>
References: <20240419171909.GA3787433@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240419171909.GA3787433@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: be121ffb384f53e966ee7299ffccc6eeb61bc73d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bf5dd7c735c837fcd847831f96e3239471363bc
Message-Id: <171356085278.511.3050442853996897417.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 21:07:32 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 14:19:09 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bf5dd7c735c837fcd847831f96e3239471363bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

