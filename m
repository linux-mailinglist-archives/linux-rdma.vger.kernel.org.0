Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47480578F29
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiGSATe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 20:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiGSATd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 20:19:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BD357E2;
        Mon, 18 Jul 2022 17:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 515DAB817CE;
        Tue, 19 Jul 2022 00:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18C62C341C0;
        Tue, 19 Jul 2022 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658189970;
        bh=/c6fW97FOQ82tTE2f64MRuaAsrzxWpSYevu3hAWQn24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QGxKRIWzfRtC5IE8m4VoeMwHN2aE4VRDznlbjJ3Uie/BdlpYeTXbYGXLt1nCmVb09
         /6dH+pwSO5i56xcwk6iMFsJaK4GErYwJ7WblAZKIdYBXHwAU4XB0DTFvO5huQb1azd
         9novKoaPt5g2L60MOL63kA9nAkPOEHyFKxIAsOF5RzEa6NflzBuEx5OTznlnadmgMU
         P2wrL/tLXxdK+I6ekk3yhGIR4+QMiyKNIyzXJ+/GM1a0J9TFxs7YJTEm02IunG33R5
         2emQTlGFfETgJNmNqcUNeG+8F4Is3dED7DjKbb3WWz1uof593UxfkhegD69/bLrnj9
         Dwf25eQ1jkLXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02A1EE451AD;
        Tue, 19 Jul 2022 00:19:30 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220718231210.GA143116@nvidia.com>
References: <20220718231210.GA143116@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220718231210.GA143116@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: cc0315564d6eec91c716d314b743321be24c70b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca85855bdcae8f84f1512e88b4c75009ea17ea2f
Message-Id: <165818996999.1199.13923570850825484889.pr-tracker-bot@kernel.org>
Date:   Tue, 19 Jul 2022 00:19:29 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Mon, 18 Jul 2022 20:12:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca85855bdcae8f84f1512e88b4c75009ea17ea2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
