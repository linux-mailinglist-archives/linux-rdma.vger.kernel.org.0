Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA16E2994
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 19:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNRkg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjDNRkf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 13:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003C48691;
        Fri, 14 Apr 2023 10:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D7F60BBB;
        Fri, 14 Apr 2023 17:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFBFFC433D2;
        Fri, 14 Apr 2023 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681494033;
        bh=vgMXkEr4eWqmQQtJZbRB+47lM85IE2xRb1/mkVWyVpQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KnsYJ0K1jRVExFxbJ3CBlX1eWq23fn9ZfTKzJJrES6H5NSH1E0poIZWuMFUt+L8Dc
         vsC1oqFwNcXJiTB2a5H6+07wPEkql7OqhmC/fr5523qKrixAzNtDRSe6pw0Fmc5wZB
         PDCDJa25zc7lJv6t7yOqDohP2LpdgaD2Y3Q8kgxdBxCz5+SdYcvc9p2HvYIH5ARdNu
         hyvUJ/p8VpUclrqoIXYzYnwRvMubnXiJ29s1p411xpeMc7P5ClZEZMItXxevfw1RYg
         RInrxu3VID8KVi2yiMeUxtOuBk2Z2XK9mmlurJZB/QFpg2O9ci6UFK5rKrMu/7f+ea
         CKYuyBMqCoQgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE615E52441;
        Fri, 14 Apr 2023 17:40:32 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDlErF54qwFrZ/X9@nvidia.com>
References: <ZDlErF54qwFrZ/X9@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZDlErF54qwFrZ/X9@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: aca3b0fa3d04b40c96934d86cc224cccfa7ea8e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aee3c14e8659b2d14f417422b7eeb8a1e97ced30
Message-Id: <168149403290.11053.15643501410122099548.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Apr 2023 17:40:32 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 14 Apr 2023 09:18:52 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aee3c14e8659b2d14f417422b7eeb8a1e97ced30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
