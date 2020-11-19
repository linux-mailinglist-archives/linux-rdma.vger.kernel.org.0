Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D322B9DEE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 00:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKSXAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 18:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgKSXAz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Nov 2020 18:00:55 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605826854;
        bh=VO2yf0E1djoTlaZ168jEv/PSVzMN3dcRm+0jSGom9tM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yW+7WrWQigmKUdJiqD6PZ0IoTduXzASXbTi/7Fs6jiVuvIADfd25IM2sM7XeUpN18
         sJb1/YMfr1YS9rCeWMzti0oV1OjRgu5H8g/FztsxXbgvKJxbe1mvmL1KSGZNYJeMCS
         zfYM+EJh9d+IMnv/Fuy4D15c/v7dduXn6T94+rMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201119192925.GA2028353@nvidia.com>
References: <20201119192925.GA2028353@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201119192925.GA2028353@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: ee415d73dcc24caef7f6bbf292dcc365613d2188
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3be28e93cd88fbcbe97cabcbe92b1ccc9f830450
Message-Id: <160582685460.24786.5760644221091077948.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 23:00:54 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 15:29:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3be28e93cd88fbcbe97cabcbe92b1ccc9f830450

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
