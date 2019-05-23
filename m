Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D202814E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfEWPem (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46711 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbfEWPel (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so4370497qtz.13
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0fnCIS1UU2Yl5HFhaP9USXWVXi3ioUfilGqBeg9WXo=;
        b=ZAWb6C2Zy9X1DesFJzdUY1NrKsPiS5Jvp1PCkg+zTa3+HZUKgu72kwwZR9Zz7cuUsN
         hqHmPHEl1SZqi6Ksxs8IWDmWa8NYcaq27MZg4o43q9cS1rMdNIwjOHXVvrNrUhmerPLH
         2C4RM0d83niUVSA60rDZxLiCaCg0XIRLCrxlMxIAkpDCL2qGgOJrwg93mDBo0owbS9wG
         GigRKCJfgXFzftD8yNj5WhTzw0oUfA/5axgHUIGjENJUBHkLPDeOC2pI2f/yYxuyr07Y
         3SKahFyaohSEsYHGIuLk/ql8MKS182Eez2RiWCFyOULJUSZK8ElKWKLASN/yeR0Yf0fy
         jaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0fnCIS1UU2Yl5HFhaP9USXWVXi3ioUfilGqBeg9WXo=;
        b=NuTquW/wbr3Q8cVy8/CyIMJZmaUnaghnqJBkgR0VYjeo1ux8bDUOtMQ4R0l+VcIhzk
         AulH8vwBf/y0betVBoJliGUOuzQpozeRz8oSgumA6UAdu2Fqm4+7lvIfq+USEQkSnI/C
         On3QfiyBDNryeG/hJjMYsQEVrZA0u6ZGaBL8JfbWtcDX5ml3gzW7X04hhRXYloOd6AVd
         /xAChal3FOhUctqhmxlNH4yVMbXYsuxh5xEVxZrwvAEJ583mixIsrk78Jef9j2SUyo+l
         Upt4pm1OW/eFyexsvAjLL0vNOAHedyMv55WsYwJA1AOeyhA5gT3ec4gh5RFdKPa4yrt5
         WUvw==
X-Gm-Message-State: APjAAAU8XHkXEcU4BQlXdVM26dlkxTHMwm+Mn4uLcBxiNGnaL8Pa5/oT
        rr9hX/ntO1UYU8EgNhKL8j7VFtKLoQc=
X-Google-Smtp-Source: APXvYqyWStElkAeFxeRHIt8qw7jwn+e9hRhuM1POWa1lozD72Ww5AlAsfY/GROw/QPhwUqv3LHvK6A==
X-Received: by 2002:a0c:8b6f:: with SMTP id d47mr30646505qvc.32.1558625680542;
        Thu, 23 May 2019 08:34:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id r47sm18148670qtc.14.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjp-0004zN-WB; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 03/11] mm/hmm: Hold a mmgrab from hmm to mm
Date:   Thu, 23 May 2019 12:34:28 -0300
Message-Id: <20190523153436.19102-4-jgg@ziepe.ca>
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

So long a a struct hmm pointer exists, so should the struct mm it is
linked too. Hold the mmgrab() as soon as a hmm is created, and mmdrop() it
once the hmm refcount goes to zero.

Since mmdrop() (ie a 0 kref on struct mm) is now impossible with a !NULL
mm->hmm delete the hmm_hmm_destroy().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h |  3 ---
 kernel/fork.c       |  1 -
 mm/hmm.c            | 21 +++------------------
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 87d29e085a69f7..2a7346384ead13 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -584,14 +584,11 @@ static inline int hmm_vma_fault(struct hmm_mirror *mirror,
 }
 
 /* Below are for HMM internal use only! Not to be used by device driver! */
-void hmm_mm_destroy(struct mm_struct *mm);
-
 static inline void hmm_mm_init(struct mm_struct *mm)
 {
 	mm->hmm = NULL;
 }
 #else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-static inline void hmm_mm_destroy(struct mm_struct *mm) {}
 static inline void hmm_mm_init(struct mm_struct *mm) {}
 #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b4cba953040a0f..51b114ec6c395c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -672,7 +672,6 @@ void __mmdrop(struct mm_struct *mm)
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
-	hmm_mm_destroy(mm);
 	mmu_notifier_mm_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
diff --git a/mm/hmm.c b/mm/hmm.c
index fa1b04fcfc2549..e27058e92508b9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -29,6 +29,7 @@
 #include <linux/swapops.h>
 #include <linux/hugetlb.h>
 #include <linux/memremap.h>
+#include <linux/sched/mm.h>
 #include <linux/jump_label.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmu_notifier.h>
@@ -82,6 +83,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	hmm->notifiers = 0;
 	hmm->dead = false;
 	hmm->mm = mm;
+	mmgrab(hmm->mm);
 
 	spin_lock(&mm->page_table_lock);
 	if (!mm->hmm)
@@ -130,6 +132,7 @@ static void hmm_free(struct kref *kref)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
+	mmdrop(hmm->mm);
 	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
 }
 
@@ -138,24 +141,6 @@ static inline void hmm_put(struct hmm *hmm)
 	kref_put(&hmm->kref, hmm_free);
 }
 
-void hmm_mm_destroy(struct mm_struct *mm)
-{
-	struct hmm *hmm;
-
-	spin_lock(&mm->page_table_lock);
-	hmm = mm_get_hmm(mm);
-	mm->hmm = NULL;
-	if (hmm) {
-		hmm->mm = NULL;
-		hmm->dead = true;
-		spin_unlock(&mm->page_table_lock);
-		hmm_put(hmm);
-		return;
-	}
-
-	spin_unlock(&mm->page_table_lock);
-}
-
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
-- 
2.21.0

