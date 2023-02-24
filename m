Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64D96A2509
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Feb 2023 00:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBXX1d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Feb 2023 18:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjBXX1c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Feb 2023 18:27:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689967E25;
        Fri, 24 Feb 2023 15:27:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09943B81D66;
        Fri, 24 Feb 2023 23:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9C7EC433A1;
        Fri, 24 Feb 2023 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677281244;
        bh=b5AG57b5to8WaQq6PQhdxE/4fxQBRAUiSEKhWTUl+24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GLdn9d0EyRVQzz3C4FJ/YkJYKeZrSf9xBDUkdSK3fO057GLOHys4aa8+fGiG2Ce4J
         E0B1wzwUgowd21ZyQoyhtglNjHRVbNB/MDRH8tEvzV0VWT580qeVmRaSWEIlc6wLRe
         jhCntojWP/HgPoGovlb2xkSB1QJy29Go4qt82HOz+/O6VxQXbtlVgz1/7+Xa/HxHti
         fsxmi3QMRH5nKb0LJWFzBAGvTJxIm/ugPq5tMqfqryIJeB7DJH6X8AwxhlNIhjs8/H
         eLQJXawr72IZdB61ZdmyYJz7VvKZblmckLCZodT+6hzwlmxKLzQrLh85sZPwuqZoTt
         +TuhK0aJd0sZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B876CC43151;
        Fri, 24 Feb 2023 23:27:24 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/gSi52mNoJjI6dk@nvidia.com>
References: <Y/gSi52mNoJjI6dk@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/gSi52mNoJjI6dk@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cbd92339db08b19b93d1637e5799ff2a8dddfd2
Message-Id: <167728124475.28021.10080251509834659875.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 23:27:24 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 23 Feb 2023 21:27:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cbd92339db08b19b93d1637e5799ff2a8dddfd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
