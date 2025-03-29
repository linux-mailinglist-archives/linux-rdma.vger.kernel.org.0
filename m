Return-Path: <linux-rdma+bounces-9028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D5A7576A
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Mar 2025 19:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106923ACFCB
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Mar 2025 18:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666541D6188;
	Sat, 29 Mar 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4I2+cps"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F620B676;
	Sat, 29 Mar 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743272644; cv=none; b=g0288aWpPUuyvL2/FFelRwOtFB/KJEggXKVOd1BwcdrKE6vbeoHTmDtLSdd27B1VjUeNtkiO/RZhFy68htZrNzu15Ibq7c2Xd+a2IMGR0zQMn+bx8WZdjy58lhDldwG3HZF43eFTiBOWWsnKcgPp6jcJ9NvYjsk1vbI1czsYe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743272644; c=relaxed/simple;
	bh=wJCSBATLVoS9Auabsn0YpeFReJyvW++x4o6YsVaapHU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jnrZnfe1OtBtHqWzXDBMgOUynQmYQlGo1KSazUnPEMERhBHeQAYirljseABmd5Th3UIUqmavl73x1HuX84gxEo3+IjT/wSAnJl37dNViHFtNXUYxWjIY1x7MBK+lTI4Ojw2fJudDUg2o3DJj/sYJ0DHQiJHQZ67znJEj4qhi3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4I2+cps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4CFC4CEE2;
	Sat, 29 Mar 2025 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743272644;
	bh=wJCSBATLVoS9Auabsn0YpeFReJyvW++x4o6YsVaapHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F4I2+cpsB1YZzZuMfGjTqvAjegnvkSAgK3ZdjhJzB+fZvBFlPJZpxwZBGL3oFsADr
	 46yvgKJSeMDiBqv85sXF2WsO92siqoJuxyq4AIKTB5FZ/9vajIJmFgcdmdVkOHqYyC
	 eCebANl/AfU0BdWSfV5LDScuB2pnatiANIEfwEsX+Tn/kOxgzL082p51BFfmemmhcI
	 62h8tH7rfzRIp+x1YiEiHfvZ3YHJXTu24kJfDfZ5NwPxVHFUJeOVquldNDkLMlL3WI
	 U0f4kvqeXwYYShVhlTRW3zVwKjrE33VlYUs8yFtSAAVzvjoqC6RZ2QDQnsvThnDKqi
	 pj22NCsLWIlQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3FA380AAFA;
	Sat, 29 Mar 2025 18:24:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull fwctl subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z+F2tcBM1LJpTDF9@nvidia.com>
References: <Z+F2tcBM1LJpTDF9@nvidia.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z+F2tcBM1LJpTDF9@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-fwctl
X-PR-Tracked-Commit-Id: 403257070602fcd1512af6f24cecdb23da8a914a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ccff074d6aa45835ccb7c0e4a995a32e4c90b5a
Message-Id: <174327268018.3243059.10012259222353752539.pr-tracker-bot@kernel.org>
Date: Sat, 29 Mar 2025 18:24:40 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, Shannon Nelson <shannon.nelson@amd.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 12:13:57 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-fwctl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ccff074d6aa45835ccb7c0e4a995a32e4c90b5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

