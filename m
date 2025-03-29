Return-Path: <linux-rdma+bounces-9029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C1A75770
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Mar 2025 19:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D188188A8C8
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Mar 2025 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F251DED4B;
	Sat, 29 Mar 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4BiiSdV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338C1DE8A8;
	Sat, 29 Mar 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743272659; cv=none; b=KA/USedT/tZ8oSVRlT7bswCFz44Jmv5HoGSz+VrNKRHizJNOQn5Uj6HUQnmKt4rKFZOlY3rIyhb3PYNujb6sZaRZFexWdL/wlNdHFbZqOY2zOuFGZX57Euta+xIY98FAORb9yUZWPQa/wbGs0XxtHT/gNVV4Mk4bH9D5wVecu5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743272659; c=relaxed/simple;
	bh=aa9c9x9D+LveEcvZDomYGWFZSvsLdqsbt+C/L4ZmJMw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WFAlWslTArG3rlHYMQdvmlPqdGWui/BaB9vDgfr6tvpQ0tIC2nYUWlBXUxBnPcXkeUwZMjbSRpkDPfmpwTAQRYRcO1AUeS9NqAf7AuhG2s4dJkEwu1dDDbVMfTXtVhqFhaTaTnjk5yjctL99vVafTjkJn0r/65Mw2ycIoRy1vM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4BiiSdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F81C4CEE2;
	Sat, 29 Mar 2025 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743272659;
	bh=aa9c9x9D+LveEcvZDomYGWFZSvsLdqsbt+C/L4ZmJMw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q4BiiSdV9h9mNLvArmATQytrz4fqDif7wqCfWwrqpiHAxT/wHZ8gs6h7x+X2pUtgB
	 Ea30UWwreat54bAS6VaTBL/LmGbuW93AD3HxY7PUR8OmzFxsLCyPw7HMLvzhCzyjtj
	 rmH1Fgc8G0kavwg6TYAqMfm0dOKX1xIPV581gZzhlGbyC8x+a5YoYRq0Yn4gn9nH0N
	 ARBdUoV3Jcyu2juIIA+ZNMIVa2Y737emSYHo7sUgds6XvtR6ro5BzeD1Yzg1aCykvI
	 HMDE3Si/7KRw29IzDswpouqrx14rdBaXD3Dz78tZVdOc76Kgg39zgb3N0Pc6engzFv
	 vFZ6hSn5hdCZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35F00380AAFA;
	Sat, 29 Mar 2025 18:24:57 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328142313.GA117859@nvidia.com>
References: <20250328142313.GA117859@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328142313.GA117859@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 37826f0a8c2f6b6add5179003b8597e32a445362
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 092e335082f22880207384ad736729c67d784665
Message-Id: <174327269590.3243059.15067312097001400496.pr-tracker-bot@kernel.org>
Date: Sat, 29 Mar 2025 18:24:55 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 11:23:13 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/092e335082f22880207384ad736729c67d784665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

