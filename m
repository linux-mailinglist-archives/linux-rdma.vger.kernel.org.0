Return-Path: <linux-rdma+bounces-9421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75FA88A08
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 19:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B253B6020
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110A28B4E0;
	Mon, 14 Apr 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEmaSvKJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E628A1F8;
	Mon, 14 Apr 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652439; cv=none; b=Kx0x0XBB7YTKND5t/BYVBIft98jCXClxDnlXK1iOMqceVI0/vhijdwUlSRUV3D6LDvShSnDVtnFY2jg84mQvuM7z6R8FetlDyV6fEFyIA93I7yr7jT4oHns3PpmfNuDxnA0m9UO9iVYr3LgQvJLnD8xWp83KCT2Q1frTGtDEeFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652439; c=relaxed/simple;
	bh=hX7fZteky7OVDm4ROo6GoNgQ4c5VhQMtlRZ721WPgdw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eBjGo/GsM4mn0DQqLuv3SG2RAfez8jPS9f/Cg2HohIYORX5F9o0C80Sy3GsQkWa/a2mBa4Q2YX02C20n6eXLi7/Kcg1valCnOLx6Ig0Y1nQKZQBiYxHLhaXyRffyuddlrImAA+8zToV4I7+hqhfjaBNx9OC5T1gnTTiapNfEdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEmaSvKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B0EC4CEE2;
	Mon, 14 Apr 2025 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652439;
	bh=hX7fZteky7OVDm4ROo6GoNgQ4c5VhQMtlRZ721WPgdw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bEmaSvKJ/c1Qrs8TbI0+NSHlE73nDz1aZ6+SwxsDOBcQbuewjKjluMDipclagVllo
	 Ud0394p6uvvp5Q3f/ErbAv8ThxjDikaj0YgRr31T0u3TdhGsrr9XoOP/zSN/dr68Hf
	 pWlNT+8PHXtNUdKNPvqhx2e9SCkKEucgxGE9i1uwZ9pNJUkHUf6oPWapyTTDNC91tT
	 u5t3HX9312lb+eR0WH75mcj7it++fZ18X4//Do2o81T396/mSZh/3HXNXHA3utB+jF
	 /S30jNxoYOoA5ocuZf9aTIVTkkMZwElKhsxC+ajgzYsZ7G6KsLI2Nkf2DaIe36mDNx
	 HZd2ZibkWykbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717363822D1A;
	Mon, 14 Apr 2025 17:41:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250414130622.GA399879@nvidia.com>
References: <20250414130622.GA399879@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250414130622.GA399879@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: ffc59e32c67e599cc473d6427a4aa584399d5b3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 834a4a689699090a406d1662b03affa8b155d025
Message-Id: <174465247697.1985657.8366428093426567142.pr-tracker-bot@kernel.org>
Date: Mon, 14 Apr 2025 17:41:16 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 14 Apr 2025 10:06:22 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/834a4a689699090a406d1662b03affa8b155d025

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

