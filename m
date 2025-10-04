Return-Path: <linux-rdma+bounces-13773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCEBB87DE
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Oct 2025 03:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4568189468D
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Oct 2025 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD141EF39F;
	Sat,  4 Oct 2025 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga5Se7Bb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D61C84BC;
	Sat,  4 Oct 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542084; cv=none; b=XTT0c6E0AaXie+mNJEMSivRGs8GuwBr/733BEG7qTPNb5xuUcxzk0i4uixe20OG+kA3/oNa/rnt8WBAAfyfnYM5KyPs5xPn/EfzV3ziydYSBSzrGmOdDJuDdSnJxiLOYiiwKFcy16bBQomeIGh9qiDZpnauaSMjsP0anfTYmiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542084; c=relaxed/simple;
	bh=JIZqDI90sJ8gKPPrW++UrfvkbLCVktL8801WM1Pusos=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d8idwMXZZyW3mk2DD/1fAFgwMABrnkMdCIX2+UIV9WYBkxNu+9qLm8zqzx0Zy3UXq4qyHSPhr6cKuCyxmmm2uNiewtA7y+bSL6fflIyhU9kgUrHYZATkPZk+GGaOm6ZbrbyDEFqui4rOaS2O6P62unRsJ+LSEFgrN8CUDlIR0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga5Se7Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B2EC4CEF5;
	Sat,  4 Oct 2025 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759542083;
	bh=JIZqDI90sJ8gKPPrW++UrfvkbLCVktL8801WM1Pusos=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ga5Se7BbCL/ILS0AWzFWDxgV7FDbDpX5Rfwh8wrfdWlQLHU8QARJQXxTtGIhkz+aW
	 ONfBHMuQPhlc6S1uvoa3o6jGLc737hplUNEe0UmKGE5JIuOTM39OXpc1sJFzCadZ2j
	 JGQDCAyZ3r5odkvhBsxby6dZBxdVg6o0tfmENY/eh/YbjPMqZ5KmlVxhNoCRllFGiS
	 aCzN9mo035i/l0PvyZmgPmWsFtv7s5XO7tRnTTtFDI5Ppfz32pNhlPnbn6N1q6C1pE
	 cN3wGtPfDWusAP8TqyPSf5XYghhpIeEDeKXJLo6dslVaF42tMC6CMJX5fN8gj/eXo6
	 yoGNt5yFVYggA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BBC39D0C1A;
	Sat,  4 Oct 2025 01:41:16 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull FWCTL subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001193534.GA3227444@nvidia.com>
References: <20251001193534.GA3227444@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001193534.GA3227444@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl
X-PR-Tracked-Commit-Id: 479bec4cb39a1bfb2e5d3e3959d660f61399cad4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a44189f204695637be0373c8ea8e3ea4c1a1926
Message-Id: <175954207493.144727.4987629668337323124.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 01:41:14 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Saeed Mahameed <saeedm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 16:35:34 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a44189f204695637be0373c8ea8e3ea4c1a1926

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

