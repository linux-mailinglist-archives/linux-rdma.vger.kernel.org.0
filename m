Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48A910B5FA
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfK0SpW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 13:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfK0SpR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:17 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880316;
        bh=h0tc59d+kmkpHy21UmhivZLRAzewlsXGrbX34HlG3gg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XPmZ0YLKtvdahFs9KMqyhZDgQEFLA/1DnSavWkGNDfUptmTZKwQqsB/FwELp7MtXR
         yyUe3nPhXQTDRBEpJcuVCsZcDf1YbySR0yNisM7yh90KMFJQX7VQa9heGATcBP/AK/
         bB+08xNBXSCDj2equK7JpNdrJNceQz26WYq/aToQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127002431.GA4861@ziepe.ca>
References: <20191127002431.GA4861@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127002431.GA4861@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f295e4cece5cb4c60715fed539abcd62468f9ef1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d76886972823ce456c0c61cd2284e85668e2131e
Message-Id: <157488031673.21185.14237744447686342993.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:16 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 00:24:40 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d76886972823ce456c0c61cd2284e85668e2131e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
