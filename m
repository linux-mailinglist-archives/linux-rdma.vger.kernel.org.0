Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078FF2D661E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 20:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbgLJTMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 14:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393360AbgLJTMj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Dec 2020 14:12:39 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607627518;
        bh=M+OZmnb7nUuG1FSWNyNGQA9xTQEGmFLJ6ZxYD9olH5A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f6/EP5f3ZfmRHyXG9wZ3BXNLddJb8xwcwrBarqBCiijRO2+3h99ZtbYvOFebox2pj
         FBbIkl/8SBltXYNM9Sm0L6aEzMEI3kUkpisDcMmbrFRYmRI6KowjOVYnCSAV/9zWZF
         7i3XUJGkHQEoopTVSFrzVNvJINKFh6AbD/J4TFxp4gyToYKA3zaXXoYhnCVZmB2ILi
         WzGMbRjey4PIPjwiDiG/weNNQFHrdySg5m88ZAdByLHIMEBebtkoBGal4y6v/WTuE7
         ro56zgKzGyhgKOPiTw6PsPzOUbjH7fn0OXCbBJgvPyK1Lxl+ZdVqSeaMdb5y3KEdiU
         S6ZktwnNSls/g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201210155005.GA2106949@nvidia.com>
References: <20201210155005.GA2106949@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201210155005.GA2106949@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 340b940ea0ed12d9adbb8f72dea17d516b2019e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fca90cf28920c6d0723d7efd1eae0b0fb90309c
Message-Id: <160762751830.17187.12269356525552409080.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Dec 2020 19:11:58 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 10 Dec 2020 11:50:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fca90cf28920c6d0723d7efd1eae0b0fb90309c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
