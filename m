Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66ED1BCD93
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 22:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD1UkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 16:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD1UkN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 16:40:13 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588106413;
        bh=jQJ8NzfnAGQnbM0MzVH1OciL2juYiBUJU2CbelN3t0A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b6zWkxV4LQ6UxZNmSfXa1Ts68g+jnEF9b6QmZfngkR/XZ+FgpLh6pEOQ+8CoEVgTT
         qN+Vz9RXqM5AtBuwQzaIKfPGBxeygTzM+j66H+ktjixMdMkwV2T7E7utvHIjJ9abfX
         uiD8meSvmRH0ZkO/5BQ32Mu9dBAn4aeH1piUz6Ow=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200428195914.GA24418@ziepe.ca>
References: <20200428195914.GA24418@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200428195914.GA24418@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f0abc761bbb9418876cc4d1ebc473e4ea6352e42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edb98d162418e90d6d2c1cec42e09be0375cfd88
Message-Id: <158810641295.6200.14784665547268309787.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Apr 2020 20:40:12 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Tue, 28 Apr 2020 16:59:14 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edb98d162418e90d6d2c1cec42e09be0375cfd88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
