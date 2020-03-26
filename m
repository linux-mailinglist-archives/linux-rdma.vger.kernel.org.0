Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D271945CF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 18:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCZRuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 13:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZRuH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Mar 2020 13:50:07 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585245006;
        bh=T4RhMfsPNRHkPPICu5fdtPwDOB8bAIcLR18c12kcTNI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ojpWnY+GskkYpxDqYM3iaenCeQwRYQ1UeTUyhIukImj8Uf0X46bIX+kaylMy8kxrs
         nGG37veQDWFq52bXoxKmtdzYC+q2RRVYWwFzJV1kZtkCEIV0EWYHwHyG6oPf17nL3N
         GGog+95Ig8EoFf6PWvYXRpibIMaGX48DvRKVcExA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200326173152.GA22458@ziepe.ca>
References: <20200326173152.GA22458@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200326173152.GA22458@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: ba80013fba656b9830ef45cd40a6a1e44707f47a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9420e8ade4353a6710908ffafa23ecaf1caa0123
Message-Id: <158524500654.16048.14590188393209667775.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Mar 2020 17:50:06 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 26 Mar 2020 14:31:52 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9420e8ade4353a6710908ffafa23ecaf1caa0123

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
