Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1EE1EC4DB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgFBWUG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 18:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgFBWUG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 18:20:06 -0400
Subject: Re: [GIT PULL] Please pull hmm changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591136406;
        bh=AY1pqien7wCMuZ9apGiNukl+u+CVWaQr0SUzXRzJi7E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sZxhAJMoYDlcxViwgIgPzf+ZBYGVhm32Sb3Aw8WnPkQSkeNu3Wwk8qlt/aN66mYly
         nXXVNr0PmlK8MSAV5W/LnecCde0luklRe6EHstQ6pYv0Hsfa2hIz/e/WKmEEAeKHgm
         xJwqcJDQRZe68DDnExQAFXWDeeg6bsa0cw2LioDo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601182552.GA28020@ziepe.ca>
References: <20200601182552.GA28020@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601182552.GA28020@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
 tags/for-linus-hmm
X-PR-Tracked-Commit-Id: f07e2f6be37a750737b93f5635485171ad459eb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfa3b8068b09f25037146bfd5eed041b78878bee
Message-Id: <159113640626.9664.5574442426922899316.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 22:20:06 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 15:25:52 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfa3b8068b09f25037146bfd5eed041b78878bee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
