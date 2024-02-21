Return-Path: <linux-rdma+bounces-1077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84485CD35
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 02:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AFC1F238F8
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 01:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959261FBF;
	Wed, 21 Feb 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBjgk5SB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3D1C20;
	Wed, 21 Feb 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477414; cv=none; b=mxRoDtHcU+ruOX8Hakr00Z1EFReAxCjkNud+xcdQfCqigrwGprWa3kYnuAm5Wb70AHT2+ElGUWlqoUpOZvAoQfTzOMEgdYsO6jIXIuDM9bI+j+T+gOtJtfgTFJ4cCOOk/aOyHYILlHC4iqVsUU6J1rEXES5fKDir3pDXURv2CQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477414; c=relaxed/simple;
	bh=hlY40fGj0q7TUq7fVaysCaivYTFCMOKz72L/Z1aIe7E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ncE9uq43zYcfijzMd3ULjDkWOB5ZOhgLpvlzquCuYf7akyDmyoG7QXSWsefn1VwzEuO/5Ll1RJL5lvyRG9lV+FZFEGe5E88YjmgmSt03bICUhtF5w75zFNUQHC4taQMI05mxfBL802yiUcmdgRJ1NMXvnw9htnt9Rz98RGHorUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBjgk5SB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD423C433F1;
	Wed, 21 Feb 2024 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708477413;
	bh=hlY40fGj0q7TUq7fVaysCaivYTFCMOKz72L/Z1aIe7E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sBjgk5SBDINf5X98rs6dYcY0VFvlg04XVy36vCF/uHH0D5Ma1lASl4xyitwEvXYZP
	 jQT8oFGi8PdM5b73ePhPjNKFtQH9ZvCTlVGzl5vDtTb3WqZAz9Jy+WvgA0XXAJ9tPJ
	 36+Q4+va2aerfJe1PeBVlzGv+64mFR5BcEVmVZ7mHIFWWipOs6O9ArrnlvrjblxqBR
	 fApcw29hirlVLiBHM2Xzpe62pVbeR7/qJVEy2Qdwuf+5ydzixgFaGk/pH9QSYdRgBM
	 sJ7IBj44YBWZ3eM3HXuLYKEEccDlgORLDdnVrCloBcjXv1pEkhbDDBfrt8kQawqatt
	 zMs23c1+XWvjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9D6AD990CD;
	Wed, 21 Feb 2024 01:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240221001241.GA2081949@nvidia.com>
References: <20240221001241.GA2081949@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240221001241.GA2081949@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: eb5c7465c3240151cd42a55c7ace9da0026308a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8
Message-Id: <170847741374.31278.4240090897510837759.pr-tracker-bot@kernel.org>
Date: Wed, 21 Feb 2024 01:03:33 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 20 Feb 2024 20:12:41 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

