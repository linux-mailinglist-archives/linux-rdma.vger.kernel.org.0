Return-Path: <linux-rdma+bounces-6003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5029CF470
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008A0287D5A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6A81E2829;
	Fri, 15 Nov 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az75aLN7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D11E261E;
	Fri, 15 Nov 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697149; cv=none; b=VSX4kwAiyG+zLrhbL1WmHD8LwgmAZZMLzozBb9K8nS39jRvMqTNyoGcMHK7aywubMl9RR86bG3wNaV8jeZbeHh6LEpDsQk/fZRr1n4O9O1Sc/ilfEw+sU+DsEvObfUTiszgI33lQW0J4cK3ix4xqP+UY91o6fGPULDR7najHqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697149; c=relaxed/simple;
	bh=+Y12lkrhUQ/sbNiCDIV3Ou/oin2Jf7g71ueymaRGAqw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iW4SjNbq1aT5rSInVNUb0uJZOIeJfwftNUPctSR2FUoPAX08oh2K3zmpUAK1Ckn1XOEUGsEX2tC3FYHS46ECOdwAE90U6jJma2DLm6LsRkZMOe1sHwfx11QwRIhotTh7NZgk8LVWldEMlmc+6miFI79LOuTuNeydX7+EyXsVH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az75aLN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3849DC4CECF;
	Fri, 15 Nov 2024 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731697149;
	bh=+Y12lkrhUQ/sbNiCDIV3Ou/oin2Jf7g71ueymaRGAqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=az75aLN7IQSDdcY76F6FqBXmlTl9mAUcaVURKsDzS1N5yGXD3LAJbCKwjFlux3JI5
	 Q4efb2Gamjs3UGCwUxlLQiuWIuiAtHpf1wcsZDNwPCvyRX8xQZ6ZetIDr/CNOJZBwD
	 97S169ROMDhlnGPo7dRuQy4wi5PPehGqpzW9kbx4LyhSr043WnU2ZMjfsjzdz9jv6D
	 /3GVU+Cfl4DLe6e6Tt8G8pgQiF4fJvRGEoH4GGJ6r/XJqhzbAEGOTiz5Rty5Z2yV6j
	 GcYkEKVzdWtUQNTTcJDqHNNFg+Isbi7FWK7Rk+HmjsvIBkVJlppLYDz4UPrTqAki+u
	 DlLchbZqcq/6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF03809A80;
	Fri, 15 Nov 2024 18:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115151807.GA611514@nvidia.com>
References: <20241115151807.GA611514@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115151807.GA611514@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 6abe2a90808192a5a8b2825293e5f10e80fdea56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5395732841802fcfd04fa7faa9a6cf2d4a8a714
Message-Id: <173169715974.2685462.2727431025312093660.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 18:59:19 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 11:18:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5395732841802fcfd04fa7faa9a6cf2d4a8a714

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

