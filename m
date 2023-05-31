Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE60718941
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjEaSUD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEaST4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 14:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B000193;
        Wed, 31 May 2023 11:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E983063E91;
        Wed, 31 May 2023 18:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 558A1C433EF;
        Wed, 31 May 2023 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685557160;
        bh=xVsaMV+9hD9hnhWwGlp3/jFFIjhY7IAh+Oqa9Da3rkA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F1bceTUGnOMkljXlMNnSRk7uKaOF67XyFGYc6bwkSHNSpolf+E8oOGo1niMgD6iX7
         RR8lsMVL8ddsaR5Rl+dBJDJFWSZkMmBsejc3jLNoYrjyvIQvILuCy8KHTsrcNu5suV
         fsDJ4vTNlHtGF7fmmErafZ7+a0cRsx0U5mo5vSDkbaoGa/ZHaXaegvSX7lEaRHg1dR
         ZeXoZrjcXGu7uoKtM+dTmOu2OMexK5J/O2MyLTJ5+d+S2XctVCzjwRzyz86EeJGHar
         J9fFS+C55dBI5jCrGyhVJjx0Atv9dB1Kj+F46WrjcU3iqLL14IdZXN9iA34/OruyGF
         YpoIMGP9fyo6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42935E52BFB;
        Wed, 31 May 2023 18:19:20 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHd8qRfFribp26D6@nvidia.com>
References: <ZHd8qRfFribp26D6@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHd8qRfFribp26D6@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 5842d1d9c1b0d17e0c29eae65ae1f245f83682dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 884fe9da1b7ccbea31b118f902fbc78f58366b4a
Message-Id: <168555716026.4511.10261751054544702219.pr-tracker-bot@kernel.org>
Date:   Wed, 31 May 2023 18:19:20 +0000
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

The pull request you sent on Wed, 31 May 2023 13:58:17 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/884fe9da1b7ccbea31b118f902fbc78f58366b4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
