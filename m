Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E42814B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfEWPek (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39121 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfEWPej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so7230018qtk.6
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEV5tWURKgLpgo5q6BTc4NlcwzQLAQ+EC5rW0mqA8Xo=;
        b=I9LiNRnSFZ2kQk44SojHBUW2L/OelCgKL7qFGsT/eFBZ2o/2dPwYCQGKf+9I82gF9J
         YmMPy0Vt8yxMxwVrRjPf1tzl99wZpY7NcFdn6A/F9DXWGGsgYFAf9hzxBTZhnRj7FpkX
         KCfPvI3xXOWOfHmUYKlJnS7RLRigNiJ4KB6Y4eR6rbyCee8r5pMw+2ivxFrA4Ayu8Gss
         PQfscnAUj4S9o3GZGzlKdoR9TJ5mZQ9/q38CVQfZDT6a0bWJ/CMpI9Ri3YdsezPFWpTT
         TGOExwxE+rRG5Ddo9+islZJbknQywxmTIzteFK17fpDdnRWg0EIaptARbwqBp/Gn1e0a
         KLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEV5tWURKgLpgo5q6BTc4NlcwzQLAQ+EC5rW0mqA8Xo=;
        b=gQqo8AoFPCiR5FtkLHB1kP3s7Qc77tqXNipxe1oiYgJckrm5+1wSz9vCsMIUF+i06v
         U9cl0wW1mmGwN2F9WvFiQv5MjtdvZjwqOgQ+F1608rg+iGFkMKQ4s8wpUGQerR9p5ZuX
         U0jWBDaeHEeQ3q4RXfSmwMypHxUX0ql7xyGoWdivt+mbb1ozsRLi9FePVDkr7tqttIto
         YWPVBPPjIb9UB1VLUut//tjyWdx7yIcMuuf5yEBBCF0D+NNXtXT5xtJw/ebQ4VmvZPaa
         ZZxOAv90aQCWnCtisqxX65jGbkFOOq4ZEAoUrEeXwjtqqJXN6tdF8tZJkkjbbVvVUcXg
         miRw==
X-Gm-Message-State: APjAAAVqV0kE/ZSgxs+w3bH3Xj9AdwPQvTYgX7jSfIvShwBgfv/Ovs2c
        qc99ms4mH4UxPfVxU7OshX3XID/YvsI=
X-Google-Smtp-Source: APXvYqyiewADpQP8cIsdPqhAjkY2KNXOElH4d5PbPs8KXkM0UEqnBsU2GR+WRo/ynGz4+mLf+I4aIA==
X-Received: by 2002:a0c:961a:: with SMTP id 26mr61952699qvx.131.1558625678799;
        Thu, 23 May 2019 08:34:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o6sm14126879qtc.47.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjp-0004z4-RS; Thu, 23 May 2019 12:34:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code review
Date:   Thu, 23 May 2019 12:34:25 -0300
Message-Id: <20190523153436.19102-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
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

Locking of mm->hmm is shifted to use the mmap_sem consistently for all
read/write and unlocked accesses are removed.

The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
standard mmget() locking to prevent the mm from being released. Many of the
debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
which is much clearer as to the lifetime intent.

The trailing patches are just some random cleanups I noticed when reviewing
this code.

I expect Jerome & Ralph will have some design notes so this is just RFC, and
it still needs a matching edit to nouveau. It is only compile tested.

Regards,
Jason

Jason Gunthorpe (11):
  mm/hmm: Fix use after free with struct hmm in the mmu notifiers
  mm/hmm: Use hmm_mirror not mm as an argument for hmm_register_range
  mm/hmm: Hold a mmgrab from hmm to mm
  mm/hmm: Simplify hmm_get_or_create and make it reliable
  mm/hmm: Improve locking around hmm->dead
  mm/hmm: Remove duplicate condition test before wait_event_timeout
  mm/hmm: Delete hmm_mirror_mm_is_alive()
  mm/hmm: Use lockdep instead of comments
  mm/hmm: Remove racy protection against double-unregistration
  mm/hmm: Poison hmm_range during unregister
  mm/hmm: Do not use list*_rcu() for hmm->ranges

 include/linux/hmm.h |  50 ++----------
 kernel/fork.c       |   1 -
 mm/hmm.c            | 184 +++++++++++++++++++-------------------------
 3 files changed, 88 insertions(+), 147 deletions(-)

-- 
2.21.0

