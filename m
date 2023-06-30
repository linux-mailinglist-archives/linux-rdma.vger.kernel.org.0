Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F474336B
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 06:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF3EQq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jun 2023 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjF3EQp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jun 2023 00:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A81FD7;
        Thu, 29 Jun 2023 21:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 832A26167D;
        Fri, 30 Jun 2023 04:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDE10C433C0;
        Fri, 30 Jun 2023 04:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688098603;
        bh=UEbaQ7BXNoThBFtdI4w66veNSz4ItIQdwCIfmHkiAEY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W+cDfJsXT59sRuu7QPcqBztAa0TCfaQynepcwRk6s62T5b9Ft9TkPVno0MT/l3VMf
         m5of5cRu3sI7WuTKx7DyNwhSwv6iE5oT3cvYQrktgLvrFQ3rXUSGV/jZO3Ad1gvyOQ
         XVOeJT3JcJHUzxgCOfOhjjf03LqbemjcVPBglTR27We4pc4SNHXm5OASEu7MwEaPbz
         qaA/H/gFSBMM2Uc48MfBIyRcvSmVbPizbLYNNOLQ9ZL3C66VOpxTjCGfIvgPnvWl5q
         W9xMh2ErKtYd3MHtrz+0hPTBw/cZz23KUjR5cw8rLpLt39ow1gjcbRr5NrV5JEbbCu
         ma3BwdtaZS4sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6A80C64458;
        Fri, 30 Jun 2023 04:16:43 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJzUeFT7lLqEjMJn@nvidia.com>
References: <ZJzUeFT7lLqEjMJn@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJzUeFT7lLqEjMJn@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 5f004bcaee4cb552cf1b46a505f18f08777db7e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ede5f78a0d74b574791c7eb0e2ca6e54b80c93c
Message-Id: <168809860380.23778.16011599589680893363.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 04:16:43 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 21:46:48 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ede5f78a0d74b574791c7eb0e2ca6e54b80c93c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
