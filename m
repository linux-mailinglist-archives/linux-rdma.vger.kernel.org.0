Return-Path: <linux-rdma+bounces-5077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964F984BA7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 21:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3CD1B219EF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F5F137903;
	Tue, 24 Sep 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btPQyLbX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F513C690;
	Tue, 24 Sep 2024 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206577; cv=none; b=HtGI2qF6l1gl3WlrYDiA+OlbYKnukxsfhfZDhcT1xf1EZQYAT8uv4k2CSbJBbKbtpMv6ANywzBTQWNy0hH7tPLSfJsN++GuXP8Y5SBB0GQzb3UKzS6TdZNxKCsIkY7Aar2JSb7OaWpW297Ts4DkUzpxYEJE5BJs+Qwwx18PtdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206577; c=relaxed/simple;
	bh=D8kxFaLU4GmvlRFhWdkfQ1CIqeaOtuNfFwcWa7qFym8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NEkd9V99BJ8pTGd0AKQY2F8kqL9YmTaUe8ltlOE73VvpYgMrSt9XU8LNZzAmjwQL02J68CzgEoQC7PKjffsrHSG4oWttzCefq9hBtpQGM2We9+INVZiZabN5xremSRKdAnaEzGBSaazhW0vzhrO183YLT8XSGoYUTWXsl6P79og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btPQyLbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC633C4CED1;
	Tue, 24 Sep 2024 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727206576;
	bh=D8kxFaLU4GmvlRFhWdkfQ1CIqeaOtuNfFwcWa7qFym8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=btPQyLbXYzjgj80GwEv+wkpXBtZmuRg9W3GwD+PzawfhrlVhe33EpLQxbuN+kve97
	 RSrt1237nirlgPWPgDIDVnbbK1MyiwNSOBAf0wdzazVgTHHe+DHCwDW6XrLpUczNOi
	 eFPw5xDZaLlMWjkhFpq4kkEcC/kO0VIc7v6Q0jtVV4BcPY7GIPnhU9sgqpdMet8w8W
	 USgajbRvLr1UAVOE06UdiiaQn31K7hYOXX6Hx1GnEwc4mwxZ9VvU4Zk5TBz0A/QgME
	 /IgQ2i/nj9R4jWxJzMFkegZSLa873xH3lvLUgBikRjU39bGajTe+fwjaEck8ry91cP
	 IKA03gD8mBIdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C533806656;
	Tue, 24 Sep 2024 19:36:20 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923171614.GA53576@nvidia.com>
References: <20240923171614.GA53576@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923171614.GA53576@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 70920941923316b760bc7a804eb3d49a126d8712
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54d7e8190ecfe72ff0dab96545e782f7298cb69a
Message-Id: <172720657893.4172315.8302928404758688271.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 19:36:18 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 14:16:14 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54d7e8190ecfe72ff0dab96545e782f7298cb69a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

