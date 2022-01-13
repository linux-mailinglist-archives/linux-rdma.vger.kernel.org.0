Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4792648DE16
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 20:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiAMTTd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jan 2022 14:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiAMTTc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jan 2022 14:19:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998ABC061574;
        Thu, 13 Jan 2022 11:19:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EE65B82338;
        Thu, 13 Jan 2022 19:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A64DC36AE9;
        Thu, 13 Jan 2022 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642101569;
        bh=WEjtVMQM/QlEZWFu6NR3W+sh+lZpw49pgQSg9ol43vM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=os3PXD64QQ7XdsilYEhGmTLhpZiL2OkfEBb61fnmHtETsHGUpDjEtiHNd+e1cRpia
         sLKX2cPM9WOZ2PtcsNbUWHXQzQY6g469yDXalWe+y27QAkXbsXPXiO+2G1cBaUksfX
         ijG8Ptwse7oBy/mZK87PJSd20YVrOTcvpfD2PVTbrHStS4UPOTVYmZasK+v3RxDLhf
         jLp6zK4ZuLRffcvBwTKlFZcTA+PAbw4ysrYmx9Ne67pYLuWI07NEe/k81IRtP5y7NG
         K3WOb38FnQCuNUPeyDh+47ya+pMoxiI7ylc+rVsN6AXABzXj4Vkab7M9IEy8Oo2lqj
         tcyGa/64rUUeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC148F60794;
        Thu, 13 Jan 2022 19:19:28 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220113185310.GA3791344@nvidia.com>
References: <20220113185310.GA3791344@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220113185310.GA3791344@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: c0fe82baaeb2719f910359684c0817057f79a84a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 747c19eb7539b5e6bb15ed57a0a14ebf9f3adb8e
Message-Id: <164210156895.1554.5910395773551436337.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 19:19:28 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 13 Jan 2022 14:53:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/747c19eb7539b5e6bb15ed57a0a14ebf9f3adb8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
