Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6417C51DDFF
	for <lists+linux-rdma@lfdr.de>; Fri,  6 May 2022 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443998AbiEFRCo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444005AbiEFRCn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 13:02:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594516A40E;
        Fri,  6 May 2022 09:59:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE1CB8366B;
        Fri,  6 May 2022 16:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B15F5C385A9;
        Fri,  6 May 2022 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651856337;
        bh=49ozkdixZYMrL9E3p3xV0UqZRaaTer52aw1l9SSwIFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r5B2eS0c6mMKSgL9b5luKtoYV1KTQhBcsXdv7VlX3DQBRq3ApBErNIyhjvFVa+93s
         ZgnxE/CzQ2v+c6pXvHMghTsgecOI0p1D0X/4CGKoSgUQd3IQ6ORabkQaH7rJC0kMRa
         NE9MyO34+QCIur+XJr2q7dbZPWYrACnX6RBxydVTWL0Rz+IJFruNN4vMOVrBFd+FJ8
         QhgT8forSN+xaG70zNMAqTb3kewpcWmhGOUmcC/5qstWgpsiO+q/2Iu5hGOJIfF25R
         /FLporD7NDXI2qr1ily+TztNItAFNJUDnpv87qub/NZ+WBocRbWFe32dTT730eHprb
         wz2xsA3IrUDxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CD22F0389E;
        Fri,  6 May 2022 16:58:57 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220506160151.GA596656@nvidia.com>
References: <20220506160151.GA596656@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220506160151.GA596656@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: bfdc0edd11f9501b891a069b5bbd3b16731941e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4df22ca85d3d73f9822b1a354bb56dd1872180cd
Message-Id: <165185633763.7534.15072230294670244258.pr-tracker-bot@kernel.org>
Date:   Fri, 06 May 2022 16:58:57 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 6 May 2022 13:01:51 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4df22ca85d3d73f9822b1a354bb56dd1872180cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
