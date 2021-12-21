Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCED47B6E7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 02:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhLUBhf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 20:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhLUBhf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Dec 2021 20:37:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC07C06173E;
        Mon, 20 Dec 2021 17:37:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF8A6129E;
        Tue, 21 Dec 2021 01:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 260F7C36AE8;
        Tue, 21 Dec 2021 01:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640050654;
        bh=PqkmIKY4D8LOgCwCAe0/g5uRYrWH1D3oVZLhRQia074=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nkza214LSudVN5a0/43O11JDNV6oYKJWAcd+p2kD8outgoSOVDVvoj+CzauQ9m2FG
         160sVq+vkbS7XDtuFSvZAF3w8fWBKtDXcMuJ5ii5yKHR0C6KnK9j9G0pLvT5Vgw0/d
         5LPHMH884jKwWIvqfHLbvWw0QXerX7os0hboCa/iBdXw28w9uH2q3J02Ro3oyLJWS3
         lWqg6V2szyHpy8e0+EzzA7DiuE+UVtqFiioh8Mj3Se0Qo1WN54gWe+dRkxraXUJTwL
         y2yV1zyeHTtJLn9/1+8NKkWlnOrqVAxKs/m1h3s9i9bO3cMfugXUf16i3D+rBMfV0R
         gr7XWTiaRM5Fw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EEEB4609CC;
        Tue, 21 Dec 2021 01:37:33 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211221012540.GA1665423@nvidia.com>
References: <20211221012540.GA1665423@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211221012540.GA1665423@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 12d3bbdd6bd2780b71cc466f3fbc6eb7d43bbc2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e0567b7305209c2d689ce57180a63d8dc657ad8
Message-Id: <164005065391.27121.15164787680609643831.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Dec 2021 01:37:33 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Mon, 20 Dec 2021 21:25:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e0567b7305209c2d689ce57180a63d8dc657ad8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
