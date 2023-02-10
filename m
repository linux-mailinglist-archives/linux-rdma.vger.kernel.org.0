Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37C691666
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Feb 2023 02:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBJB4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Feb 2023 20:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjBJB4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Feb 2023 20:56:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F4C36FCE;
        Thu,  9 Feb 2023 17:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9399A61C41;
        Fri, 10 Feb 2023 01:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04976C433D2;
        Fri, 10 Feb 2023 01:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675994194;
        bh=8ADW1mppMJhd3toMRdjnwLTfbfJn/kGBLTYInIuYsgA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fILPD/9at5y5gdHXeHPuUOQOo8X+cnT4eEuwr9doF+TlKFJpQVtgH4g0wkJJICDMg
         PO8KKNbqHxIowiis5ySjHvKL/CXSzRXgq0tbroAoOIZtAW/n/BtSLEqxFJmsclOu2d
         4UB5HnjDnHo/RrmKnk1Awbj86JnC/63grgU68LEROhFi6iCgjhKDZ748bqiU8ASNlu
         LaB5LBdOKBu5f5w+T4u9yzWFS3gCEbCSY3qpAM6MQVTUF8kIZPjiHqGa0MH5o85I+/
         kG9PjLZB85lQkLyrc7ikz6qX2gY0SgsygMRaoucencoehjccRZXjzomfYQs37/NJHL
         I8mWM214wL5Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6951E21EC9;
        Fri, 10 Feb 2023 01:56:33 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+WRZa36TxqYbpUP@nvidia.com>
References: <Y+WRZa36TxqYbpUP@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+WRZa36TxqYbpUP@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 2de49fb1c9bb8bfe283070fef2e9304d9842a30c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1424c3e309bbdcf2d93977bf2840cc00ef9b6208
Message-Id: <167599419394.18539.3665667529872107927.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 01:56:33 +0000
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

The pull request you sent on Thu, 9 Feb 2023 20:35:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1424c3e309bbdcf2d93977bf2840cc00ef9b6208

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
