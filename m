Return-Path: <linux-rdma+bounces-5684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199EB9B8979
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 03:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9AB282DE5
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE21369AE;
	Fri,  1 Nov 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUczLs4E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7855D8F0;
	Fri,  1 Nov 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429515; cv=none; b=NswEm1tvMU9sc+Y0tniCfup+58oLbEWQczyYAHQUGaniaHnr0qmLQP+ZRmMYal7KABdhQc2r6n8NetPDNdo6HRcLX955cNwQZWjuPYSK58/VrYQqF3Vr3z7HxP/rbfQmJnaQ3OI4TuM21FysrNzeBY2XeV9jk49Q20k5QZN5M4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429515; c=relaxed/simple;
	bh=3GRgH3QUTsj8zrU6zG3ob2prYP2gWD2tX7rGxVv39+k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UuxXaarNLv2EVYTJZxUzJ6cR0RZ7GBMbW1RgSIJP3w+vnIeJgPu8SRiwA31SmcQYrWDwTWhObW8ykrkHKpdKq2fGH9ozWhklhM12R2gXws3dybzXKnegItz+PlFpu5ezVl+1OSQWyXnn1roXpt7nx1w6AC3sxCj3nsR3riwhdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUczLs4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484D2C4CEC3;
	Fri,  1 Nov 2024 02:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730429515;
	bh=3GRgH3QUTsj8zrU6zG3ob2prYP2gWD2tX7rGxVv39+k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XUczLs4EsRboNpcc/pPYiKZhVAAmCFvyl5Oxn3e1Ge7uATKHlKVPonBcvIOi8Ivhb
	 t/iiFsDrR4WGfixVP2oPWU6dSBPBWDyK/9gdX00+rBUJvvtR6USiQWEY1dznBrzSeN
	 aAOELgSNpoRwHP8diL711kX5IESL/wH8jhGjyo6kk71JHkaskArDsv1xt2LG1ou5Ps
	 V3zTxdx+rxq5nC6Rw0XkgovuEdFjln4/3eWtQvxvgDYX8jsbZ0S+CRB++aIVfnGXTE
	 jtReKSp9xg4vHAqW3QzNNDdU/ZBMaRx1fCeemaXoLFpK72Ax0Gj8Njl+BWlwpp6JSw
	 Vx0mkYmdF0lTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71091380AC02;
	Fri,  1 Nov 2024 02:52:04 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241031163014.GA71683@nvidia.com>
References: <20241031163014.GA71683@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241031163014.GA71683@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 76d3ddff7153cc0bcc14a63798d19f5d0693ea71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c52d4da1c742cd01a797a4d0a2d3c5a60dc9bfe
Message-Id: <173042952294.2161836.3400059072222707235.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 02:52:02 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Oct 2024 13:30:14 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c52d4da1c742cd01a797a4d0a2d3c5a60dc9bfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

