Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36AC4FA2BC
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 06:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiDIEl3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 00:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbiDIEl0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 00:41:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0D27FDE;
        Fri,  8 Apr 2022 21:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE0CDB82E48;
        Sat,  9 Apr 2022 04:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F37AC385A4;
        Sat,  9 Apr 2022 04:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649479158;
        bh=Mj/GFYmRwXXFI/XxhMOk7AqbJrPICqfRmmkgmhs3XWU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KR2E/J5ErEVVltIlEidRISWi1B+mSxJ9HF9h2cW+QU21m1/h0qpiBTkV12NBw/s1R
         sb8uNYVm9EiCeixmytUcekTV8Pop3s5zLPZg9oVjubbcLQhL/y7I55xx5Z8Y5RSwwd
         356wnM3XnecXqIMHqT8EK4rbzrmfUBP6IBrjcTL/Tf81jLcfqooIU/5orUlz+XL4PV
         HGOcWZjGdva5vnfkqHWPYxe24aEHeVP0ZOFVvkKm7J2Yt05tYEAYF9Ng43RiTdWvXV
         I53gZK1FLDkEiM6cHRIh/lq9hWmeCg+nSkGY8CZXLALd48ReGqI8sRTQKRTG2KRMyi
         KoSmsj9roGrxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67B6AE8DBDA;
        Sat,  9 Apr 2022 04:39:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220408190326.GA3698843@nvidia.com>
References: <20220408190326.GA3698843@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220408190326.GA3698843@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 2bbac98d0930e8161b1957dc0ec99de39ade1b3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f335af10482a41ad5d28b4a2b0bee3ea35f771ce
Message-Id: <164947915842.5739.5711351648369479478.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Apr 2022 04:39:18 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 16:03:26 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f335af10482a41ad5d28b4a2b0bee3ea35f771ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
