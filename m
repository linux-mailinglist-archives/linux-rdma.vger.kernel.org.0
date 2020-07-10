Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1D21BF8D
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2020 00:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgGJWKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 18:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgGJWKE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 18:10:04 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594419004;
        bh=YLKBsl+YyIPqB0lKX+8U9O4T9ChNs+b3L9bmtEuPbr8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mCmjPb0JPm3Jx9nCeHsv+QW2YWiNMy0PuXEGFM8iClDtO9DKZLXgouUFldVASux89
         mQTqrTSVSOrG7MQjr2FHSGAlXAidTYbqtiefcPsB1O1mIbpA8TMobtY5nmXKFqvRqW
         WxyBa6GANK89yFRBku9eE0uXwDHm/q3ZOhBuK5FY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710175806.GA2067493@nvidia.com>
References: <20200710175806.GA2067493@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710175806.GA2067493@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 0a03715068794e4b524f66ebbf412ab1f2933f3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa0c9086b40c17a7ad94425b3b70dd1fdd7497bf
Message-Id: <159441900404.20268.10288707904594934995.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 22:10:04 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 14:58:06 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa0c9086b40c17a7ad94425b3b70dd1fdd7497bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
