Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8897D39270
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfFGQpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbfFGQpL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 12:45:11 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559925911;
        bh=dewJd33oSw/c07BVLCwYhSX+/yORn3lSorUPNSTJH9A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J1IK6NjmHkIRiZVFXsF5oH1cJcIDc+ur5aq1yrzVpzSVhU6wHkVk5jvOanHRLxr8D
         UL2R4nL3QfKa0gkZylqg4ZcrmPxtcoluIhy+RydsWXTCtTUR+KJDJ2dYtZ+DdD7puU
         2MMnMAcPQD3rssqiQh4Jx+CrsqXEZfSU/KccueJI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606201420.GA9763@ziepe.ca>
References: <20190606201420.GA9763@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606201420.GA9763@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 4f240dfec6bcc852b124ea7c419fb590949fbd4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e38335dcc70f03faba26bf1260ee024d930afe1
Message-Id: <155992591105.2725.17839182914999758884.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 16:45:11 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 6 Jun 2019 20:14:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e38335dcc70f03faba26bf1260ee024d930afe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
