Return-Path: <linux-rdma+bounces-1481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B739B87F341
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582C21F21AAA
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470465B1F6;
	Mon, 18 Mar 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaVXxpaG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FD5A7BA;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802043; cv=none; b=Sk07Mcya1yhEd/5SbD8rRpdFB/e5IY3n3tLWdovap3UsnprB34eLzPrZU9Mxx1cpd16vc9FlyRXEiYYz4j8+/TS7xlKshL30iuc6DD/odd/oxIFo1kf7OUENH5iVbhlzEbT9wLICl/2Q7QeO+TXZF1YPFMM0/TrgwVDTvkwzUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802043; c=relaxed/simple;
	bh=iLKo/U3WZLmtrsX/dhBH7iTkvhGmqKqRt+KKdoB31eM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O9uYmqgkn77ex3SUwKZqIKYxGLJAS3rVglyKHavsn+jFK6+9mlHiKS87N9ikSbOELUaQYI0bJU7mJfOXNBGZV5mgKJN6e69/tYtgnjNw9SQ5YTv+Z/4Lc9aM/pBwn4oHCqW1UPy7H0sGAo5fJ4byLV4E4jPOu1tK3iRgg0A0dyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaVXxpaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D25A8C433F1;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710802042;
	bh=iLKo/U3WZLmtrsX/dhBH7iTkvhGmqKqRt+KKdoB31eM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gaVXxpaGzuFVAbykuTRUyz+95kz4GBDrXHxcQp6Y6ww7e/zxHBDlEhAUxTIKwhIqi
	 KitTvhrMBkCh7avvgEzD268yWbBZsiD9xFM5rLwxbv6jNkuM8SVd4zdj6JSZeJZEOY
	 X5/7JFjKRlU1tjXJDjSn1+5VxJlTnrzAjXYGVolqbZ3962/SBDlyoBojvpToHdgeIb
	 G5tP6p1uPfahhuOt4ukztoB7TXsM1/R8CDoOqajIrYK9ND4ySJmRLB5qCsh/ClRsov
	 ViReCeiF8PnKDSTXHesdgVoFzhV+U5LZhF+Tp5av16QIMbVOv3IB5yKgjU5LwtL7/k
	 ZCVCL2Ig9Obtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB0A1D84BB3;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240318165111.GA71443@nvidia.com>
References: <20240318165111.GA71443@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240318165111.GA71443@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6207b37eb5c5e48f45f3ffe0a299d2df6b42ed69
Message-Id: <171080204282.23091.3119379779152125017.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 22:47:22 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 13:51:11 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6207b37eb5c5e48f45f3ffe0a299d2df6b42ed69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

