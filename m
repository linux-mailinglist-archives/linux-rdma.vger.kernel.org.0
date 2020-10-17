Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92C2913A3
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 20:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438879AbgJQSWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Oct 2020 14:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438857AbgJQSWn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 17 Oct 2020 14:22:43 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602958962;
        bh=ZJhBWWopLQvF2UxXLEbKDxRKqrX4d5+Foi7eRPFsfuI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bXOBrEs1hjCZSpAChX7j2OvdOVXQm4DcRdF8PwCQ2TONqRBcsuoXu7Pa/tgWMVLMg
         6+55VU33cWnxZwueiE6ZOyEtqvB6KNkYMU44F7phste1Jwo/uPtTfApLwJzsm5FdpR
         zQcGCOiwHnxTXYStHApf6Iq3+aduZpIM8TisnE7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201016185155.GA233060@nvidia.com>
References: <20201016185155.GA233060@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201016185155.GA233060@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: c7a198c700763ac89abbb166378f546aeb9afb33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1e16bc7d5f7ca3599d8a7f061841c93a563665e
Message-Id: <160295896282.15185.17250016359986869696.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Oct 2020 18:22:42 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 15:51:55 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1e16bc7d5f7ca3599d8a7f061841c93a563665e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
