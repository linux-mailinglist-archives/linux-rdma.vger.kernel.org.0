Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3458A4FD
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 05:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbiHED0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Aug 2022 23:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiHED0Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Aug 2022 23:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79805DEB4;
        Thu,  4 Aug 2022 20:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1699260DBA;
        Fri,  5 Aug 2022 03:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78B9AC433D6;
        Fri,  5 Aug 2022 03:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659669972;
        bh=RiFsmtPK3C0sxX14TBvV1QeNDwkSe8hOKTmeVcrjEts=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=odf0gs6gIei4Kejfk/zJ4nvfkfbStgmj3b4+JN6+Wzyz5aRIfTnatPPb5a5+sjtM+
         g6VqDxAgmyV9aSZMcJo1/HBlAc3kwiNfZTzidpjhjCN64ZDKFOaCVQT4R90LSA5wdi
         S10gVRE8IE4CBmKDWH7IW09/f/7XD7Dc5i2ly5ZfHat6tbUTjvoBfHepTEG4UL5+6P
         HUTChtwWkzzLyhhx5KM+/Xk8RylnJyJwmHPQVAhESCZg5lRoWgK79F55wS1hwgwbYu
         kjNPiju9OKb4/38tfywVgKWxV9paFoqmjkQ1R1YM+FTW1+brzvqeHt3r+7oHFz5HHF
         yfAKkfecaN/vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67EC9C43140;
        Fri,  5 Aug 2022 03:26:12 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuwUmSRis1rYhR+y@nvidia.com>
References: <YuwUmSRis1rYhR+y@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuwUmSRis1rYhR+y@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 6b822d408b58c3c4f26dae93245c6b7d8b39e0f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e495274793ea602415d050452088a496abcd9e6c
Message-Id: <165966997242.9883.1001097071562370675.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 03:26:12 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 15:48:57 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e495274793ea602415d050452088a496abcd9e6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
