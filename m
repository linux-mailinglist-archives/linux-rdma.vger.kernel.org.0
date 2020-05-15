Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24A1D5A9B
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgEOUPQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 16:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgEOUPE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 May 2020 16:15:04 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589573704;
        bh=tmkkfb5RlgiolGotuwMjHh51nDR1N6E8SzFTI3GSFeQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tXOSpJjkfNs2y1D1BhBs2SndCSbVK63wjYNsrqUoCLDIwqmsbpicJhaqiVFxwHIYY
         eswxt2uT5ke2kbecUTPr3wl7lsNW1Eppm5TkqUCT7+wF+jbVy8aHggiaOaqpNXMVMH
         7op84PIaivZylRCDAd608OEaBK3eIs7vb6iGh9e8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200515191354.GA17053@ziepe.ca>
References: <20200515191354.GA17053@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200515191354.GA17053@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: ccfdbaa5cf4601b9b71601893029dcc9245c002b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5dfe4f1b44ed532653c2335267ad9599c8a698e
Message-Id: <158957370400.26450.6291646987244577141.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 20:15:04 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 16:13:54 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5dfe4f1b44ed532653c2335267ad9599c8a698e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
