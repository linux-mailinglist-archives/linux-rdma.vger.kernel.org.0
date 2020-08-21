Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD5D24DD6F
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgHURQw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 13:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgHURQV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Aug 2020 13:16:21 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598030180;
        bh=q6rfVjn0yYm6ThxeEtdzNfNV7StWYionyldIVlJ8C5I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f9bz0sbcpokVFDROQn1sw4RpkvwN6hA8K+gR+QVzoLXaYLz96CQVWIRYaR7mxJwse
         73Gp4KA8qEV0eFTPO77xKjkdwrOv+YqIqZlbwOu+AqxFOzF4h2UOgIPiLICulDxw0D
         vea5mOT/Cb6VAKYK4POdCPwxbg8vA7j2J2asmAg8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200821140612.GA2665062@nvidia.com>
References: <20200821140612.GA2665062@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200821140612.GA2665062@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f6da70d99c96256f8be0cbb4dd72d45d622c7823
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd02217a5d813e2bbec984a9eeb8280ff290a150
Message-Id: <159803018077.29562.10055519306729526899.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 17:16:20 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 11:06:12 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd02217a5d813e2bbec984a9eeb8280ff290a150

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
