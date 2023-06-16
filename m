Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC6732623
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 06:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbjFPEQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 00:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbjFPEQp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 00:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56D2118;
        Thu, 15 Jun 2023 21:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAAD761B75;
        Fri, 16 Jun 2023 04:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03BB3C433C8;
        Fri, 16 Jun 2023 04:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686889003;
        bh=JZ/O9tBdPn7eEkIi3KO/wvIggd4qHCiyKjr5N5o6bYc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BBElsDD6sl+7JWWAVjVO3t3V0Fuv6wz5sOvcNw2JbmhYjfjftQdC3fIHgLnT8eo8/
         fWPpv7Uxh1J/CiQUNc2gIL+Zzh3yqq6X41ca2lHC4b5lOouKxFUcqyxn4KRoAJ3CKz
         lALfZmroEf4f9TtYfpJqM1MDt5mFflSxi1rWZNTFfshfYpqkLrODEMtZelN2T1RraW
         2+LfZlkPvuNcvmcjljjrVe3nVV5plTcq0P80YeMtvLLMIMRyvpETOnwt5jcl8M6irQ
         rxI5nbp+XGn8Sxb6aGL6iGGAbkDasOCEGmWvLXKtwNeTMC7WmchTZLji5XsXy/r0gi
         UJ6P66kQuHV3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6104C00446;
        Fri, 16 Jun 2023 04:16:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZIsGgrn/gfiufynL@nvidia.com>
References: <ZIsGgrn/gfiufynL@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZIsGgrn/gfiufynL@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 0c7e314a6352664e12ec465f576cf039e95f8369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93fd8eb053800a241d09c00ef075cae0b5b03ecf
Message-Id: <168688900293.32380.16656444618672933074.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 04:16:42 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 15 Jun 2023 09:39:30 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93fd8eb053800a241d09c00ef075cae0b5b03ecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
