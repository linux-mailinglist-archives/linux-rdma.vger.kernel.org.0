Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7931259AF4E
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Aug 2022 19:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiHTRzo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Aug 2022 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiHTRzn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 20 Aug 2022 13:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862B254672;
        Sat, 20 Aug 2022 10:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D22160D45;
        Sat, 20 Aug 2022 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84471C433D6;
        Sat, 20 Aug 2022 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661018141;
        bh=L60n1L5RonTwGo9L0pqiV6oKZblZjQ+pilEmhGi3ruI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OZvV/1UYvCx5tkMwPQW5MTIPavTmXcG3DJ0ZFn2kAaU6vI9ILBJRHfmTRS834tj5G
         YeBMnA747+atulGzfOOny6HAch/TlgxK7SHkbAfY1vbkLfTMSOCptgk4bHJa6XLssk
         acaMweDZrGZ8/DHbfl4N8QBB+R8xywoy2rpAQaRyw2FQ2jOHbSHqxkPzqswQRVfc1/
         qFmkpxHtQfs5O4reFydqog0oUUQVsMPpM4uSwsuaIw66KQ7q0UxoYwMGsRLqs9UmC3
         GQLOSM7iFoyqCJMQvYXUkguvN24XWMowzdio2G211bndZ0OZ30qqR51rul7GyNacP5
         pDEavKxlKm/8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AFE8E2A052;
        Sat, 20 Aug 2022 17:55:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yv/Uti/+/VAycxfW@nvidia.com>
References: <Yv/Uti/+/VAycxfW@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yv/Uti/+/VAycxfW@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: b16de8b9e7d1aae169d059c3a0dd9a881a3c0d1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f31c32efd57c860f2b237a08327840f8444362f3
Message-Id: <166101814143.10395.8817191920146481642.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 17:55:41 +0000
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

The pull request you sent on Fri, 19 Aug 2022 15:21:42 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f31c32efd57c860f2b237a08327840f8444362f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
