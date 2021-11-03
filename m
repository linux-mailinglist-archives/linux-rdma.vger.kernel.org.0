Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55450444526
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 17:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhKCQEU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 12:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231868AbhKCQEQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Nov 2021 12:04:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 625E460E98;
        Wed,  3 Nov 2021 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635955300;
        bh=8cwOPhrjcgjfDwmGuLRC9YxSx7AHg3b7GIj7n4VeJlE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UesVcoUnQ1pPReAaqglBTqgKQ8/QXSqzBy5y//HG2BdNKiZPD5BvsFuhqUI+bA3wY
         qUElGEY2QJjcYnQHwITxKeL+O+WcZpUk/Jpf/0tUZ9UZxBx9niWEZKLl+OW6yVMkLz
         sMaM+aVYfmBtt2VmZwMdYtLvJyvLCfjFPgFG2+JThGZilqxV1Jk8N1lZoj0CdY5vZN
         eoYK4WgQvQ2RlGcm2GDg5KODwq/BK9FLvEA3o9xvzeGljUEOKyiqxYCl6rFSQgnNHd
         xy6k/JFty5BqDRpoA6U0FpZOdMjbW6ZfoqMq6iMIk4Hq7lXv3HLAzd9ME2e3eV+yeY
         OBUxtNOQEA5vQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 53A6E60723;
        Wed,  3 Nov 2021 16:01:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211103134323.GA1344917@nvidia.com>
References: <20211103134323.GA1344917@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211103134323.GA1344917@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: f1a090f09f42be5a5542009f0be310fdb3e768fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25edbc383b72c2364c7b339245c1c5db84e615e1
Message-Id: <163595530028.26844.12752903569882253874.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 16:01:40 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 3 Nov 2021 10:43:23 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25edbc383b72c2364c7b339245c1c5db84e615e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
