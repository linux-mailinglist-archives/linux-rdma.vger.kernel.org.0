Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8345774A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 20:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhKSTtV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 14:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236237AbhKSTtT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 14:49:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5BA4361AFF;
        Fri, 19 Nov 2021 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637351177;
        bh=xKK2nuJcRVOla1OpkutQBa+M2Bd9nOnYHf/rjf43+Vc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=byh7HHdeHwKD+QbD8Bt68osYZk93CjVri/b7m4oAOTnUrbdjxbsESdS4nsqSqxEl+
         yDBToBhRow6+UBkGYK7QRgUcHnKZc4aD67Ne5XPG9srJkqs7QnVmtcxwL7ibPp1zyb
         44zaWutEQAH0bEf5s2VIh9U6bxwEQ6GUQXrliFnEIFN+0N1puV9872u3eFCobTxJWa
         pQY06aOgJfT7093/RS+ChSuY/oCnnLbc77esbbShhktSCP5mIToQ4JmEZngjQfd4zg
         kMn58ukW6eYZ2olZcy6lcm5jNik69qYW9Nu43ZLvOXJg4rl7PmJuoXueTRrj8gehq6
         2q5QK6/iCd5tA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 55CD460977;
        Fri, 19 Nov 2021 19:46:17 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211119171926.GA2987583@nvidia.com>
References: <20211119171926.GA2987583@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211119171926.GA2987583@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: df4e6faaafe2e4ff4dcdf6d5f5b1e2cb1fec63f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8b5f8f26da878abc6c357f485d446391b43ed36
Message-Id: <163735117734.2946.10172787974567150351.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 19:46:17 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 19 Nov 2021 13:19:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8b5f8f26da878abc6c357f485d446391b43ed36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
