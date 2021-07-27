Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7FB3D8199
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 23:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhG0VTh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 17:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234494AbhG0VR4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AF02260F6E;
        Tue, 27 Jul 2021 21:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627420675;
        bh=fgnjCpOpLiQQL/G2O9SE5PG4/gtnXh929fAXHD1gBDA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L631o5+ePeCz/NARLUTemRKmHJs7RvSlMU8DRRbqBBFsbwFtpBQUFDZiEdT1VLwTD
         KiMut36ccQsDjIZITcx6Tv9b7rR2GRbaouu/IPzxM7KCQDWqSAT6D1JCxo1aY8oU05
         T71izMJ5RoZr4NIqZGGBZoxXpDFRl8H65V7jfWHmIMbFtxVtM6F62t180nvi80mLM0
         Z2bT4h3WvdcAK2cmjS90IiwHPK/5n0vxNMCGEO6UsRBlMoWO14NRCoEm9Wvj/oX6I4
         PbBEA8yLHuWO6nLqEu5JvL95ehBM2Drk2/TOKYJcd5gMBBm+40X16/b2S5JWeNGoI8
         DIB1crsA9mb1w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9C4C5609CC;
        Tue, 27 Jul 2021 21:17:55 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210726231035.GA2109238@nvidia.com>
References: <20210726231035.GA2109238@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210726231035.GA2109238@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: dc6afef7e14252c5ca5b8a8444946cb4b75b0aa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d549995d4e0d99b68e8a7793a0d23da6fc40fe8
Message-Id: <162742067558.21413.9676120194086838340.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jul 2021 21:17:55 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Mon, 26 Jul 2021 20:10:35 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d549995d4e0d99b68e8a7793a0d23da6fc40fe8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
