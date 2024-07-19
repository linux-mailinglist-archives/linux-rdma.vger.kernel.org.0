Return-Path: <linux-rdma+bounces-3909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0209A937C1C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ADD1C209E4
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE21494DD;
	Fri, 19 Jul 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXot68Z7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBC148FEC;
	Fri, 19 Jul 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412560; cv=none; b=T566asm+kdiumhcSd1bIs9gj+F213XeeLtfKL1dUA6IHyLd7VQSUwtWxZZq1PrE58E/7MJhYPh2ZBCy3vzYM8EmnVEDaoFgzjt4li5Q/uJ/pEUTI3sbxp1vO8M75woGGt2td7arZl13roGe5MNzbl6WtHfSEAZ4P4gAb5bITEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412560; c=relaxed/simple;
	bh=+K4f+RfsFEdH9jDfV2FcaqFR12GfUnAURfbKZV6jpao=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S/tZF82mDS569u093gZfm6Of1quZLtsg8BP9t/nL1DVk4sip3MBYY24NUMnsV4GOnNbHRbDVbYFIpr4if9gFlIgn0M9BiwWODrnVUu2zLvlNvhBc3hEkj0OTsjIH3yjzyyKQvVbl2UrL74Mum76x2WKXtQcnJBVfFujD15wVuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXot68Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9943DC32782;
	Fri, 19 Jul 2024 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721412560;
	bh=+K4f+RfsFEdH9jDfV2FcaqFR12GfUnAURfbKZV6jpao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bXot68Z7PP4aoU5Xf8ZV31jZM406ojzPd++c71FNggdO1rSPbiFzPZt8kX7UUr77c
	 BukyAh/5s2KBUHyhvqery45IWq1lGsiW8hg2sAUUkg8i3k6pZUnh92V9D2ccfQUsX7
	 OQAJLrAyO6uFSiX291HFCDShj9Gud3JM2zoK8aQRfbdzAi0NWAgBfUnoGSxz72P3VQ
	 Oakd1COzRHgW/FX21atNn/UfJhAx6U5fxciOn48Z95E7O3CxS0ewTNcKVQ8xcYHIdT
	 mV9opfyc7GB43fya7V3u1qMrrJhYJnmazO3VcWXrSVDfFezwAEQHc+jXp37Cv8kvSk
	 F3yjGXHMm3Agw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 908AAC43335;
	Fri, 19 Jul 2024 18:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240718193149.GA1670333@nvidia.com>
References: <20240718193149.GA1670333@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240718193149.GA1670333@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 887cd308fd46a1c6956e9ccda1aaca830edc8ed7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d51520954154a476bfdacf9427acd1d9538734c
Message-Id: <172141256058.2862.3016435065381330683.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 18:09:20 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 16:31:49 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d51520954154a476bfdacf9427acd1d9538734c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

