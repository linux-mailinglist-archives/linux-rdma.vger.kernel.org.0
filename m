Return-Path: <linux-rdma+bounces-12622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86A0B1D203
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 07:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14F07A907B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 05:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5521CC79;
	Thu,  7 Aug 2025 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVDwPBb3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECC21C9E1;
	Thu,  7 Aug 2025 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544607; cv=none; b=LSAL8jQRhvjzRr9eSVdXTsF5ZnlpaZeMX7IeoCN+STdMEyaviYny0chwATZd3BlxmW2N97qpIU2tfnW9Z2QWMe8ASmA5AG5UUaWLRX5PP6OqQdmVD4G0udmcUbisKhQvDpRyWZM7+yb3Dhivuxc08PUkX46iltuAxrN+ToLKVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544607; c=relaxed/simple;
	bh=Wzd6UhoUg0yfSQztKgrpjHYw7FdC+UjXdbbk8o/OoKA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q6MAFblDYuOEOfr/8V/qPe8V4x/3dfNn60j3whBMhjnNwapeJDRrpFmQINuFj+D62QW1ZgP+7MgXWXfTigPparWCtTS18eY9WrKsxPeRUOYKNqIJjA3JOmQRqzkHEBg3raaA70AovHfbivUWTosQeBmpYjga01EIq1WzVhhj3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVDwPBb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFFEC4CEEB;
	Thu,  7 Aug 2025 05:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754544606;
	bh=Wzd6UhoUg0yfSQztKgrpjHYw7FdC+UjXdbbk8o/OoKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UVDwPBb3pPNOG5HZJ3pc2eAQ+u0UyL009r7RsQ3VGkeKnBlZefGZjvau4mGWPadFe
	 uy5PxzafteOOR8K9BKdWSPiDb+Jh7yFOnCvztR84EVWIpHibcqj2QSp3k3qNqYDEiK
	 DO+lRkcc3bKtoBmExyZICM/pe3k/njRzgydQGEOoxnqOqv+yc2O3cU1K+6xzeu7xIZ
	 k6rn35ia9vKSldKv3R9Gvynb/5qMT2ZYfnBeBe+YIj0d6O+aR0BJGdZlWtnTZlBASs
	 +0odkonc/UrvtrEaUpJZdZ71GtoMcBMyF2VHo9XIHXW8Alk+fyuu5YHE7fP4cZ2vDJ
	 ovAvOq2CQBf6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF04383BF56;
	Thu,  7 Aug 2025 05:30:21 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250806183616.GA441213@nvidia.com>
References: <20250806183616.GA441213@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250806183616.GA441213@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: c18646248fed07683d4cee8a8af933fc4fe83c0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2095cf558f65d9aad9a945e4fd1077b97bf61383
Message-Id: <175454462035.3059740.4284159928912062332.pr-tracker-bot@kernel.org>
Date: Thu, 07 Aug 2025 05:30:20 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Aug 2025 15:36:16 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2095cf558f65d9aad9a945e4fd1077b97bf61383

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

