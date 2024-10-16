Return-Path: <linux-rdma+bounces-5437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC49A1469
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 22:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FE31C21DA7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806111D2B10;
	Wed, 16 Oct 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV8BlkVb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C31D27BE;
	Wed, 16 Oct 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111883; cv=none; b=FRttPiGeqwHlpvtUa1SpzJ85hjK2kjV8NIP/QJdZCrtoQ7yDPvSmCDflPKo7x8Y8KMEp6cvrhdtf5WdHlrKR3uEbgg78PPqrB/j3zFh+Gfbn/Oh3tmkWc4P8eZ0zQ5iCAP2l6Cww03xHe8oMdchkoD/rGDUw5+1DGMOUp8D5ym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111883; c=relaxed/simple;
	bh=xSYvh0kyBi4yvd8IkiZS3BTBY52kCFtP8FMuG+gkLq0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RGrlQ5Dgi3pVth6W/YqDFye3B2fxj2Yztfo+kmU3pVNbqSJy0onjLVQcx1kpY6pT2AprcvmXQ71QV/085F39U794BZq3kpzIGUIl7VthO7JI4dHqho1UHJucy2BUVbERCsE76kudrml8YpM0gJi7e+SPJOM+oIQSNsFVStuvHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV8BlkVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212A4C4CECF;
	Wed, 16 Oct 2024 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111883;
	bh=xSYvh0kyBi4yvd8IkiZS3BTBY52kCFtP8FMuG+gkLq0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SV8BlkVbMjTIvE/a8PSICdDI4k0bcjHyTz7MGpnXbucDdqJj7DEJZD6e+iayhm+L3
	 xa9XNQxpZVX1uXDxkzvDgA5Zi52Ib51/hh+cu7fozRzyQt8Ws4PnTK+VR9tLeD/6q+
	 8qqmNLReVjpaErlEJQdWtEA+8EDEIrjcBREyS7UY3bkdNdB+DIz3j9sJfx6XJDjWTF
	 AY+d6og37E6O/ny+7Dj8c21gj+KV21ekzBP/kfRKD4reFo2Q9VvImpdnKnij8J5ibS
	 1CINJdDoIBJyQ2GtW5lpvx0FDu9tgflxp3qhtZVRlKx1COvHnhLPR0pO3+F1ZWbmNU
	 DS7Ggr7DE+yYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5593822D30;
	Wed, 16 Oct 2024 20:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241016180031.GA176045@nvidia.com>
References: <20241016180031.GA176045@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241016180031.GA176045@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: dc5006cfcf62bea88076a587344ba5e00e66d1c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c964ced7726294d40913f2127c3f185a92cb4a41
Message-Id: <172911188841.1955101.1946458530402256543.pr-tracker-bot@kernel.org>
Date: Wed, 16 Oct 2024 20:51:28 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 16 Oct 2024 15:00:31 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c964ced7726294d40913f2127c3f185a92cb4a41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

