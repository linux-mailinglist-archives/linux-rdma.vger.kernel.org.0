Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE69D18FB
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfJITaL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 15:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbfJITaK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Oct 2019 15:30:10 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570649410;
        bh=JJ5I9OVWtkwkRq2I70I9m+OltylDY3E9ybe8AUc5jGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tb4EmhwdpNyI6jrgmIV42aT98s0RiyYFR3xJMegVm1/80YxWttg2vTU1iNUYm2BkI
         o5ljmLd7p89u/Elcu3nKSH9TceMe5vNb4GL7XHTfcJfe30HP+vE+8LfCqkj/lu0wdR
         +4Gmjsxh3jHdl+FtppW57JH/Uwi/o0r8gTP7NVCQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191009142811.GA29521@ziepe.ca>
References: <20191009142811.GA29521@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191009142811.GA29521@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 0417791536ae1e28d7f0418f1d20048ec4d3c6cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a8c600de5dc1d9a7f4b83269fddc80ebd3dd045
Message-Id: <157064940999.25372.866898993735455801.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Oct 2019 19:30:09 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 9 Oct 2019 14:28:15 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a8c600de5dc1d9a7f4b83269fddc80ebd3dd045

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
