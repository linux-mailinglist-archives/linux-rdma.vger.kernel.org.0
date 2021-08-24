Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368703F65B7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbhHXRPy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 13:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240022AbhHXROE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Aug 2021 13:14:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B7AF261A7F;
        Tue, 24 Aug 2021 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629824495;
        bh=rGBceb6nEqSjkrJx5lFbFiYdVrmnBh62HwT++73XYzI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DSlea4jACmtF60tK99yPYFv4sn+kTVnkM2rAYIgKPPivxWTO2rVryKtMA1hsEBQQ8
         FBZ0QDz+BAKMs1yJXz8r46Yt/FS1jL7J/zqz04qE2lRSlTifV3eJk0va2lv15UduaZ
         NI7HNMlLAvFLX9qo/mSfXqIAzBqUBgloWxAQePtbiQyxNDOsurVC1cHJE9C3X+k9ZV
         JDzMLCbcjQYE1a6fJjX1Ek+tzN38YazBGeNHvswfF7gEue4s9t5Z8V8swLbc6g+wVQ
         CgpKctLA8cVrG4WJFy9PuDs+DOXSwKN/rI7OgC+ZCNSU5/6+7sSxMByR3tsaR0J4A2
         U9YCVxzUcRWYA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A7FF26096F;
        Tue, 24 Aug 2021 17:01:35 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210824142310.GA1070942@nvidia.com>
References: <20210824142310.GA1070942@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210824142310.GA1070942@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: cc4f596cf85e97ca6606e1bd10b3b9851ef52ddf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e764bcd1cf72a2846c0e53d3975a09b242c04c9
Message-Id: <162982449562.32359.8999725810934804142.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Aug 2021 17:01:35 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Tue, 24 Aug 2021 11:23:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e764bcd1cf72a2846c0e53d3975a09b242c04c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
