Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7555E4AA513
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Feb 2022 01:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378786AbiBEAb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Feb 2022 19:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378782AbiBEAb2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Feb 2022 19:31:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A22DF8E3CC;
        Fri,  4 Feb 2022 16:31:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A747C61D38;
        Sat,  5 Feb 2022 00:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ABE8C004E1;
        Sat,  5 Feb 2022 00:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644021087;
        bh=q3Yih5XixSjxwdzRqf1AAkWP1dP8EZSIU2HR3ZpqdWM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LVapDQUtZdo4ImBuwmNk7lUOG6kC4ANuVOKvewpNS2eOcZj9vP1GnSqz4g0WoJf0J
         DJ+9c2sxxaRbLOYhFozto3LWRD6S0TN135/opMaoeyGZAXSF7Bu1FGbfSjiLejyNNa
         Oz+PAuGb19DZBNodzELuOCulzIUucdKwLhLp1/1w0v4+PzHihpgCRXEAWuY7qC/jT0
         JG1oMfVCfJdVm9DeC3AB2ZYo5LgXBm85j0UAMsw4McErFCOgahpwZWjgaHIk4G/nyo
         CfhyEhK+ZY34v2v1IoWl4L98GIP+smQNHfa9GuRvCGebDw3uIbLwx1mC8yVdStfz2y
         MOBmQRRWN1GaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0900BC6D4EA;
        Sat,  5 Feb 2022 00:31:27 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220204235922.GA2979630@nvidia.com>
References: <20220204235922.GA2979630@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220204235922.GA2979630@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f3136c4ce7acf64bee43135971ca52a880572e32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0457e5153e0e8420134f60921349099e907264ca
Message-Id: <164402108702.12045.16716679454452985582.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Feb 2022 00:31:27 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 19:59:22 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0457e5153e0e8420134f60921349099e907264ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
