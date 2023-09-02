Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77B9790460
	for <lists+linux-rdma@lfdr.de>; Sat,  2 Sep 2023 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbjIBAA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Sep 2023 20:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351363AbjIBAA4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Sep 2023 20:00:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90A91A8;
        Fri,  1 Sep 2023 17:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 32FDECE251F;
        Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3AA1C433C7;
        Sat,  2 Sep 2023 00:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693612851;
        bh=/JqiAeesS5SMbJUI5kq7s0bw5doW3HN9ckx4uEKE4BM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T8qJ0gST5ndvGrpzLrGOUnNh+Wej6ibHIzTnZLZca5STFlZQADkqD4tbYDcByfZ+O
         T0sb1GJwNwiyjUUo0seS8rLridwDD16WoHztZC4Ccc2x5ILcWfvW/bljQQ15chnkdt
         8iV2SCMLUrdrzc25FLnBy02fwOI/pkhR4BFxr+V0uC3lLaNwkQyxCToY71rC4TRwtp
         xUkwLPCd/USsNqIpATc8uQqJUbd8yDbNDUIklPaba5WQoLxSnVgu9TTk2wE+god/2F
         un/6zpM+/ZKlG1aWCHSZFmrCcoapRf6pmwcL9FcfhfAOC3daGcXR+092tMF9PaL9BQ
         VYImCWIZ4Y+Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B015CC64457;
        Sat,  2 Sep 2023 00:00:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230901003031.GA111366@nvidia.com>
References: <20230901003031.GA111366@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230901003031.GA111366@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f5acc36b0714b7b8510a8b436087d33a65cb05f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7e97ce26972ae7be8bbbae8d819ff311d4c5900
Message-Id: <169361285171.26727.15098273409495269738.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 00:00:51 +0000
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

The pull request you sent on Thu, 31 Aug 2023 21:30:31 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7e97ce26972ae7be8bbbae8d819ff311d4c5900

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
