Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540D83A33D1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFJTU1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 15:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFJTU1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 15:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F8C761246;
        Thu, 10 Jun 2021 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623352711;
        bh=Zy+D1ZBoTWiwKUGzhi4t1y6ft657IsVXfyU4yEkBBK8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PGzd80FNWBw60Aw0FA+2rncVosunysf2rnfX8bPBEBOPzTW3mu1YSm1RJQSOSk2OM
         VBqkHUIFl5V1eYrthyzntKne/MbYcfaVbjpE3/zRnEYJ6xz2XwuZqJE55/+cGamYRk
         FiyJh6+LbWCQzwEu8cVHM5L0EXQAVz4rwoK7JpD9b+9A4Os84UBLYbkI5+3Lq6DxTz
         f0g9Jp4zJ3nqnxQ35iKRE71Ian1sUwYMK8evnsJeC653BPnf1glJ7PkRfpG5cr+Fhp
         gLZzuV5vVfMfScoigWTJdjjMGKG5ZicEiCYUsrsRbsdYdwNAFh+CFzI3RB5/3DpUE4
         017EeKiuNd8gw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0DA6860A0C;
        Thu, 10 Jun 2021 19:18:31 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210610123745.GA1260478@nvidia.com>
References: <20210610123745.GA1260478@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210610123745.GA1260478@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 2ba0aa2feebda680ecfc3c552e867cf4d1b05a3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29a877d5768471c5ed97ea967c0ee9436b8c03fc
Message-Id: <162335271099.23981.1476888197598035841.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Jun 2021 19:18:30 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 10 Jun 2021 09:37:45 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29a877d5768471c5ed97ea967c0ee9436b8c03fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
