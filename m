Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09EEC749
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 18:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfKARKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 13:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbfKARKF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:05 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628205;
        bh=8f7LfhXkMDaTTMyarlXctK8KsP+xTC361zjJ1nFyGqc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hOAXyAdb6wZZqeDkmfXKvHiLZcq+yWRfSklzhSb6PQQBwghzOj77L7cDPCrIaB4qg
         WWkqqcmkGIGqN8MXKuLYhXKuYOq92yHO7ULu9oR/tvogG7feWr0sFlqFTv7WL7k2Gf
         c01eB0ZGL4X34ee4pc79LeukvNCrrWqMNsan2ZEg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191031182211.GA27176@ziepe.ca>
References: <20191031182211.GA27176@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191031182211.GA27176@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: b681a0529968d2261aa15d7a1e78801b2c06bb07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4252a1a9b01f3757481f08b4775d27f90d422b23
Message-Id: <157262820532.11375.11625277088875240180.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:05 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 31 Oct 2019 18:22:15 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4252a1a9b01f3757481f08b4775d27f90d422b23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
