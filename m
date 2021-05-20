Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3C38B491
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 18:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhETQs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 12:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233678AbhETQs5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 12:48:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3FE9D61019;
        Thu, 20 May 2021 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621529256;
        bh=dKfh8vn2wn4bopc33PvZUsYy4tfaEwhwWCUX1AgNuEo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G/f3CWIzMflMZfIkJeaB5YC21izG0DL/N8obJnZiWKwMaP6Ga9P4rjr10SsFqmEFc
         9e7pqF37QzB2pE2ShBp69xU7G9mkhmwUvW5F0p5+6hJTQfH8loom1QMjMUoSk6jxmg
         Wg9D6j1652EmJHkg4euevN2a1dWdQH2Px2NY8v/lhfZZyi2N75DfMzf/4bimA+d79c
         ALigbr8aPod4Ijqh7g11M6BG13aWjy+p34C3D2o0fN9RJ0fV1Qcvvo/NZi8Rdq8wBm
         JbWHxZjMFOLL62TJuYyvF7kVtVajeRF2XbMWERUMWsRbngFiavXKny7jqUroKhzEWd
         7FAt/vuHduh4g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2FBF1609B9;
        Thu, 20 May 2021 16:47:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210520143724.GA2715302@nvidia.com>
References: <20210520143724.GA2715302@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210520143724.GA2715302@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 463a3f66473b58d71428a1c3ce69ea52c05440e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f01da525b3de8e59b2656b55d40c60462098651f
Message-Id: <162152925613.27581.9666855151160127147.pr-tracker-bot@kernel.org>
Date:   Thu, 20 May 2021 16:47:36 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 20 May 2021 11:37:24 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f01da525b3de8e59b2656b55d40c60462098651f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
