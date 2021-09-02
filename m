Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5183FF754
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 00:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347848AbhIBWnj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 18:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347763AbhIBWni (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 18:43:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A49606023F;
        Thu,  2 Sep 2021 22:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630622559;
        bh=h9RKv1nykY5b7iPc+O29+99AlCzNnjDsnoqGadLdGRw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nREtWOeUraCETppa5yi0CAOr/LHpb95MXS0HJcMSUTRATxKuldc56B6s+5D6kCOhI
         vc4UMPMY0r99vo++g0bclkkT36wyiMvYNT8mD2rO0dZHGwN2OgqMylW2S7xLYR4qMl
         B869jYgyXEvI8Pxn4NPgYyk0x63wcqiyRFOOQ45EJsbnQ7ONAAl2jo/BZmZKgJ6D45
         8fGv+qtjXJ7Hp+RsjAKqKuIke2j2Y7pdsLOliPAcMOGySLe/4DDPCu5nZdCH6zkiuM
         kLdF2OCznO7/WERjR/bQTdbwhniuvWLegKHdiwpd9y4ZZVRaQjd38J4DGDu2GBiDdM
         jBGMxD5JxTpdQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9EBBD60982;
        Thu,  2 Sep 2021 22:42:39 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210901234159.GA2421971@nvidia.com>
References: <20210901234159.GA2421971@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210901234159.GA2421971@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23852bec534a1633dc08f4df88b8493ae99953a9
Message-Id: <163062255964.25965.11861592701499946521.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 22:42:39 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 20:41:59 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23852bec534a1633dc08f4df88b8493ae99953a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
