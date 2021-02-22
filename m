Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76978321F53
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBVSoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 13:44:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhBVSnA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 13:43:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EE49564E34;
        Mon, 22 Feb 2021 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614019027;
        bh=JQGcprhaSNI4UWW0gKJD2NOzXwkpNiW6/jegMKCATWM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tSezLW1SCv6dI6JuDT/w531CM3AeM7zN+xbhVXaAokJfVShp4VnQXIGXoDc/C2MYa
         T2xeWED4IHSl3feBlKcDH3xfPNht7FYrffquTzneZgOrUO0O5Sg+8b04XVe6QwQhu1
         8a3AFCwmR8dbHmCe/ppNhtxV9iWfrCfMHDAdZfbyVy6YRErxTw/wxZ87DyqKOt4V76
         lyUU5NA/C+5iiVisk0ecl/u5IEXPOzZN8SMJxT//TYzd9oxpvsMhOBE3jE+xCC5quM
         W6xs9DjqHP4OY0D0/OnLkdQ3NBwH/+YR5rlgkypxhb3GomxixX1vOxNWJEt2uR6FxU
         qtKCpsDxxLyyA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EA6BB60963;
        Mon, 22 Feb 2021 18:37:06 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222145921.GA3435145@nvidia.com>
References: <20210222145921.GA3435145@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222145921.GA3435145@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 7289e26f395b583f68b676d4d12a0971e4f6f65c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3672ac8ac0d8bece188f82c48770bbe40f234f1e
Message-Id: <161401902695.24925.3469178097986913404.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:37:06 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 10:59:21 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3672ac8ac0d8bece188f82c48770bbe40f234f1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
