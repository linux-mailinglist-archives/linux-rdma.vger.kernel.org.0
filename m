Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D864F959
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Dec 2022 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLQO2h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Dec 2022 09:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLQO2e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 17 Dec 2022 09:28:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0135FC7;
        Sat, 17 Dec 2022 06:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15122B80CB7;
        Sat, 17 Dec 2022 14:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC0CBC433D2;
        Sat, 17 Dec 2022 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671287303;
        bh=WT4RFCFJnMGZ8UEDIqdDh3m9d1WuuMMPQoq5ULI51qQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NCaAUMHYU8Ui6JNMV6HLrfFQ3MA0qe3vkQuOrxFJrhFxqFGC7bSNBJsiRZbRZfHgU
         zW6Nee9a61Qk/e5NzqJLZRdm+RKocSlMGX+Lp4UwltXb9N/Rr7T0ObDjo7weBz9Lwk
         pVcsHkaam7aaFIYhMVERT2vLquJAGVHVAOqDfIHFgvfMXf+tFiuV3WT0hVQSRDlKBN
         dnRsv5YHkwTZSbYknq+ZlFEub9K5rvG6jF5df/2E/rM6HgRakU4pczZMga3+GFW24Y
         LVsdf0q5Taiutry+/XPkFdkh7rNFjzXufyxixSW8uCkeIOEaDAy5mohBgrGIESd86u
         fVDAkYIVML4Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A3F5C395EA;
        Sat, 17 Dec 2022 14:28:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y50V8+TQA7wsipC5@nvidia.com>
References: <Y50V8+TQA7wsipC5@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y50V8+TQA7wsipC5@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 5244ca88671a1981ceec09c5c8809f003e6a62aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed56954cf5a8b7abb530676a073d14f9de661d69
Message-Id: <167128730362.18739.8917676882091873485.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Dec 2022 14:28:23 +0000
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

The pull request you sent on Fri, 16 Dec 2022 21:05:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed56954cf5a8b7abb530676a073d14f9de661d69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
