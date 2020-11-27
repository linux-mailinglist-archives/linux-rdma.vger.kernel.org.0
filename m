Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32552C6CEC
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 22:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgK0Vc7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 16:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbgK0VWC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 16:22:02 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606512112;
        bh=a7/vPjZtYXMiC6pf660DUsi+yrWCfgWf3VKXcHUqL2A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iRrBCWIGBVJgGT7VMoxEGYoG9tiRnTwiz2GA6zYrHyy/Nrluv96jQNqMnMDcKMW17
         /nYM56UdDsJzQ3d4YVXxqmcHezwiGNAO5I24Rg2clCd/AMYes1BTcqLbDSsrHrb1/W
         3wvLhKsLo72glpgAV92NWU+i/2fI3nfDRXS0Usdc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201127140052.GA644971@nvidia.com>
References: <20201127140052.GA644971@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201127140052.GA644971@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 17475e104dcb74217c282781817f8f52b46130d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d41e9b22eb871a7a7060964db9ce1ceb1c6e5b57
Message-Id: <160651211232.4351.4971679892065189966.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 21:21:52 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 10:00:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d41e9b22eb871a7a7060964db9ce1ceb1c6e5b57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
