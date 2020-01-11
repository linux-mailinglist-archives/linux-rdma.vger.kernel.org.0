Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39B138191
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2020 15:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgAKOpF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jan 2020 09:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgAKOpF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:05 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753904;
        bh=LCQal0F47sx1zk123eqgeAx2OltA8LoOc76EWgyHADg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qs7obUzGUNOl7E10b7svO9hW3gvOw58LX2VTc8dwuVIF7i9qC9jsJSm95GfI2KdY+
         kaKnfqteYxX7Uln0sVF2tiEucg6b7xfZvkHUgiewYa2I6Mj8xGlHq4nG56MZRD65MX
         4lKd/rWeWkDU23fxs/uHy7Ct3FtV59ClB+AU7/JU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110021623.GA6057@ziepe.ca>
References: <20200110021623.GA6057@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110021623.GA6057@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 9554de394b7eee01606e64c3806cd43893f3037e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e7c1b75bd2a75005313574dd6e5354907005f93
Message-Id: <157875390454.30634.8465355856938892660.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:04 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 02:16:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e7c1b75bd2a75005313574dd6e5354907005f93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
