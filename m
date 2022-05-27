Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A5535836
	for <lists+linux-rdma@lfdr.de>; Fri, 27 May 2022 06:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiE0ERJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 May 2022 00:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbiE0ERI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 May 2022 00:17:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A317AA5;
        Thu, 26 May 2022 21:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86A64B8227F;
        Fri, 27 May 2022 04:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38DCDC385A9;
        Fri, 27 May 2022 04:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653625021;
        bh=5c4HbAU+MTfHm4PSTHzcxJJe2w9BAiBt0vlZwKqOTNg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZEstRGnexIMZTGOdU+xWupdxrcrX7saQ4KyRUkNGIQIgQ9/Ji4bEeb3ZBKnuT+mIj
         w/WJ9CpW/HE8L385gxL9poO4d4DTxQ3wANvcBUb93jdrBixUHp+zyhC9573pvdNZhr
         L63cyjGIhwfprDos/HvaS8IaAWyfI/wbaZSI4wAxr6z7mnr+9McB5dj+VIEDQJ8YJp
         vAI76yh1n6T18uaqygyK3pL4mAPq2JpOS/PqqXLXTmJr424xrdxl2n355iJGWdzlPM
         wD7o9PICFYzmvP1XyxTbf+JF8hQjqjp5JnUeAric2XiTPAow9dIvq3ccphwG15YZQg
         2Sq/tGu1cjKPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26359E8DBDA;
        Fri, 27 May 2022 04:17:01 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220526144615.GA3087820@nvidia.com>
References: <20220526144615.GA3087820@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220526144615.GA3087820@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 9c477178a0a187c4718c228cc6e0692564811441
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 780d8ce7162818cfe03e9a5e23b3af192a1d37bc
Message-Id: <165362502115.11855.9972919363474246528.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 04:17:01 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 11:46:15 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/780d8ce7162818cfe03e9a5e23b3af192a1d37bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
