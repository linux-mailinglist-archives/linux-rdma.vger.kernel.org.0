Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54631676039
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 23:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjATWi2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 17:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjATWi2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 17:38:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D69762ED;
        Fri, 20 Jan 2023 14:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACDD4620BE;
        Fri, 20 Jan 2023 22:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DF11C433EF;
        Fri, 20 Jan 2023 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674254306;
        bh=MpEGY6/xksiGVYiHlhYRcbm1YXpcd5WDLzFdFfPXiJo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EZ3N+68xWx3DdO0W73vblDoNXoC1oWAgsr4tmOdjkZjj5GQQuiuU2G7cIzLYZaP6z
         icBSrGHNf5rYxYAl/o2hc7abOJ2XulRhdl6vLL2smBAuEHTuB1sj2miXMnbcsqfCnI
         DK38LQ59OpVLDtB2Nl7sQit01I2wRrXGIGJVs/blNFYv8knwlqsC5URBtNBnbW086n
         Ts6mNER/R6gTrkx4WLTrkujZuu/O4mBREk0hFuL4303sL82b3hpjoxC8mWQrQMrc2b
         DM4TgvsteXxqDE399sxeu3SKZEg0Hfzu7BkxHHHsjDBwjrkTiuvEgMq5fMS1bXuruV
         hOINf+QWPIzxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AAE1C04E32;
        Fri, 20 Jan 2023 22:38:26 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8sD+xH7fohazCtu@nvidia.com>
References: <Y8sD+xH7fohazCtu@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8sD+xH7fohazCtu@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 0f097f08c9b3c1fdb6cc9f2dd423abc17d13f1a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8974efaa3385959e7ea1019a4b63acff28631e6d
Message-Id: <167425430603.2096.15873709089812714863.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 22:38:26 +0000
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

The pull request you sent on Fri, 20 Jan 2023 17:13:31 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8974efaa3385959e7ea1019a4b63acff28631e6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
