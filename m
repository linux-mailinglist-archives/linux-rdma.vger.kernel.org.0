Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F420A680
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2020 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436509AbgFYUPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jun 2020 16:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436497AbgFYUPS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jun 2020 16:15:18 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593116118;
        bh=qwTIv2U439qORpBFj7RnUfDqRszJm9HA0FxIhFmYUvg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HUY1Q/IlS5N8/B/CfNh/LMVSxRTe3zqyHy9l2IDAqi5lPUbybSAPQVGhWq0VLLVoF
         0nQyUPa+XKuVKRwHz+mqXFEJ3zl1QkKbm+gM9MuujspJe18/7YywNOvtP03Ddv4rFI
         w22Btc7B4itM7pL7jxX864WaxrAp3X0dWhxJB5cs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200625175610.GA3402155@mellanox.com>
References: <20200625175610.GA3402155@mellanox.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200625175610.GA3402155@mellanox.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 38fd98afeeb79d3b148db49f81f2ec6a37a4ee00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87d93e9a91c76bcb45112d863ef72aab41e01879
Message-Id: <159311611861.12359.11117737871815817919.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jun 2020 20:15:18 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 25 Jun 2020 14:56:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87d93e9a91c76bcb45112d863ef72aab41e01879

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
