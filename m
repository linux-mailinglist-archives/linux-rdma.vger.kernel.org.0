Return-Path: <linux-rdma+bounces-2536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0A8C9253
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2024 23:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8621C20F0A
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2024 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02B6BB44;
	Sat, 18 May 2024 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3RyWUKZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97CEDF78;
	Sat, 18 May 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066357; cv=none; b=IvQMaqNZr4/GAoOvo8GdyrzxcjSxQT9ylEs/z4MAETVmk4wgqnVf/TQg1yy6perJl+eYMbOuDqu8ux6d7VTSjE4C0euWQgliw4S6lJ2u0AUX77+ke3V2/EwTSlSiQNzS19SQ4tsAvygttwXCDSE0+eS1VMx6quSVV5d6XCJYzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066357; c=relaxed/simple;
	bh=/xFaUxJjMJKfFKVEJMS4Kb5PaVkTNgHMbb4+tulOZYk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EnCOlq7QcPH/xuf6S8+QgsQt4RHjzkaA007ulc1nUTFSa54R2ZX7WTK9VMbh9kjvsep8kPkz3+OG4l8j2L5kLHNq95ZFdlIz6OLJuxkEl61ZIxUC3Rzdzn9EB0CwnUAF49UIbHOqLs8Kwd1sqn8668g7XiqCK5tL+ZIqw8UsqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3RyWUKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEE74C113CC;
	Sat, 18 May 2024 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716066357;
	bh=/xFaUxJjMJKfFKVEJMS4Kb5PaVkTNgHMbb4+tulOZYk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I3RyWUKZSpwx78+hd4QpyPSqQfWNiEzytYGZmH47tYZppzmXH0kq2zlDltN1H3Eod
	 M13O9ua7Gs1dAcSkIbVTnDodeJqRuWlbh4LpCrHQtknTWohMSFW7t9icvtD08h87aD
	 5A1GelyZRn9C/4X/WXTttS1zGwfMUZFAznVm8xHEUNijHMDM3SG1lCTAEaOsJyLWXG
	 yOsKxzURLWGW+LJuW39osFneRy8VmLSJFw982B9qmeL0nE9WptVz8vVBmsm+GxV+gF
	 uV9LwXOSxxEOrjFwgQiZ4ER5nT5g3Y1bOLcBBeeWkNYf1d0a3556pzSbK0/bg84bll
	 7FaMWIWtlqa9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6960C43339;
	Sat, 18 May 2024 21:05:57 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240517193432.GA129526@nvidia.com>
References: <20240517193432.GA129526@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240517193432.GA129526@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 9c0731832d3b7420cbadba6a7f334363bc8dfb15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25f4874662fb0d43fc1d934dd7802b740ed2ab5f
Message-Id: <171606635767.2260.9874156047369578539.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 21:05:57 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 16:34:32 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25f4874662fb0d43fc1d934dd7802b740ed2ab5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

