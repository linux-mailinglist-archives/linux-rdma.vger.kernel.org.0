Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7852E661117
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Jan 2023 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjAGSnS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Jan 2023 13:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjAGSnR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 7 Jan 2023 13:43:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD01BC92;
        Sat,  7 Jan 2023 10:43:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF0160684;
        Sat,  7 Jan 2023 18:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1935C433D2;
        Sat,  7 Jan 2023 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673116995;
        bh=GL0P0GuWsl2y5zXLwtIWgEbLgVke8Ceqm1V4tV2Crpg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rwAYoHWzZ7OAlqHmRxwRHEZqg+vcv3nM/dXFQNFy9AJU5sskfxe5GBPbWi0yMERVv
         rcaDxO0ia+eUCa+HleTMDFCAb7WGVd9KQfRMUjBJHoPdI7zKA/DSCG+KDg/Txk0qdz
         mR4HOxgv9MFDmVOgmEEZkym1Xop8/1gRTO7lxnIZNeSCtx9aTvc02FSdPq5/21gqR7
         vAoaAg0A3ZW5ETFc41WKY+VMAYEWrcKPh0+cyaVw2bEdnxPaHiuSJgp6wdvE1KkB8Z
         sYfGa/E57Z/yBZUQ4pngiKfPs5SA7etD/amY6tjzx97lYVskCPke8cPiZQPGAZf8R2
         Eoj4xoIghbAGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D37FE5724A;
        Sat,  7 Jan 2023 18:43:15 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7jU7+B793cI61LU@nvidia.com>
References: <Y7jU7+B793cI61LU@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7jU7+B793cI61LU@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: e95d50d74b93a767a026f588e8de0b9718a0105e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a4dcea0831394b876ae955ecf49ba072ffbf059
Message-Id: <167311699564.9095.7516825177396120801.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Jan 2023 18:43:15 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 6 Jan 2023 22:11:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a4dcea0831394b876ae955ecf49ba072ffbf059

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
