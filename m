Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD537C6D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfFFSor (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33089 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFSor (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so3944853qtf.0
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tcl38YCYPEHxtG59vS1/laf3LqY602AZ9Gwml32ANEI=;
        b=hlrXri4CeEqiio7H/zfky6NMR7c65pBi/F8pbkmeJr2seEsfBd9qQbAyoCdHKPCuAC
         qOjGVsCwywsrQAs8F8f7bXbvI4mxQXMaLzXfL+nD0jx3Re+FpvedlkosN9s82eEcILOF
         jjkWSF5MrKwcYO1kxfxzkGpH5jfkehCo7dr1F9ZVwxWOtEG3YD724vwOMu83c6AsplFV
         wapKpAfXNKW3ibR5Yp3tsVpjC565fxndhwuL+Aw71vwHim7yGiO0p7XecLABBh9kjhYa
         RBziZbveeMFL4Dvyn731jLuoNH1SB7mJwtOsx5v/oKmqUFczBchHp49QeSTBXmd1v1Dv
         415Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tcl38YCYPEHxtG59vS1/laf3LqY602AZ9Gwml32ANEI=;
        b=s3SUhDt2xKOeAOqv2a4p33WHi6zjk2W3X4iXI1AYMlcgwk/UuETcaV+X0owAhXL9HV
         6EsO1dIN6OaLzhmtUDM8LDZkYSNfOJs5hqzKKxgkfIOhCd7GJejxyAuMwY4iSEhLYQ7a
         ZkY1EiVP3Fcii+RF7Ghh78u1HcY6oeBjPls1/KQdptZ5AuFUIci8M8YGw7+q4cEO5Wiu
         HGe0XMl9Ztiz4sp4WXI0isnqnxnwHb0larJf+q4ipBd4iZbkZdAHo7bwoWAGxcgawRrd
         1risIRRZrv5UkXZqBAZnasDHnCmtFBxgtn0THYaV8nOYgXvFlvvSSinB0+aZ6MGIAYXN
         rsZQ==
X-Gm-Message-State: APjAAAVT9PCbLgswA6Ay9LM/Dq6NrnA/yw4OMduk6ECK2PVobWMDhww3
        BitS+adC4F1Jxk18pbtDOfWC7A==
X-Google-Smtp-Source: APXvYqwHsJyTk4fQz5PZYwBgzdqZtwH6jrE0uJFj5aHZhZ7tQwHTh6bgGfHk1coLRSMVlHO0bDCdZQ==
X-Received: by 2002:ac8:1a39:: with SMTP id v54mr42610485qtj.21.1559846686346;
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c184sm1290839qkf.82.2019.06.06.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008Hz-CZ; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 00/11] Various revisions from a locking/code review
Date:   Thu,  6 Jun 2019 15:44:27 -0300
Message-Id: <20190606184438.31646-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

For hmm.git:

This patch series arised out of discussions with Jerome when looking at the
ODP changes, particularly informed by use after free races we have already
found and fixed in the ODP code (thanks to syzkaller) working with mmu
notifiers, and the discussion with Ralph on how to resolve the lifetime model.

Overall this brings in a simplified locking scheme and easy to explain
lifetime model:

 If a hmm_range is valid, then the hmm is valid, if a hmm is valid then the mm
 is allocated memory.

 If the mm needs to still be alive (ie to lock the mmap_sem, find a vma, etc)
 then the mmget must be obtained via mmget_not_zero().

Locking of mm->hmm is shifted to use the mmap_sem consistently for all
read/write and unlocked accesses are removed.

The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
standard mmget() locking to prevent the mm from being released. Many of the
debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
which is much clearer as to the lifetime intent.

The trailing patches are just some random cleanups I noticed when reviewing
this code.

This v2 incorporates alot of the good off list changes & feedback Jerome had,
and all the on-list comments too. However, now that we have the shared git I
have kept the one line change to nouveau_svm.c rather than the compat
funtions.

I believe we can resolve this merge in the DRM tree now and keep the core
mm/hmm.c clean. DRM maintainers, please correct me if I'm wrong.

It is on top of hmm.git, and I have a git tree of this series to ease testing
here:

https://github.com/jgunthorpe/linux/tree/hmm

There are still some open locking issues, as I think this remains unaddressed:

https://lore.kernel.org/linux-mm/20190527195829.GB18019@mellanox.com/

I'm looking for some more acks, reviews and tests so this can move ahead to
hmm.git.

Detailed notes on the v2 changes are in each patch. The big changes:
 - mmget is held so long as the range is registered
 - the last patch 'Remove confusing comment and logic from hmm_release' is new

Thanks everyone,
Jason

Jason Gunthorpe (11):
  mm/hmm: fix use after free with struct hmm in the mmu notifiers
  mm/hmm: Use hmm_mirror not mm as an argument for hmm_range_register
  mm/hmm: Hold a mmgrab from hmm to mm
  mm/hmm: Simplify hmm_get_or_create and make it reliable
  mm/hmm: Remove duplicate condition test before wait_event_timeout
  mm/hmm: Hold on to the mmget for the lifetime of the range
  mm/hmm: Use lockdep instead of comments
  mm/hmm: Remove racy protection against double-unregistration
  mm/hmm: Poison hmm_range during unregister
  mm/hmm: Do not use list*_rcu() for hmm->ranges
  mm/hmm: Remove confusing comment and logic from hmm_release

 drivers/gpu/drm/nouveau/nouveau_svm.c |   2 +-
 include/linux/hmm.h                   |  49 +------
 kernel/fork.c                         |   1 -
 mm/hmm.c                              | 204 ++++++++++----------------
 4 files changed, 87 insertions(+), 169 deletions(-)

-- 
2.21.0
