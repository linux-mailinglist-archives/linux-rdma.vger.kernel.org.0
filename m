Return-Path: <linux-rdma+bounces-6797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B58A010F0
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2025 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557DC3A4320
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 23:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760C1CDA2E;
	Fri,  3 Jan 2025 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrIHTEV5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F21CCEF8;
	Fri,  3 Jan 2025 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946526; cv=none; b=hVkF5gz4/Gb9K23QSGrq3jCHR2yAWXaTaZyf2a4QhoG0yR0AFTzt/fwXuYnXsDWU3lkX+77HV9jtI4GPzxGIPYjin+bj6AaXgWmKFcCRqcDtA4IZ0rdKrfmOooLmhpsFY6V9mJ/06RZbr82eDfEDhoJWgzXLZMJvz+jKH0LPBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946526; c=relaxed/simple;
	bh=8nlOtH5imLsNG0lZ+cMEQWLrE8pOvoWxTtGJVKchsas=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N1EiVI+VAiqNJcDjdbKr1Gv7aONggzN5Ejx1HsJxjHpMXIAYnV3J2ZVh/I7qqAVQYOUqvaIVa0SJSSOQktsYdUDhMdmyksmIlZCn46NINSM+FSxuEpJi1gWlvisiIqC/nRLtWYuKTBbyy7VMJg3Tvot3dB9m2GUvRie4RAxoank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrIHTEV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCDDC4CEDD;
	Fri,  3 Jan 2025 23:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735946525;
	bh=8nlOtH5imLsNG0lZ+cMEQWLrE8pOvoWxTtGJVKchsas=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TrIHTEV5fVXBLvm3fAR4xfWpGr/Ra4pgf6J5jRNf4DmLQOlgBZHBvgePu4kF0/EJi
	 /OasD6PnTybFfGcUbcdJsfIPolFD5u3AgF5c6jlGTtwlN7ykHhrb12xFlMrHOMLmFK
	 bGjXvCms/uNndk1Svj/KXL+lnh6QLAZi/vOzbXu+PQgBbpRkZtYp7fwjhrQdgVEs7s
	 SvAue4R9+x/TaXUkxmvBdjSL2kIamPcwqyfm/PVr2VeL8q9kPZP9MZ5zisseKW0W1I
	 zkwAM7Hq3yI2X1eEOvjVSh6OTNzkwklhcCZuItXZkoehZgn+7JXiW32IEDuL5gV8XA
	 BGcy302LQUpaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE71380A974;
	Fri,  3 Jan 2025 23:22:27 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250103142412.GA170790@nvidia.com>
References: <20250103142412.GA170790@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250103142412.GA170790@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 45d339fefaa3dcd237038769e0d34584fb867390
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dea3165f989b259bc1293d9dfc50053223f5f4b2
Message-Id: <173594654641.2324745.17305964931508348533.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jan 2025 23:22:26 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Jan 2025 10:24:12 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dea3165f989b259bc1293d9dfc50053223f5f4b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

