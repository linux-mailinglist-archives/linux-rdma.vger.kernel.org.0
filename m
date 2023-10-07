Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FC7BC97E
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Oct 2023 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjJGSMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Oct 2023 14:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJGSMf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 7 Oct 2023 14:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEDA2;
        Sat,  7 Oct 2023 11:12:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46DC4C433C7;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696702354;
        bh=TpOPx/Sr4QN5FpAEkkMwbFCyP1+3zLyqqPbm0foazGU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IwWwDRSHjlyrpK645TvuKezWbWw46xPYi4cjlYbty45BzAnLYUswnFYogWCuutd69
         +yofAVb6JgXmw41SGgyPXaQqtYtSa88LAObEEuwTKp3oIdMqYk65mBOy08uzONbzkv
         f5rYy7+JLkdIFvouaePPnxGHhX9tmv7aMsacKabZ77Vrvi8e/0f1hT7FARCnkTH0gt
         b57NQKflyPAJJuvo0b3j+W9vYKk+siVn/mPeIl96rOShHZ6RHgjoV6fSgm08/iYSc+
         wEOOdnc2IhOaaxnlMmlvTijriud7MM2HzxmNa5orU4f6HdXysr4gLYGvmCv88D3jLn
         +p9PpHexEZ4Jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 330A4E632D6;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231006183028.GA1213337@nvidia.com>
References: <20231006183028.GA1213337@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231006183028.GA1213337@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: c38d23a54445f9a8aa6831fafc9af0496ba02f9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fea9f8f180b1817316e7501e601426a4a067466
Message-Id: <169670235419.17695.1582861629622808625.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 18:12:34 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 15:30:28 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fea9f8f180b1817316e7501e601426a4a067466

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
