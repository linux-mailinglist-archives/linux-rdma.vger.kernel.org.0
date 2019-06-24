Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB751CAF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfFXVCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39445 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfFXVCI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so696714wma.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TXg+V1PV7qytX0xwqixrcBsIlYVASLMn0QfVVkViw4=;
        b=RTldUZCA/ujlOPqeFpIG1/oq7I0MMWuhfuWJToHG67t3OQXfVVzK17LY3kJ6F+Brer
         lnz/th7nTkxS/2R+LqhfZEwU5MvrsZIu821B9utLccmxMdrak8HYApdsHFF6X5Hm9BeZ
         Vo8kf7gnh3yt+gibgQeVYXuNFbbhYpUZLvfs+XYPYbnhZ2hu/dNSj1xBfyMpQjtX1doH
         EZDWsi96WfqzpwW/fpPX43H1AiRarnXcaSLJUUvqCyT81nbN45aacsBUof6bL1BIOqTB
         ajwQSV/zBBYiXqc83fyuqH5/tTOsWhrpi8aDboRkZhx14nYt1qY3C4UY4GvtasO88w1a
         gS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TXg+V1PV7qytX0xwqixrcBsIlYVASLMn0QfVVkViw4=;
        b=fPcBFtlXk6cnqIEjRewdrMk1gIaYEkp87y/e10EJAUOfOKDP0IA48WcylZcf4ZZ9bN
         u7UEvYU5jjltunCrWB46rSnM9Tc3CRublBCxrc4v6Hq7nlthj9OZ9F3fuUM7zv8o8AeO
         YibVbPYKt6OVQepOiEeVVWVBQTdO73RxxE0zxDMUwSsj5Q/JnAkiYuRnuT2Fxv9mWIKb
         ce80Sqgws1t+cfGATCd/dCmldIX+iLVKy7XLalLeY+lbkt6f+cUXny8lmF4fGUjAACDf
         hYy7zbSO/o/dwd4Q0wgbdemBKQvGaXju3K9p+B7FXXWGl5yO2U81f5te/3Sh51V37taX
         58sg==
X-Gm-Message-State: APjAAAWcasFv6lAEI46FNVXZt28+u+A1FJYty/MeV3pie+tbiTfdy8FA
        6IMziFAeWfOE8qLyFIIV/899cg==
X-Google-Smtp-Source: APXvYqzG1w8w/MlwN4mNnTDNK32BkM+Kopo5HpXOnXXh6GBim1Uqm95bmEpjBPM4rzRFOIIj8zgSlQ==
X-Received: by 2002:a7b:cc93:: with SMTP id p19mr16950467wma.12.1561410125331;
        Mon, 24 Jun 2019 14:02:05 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id l124sm464451wmf.36.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6C-0001Lx-Mk; Mon, 24 Jun 2019 18:02:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v4 hmm 00/12] 
Date:   Mon, 24 Jun 2019 18:00:58 -0300
Message-Id: <20190624210110.5098-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
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

The use of unlocked reads on 'hmm->dead' are also eliminated in favour of
using standard mmget() locking to prevent the mm from being released. Many of
the debugging checks of !range->hmm and !hmm->mm are dropped in favour of
poison - which is much clearer as to the lifetime intent.

The trailing patches are just some random cleanups I noticed when reviewing
this code.

I'll apply this in the next few days - the only patch that doesn't have enough
Reviewed-bys is 'mm/hmm: Remove confusing comment and logic from hmm_release',
which had alot of questions, I still think it is good. If people really don't
like it I'll drop it.

Thanks to everyone who took time to look at this!

Jason Gunthorpe (12):
  mm/hmm: fix use after free with struct hmm in the mmu notifiers
  mm/hmm: Use hmm_mirror not mm as an argument for hmm_range_register
  mm/hmm: Hold a mmgrab from hmm to mm
  mm/hmm: Simplify hmm_get_or_create and make it reliable
  mm/hmm: Remove duplicate condition test before wait_event_timeout
  mm/hmm: Do not use list*_rcu() for hmm->ranges
  mm/hmm: Hold on to the mmget for the lifetime of the range
  mm/hmm: Use lockdep instead of comments
  mm/hmm: Remove racy protection against double-unregistration
  mm/hmm: Poison hmm_range during unregister
  mm/hmm: Remove confusing comment and logic from hmm_release
  mm/hmm: Fix error flows in hmm_invalidate_range_start

 drivers/gpu/drm/nouveau/nouveau_svm.c |   2 +-
 include/linux/hmm.h                   |  52 +----
 kernel/fork.c                         |   1 -
 mm/hmm.c                              | 275 ++++++++++++--------------
 4 files changed, 130 insertions(+), 200 deletions(-)

-- 
2.22.0

