Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32E646F5DA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 22:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhLIV1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 16:27:18 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44090 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhLIV1S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 16:27:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F044FCE289D;
        Thu,  9 Dec 2021 21:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2471EC004DD;
        Thu,  9 Dec 2021 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639085021;
        bh=/evdcvHUjIaL0zQdW+15Nh/WSsLaUouLRv1O0Fy4/m4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AMRadZwaM1k4O0FB2+1RztozGP1YSzELnLdnVHq3+4c8Mhzxc948vaV6K3YfGdN6S
         vqISPSq6k04WsQ2kgRuv8SiBwJc3e7N/QlKqnwjqpdr18QWbnbXDkXCSuupsX1D4Of
         qLdABDuDjXfuv8Q20tT858g+w/q+pRdCfzvjHcmHGQ/EOLu4Ne29be/vsKM/9bKh13
         CViraPZyYXIFWXAVqdqHSIJqzCrUTiQj7x+96wlYJlz2WY7bFxXjN0FJDollAbr6vd
         lqmhhOlI42pq+WnYYUQnCOqEs/U5NWqlVCxTrdldUN6AnC2qk0vu/CIvPa4HgrhQWn
         ZR221GQqQtE+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F3412609B3;
        Thu,  9 Dec 2021 21:23:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211209210718.GA343585@nvidia.com>
References: <20211209210718.GA343585@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211209210718.GA343585@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 10467ce09fefa2e74359f5b2ab1efb8909402f19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c741e49150dbb0c0aebe234389f4aa8b47958fa8
Message-Id: <163908502093.30005.12045571016467106378.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Dec 2021 21:23:40 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 9 Dec 2021 17:07:18 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c741e49150dbb0c0aebe234389f4aa8b47958fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
