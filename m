Return-Path: <linux-rdma+bounces-11840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E499AF5F6E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA871BC3426
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18361301144;
	Wed,  2 Jul 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDPOMqno"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640730113F;
	Wed,  2 Jul 2025 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475989; cv=none; b=N6RzmCIIAo9njrSYot7t51UaEmpQGYrNpJhumPsS0k8PJp/27226vATdEGZe/EVy9D9vfRMGfpV2pUOn7IxCY5ufw//gNFV85rIwYIgOdU8sd5K8PuFfwXfiA6N915/DB8vH6+w2sybjDoDsodDMwa4p4ZE7SJl46UXp71r6PJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475989; c=relaxed/simple;
	bh=j0Y9Rzt8Pk0k4sGGgpJKmRk0g2LI2/oDGyPS78hhwtE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GaPUSXe89EjdukYS8fvsOwz3YceZvasvUv3J6oJ8l5kFqpm5EWbcDQOIxO/npszUEgNXikgix4PvIFcFJ1/2mMbvKrRdxWXOx2sgfQdSJ3NjKO8ErfHDL7uhu0HTWV62+R6U8oZLQSgy1YGWohe2rSaz890vm/1k5HTXTAfqjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDPOMqno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41CCC4CEE7;
	Wed,  2 Jul 2025 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475989;
	bh=j0Y9Rzt8Pk0k4sGGgpJKmRk0g2LI2/oDGyPS78hhwtE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZDPOMqno4yyQTiuiTm/834ZxQRKlCTVrna4mYiCCPRrhJfeD2rv1PG/Hu4BRjdqCI
	 g6Wmg56IqoEz7Y443Q8UCH2BP0Q/yHMXf8K+dwwrc9H93TG1OHTVGq6Pq35xeMRvYz
	 I9BoWI3t0u0tbgOQFEWSM0S4IjycEMTq9Gixaq4dh6HTvZ2bz16p97X7y9IzoixvJ7
	 yE5fBM3QXKdwZQ6LInWPYyVEe+kbwjcnFu81/wzeiG4g617u10kSCch/xI0+pscChd
	 8zJ34Lb1376HjRA9Bqe0XUwZ1ULj4N4LAJf7ToXMGDOD+STfRvWjOofZ4BokQajESe
	 TnfhyeAdyaBGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B2A383B273;
	Wed,  2 Jul 2025 17:06:55 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250702143616.GA1163046@nvidia.com>
References: <20250702143616.GA1163046@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250702143616.GA1163046@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: a9a9e68954f29b1e197663f76289db4879fd51bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e4a6b57dd7f55cce9ece0778c111905e73db7b1
Message-Id: <175147601412.796050.2826621785795235077.pr-tracker-bot@kernel.org>
Date: Wed, 02 Jul 2025 17:06:54 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 2 Jul 2025 11:36:16 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e4a6b57dd7f55cce9ece0778c111905e73db7b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

