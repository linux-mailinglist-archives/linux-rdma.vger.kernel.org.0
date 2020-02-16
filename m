Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48BA16014E
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2020 02:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgBPBUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 20:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgBPBUU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Feb 2020 20:20:20 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581816020;
        bh=sdhQP0Y+KvxAekx33McAM8ysosoNXfAo8kt1Adjxvgk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=df1aLHTtuhyLSX/GzVTNdY4HtRUiplgx1z57tH2nUYzPIUw8gF9BBykB2aa2APllW
         s9HUz0rFpPivzaHkD95rnlRli+fdpzUmLYo0HmG7pZD5qwTTQQ19qr2oNkF+eyFKDW
         gO4twksUnd/77pmW/izEqCUpDgXiom52AzsU6AcM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200215213204.GA16455@ziepe.ca>
References: <20200215213204.GA16455@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200215213204.GA16455@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 685eff513183d6d64a5f413531e683d23b8b198b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54654e142d9ed3f7382767d6da769a2887888a75
Message-Id: <158181601994.2543.14981539320132221982.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Feb 2020 01:20:19 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Sat, 15 Feb 2020 17:32:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54654e142d9ed3f7382767d6da769a2887888a75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
