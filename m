Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC141405D07
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhIIS4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 14:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhIIS4A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Sep 2021 14:56:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BEB396113A;
        Thu,  9 Sep 2021 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631213690;
        bh=IiV6BnLJaJ+FV+6kSSF2RYEdIVVXISpDEMd1BcgdO/w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P8Z2RrHD+zbbdbqQN49muFSRPzfo1soud/Dk84C1YDTkPPmDvVMsYk8dkrkUtyrs4
         sCFQ4pAsbofxpA0n+at27a8C9Vj/s4YMtX+p/qadHN7pWcPihpoYn7qO8ZhE9krTnO
         1B8g3jifb0Bhk+48+dhHsfj/8o2AN/zZmdkP6JMORP+++Cdo0aLh6ftdS7zQYftkjA
         2KKaJsATsjzrdU/z1XUAhvEOR73SM0ka8rRKDT5ZyEVi2rObUVKQNB7AKLP4tZaqmp
         Q82jEirpoXZo6h77Bd1nXgT/CsHeuL2Lzq13qlWxhsuCL01nYOWQHEoyMSJLcJ68tP
         jyEUhZF+4nhEA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ABD1D60978;
        Thu,  9 Sep 2021 18:54:50 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210908234032.GA3545321@nvidia.com>
References: <20210908234032.GA3545321@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210908234032.GA3545321@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 2169b908894df2ce83e7eb4a399d3224b2635126
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b105f4a256ae629522a7ed1611aba28fd282bd5
Message-Id: <163121369064.14164.18212912952254007610.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 18:54:50 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 20:40:32 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b105f4a256ae629522a7ed1611aba28fd282bd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
