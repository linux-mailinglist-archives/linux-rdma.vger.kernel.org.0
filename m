Return-Path: <linux-rdma+bounces-8875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B23A6ABA2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 18:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06FA3BCD1C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 17:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0321CA00;
	Thu, 20 Mar 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0+8wHrQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5C42065;
	Thu, 20 Mar 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490127; cv=none; b=WJi/1+cS5QwUba4YYo+91DtWdXEmobJ0iG9puTHagGvxEtWL2a20Zl+uJwVRsMw8iNa24/k3KFgZPW9QURGgZGDvJoA7/5yenZk5KTUV8QO/nOMRxBiahqhSYoTIQNxxToL/DE302azOdgIXGPcR3B2jzN7jwrywG8yzEOII8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490127; c=relaxed/simple;
	bh=gEic8ahRJ6KDT1FdnB31aZgxgWDn2gK6N0fqnHkK00Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D9Qrv0McMCXZe5KLd6xF4hFIvXyagkf1mbG4LpVfgihn/BEQfFj5Pn/R59cgJZjTDD2dquXAIltqTfeN13mPIukvItHaZkSewit8C39kxLcW5KneXqJMRr8w5PTbFK4LvioAFmi0kc9MpQlZcPPr93pOvEMvBEraxqrpkaZzn5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0+8wHrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56975C4CEDD;
	Thu, 20 Mar 2025 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742490127;
	bh=gEic8ahRJ6KDT1FdnB31aZgxgWDn2gK6N0fqnHkK00Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y0+8wHrQr1tVPoSfi+nfFMQUAXKtMxHJPyEuE6MjkWXudq02JO6roZTP0rZ+E5mHJ
	 UEjUhlzqsidRe2rTQI9R/KsnqsIZR+q/sECmXqYmBYpDGm/ol/7Kxt6VI76JEm6kd9
	 3FzhOxRhQq08XYD//1h5YYx6fVwcXCcxUXQB90RYPupZf6N5jzIeX15AD+MHAg9kw8
	 kCTfanGQ3Mufk0AP0LoFAeO4M7bFVjb7R7BQ3rruU/GUqKqDCOJen7JTJfZfy+FDey
	 RrUn94Wt4qkYtbGx2QmGtTo3Z8nfC6vY986XVTsLOWinfXiXiWibRRS94lNaM5VwiQ
	 ymgHjudZmFmKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 723C33806654;
	Thu, 20 Mar 2025 17:02:44 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250320145702.GA204190@nvidia.com>
References: <20250320145702.GA204190@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250320145702.GA204190@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 6b5e41a8b51fce520bb09bd651a29ef495e990de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80c4c25460849f441d35810555539aa3adc52929
Message-Id: <174249016297.1840953.8392459133555349988.pr-tracker-bot@kernel.org>
Date: Thu, 20 Mar 2025 17:02:42 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 11:57:02 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80c4c25460849f441d35810555539aa3adc52929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

