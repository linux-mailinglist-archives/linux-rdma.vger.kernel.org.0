Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0A4E6CA2
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Mar 2022 03:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357951AbiCYCss (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 22:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357949AbiCYCsr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 22:48:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0FBF03B;
        Thu, 24 Mar 2022 19:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70820B81D87;
        Fri, 25 Mar 2022 02:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23C8AC340ED;
        Fri, 25 Mar 2022 02:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648176432;
        bh=hMAQccOefc/GgMbYVJm7PF0uWq02bRrih9hwRFqJ200=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MaxnKXl3sVgZkh+VCLLHedDWf113xJCKCiyFGeORBn/h+3JzsR0U2maiPd9eJT2GB
         c5LIrzZ0ziqD/b56eHfuO7yHQrCZOhEDDbCQYIZrFwe/MDUzKBF+qjqgLfyvBOFKkD
         zZEnaJ3vrUKW9S/tJ5BvBS8nDMfM6mdDlcVuWH0b1zKtJ+nenLuIRsiPZ+60Enf/+q
         DlUo27uruY0fh04Rg+KE35XPavyOhUa8ngBHg+KcAyQDdaQ5Ke5r3nKs4Xq2rbz+mH
         plX5eF8SxwVDnEyCPr992bcp/5LCa1PjZ4k0bzeKPHvYPhUBZdWA8vDdeTxlVbX6ro
         hGr9DmtbSmE2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 122D5E7BB0B;
        Fri, 25 Mar 2022 02:47:12 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323195436.GA1216814@nvidia.com>
References: <20220323195436.GA1216814@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323195436.GA1216814@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 87e0eacb176f9500c2063d140c0a1d7fa51ab8a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dacc1e57b95ebc42ddcbfc26cd74700b341f1df
Message-Id: <164817643207.17034.1765146112155388319.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 02:47:12 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 16:54:36 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dacc1e57b95ebc42ddcbfc26cd74700b341f1df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
