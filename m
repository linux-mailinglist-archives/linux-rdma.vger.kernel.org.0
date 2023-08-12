Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6219779CD2
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Aug 2023 04:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbjHLC4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Aug 2023 22:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbjHLCz7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Aug 2023 22:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31112211B;
        Fri, 11 Aug 2023 19:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E8F63B76;
        Sat, 12 Aug 2023 02:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35C0EC433C7;
        Sat, 12 Aug 2023 02:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691808958;
        bh=JjaEMz4VkyfCgkbAr2VUoiKjIpGBIlt79UhncDsHFOk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qdncCbLh5qWjnZIejuzttc6w4KK6MMrbhjto0QP3GSqe601EG6u6RzWLgOd+Agfwp
         g/s1CcKhwT4JhTFwyK6k4/OOAnMenmUzKwtNPR6vKzxlwHB/hBah2tSer0QEGOlqsR
         XSuIE7GkZjkjd06I72lVYy+m6kEWxXLBSMdcHeMrgDan/utjFFCc6JfcfiOQxJojYk
         14ExqUseOjT6vUJnT5h2eGxGrPx3FBpJN32VJlnxfU0bYkyntqPpySM2aSYe7Fh8j/
         SHshOuUXFS7fRaYLC0Jucw7KDE6dAHczF4gc6Crr3yjDoMNxVMhG46IQqkW7RgbO+C
         8pfPb7crprZOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23E2AC3274B;
        Sat, 12 Aug 2023 02:55:58 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZNbKYH+u1lodzknB@nvidia.com>
References: <ZNbKYH+u1lodzknB@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZNbKYH+u1lodzknB@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 64b632654b97319b253c2c902fe4c11349aaa70f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a20704fb40642d5b7d4f1db58f252f6aca563a9
Message-Id: <169180895814.32599.7342919967494124105.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 02:55:58 +0000
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

The pull request you sent on Fri, 11 Aug 2023 20:55:12 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a20704fb40642d5b7d4f1db58f252f6aca563a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
