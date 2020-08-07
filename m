Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7F23E5A5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Aug 2020 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHGBzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 21:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgHGBzw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Aug 2020 21:55:52 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596765352;
        bh=Kuxr/E45KykG/F9cinjmLyrKFsHbQTNBQoM2q88Ns5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VVgJDXgDxO+gOy2j13WNsuoLxWyWzQcseCQ/T6X1alqTLqmw7dnLTvqfzCyxWLKUe
         F4sdO5QrKXOOdKJL2T/puwgR1fPQckGvx6wUQYtcpatf3YaAT9DLq2y57+q8q8z4C1
         ZjIp6KGX1By7W0a9UjpRhY8QuV54QCgB9ntkdBrU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806182732.GA1062117@nvidia.com>
References: <20200806182732.GA1062117@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806182732.GA1062117@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 23fcc7dee2c6aba1060558683988263851e74bab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7806bbd22cabc3e3b0a985cfcffa29cf156bb30
Message-Id: <159676535207.30846.14993292043025471844.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 01:55:52 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 15:27:32 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7806bbd22cabc3e3b0a985cfcffa29cf156bb30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
