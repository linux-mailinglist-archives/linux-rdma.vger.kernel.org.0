Return-Path: <linux-rdma+bounces-13578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B4B92987
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5072A1341
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B43031A05E;
	Mon, 22 Sep 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGotDhyF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81E2E2DC1;
	Mon, 22 Sep 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758565670; cv=none; b=jpJHxv4OscfVfq+J+beckpYuS1SAMm02keUUXPkF+Z8TFnm7G4WQejg0L0r0gi+5QAcDUvxoc3xkCQk0iZKZxqv6xQ6qWTv8IdEej3OXFkpgrsRETIWrmt7llwrLGk+gqF8IDHHJ9Q12nI1ar9afyY/EC3lRLjtH2XaFWfA6UxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758565670; c=relaxed/simple;
	bh=EMzN53aowTznjSqnr+CEIXDATtGcsQ+o59S+NQEKZDo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pznAvUe1whylXVs2cvzvK6eIEsytnLMW8Cb3nulxUNktgI7SuaxbCKkRZcAfJVxnjz5B4kBZ2f11Rwvw1iN2gCALc63WGOHicTCjxr3TNoCAF/GtxhDBw+JJaZ2U5yMJkBsaxxCxosI0MOj+ppyXQCo+qOphvrBr+OGMDpTQf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGotDhyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC0C4CEF0;
	Mon, 22 Sep 2025 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758565670;
	bh=EMzN53aowTznjSqnr+CEIXDATtGcsQ+o59S+NQEKZDo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GGotDhyFCYegZ9rZMFTRrkdcSpvkrISXNGdddoeQuq9vRO0XcSGXSu1L22WPbpDOg
	 lj7InHkR2aR9tVsqqeumNfI+npsB8Zk+3YMwcK8YtnFHQcsF/UkpT09+dCwzysFJrz
	 T10pvsCwWZesIFvJs0L1ehy92F4nP5meI9x4i4TbsVJ8u09pDbhvfnPnL4S9f9l6X+
	 u9FiGe5szsOxdGgzSTIGGWI7Q4zLEywaJbIly+zwszPMsPGTGdSUlIp1b4kqp+kJnB
	 a+bGHzhEuHj1aFtbD+i9hNCHDZ7k7pWBIVk07X43+/ODjGwBgardEwflE2kTFd7qxb
	 eXQNL9sPgIpLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA439D0C20;
	Mon, 22 Sep 2025 18:27:49 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250922135846.GA2502832@nvidia.com>
References: <20250922135846.GA2502832@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250922135846.GA2502832@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 85fe9f565d2d5af95ac2bbaa5082b8ce62b039f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b183f251e2024531c2262829e97907b0e623cc41
Message-Id: <175856566807.1111894.17786497958643240690.pr-tracker-bot@kernel.org>
Date: Mon, 22 Sep 2025 18:27:48 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Sep 2025 10:58:46 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b183f251e2024531c2262829e97907b0e623cc41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

