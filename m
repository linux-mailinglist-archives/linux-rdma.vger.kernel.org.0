Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BC1B9F32
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Sep 2019 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfIURkW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Sep 2019 13:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731214AbfIURkV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 21 Sep 2019 13:40:21 -0400
Subject: Re: [GIT PULL] Please pull hmm related changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569087621;
        bh=LsJ4KroFpbZgHfIznXa/jo/IJP0ugyfdqLBIjhc8268=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n6E7JQXe8lfUX+FaNG3J+BYya8cbdUEeLMb5493L7IbpwanV8sKgytc7F7dtJJl+X
         YjHEfN1f8jVJtTyKyC+iccEBHw6eLdZDJyNoYh4DJSM09PrXbKWFTlSE0jE9DKn1Bn
         V5mLYnWP9WTwNf5ger3difRJGdlkUKrHh5JlYecQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916162350.GA19191@ziepe.ca>
References: <20190916162350.GA19191@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916162350.GA19191@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
 tags/for-linus-hmm
X-PR-Tracked-Commit-Id: 62974fc389b364d8af70e044836362222bd3ae53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84da111de0b4be15bd500deff773f5116f39f7be
Message-Id: <156908762129.32622.9253749641256776927.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 17:40:21 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 16:23:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84da111de0b4be15bd500deff773f5116f39f7be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
