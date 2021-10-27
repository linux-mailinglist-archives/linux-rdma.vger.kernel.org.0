Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7D43CFF7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhJ0Rqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 13:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhJ0Rqx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 13:46:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3BA2F60F92;
        Wed, 27 Oct 2021 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635356668;
        bh=EulqxgmjceC1LVbVqFWb6wDGB2f/xh8sw3zbeePgYp0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AfrmE6xftmd0d1bneqZDdA1zuFCIV3Yvj99Zbm9b58cG1xQQc2uPH5biPL7UOQ5hQ
         wpNktLqEraHu+jTlRBh2x6wYQGB6rzTNzT6JD+kd5D44X02rwHVCzvE3FvuBlYG09R
         FTbld5Wpm4cGEbcXGmpfgydLzRYkspVzqB6cbuDTye1+D0GYrB9tfpA13eH6y6uMhO
         yzvZt++Im6pT3LlWDD4Hx7pMdT+r8tcxTIUvGlikaPWNgiQDL8DwMj+fEBAzekt5au
         50niIIiVdKP+ndQ9qAnlVSDHB7cDtBAmcH6gV3wsIUBSMZJIT4NTshFe0OBtN9cOsO
         DnkAokNZHLqIA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 29156609CD;
        Wed, 27 Oct 2021 17:44:28 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211027124955.GA602533@nvidia.com>
References: <20211027124955.GA602533@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211027124955.GA602533@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 64733956ebba7cc629856f4a6ee35a52bc9c023f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab2aa486f48c79b0c9df77e3827922d29c60df0c
Message-Id: <163535666810.24725.9575781473570444786.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Oct 2021 17:44:28 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 27 Oct 2021 09:49:55 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab2aa486f48c79b0c9df77e3827922d29c60df0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
