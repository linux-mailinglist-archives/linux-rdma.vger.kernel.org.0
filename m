Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243682DC883
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 22:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgLPVvn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 16:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgLPVvn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Dec 2020 16:51:43 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608155462;
        bh=loQCEnZ8v9NT161uivZHxUVWprNJAYNjXldo11xbSzQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rIWLyHganCG+XxduIBwZgxlztry/NBX9yjn3AzKN1GzffwcJ0RJ5xs7sqtxPCwA1T
         DCU82DjZ7tERNy2I3bav6TxjTJ9rKslfFlbQtYJpZI3bNeIaRGN3/AUih7ElfuhHHZ
         +FcDiaIeqy86itsjAPHc401LXZzUtWTGyTnTSfXgixyBZbd9ZQ80t0aSVuHFnU17AJ
         /dTzSqncSL1RBd3mGv2/NkvozxiNJZ4HijUUgvL9i3v1/IKSVKLbbwtTxWP0dXoTnQ
         fZufZmsjvv/kJN4LJhCmlSZnY9LVZehwg5uq99rvP7aWpldaXBHQpqQnT1YS2oypxL
         d3lE3Jwu2YvDw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201216175730.GA2787107@nvidia.com>
References: <20201216175730.GA2787107@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201216175730.GA2787107@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: e246b7c035d74abfb3507fa10082d0c42cc016c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 009bd55dfcc857d8b00a5bbb17a8db060317af6f
Message-Id: <160815546244.13626.3866461600054878990.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 21:51:02 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 13:57:30 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/009bd55dfcc857d8b00a5bbb17a8db060317af6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
