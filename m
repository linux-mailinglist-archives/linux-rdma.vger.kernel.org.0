Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A8370829
	for <lists+linux-rdma@lfdr.de>; Sat,  1 May 2021 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhEARVf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 May 2021 13:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARVe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 1 May 2021 13:21:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9C03661284;
        Sat,  1 May 2021 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889644;
        bh=QY85+Vd3yh8ScTdhcUF7j7rN+Hgd+6M6ADK5QYYSLL0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ddcElWtwy3A8QQHoWqNWYCGXRhRp/zdzdgtbETBheDQG2hYW2GiLaVnPU/1TQFAO/
         MKktSC4vkbnEBcgIMOhOAjE8VxqYZx8ByxRo5myvpUI0bUTgVRaiaAQDQcFbtjjfmw
         89dsYsRnOuqtjbOT8IUz5I8oq5uHfzp9U6ICo5b0jJNkTcQb2Mcc76sWUZei17+MVr
         clv4KCPJfc3Gyqs3WccrY2FdafnkGVlMoO9qOad6r87geCxNoeZ4TVHWCMexz0Anhs
         hMcZXD1E7uLZb2F3DLTEmB09GXjXpLfSE9gs7xIhnTpdHIOVrmYZQxMc8fiGeMzZt8
         jLGt4fp66kMZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88D6A60A72;
        Sat,  1 May 2021 17:20:44 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210430165527.GA3573658@nvidia.com>
References: <20210430165527.GA3573658@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210430165527.GA3573658@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 6da7bda36388ae00822f732c11febfe2ebbb5544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f34b2cf17825d69ae1e227871059ab18c2f57817
Message-Id: <161988964449.32500.5703350496456231951.pr-tracker-bot@kernel.org>
Date:   Sat, 01 May 2021 17:20:44 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 13:55:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f34b2cf17825d69ae1e227871059ab18c2f57817

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
