Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA76428150
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfEWPen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39127 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbfEWPem (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so1942378qkd.6
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8d3qZxuduenTYxmVtLo/HTiLB+fwW/lCyyNPj/qu33U=;
        b=hQux6/iJ6hqg+JBrYX1VSUyG5Ws/3mnhZg2BHMv3L6kyfjzf8PCRUOnHPNnDo5Ei52
         EzmG7qHzV3jffzCQXKj0JUoEfaIP43zLaY5Wr6VzQ8nmDtD5NmA7j9TfXODD1YOs1F9H
         PZH2Za61bIL+znufcpgTJCwAGDEtZBaDT+uGjIxs4vHGmpuGCYXgRA67X3+xj2YEGoS7
         qxppgbz5Ak0ZlKqhXrbw3bOcAA4n662B0aWl2e6V6tWw4A7HXJaDEV3RGWl1ZbpgHojB
         dZ3Mex3pGWIaqI5HTw4cpQ7GxfHh8wiS7DQizBjbqw30fLSk5qlGsvcbGE4opOCxHQ2o
         yokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8d3qZxuduenTYxmVtLo/HTiLB+fwW/lCyyNPj/qu33U=;
        b=FSfFjRWtHAXXjSTk52l0TFZ8WG/gTu4vx0G6QCUHdpvlAzBNkAceNwqH8M5Diztt1W
         E2BlC6THelBh3yQ+7xdKY3YvP9cCXVk11QK8wpgLLqyNx7GBF6V5/o2UGjQFEKHkpCcr
         G33oX7VU+l82BjKVogC93Xv5lkHI7SpjfXpYP7umxDgA2Jp0eK2pxEXGgOjYGl2z8mAq
         s/yqOpLdBbVv3psiA+enIN4zcdSaKYPkgApxFbMLJNWPRnp1JXdRmj+cjlxjiMSsCmMR
         6AqBC0aO6rtxR4RuEbYV1PCdUdvMXDGotw0fabDPWgGHmYhmNL2HLSYKA24l5H5CkXBD
         7dtA==
X-Gm-Message-State: APjAAAVSYyclcszt6yknjAVSwp5mbrjuFXMaiYVsCkQFYh3EK4X9z+jt
        Epi/BX/vVDkEcv7pQ6CE71FoBG3rkG0=
X-Google-Smtp-Source: APXvYqxEddBfU0Rf4mgWBf/qIenpeQFY2LV64soWSgPl9ghoFmgdVdxNL+eh6sZGq9t3KI14a4o+gg==
X-Received: by 2002:ae9:f70d:: with SMTP id s13mr75933217qkg.213.1558625681585;
        Thu, 23 May 2019 08:34:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v69sm745374qkb.60.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-0004zZ-2a; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 05/11] mm/hmm: Improve locking around hmm->dead
Date:   Thu, 23 May 2019 12:34:30 -0300
Message-Id: <20190523153436.19102-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This value is being read without any locking, so it is just an unreliable
hint, however in many cases we need to have certainty that code is not
racing with mmput()/hmm_release().

For the two functions doing find_vma(), document that the caller is
expected to hold mmap_sem and thus also have a mmget().

For hmm_range_register acquire a mmget internally as it must not race with
hmm_release() when it sets valid.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index ec54be54d81135..d97ec293336ea5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -909,8 +909,10 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (mirror->hmm->mm == NULL || mirror->hmm->dead)
+	/*
+	 * We cannot set range->value to true if hmm_release has already run.
+	 */
+	if (!mmget_not_zero(mirror->hmm->mm))
 		return -EFAULT;
 
 	range->hmm = mirror->hmm;
@@ -928,6 +930,7 @@ int hmm_range_register(struct hmm_range *range,
 	if (!range->hmm->notifiers)
 		range->valid = true;
 	mutex_unlock(&range->hmm->lock);
+	mmput(mirror->hmm->mm);
 
 	return 0;
 }
@@ -979,9 +982,13 @@ long hmm_range_snapshot(struct hmm_range *range)
 	struct vm_area_struct *vma;
 	struct mm_walk mm_walk;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
-		return -EFAULT;
+	/*
+	 * Caller must hold the mmap_sem, and that requires the caller to have
+	 * a mmget.
+	 */
+	lockdep_assert_held(hmm->mm->mmap_sem);
+	if (WARN_ON(!atomic_read(&hmm->mm->mm_users)))
+		return -EINVAL;
 
 	do {
 		/* If range is no longer valid force retry. */
@@ -1077,9 +1084,13 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 	struct mm_walk mm_walk;
 	int ret;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
-		return -EFAULT;
+	/*
+	 * Caller must hold the mmap_sem, and that requires the caller to have
+	 * a mmget.
+	 */
+	lockdep_assert_held(hmm->mm->mmap_sem);
+	if (WARN_ON(!atomic_read(&hmm->mm->mm_users)))
+		return -EINVAL;
 
 	do {
 		/* If range is no longer valid force retry. */
-- 
2.21.0

