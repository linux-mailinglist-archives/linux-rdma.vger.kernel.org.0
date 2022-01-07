Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E24870FB
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 04:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbiAGDF4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 22:05:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54038 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbiAGDFz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 22:05:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41D4D6198E;
        Fri,  7 Jan 2022 03:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA9FBC36AE3;
        Fri,  7 Jan 2022 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641524754;
        bh=E0PL4Bmmy5TQTItwz8zKtSNCU2gEEmQl4S2Pra9QPWA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fQU2QTD8sQXogCo0kAfGGp6xWPSn1aIacNzRk9PlMuMyY0qDmmGcwRQ7ArPFtFnCV
         9qkdmiHluIhH3v4g4tbk2Chb2ANqtEIwwYQbbzB35XKodAzEiKlymcgme9kc4UXpXn
         lGuZw12pb7PtU5GMDu0Sk0aJR3OVBaBEtI2yzNAbfQj59Ggngi65QODW5M/7rgle5r
         AnpfWuxwngyqQlrG57pJwajBrDAFU1KEPAQdFJE8beGABG6HqH+JhG9Zzo3utVhBDi
         yEM5tjwoqQAk1RUQZTW7muapcCyLXrsyAFBM5G+w0BIa6PTdfKZk2/Or1+udWE5o9f
         dLR8SIBgI/BRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99F9DF79403;
        Fri,  7 Jan 2022 03:05:54 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220107011519.GA3028671@nvidia.com>
References: <20220107011519.GA3028671@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220107011519.GA3028671@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: b35a0f4dd544eaa6162b6d2f13a2557a121ae5fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddec8ed2d4905d0967ce2ec432e440e582aa52c6
Message-Id: <164152475462.17821.13228277522402535613.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jan 2022 03:05:54 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 6 Jan 2022 21:15:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddec8ed2d4905d0967ce2ec432e440e582aa52c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
