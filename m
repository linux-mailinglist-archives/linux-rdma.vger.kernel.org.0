Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14751616CA2
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 19:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiKBSjP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiKBSiy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 14:38:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13704F4;
        Wed,  2 Nov 2022 11:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38452CE22F3;
        Wed,  2 Nov 2022 18:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64D7DC433D7;
        Wed,  2 Nov 2022 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414298;
        bh=pZDCp0KXPnLmkve7PBdr6kpHYtWlaaHl8C++MwNcfsA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L3QzrRyYHz8tibslVKVmKWmhg66iUPV75ygacnx6KdDa9wbPYy/M7Ky7t7R4Msypo
         /LsfMu4yURCQy2PzAXeZtsbusAKI+qgT7OWQkqZg2cam2fICVvz1E/+fPJcskd10ku
         wzUJETpWy2EsePej7tnfxxUzN4GNcOnyyVwxGx0XCKeqj3NbzYej0c2Opmenzh+c+M
         3700Ocx/3oFNs/QxH0Ebc4kpgVxfe9BesblY20YS+KMpP9YgEHRlDvgdrmK04IJmJd
         ZWuf1bMhS9xQCUvnsxBGWC67EhzM+NfwH/MIaSXCfP8g8xSD9E9tZE5Jwkfi+FbaKn
         tPwb+G67GY0VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51B81C395FF;
        Wed,  2 Nov 2022 18:38:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2JiBz6YMTTFfxI/@nvidia.com>
References: <Y2JiBz6YMTTFfxI/@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2JiBz6YMTTFfxI/@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 7a47e077e503feb73d56e491ce89aa73b67a3972
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae13366b177b062b420288c8affe6a513aae56f9
Message-Id: <166741429832.10915.15258625257393756810.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Nov 2022 18:38:18 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 2 Nov 2022 09:26:47 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae13366b177b062b420288c8affe6a513aae56f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
