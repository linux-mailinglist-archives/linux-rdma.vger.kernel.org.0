Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58C035905D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Apr 2021 01:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhDHXk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 19:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232819AbhDHXkZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 19:40:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C5D7D6023C;
        Thu,  8 Apr 2021 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617925213;
        bh=QU7f+Q/WRij4mKeZj/Vjf8FnBre1uR5zTypAJkYA4/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KYc1jPpOXaBvA4ZSnh4peSIGTK8IbEsUCvRYM0qvYjeS6hS6mlh8Y1vGF7k936yS5
         YRiyLw/y62xm5Ys69uZ5L8QtfACfN2dzI0Zk3bIn4DhT+TNJvr4XRyeSWXApniDImq
         mtH+qHNuYcHdb99Dn4xo620busNCQvan930wZabxFTXPJ/wg9oQEYs+4UEJvIIHxIP
         nXR1wluDPJ82bHfT0IPh3z261g/uAgItH/hUd+LyGJwn1IdwwefM7CIlCyUDsitVcW
         kT/YJiufilAEx0x/hAW47Bs30VRHk8P/HVNJaA2LOyNpk4DM781VJ8F0CHv/KegwqF
         2f2hU8m5eJbcg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2568609B6;
        Thu,  8 Apr 2021 23:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210408195127.GA742240@nvidia.com>
References: <20210408195127.GA742240@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210408195127.GA742240@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: d1c803a9ccd7bd3aff5e989ccfb39ed3b799b975
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fa56ad0d12e24df768c98bffe9039f915d1bc02
Message-Id: <161792521366.7297.135338474942016640.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Apr 2021 23:40:13 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 8 Apr 2021 16:51:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fa56ad0d12e24df768c98bffe9039f915d1bc02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
