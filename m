Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916B53B9864
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jul 2021 23:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhGAWBB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jul 2021 18:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233852AbhGAWBA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Jul 2021 18:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 776A561410;
        Thu,  1 Jul 2021 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625176709;
        bh=pGO2cIfkxP/D+eiUIwZBDub00iZzCEeDvEzSyoG2NzM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nT+4lWZSGBPfg+/dXlVseEnikMkqGX/5WVeqAFmNwbQ1Fctu8VHfxqZOOWjl2l2OT
         xj7uzjxEAgT5JdDhljM9YjR8CectwdU8FL3Ux634cNkoD25226EpdAu1lONpFptMST
         9H3xxLSIha3Z+i3H7zNKTCYliA97V7GOZ7szISeGlFq21bmQidz4mdsF1LP2UtRreF
         bx44djVbH0DsANG84UMx9T6S3yoLdtlVHvvJcJQO12UBF3N3lm7kxLbJAu8oqbRh6r
         XA6tuCFbupwTgf/Guy5LgBa2RRVoVOSTt2PWHTVU+mVAX+YmouEkaVAayh7/vNvaB7
         wwMlDob0Ei6Hw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 71C3960A27;
        Thu,  1 Jul 2021 21:58:29 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210701013027.GA542170@nvidia.com>
References: <20210701013027.GA542170@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210701013027.GA542170@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e04360a2ea01bf42aa639b65aad81f502e896c7f
Message-Id: <162517670945.12814.6790653186770604073.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jul 2021 21:58:29 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 30 Jun 2021 22:30:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e04360a2ea01bf42aa639b65aad81f502e896c7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
