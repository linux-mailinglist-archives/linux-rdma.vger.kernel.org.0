Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A111562140
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiF3R2n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiF3R2i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 13:28:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574B322BC2;
        Thu, 30 Jun 2022 10:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D79C3B82CD5;
        Thu, 30 Jun 2022 17:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92B82C341CB;
        Thu, 30 Jun 2022 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656610114;
        bh=V/IPe3rO9P/zyHu8lSmaM9/K8wAlJRmiVxXPG3yDu08=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uq6D+TpWoJ54Fbij6u/aPaPRYM2w6Yei4jCAq5qzceqNjPG0mhDoS2E9RAijFhdpa
         D4EeWDXyT6Gh2I27uAGxc8Vy3p7m3R9DFhHehJiPNicEk2XWvkyBy7vSsW5QYdVLbo
         Ek30s/3m/MBkF38iZi5lNZhOMQ2tmDjIuZi7s7ojSZYossPWH2mhH6oPR2JAYE/YzX
         f5vM51oYm8nu5Qb33uoc9UjflZHtl5oTkQJEcHzJtoycZic6diEyirUFQlbyDMWFJR
         uy9YBY1ddJ7ED/FeZ8+JBA2zCgOfPShGfsL5Zf2VK0YJ6e5L0nqyxAm0EqsWH7LPEk
         p2YXevwmsLfGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D7C3E49F61;
        Thu, 30 Jun 2022 17:28:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220630125738.GA969304@nvidia.com>
References: <20220630125738.GA969304@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220630125738.GA969304@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 0fe3dbbefb74a8575f61d7801b08dbc50523d60d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a0e93df1e107dc766fdf86ae88076efd9f376e6
Message-Id: <165661011451.6493.18169255441676278016.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jun 2022 17:28:34 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 30 Jun 2022 09:57:38 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a0e93df1e107dc766fdf86ae88076efd9f376e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
