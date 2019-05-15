Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0021E746
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 06:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEOEFQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 00:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfEOEFP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 00:05:15 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557893115;
        bh=0Dx4PPO+0xS2TITlGnHVmoMhKKTXc4r/CwrU9JzOX+s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2GPcqYoM2Kj5bcXGM1V3Z488IGLMWYDB2XQqC8IiMwoDvL/c7fIx3QbNwZ9oHcwBY
         jvI8Ajo3QNs/B3F7+c+KZFzl5YLEYINvwaNLJl3ePSbvSRA+TCUL37+rPOFFlH9WEs
         q5bU/CXWiJuGFCQ99+0onbOLArKCXyQDAssDzzV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515004652.GA17171@ziepe.ca>
References: <20190515004652.GA17171@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515004652.GA17171@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: c191f93454bcc92810b9c8cdb895a452a57948c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ac94332248ee017964ba368cdda4ce647e3aba7
Message-Id: <155789311526.1075.6733986187379717402.pr-tracker-bot@kernel.org>
Date:   Wed, 15 May 2019 04:05:15 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 00:46:58 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ac94332248ee017964ba368cdda4ce647e3aba7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
