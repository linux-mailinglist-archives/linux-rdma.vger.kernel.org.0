Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E652F8973
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Jan 2021 00:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbhAOXfv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 18:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbhAOXfr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Jan 2021 18:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 50A6F2336F;
        Fri, 15 Jan 2021 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610753707;
        bh=+bAM4hP1LqaBTz+jX5iv7B4iHImFOkU8UNOEN1eBaI4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K3PdmgcntjyuwGXw1Z/iZFQ2IHpDAIfz0ZSY7urMSrsZEYzbm5jwJSjjOcRta67c4
         zVTBsmVcByoboZqI8Y6EqJdZQUjeAm3/qBpsdBieo0btPwKWipkP7/j7grMCoujusI
         HWgqQjjKg5xxqY7HXxOafyKHQcVuLR0sAthBjxIKxtZmJb1TP2lFzaT1kgWPBLMwl+
         IX6UsKh4ja5tdm7zBXu1jaT9zzOk00HdtASJDZeS4dm+nVcXfxh+BxiIunJD8teK3q
         BY46Zp6cTewk5xKQtyuvF6D34zM1Dqy/cyuf3zE/CRJDkTjipXsPhYJ7Llkg67Jqy1
         BnQCErjcLURoA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 3F4F360156;
        Fri, 15 Jan 2021 23:35:07 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210115192140.GA456837@nvidia.com>
References: <20210115192140.GA456837@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210115192140.GA456837@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 7c7b3e5d9aeed31d35c5dab0bf9c0fd4c8923206
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cbe71e7e01a9e45a390b204403880c90a226039
Message-Id: <161075370718.4647.8588713566063823800.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 23:35:07 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 15 Jan 2021 15:21:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cbe71e7e01a9e45a390b204403880c90a226039

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
