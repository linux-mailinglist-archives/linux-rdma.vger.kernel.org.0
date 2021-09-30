Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1F41E366
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 23:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbhI3VgU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 17:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhI3VgT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Sep 2021 17:36:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B6D361A08;
        Thu, 30 Sep 2021 21:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633037676;
        bh=viz0vsJ9DYMWgsR7KdMVIFQa7QgqHAuEdg4BGAXalZM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ICELzSWpXSwRl2QzETS3qfjCdXgUXi68vItsWqYIBEuPxdQdE++ZUaG1txGNKV1S2
         2rJ+aoA+1Frbk5ia0XdOldlygsrqpxKAtZJy0BwYbDyi5or31lH4q8hbg+chO7Qx27
         1cDAsmes/wrRuQaWaUjmbp30rcfF9SAr+vaahNwZUFP8Tu/pj7dy2tNBpMsypI4ahg
         nwwm7HvX8rvACr8c5CQPQaW1CVwytrJeP9tvS6yY9nFY/wp+Mnh2f7oeiaRepul82k
         QCln2YEmhqRiTmulfoYQOaHh9ir9+NK9MMuKo1hFv7/PwNR1lB+PAFfFlpzw4AvGoa
         au8ami1mlPvUQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 67D5660A7E;
        Thu, 30 Sep 2021 21:34:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210930010235.GA1888324@nvidia.com>
References: <20210930010235.GA1888324@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210930010235.GA1888324@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: e671f0ecfece14940a9bb81981098910ea278cf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78c56e53821a7ec3462ce448c1fe6a8d44358831
Message-Id: <163303767636.5240.10301402475924787419.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Sep 2021 21:34:36 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 29 Sep 2021 22:02:35 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78c56e53821a7ec3462ce448c1fe6a8d44358831

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
