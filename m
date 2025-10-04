Return-Path: <linux-rdma+bounces-13774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025EBBB87E1
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Oct 2025 03:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5A719E57FA
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Oct 2025 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2AB1FA178;
	Sat,  4 Oct 2025 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oylWq4Ci"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0911F418D;
	Sat,  4 Oct 2025 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542086; cv=none; b=GF2/bgJ2WrWSMpJBogxhJL+HbU8Ot6ivqPOiG/rKrB2+e9jrlUzqkf6xhIwxnODyJZlB1CIlIzvvWRcKKCBxgLIuuhkhWbGOnW8y/33txjuj97Ppar15WicjF0jmT6Of+0IoTQSLQ7+iEyrXlYAqBAI0mntY7Uzh1KNddinAklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542086; c=relaxed/simple;
	bh=SidXs1o0t2t+TDx3W48oBQNqvD36hYUVQk5zvqvg/i8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TWdJMRb1PEz/h0210flPB+dqWtI1ivGZqkjr2mtMYKDd3C+C+Gu6LQVfbCDAVtCIYgF3MuvSF+v3tPoly707ukAHwWmIc8msL0QjtUB3xUO7llINGbirtoqtCFMunKcdNSSgI1/f0lxllvAKP5WmwtxwrKEQW6D8J/D3p85HNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oylWq4Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CF7C4CEF5;
	Sat,  4 Oct 2025 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759542085;
	bh=SidXs1o0t2t+TDx3W48oBQNqvD36hYUVQk5zvqvg/i8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oylWq4Cifg/a4AliVnMm7BJwIPZO22RS38Zqsd5H+l3u4maqtdR3L5f3YkjQiAaIn
	 McNXiD/Hc+ssawkgen70Ki4zZA5KNDKH4K9MxPLQGgstTx3eEXQX56LIVZomgrzxgv
	 Srw+vHZKhJ9k+wm8rq73MhzNYGWDZTuAIwLQli8mXLpZ0KMz5dHHQtet5w9DGoyYlx
	 EMMfy0fNBFjZDPQHoeeNN+FaHGMbuFVN0KAaTWgnhB7V8POkbon+bc3Vny06LlTDMz
	 fkwSNtQu4VRQPqB2TFA7AchnKlNTB0YPq/Khhu2fLOXnId83W9w26wsVPRaPuNndmr
	 39zCP2sFpZq/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC139D0C1A;
	Sat,  4 Oct 2025 01:41:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251003000244.GA3344797@nvidia.com>
References: <20251003000244.GA3344797@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251003000244.GA3344797@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: e6d736bd08902ba53460df1b62ee4218bbd17d9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ccb4d203fe4bec72fb333ccc2feb71a462c188d
Message-Id: <175954207680.144727.14015765425760154351.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 01:41:16 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 21:02:44 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ccb4d203fe4bec72fb333ccc2feb71a462c188d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

