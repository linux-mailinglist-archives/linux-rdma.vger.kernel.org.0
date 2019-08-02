Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C08028E
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Aug 2019 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHBWKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 18:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfHBWKK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Aug 2019 18:10:10 -0400
Subject: Re: [PULL REQUEST] Please pull rdma.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783809;
        bh=ZASyBPGmm3S6IHbaChH2bfElSW96PzDvc+KMwQrEEC4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V1Aa3RQ/oHhcPtnxeVFEsmsTFx6FPH/mxR+v32mrQf2eLQfVeaOlKzXwNXL3ww2LJ
         C1QRAA1nEqVufzKKTauqc5RfHMoQ4Jvs+Wx4o3HRcHan0DWCWJ4pG35J2bMfgKW4v/
         CKSBkjazGCsYJGGofa3lHTlwIEIINl1dVyp9pig8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b64700fda3cd5c3cc19d6bf17c948b63a0413645.camel@redhat.com>
References: <b64700fda3cd5c3cc19d6bf17c948b63a0413645.camel@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b64700fda3cd5c3cc19d6bf17c948b63a0413645.camel@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 020fb3bebc224dfe9353a56ecbe2d5fac499dffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07042ca32ffca69b4e3c3b938bb89ab8aa18035
Message-Id: <156478380974.28292.488788745060344636.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 22:10:09 +0000
To:     Doug Ledford <dledford@redhat.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Fri, 02 Aug 2019 10:39:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07042ca32ffca69b4e3c3b938bb89ab8aa18035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
