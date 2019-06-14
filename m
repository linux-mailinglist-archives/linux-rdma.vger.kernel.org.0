Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3B450D3
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfFNAoz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34255 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNAoz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so634452qtu.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/AhTlxkz9VD/Gth3t6L3luS1MUasGphGhAFUOpm608=;
        b=lwkJgPljFC3Tn+LXK7qjmyhVvethI42H5ylf1MGRcm6oKxXVhq8Wzl8TRDe9Eqm+YN
         rJkB0pghRseSkcWlc54ohBbckUGirR4baXgc8115jYObInJrRLwQtP1X+52KdX8JiSYG
         ZULIP8XcgCXVOf6rHO/PNjB1SdPHt7h/hl6bwATGZ4PjbayxrcZKj0MW25KMUNfW8oby
         AUpBHYJLOgSKHGgD0ip9zurdr2qqnIm8rtMl4gsk1TRGtmQsYhUxbnXWYhvO49MrsJaQ
         CyFu2i3cjrPLnh9c7W2+KHMZZ1HkvmrdKx7z9NMxZ/34RA3NYsFe25qalY3RhhfJ8whk
         95HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/AhTlxkz9VD/Gth3t6L3luS1MUasGphGhAFUOpm608=;
        b=LPWXx8/QiKD7WYETdF4aXGC81VZDqpuv8c66KQVH8DlV0WEvm8/HAmJ8AfA2dMotkM
         V1Mxsala16zLIzKZeE2JEgFRaQiBo6UJbOH2CWGAEA//MPJEO6YSofnW7BkvoSS7cMIr
         KwSqTHxc1QYzZo8oxrbLavDEGM8oNjocnaLzeKyHj2k0ccD14/GKHoQLpcKS7lAwFRY8
         /WfdT/sBLbGRcfDbJb+diGFDl75LLVYovRZ+qkG0o54umyD895olPNdphQZFMvgRbI4M
         Tsq2zb+Atf6lpwPAZeV2HRsOS1rdNUOehuDeFItg9OIzdlki+qQWnp1UMz4iv1kWwVHQ
         UdUA==
X-Gm-Message-State: APjAAAX5/OlZl3QP4baOvd8jKggKry7tQnycZMNJqRgFxzU4aEumFORa
        ntVKLJMWcpZFl2K4Zz31+DLB2w==
X-Google-Smtp-Source: APXvYqwwLhCAHZe6HhzxmL/Iw5P6iX8RWN7iT/fwDDndsKBg+CvZVk5Nt+VA+fnelddHK4pmtIZtkw==
X-Received: by 2002:aed:3ed5:: with SMTP id o21mr76020282qtf.369.1560473094348;
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c55sm754749qtk.53.2019.06.13.17.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005JR-I5; Thu, 13 Jun 2019 21:44:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v3 hmm 00/12] mm/hmm: Various revisions from a locking/code review
Date:   Thu, 13 Jun 2019 21:44:38 -0300
Message-Id: <20190614004450.20252-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

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

The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
standard mmget() locking to prevent the mm from being released. Many of the
debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
which is much clearer as to the lifetime intent.

The trailing patches are just some random cleanups I noticed when reviewing
this code.

I would like to run some testing with the ODP patch, but haven't
yet. Otherwise I think this is reviewed enough, and if there is nothing more
say I hope to apply it next week.

I plan to continue to work on the idea with CH to move more of this mirror
code into mmu notifiers and other places, but this will take some time and
research.

Thanks to everyone who took time to look at this!

Jason Gunthorpe (12):
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
  mm/hmm: Fix error flows in hmm_invalidate_range_start

 drivers/gpu/drm/nouveau/nouveau_svm.c |   2 +-
 include/linux/hmm.h                   |  52 +----
 kernel/fork.c                         |   1 -
 mm/hmm.c                              | 286 ++++++++++++--------------
 4 files changed, 140 insertions(+), 201 deletions(-)

-- 
2.21.0

