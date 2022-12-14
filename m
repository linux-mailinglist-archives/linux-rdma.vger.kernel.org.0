Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB864CF17
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Dec 2022 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiLNSFv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Dec 2022 13:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiLNSF0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Dec 2022 13:05:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDF23147;
        Wed, 14 Dec 2022 10:04:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7130B819B8;
        Wed, 14 Dec 2022 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58301C433F2;
        Wed, 14 Dec 2022 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671041085;
        bh=juNTL0A67dvslFkB6+bvivV58YYYoa6U9yhFU9rvUFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dtKuhX8hdulFfjPxjmwWAO0KTg/swO+f8ZcWcMi3Nsv+E4ct28LtJe0m7rZ3Rpiw3
         8Oj7pm0uHRWX2xxAp2uy3at3TOwHLT2Kr4F91DVhpaI93wgPoIeXlSA90EClkDvjjJ
         gScA1N+hov7SoTl1erp/j0t668F0Xgeq+DA8xfuc6htVVi56cMlx+mwhpi4/FKBNUD
         blWHFRb3q903KMf3trFBpcp9sQ3e+/YMKhhFYl/7/VfX08aw8jJ7cPp6SdJ9/E1rbB
         reK9yUkNOUrCyLcIoLZfC+QQoleFWphqTptQ/EcMZVAk1HpgfCmyQmz4noutQnM4qz
         y6+z2+ozZft3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44C6CC41612;
        Wed, 14 Dec 2022 18:04:45 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5jpKmpwhTAf+r8B@nvidia.com>
References: <Y5jpKmpwhTAf+r8B@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5jpKmpwhTAf+r8B@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: dbc94a0fb81771a38733c0e8f2ea8c4fa6934dc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab425febda94c7d287ea3433cbd0971771d6aeb4
Message-Id: <167104108527.17244.4207557699245256925.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 18:04:45 +0000
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

The pull request you sent on Tue, 13 Dec 2022 17:05:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab425febda94c7d287ea3433cbd0971771d6aeb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
