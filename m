Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C58DCF3
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfHNSZN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 14:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbfHNSZH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Aug 2019 14:25:07 -0400
Subject: Re: [PULL REQUEST] Please pull rdma.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565807106;
        bh=qWSBdV3hWg97qBnKIsAim0F+3pcIzBkHQNQrfKrwysE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gkteLbrh1zajdgg1tkLOPvlsyNvAojzUPsKrVgrktCi/Kfzsk83dm45ApY7UbYIOY
         mngYz5/xdZeXEqQofz+M2GZsyyxjemI/zbRZvjThBe8VghefXdo6a5YiQdY9wS+g7n
         wVgAxwWldg+20/K02Xxrxx7XQhDdrxTVmdA4r+wg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
References: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 2c8ccb37b08fe364f02a9914daca474d43151453
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8dba0531bc0ba8b65e77a4a858da4b6eeaa1b92
Message-Id: <156580710639.11871.4883886338409398105.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Aug 2019 18:25:06 +0000
To:     Doug Ledford <dledford@redhat.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 14 Aug 2019 10:59:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8dba0531bc0ba8b65e77a4a858da4b6eeaa1b92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
