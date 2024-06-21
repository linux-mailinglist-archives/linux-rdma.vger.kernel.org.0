Return-Path: <linux-rdma+bounces-3405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F267912F36
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 23:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8BE28591C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157AE17BB3A;
	Fri, 21 Jun 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrZtTkdH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703017BB1A;
	Fri, 21 Jun 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004145; cv=none; b=sOi2Z/KO0D1YpJabYgxfK4reXptrwwYE6gOpG/R6JsqQdOHMGwOtu+6EF6r9UTQz47J1nCGndsj7qstPTCJMp8l9YAU7ud/BOOAh3+XzCldg4tCZLeMH79XBxDokypgb0lMY/cmzyn/Jxrj2reDywLJFDoZe5ikTXJFJNSl7kmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004145; c=relaxed/simple;
	bh=f7jhaMLrladqfwHEBY+z44EUHCbShDJHhXI4jOMEk9I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b3tk8Zhn0hyEx6725TCa9gDJHYB8lkToIlM7dKnzvnIr/MH52/lo0wgOAU4HCm9LHflEFf0KE7yg9pEWf1YRWCjblZLHwxheY9qHNeYdraVYFV4BWFbOTLAxnMQVB2m7S69dBVKsDrpnBy2Om6JvgVYGaCakOZSn79o+seF7Ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrZtTkdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52D81C2BBFC;
	Fri, 21 Jun 2024 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004145;
	bh=f7jhaMLrladqfwHEBY+z44EUHCbShDJHhXI4jOMEk9I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TrZtTkdHRJ9luullQskzpFWkluyVpwejQG8LZmhJj+PZbXIlIJu3RA11tCAuuGBoy
	 6SP0e6kMVo6prWrTsZpTzcf/CjyqI/V75x6qVBzqoU7QYXpw1l7e1ri/Qo1KEPTyGH
	 c1ePoCAfVcWKvv1/7oZIa3slAWnpiX8hvj7rMnEZ+cNjoxiMOxbzqPpeztIzB3N5z0
	 MIZnVrulzuRUhdEhwvuJn+9ySfRvsdDix9at5mzd+JBUmyxnzs2Tdv5Imz2OZzXAJb
	 vwVRZC+ry5hbiUACVmS57nhmZn2SUcVR5ugZVcY5uyD00FSdmpzoPP7j5LCvVvE3o3
	 HLYR3VYCdyJ1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4988CC4167D;
	Fri, 21 Jun 2024 21:09:05 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240621132450.GA4186507@nvidia.com>
References: <20240621132450.GA4186507@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240621132450.GA4186507@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 82a5cc783d49b86afd2f60e297ecd85223c39f88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffdf504cab55743ad55961afae41ad4a079e74bb
Message-Id: <171900414529.4758.5684428281546543144.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 21:09:05 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 10:24:50 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffdf504cab55743ad55961afae41ad4a079e74bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

