Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A74234954
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 18:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgGaQpI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 12:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732474AbgGaQpH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 12:45:07 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596213907;
        bh=ZKce+OXumkZb4kqFrvbJfKCGZDIliumucLQP3fmsUUs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rxjgXd3ive50KQMmpeLCfmb6qOEIDNTfcPablYHj2sO8kRHIRiYQZ+M0uGhgJw6dR
         WOkM9gpEl7AaBQ8tQovBN57NyURyMaf+fLOCgA4a7tFbkHvMoZPKduAj5duScICfs4
         nB9C26k9abjTpFQvbfAfsUhtDhPSfS20srUrw5CE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200731151702.GA498584@nvidia.com>
References: <20200731151702.GA498584@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200731151702.GA498584@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: fb448ce87a4a9482b084e67faf804aec79ed9b43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae2911de2eb5dc9ccb88c6502c776a8fbb7acc67
Message-Id: <159621390697.29129.7229038123498782130.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jul 2020 16:45:06 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 31 Jul 2020 12:17:02 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae2911de2eb5dc9ccb88c6502c776a8fbb7acc67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
