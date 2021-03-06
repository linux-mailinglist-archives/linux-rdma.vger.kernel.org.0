Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB99C32F785
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Mar 2021 02:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCFBgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Mar 2021 20:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhCFBfr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 5 Mar 2021 20:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 51CC064FEB;
        Sat,  6 Mar 2021 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614994547;
        bh=iJPuJxGIrucXXCOOu2irGdE1xOaFkZvDuTXTISUYuuI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KGc/84PkNUoqrNgr2HKXEVi/VfscDmkmcodXmSMspEBW5Iks8LBm558Tyl3qm4oNp
         Xw1XaHx195bxyyNstMLBHctd+Oml6ikXGWteuy1uIRgnDlSjcv/UnyuAaAedz1Pdhl
         05GmlzhfrnBBbQI+lj8ZBFyW9P/NUwc5L3yyITPnuvIGZrYKasxHI0G3vi2Rp90/ZD
         7LmbCwUdH6rzkmT67bAk5ZUjtmZ6BLgvsJC6lL7zvcfkRoYY4qqryPojlRsnoGutWL
         ug74BoW/dadPberwYz867U9YbwK4nPtfQfzanbUgxgFFORXE4TevmDSmCJJ4qkH2zp
         OZpyZB/cLijKg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4B514609D4;
        Sat,  6 Mar 2021 01:35:47 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210305233541.GA1943904@nvidia.com>
References: <20210305233541.GA1943904@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210305233541.GA1943904@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 545c4ab463c2224557e56b2609f88ed5be265405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3ed4de6cc8327e4ef79e6c7892b2b5cbbc02405
Message-Id: <161499454730.11799.15049772159701976056.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Mar 2021 01:35:47 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 19:35:41 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3ed4de6cc8327e4ef79e6c7892b2b5cbbc02405

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
