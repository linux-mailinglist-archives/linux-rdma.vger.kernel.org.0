Return-Path: <linux-rdma+bounces-9527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00DA92B31
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10D2188F3CB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB35257430;
	Thu, 17 Apr 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBZcVT+6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27471CAA99;
	Thu, 17 Apr 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916188; cv=none; b=gfQrF8UqzTjhJuPC+dnOSMEDO5RKhm4vqc10fH+PExaz4Zbe/S7AaNc1IfcdXw8oKQ/VFwXAM7lbNmnaoV9Iv2PiLmcIWq/wKfbZHnF59iQP2MnMzoLJrP6+9c2H0E09T/DJtzTmBAZCZMvOtjo0etVKX93ugDbrB+KeZlmeWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916188; c=relaxed/simple;
	bh=WihgnsYkRics16oBTaeftRWOzimPo5NgaFpCm+Ogawc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qT6xqo/fBXtyRGrmZPbFOc9+7ASwnPn1IRcXtcgXF1OEhBLAcbhp07PvnIxf/a28qbqQBvOKVdv7AomYZpMf0dTNulRAozDGqKmgPwQOErLVjTJ41lm9jtpDgnQmMidHSH2MB60HCrqqDVcIhGn1vhtxZIINA3CHQEGJlzUx6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBZcVT+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93407C4CEE7;
	Thu, 17 Apr 2025 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744916188;
	bh=WihgnsYkRics16oBTaeftRWOzimPo5NgaFpCm+Ogawc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LBZcVT+60FpVk9ucTRqlz088ZBy30wYF6YTWOKezVH1cY3/vZJf6ex2ZZIMVKyO2c
	 /7o9zAVGd0HlStl5meO9JuzIw+uDSpb8S+WHhgAp0/oht83OuqsmJuXO470BJRiin4
	 us0LvEnIhW3PxxhSfeCZjyJIsPGyP3/qUvXlZnOEn3IwRF5373JHpNeQHz0fpK9R22
	 VCDJhxEFqB8JGLMvVPO4M8TqHEFZkPnSq5V8gORwRcqgfdvP1vX64wcyrIEFEI5Zu4
	 kyjkw4kOlE9HLBagk8EaKxBUgL4Pr4rCNEi49jTNjDu/Ow5FpmRM0io1For8yFf7Gq
	 51gf2+Kz04QGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC85380AAEB;
	Thu, 17 Apr 2025 18:57:07 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull FWCTL subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250417123610.GA1213102@nvidia.com>
References: <20250417123610.GA1213102@nvidia.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250417123610.GA1213102@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-fwctl
X-PR-Tracked-Commit-Id: c92ae5d4f53ebf9c32ace69c1f89a47e8714d18b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2516abf1c88212d98af889070123469c28ca2fe
Message-Id: <174491622658.4184086.1128830653739484820.pr-tracker-bot@kernel.org>
Date: Thu, 17 Apr 2025 18:57:06 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Saeed Mahameed <saeedm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Apr 2025 09:36:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-fwctl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2516abf1c88212d98af889070123469c28ca2fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

