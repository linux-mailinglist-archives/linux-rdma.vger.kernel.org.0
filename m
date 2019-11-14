Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B2CFCB21
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKNQzF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 11:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNQzF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 11:55:05 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573750505;
        bh=ujTHACbyXN5gw0as67eBx/EYvZayaA+rd54OneLVBMk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pwzp4ygHzvrwMxRyHkrZwsnEOl0vLtuk7bUM9pID2f7+aaB80ziObBlbCBALpsO8b
         Tl8QD4QYYF88rMZ3th4I5zaYmGuREaiOZWNk1wloL/ZxSjkrOHyTlOZesedOjpY2zD
         7LSOsYsKnUCpeAJb8a2sc6UsW/tNMia7DWkqEJ58=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191114151609.GA14855@ziepe.ca>
References: <20191114151609.GA14855@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191114151609.GA14855@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 411c1e6774e2e1f96b1ccce4f119376b94ade3e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e84608c7836c632aec53c0fe8993ad4b60b0acc
Message-Id: <157375050515.665.14994963726740504441.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Nov 2019 16:55:05 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 14 Nov 2019 15:16:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e84608c7836c632aec53c0fe8993ad4b60b0acc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
