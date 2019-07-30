Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36DC7B468
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbfG3UkU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 16:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfG3UkU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 16:40:20 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564519219;
        bh=G70ij5Rx72+9VaiE25ukujWYmxqSpJpseXxJYn4AENQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bw0XJII7U9qArJkEiHnFP3jHXWfBNrQ9eeApcmIohimsNU9yjvsbUZHOXFsXj6QQo
         RNkkqmL84kK12bIrytq6lGOMAJKc6z9zMbq/x33JdD7IPQATOFkmA97QJMWo5WNtGk
         b/NRDX1/bxqScbhukc2IvkZJsfEU+Dmnav3zJtCg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190730121455.GA23902@ziepe.ca>
References: <20190730121455.GA23902@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190730121455.GA23902@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: b7165bd0d6cbb93732559be6ea8774653b204480
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32a024b9a9f3b40f84bc55a6dd35eaa770ea26a4
Message-Id: <156451921926.18459.15979200829555980420.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Jul 2019 20:40:19 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Tue, 30 Jul 2019 12:15:01 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32a024b9a9f3b40f84bc55a6dd35eaa770ea26a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
