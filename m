Return-Path: <linux-rdma+bounces-7219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ABCA1BDFC
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2025 22:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C6A188D82C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972A1E1C10;
	Fri, 24 Jan 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP0d/KZC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63491D89F1;
	Fri, 24 Jan 2025 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737755093; cv=none; b=gJd9pV3p6VgclrdoENtyCI/rmXkschcF4gdOnZKcvKOpo+5GUdWKD1XKGldZvYcVfmidZq3PHP/5poUP3gfPnYI21zEA8L3bBk5WYwXzt5fNLYvys9xSYKyBRdDtle/oSTdiqBhoDLb5AstpZiU5/r5xg70lsnTQbj/j1IBr/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737755093; c=relaxed/simple;
	bh=nh0oYtoOkGRQIUFLZmpySgTNbIPwIWvOmlhaeGYb/aY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZMRfrDAXEU9rxJNfQwrdHe4f1pDf5t7tScY0xdEQ2QBrQqOyzWMZNuXqSkDEYvlBB0IF4yaWzxSI6ucqfGN/F3ehm7JqTrC+wtDCYVNjFhtlka0/MaQnnFe8CNkkIHzNLdMGRO9t5nMmLo5RG3hA0gKUvR002IRTJo2kNNeRwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP0d/KZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4171C4CED2;
	Fri, 24 Jan 2025 21:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737755092;
	bh=nh0oYtoOkGRQIUFLZmpySgTNbIPwIWvOmlhaeGYb/aY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eP0d/KZCo2Yq5p94y+uwIEnLPvKn+sC0iywbZgbO66ZIpHf0vrfcJPzt49KuFJfph
	 iW1rPsnH/7IXeiGoEPWi1Svbnu5kTbSfQ5+uCKo0cB8J5fUNE89p5zOKTid8hZaqc/
	 C9j0PUhn00Cl0kQLYn6T+kr0nlZLNm+fvxaUlV2fZ9iaW1Jakkeyz4epvjvOg8RFcs
	 haOUAaiBrPbQ0eqDH/ab6e4nobcP4jCCWN60p2Yi+7XH/b4Om6E6RhXs/j5MHXNtvt
	 0/6ZH+BaVfoMXPZYdivcAoEtKRhZJkxiATt3xeva06mdDkVIlQTctIEF/ULyuhxhhF
	 UPl06qr/Fgbxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAD9380AA79;
	Fri, 24 Jan 2025 21:45:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250123171458.GA1053362@nvidia.com>
References: <20250123171458.GA1053362@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250123171458.GA1053362@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: d3d930411ce390e532470194296658a960887773
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0afd22092df4d3473569c197e317f91face7e51b
Message-Id: <173775511760.2173506.1494309880046761996.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2025 21:45:17 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Jan 2025 13:14:58 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0afd22092df4d3473569c197e317f91face7e51b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

