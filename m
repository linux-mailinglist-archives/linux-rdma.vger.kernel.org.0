Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9036622D14B
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGXVk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 17:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgGXVkG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:06 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626806;
        bh=QqhCP1nRQIyKkXneM8FbaNyq/f4aKjtxooqH8/BVewE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WvCmQI+aTVTUef3lNiKq+yMWxec1gwT0tMoLaZ12GjeWqlhGubawK5lPm+kpb1Nni
         +MCYBXxzLiBvDEAj1pCjefTH17RH98wZzhOrvM+gkMMNM9i1wQCp8Q2tdNy7SrEFbS
         h8SkE39/6R0/MqVkD84ezK391gRFzfgHls1/BqUo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724174739.GA3635934@nvidia.com>
References: <20200724174739.GA3635934@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724174739.GA3635934@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: a862192e9227ad46e0447fd0a03869ba1b30d16f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcef1046eb1b78c98105e9b68e48df6022c23a06
Message-Id: <159562680653.3064.12242876121090229215.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:06 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 14:47:39 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcef1046eb1b78c98105e9b68e48df6022c23a06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
