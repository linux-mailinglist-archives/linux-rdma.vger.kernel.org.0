Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB529F463
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 20:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ2TAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 15:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgJ2TAm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 15:00:42 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603998041;
        bh=kPdkMVwW8E4pTGhLJ7YjlfzyKDK2Urw57643KWdY8Ik=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=grDvBl3EWbEPuRba3eGnfL7ldTZ8TFYrScEAbV4N0Mkj4b989vs8TP8eX5sN0RtWj
         GM1b0MO8iNdms/6YOU/KhpiqroGAaHIWIIEbp4uKdQL9o8ijdkLkhqLyvAGnlsNlrg
         c+UJy9xLAOZccWC9rhXW2/Mbs6N+CMimlGSiT/Vo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201029184123.GA2920455@nvidia.com>
References: <20201029184123.GA2920455@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201029184123.GA2920455@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: a2267f8a52eea9096861affd463f691be0f0e8c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9c0f4bd5b8114ee1773734e07cda921b6e8248b
Message-Id: <160399804136.25930.236036130764519954.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Oct 2020 19:00:41 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 29 Oct 2020 15:41:23 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9c0f4bd5b8114ee1773734e07cda921b6e8248b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
