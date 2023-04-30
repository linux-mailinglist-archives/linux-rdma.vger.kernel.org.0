Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21B6F273E
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Apr 2023 02:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjD3AwQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Apr 2023 20:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjD3AwP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Apr 2023 20:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE536123;
        Sat, 29 Apr 2023 17:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F5760C8C;
        Sun, 30 Apr 2023 00:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3917C433D2;
        Sun, 30 Apr 2023 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682815933;
        bh=HCj6mapdxBCyXn8T65H1nwvGI289vEksLGda2ATy+Iw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EucWTChk7d9z+wk3zHWS1DZzsE8RjKO0D3ZgDd2F5QVluTX+R2DAo+IuKtz8+J+2K
         pPLwzSz63OP7krJegIDHqLINqMGBcIBdYIKp8HiInEH4FDm2J6dopzsTmYK5cESt02
         i/57UWnPpoyJ0mYQsGLNxOfvNrkXUlsza+u3owueoFAwLm5kW1dQd2KKRQUUBdPEIU
         kFO2/rUGoaRt1Yw5MSQX9RS/Po2PMpuJxSreAILrXrJigoYNSL9x+WNoCJq/X2tU8N
         01mq+Hrbr7HlAT7YCTuwkOQikgETV545C4+T/i27xQ0iKLa4sWL0ccesgCq3V58A5O
         dAyCdDg7C4EFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E18DDE5FFC8;
        Sun, 30 Apr 2023 00:52:12 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEvnlQSpLI/4qnEp@nvidia.com>
References: <ZEvnlQSpLI/4qnEp@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEvnlQSpLI/4qnEp@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 531094dc7164718d28ebb581d729807d7e846363
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af3877265dd88d7e333f94fb37bc09554544adca
Message-Id: <168281593286.341.10745119511166594898.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 00:52:12 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 12:34:45 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af3877265dd88d7e333f94fb37bc09554544adca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
