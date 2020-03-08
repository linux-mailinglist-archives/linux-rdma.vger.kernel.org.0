Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1517D0D6
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2020 03:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCHCAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Mar 2020 21:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHCAG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 7 Mar 2020 21:00:06 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583632805;
        bh=GG2uckU09g+k7rvyZUCsLdvgOdd8dLKWmllSC50TIYo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ng9gzc03NHjIuFZRiBMtg+idg6Ng60ypnZgSlgvaH3a/6ThL1SFRy968yAxuan/Iu
         nuLs5cPPKfooxSG5hYHJEz+pfLsh9YW2SGNE+QGU+tNlmayClQYTADFZ5RcPU9Wpiy
         tch4kts7k6tNrNb/rSdJAMW5hfolat1ncoQ5fiuk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200308000718.GA27153@ziepe.ca>
References: <20200308000718.GA27153@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200308000718.GA27153@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 810dbc69087b08fd53e1cdd6c709f385bc2921ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61a09258f2e5b48ad0605131cae9a33ce4d01a9d
Message-Id: <158363280582.6802.15894724244872895526.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Mar 2020 02:00:05 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Sat, 7 Mar 2020 20:07:18 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61a09258f2e5b48ad0605131cae9a33ce4d01a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
