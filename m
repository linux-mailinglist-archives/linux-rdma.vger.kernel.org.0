Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1837C87
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfFFSsD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:48:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43617 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfFFSov (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so2118959qka.10
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVAUpO+Ga9NYec9bVUlta7oVxGoK2kbyT+1hUTcsX2M=;
        b=WgY47IGZKwCscEhmp/e1SH9Qdm9WcIPMWuHYPXHgf1Mke+ckY9UbBST6Yg3085YiGZ
         dcNR69Qrxwy8qK6hBe1Ue5L8mtizg8fgMYwpWlMDyzW4sJZM/YSdC7J0JCTA28fxl76n
         +LUXoIcNaktF9sMJ+8Tn9DSETKfpEaKYxfe0XcgkeYX9s25CuXN7zKQgSo93XiKMF8Ia
         uyDd1lBZZfguzvqyPsXI94pwdw1QaF2JfejyOIr3xXYPHSXV060VLQByKbXFlIqKGo61
         qP5nXZ0Y1Bzv69Slh4GEkWmlgkAOHNc2qWHPy706QC/VjevthD4d+IaR7G2877aUIVh2
         s12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVAUpO+Ga9NYec9bVUlta7oVxGoK2kbyT+1hUTcsX2M=;
        b=LAj7Z6GEC5hfeDhUCYKKfgjp1fw0GpT6h25/XPGan/lhcOk10WLYVO1wU3RRLlBed8
         c0RyAxMAzYjCzTDFpQzuYtONWENLtuI2WUwvRUzrijL/9XQSPwPycYJrTc+j3uaZHYpE
         vG31qXixy4dddA+eLEmz2BlLrGAqlv6MSVhVrGELP5qaL9WhkCQNzLhtcEvIO7xrFaYi
         Dpgj4/lfEttCDeb2oWabi9CkPiyoAiLsMx0W8zGo62aTeRIqJAZbwo19LaZ3YqeU6vF/
         uOzUDrObWJUi+DIyGIvaktbfX3O5LyGCOrDFTj8kEqI9aFqjAmUGzKFvt4ax6Vglz64U
         nRcg==
X-Gm-Message-State: APjAAAU6kO/wB3/qHjJLuqs1VRdVB62NmBv/otzxVBMuTHmhf9Nk5Dn7
        6M4wKd34moSZpu+iXSlUOy0vUw==
X-Google-Smtp-Source: APXvYqy0lCJbH1BvPYOo0rOmLYXG/g+I9HtsZNodsB/KhCTBbD6BMVIIs/zFfGrbgs1cd5AeX+0slQ==
X-Received: by 2002:a05:620a:16cc:: with SMTP id a12mr32024122qkn.256.1559846690927;
        Thu, 06 Jun 2019 11:44:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q36sm1951613qtc.12.2019.06.06.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008J3-Ud; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic from hmm_release
Date:   Thu,  6 Jun 2019 15:44:38 -0300
Message-Id: <20190606184438.31646-12-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

hmm_release() is called exactly once per hmm. ops->release() cannot
accidentally trigger any action that would recurse back onto
hmm->mirrors_sem.

This fixes a use after-free race of the form:

       CPU0                                   CPU1
                                           hmm_release()
                                             up_write(&hmm->mirrors_sem);
 hmm_mirror_unregister(mirror)
  down_write(&hmm->mirrors_sem);
  up_write(&hmm->mirrors_sem);
  kfree(mirror)
                                             mirror->ops->release(mirror)

The only user we have today for ops->release is an empty function, so this
is unambiguously safe.

As a consequence of plugging this race drivers are not allowed to
register/unregister mirrors from within a release op.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 709d138dd49027..3a45dd3d778248 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -136,26 +136,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	WARN_ON(!list_empty(&hmm->ranges));
 	mutex_unlock(&hmm->lock);
 
-	down_write(&hmm->mirrors_sem);
-	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
-					  list);
-	while (mirror) {
-		list_del_init(&mirror->list);
-		if (mirror->ops->release) {
-			/*
-			 * Drop mirrors_sem so the release callback can wait
-			 * on any pending work that might itself trigger a
-			 * mmu_notifier callback and thus would deadlock with
-			 * us.
-			 */
-			up_write(&hmm->mirrors_sem);
+	down_read(&hmm->mirrors_sem);
+	list_for_each_entry(mirror, &hmm->mirrors, list) {
+		/*
+		 * Note: The driver is not allowed to trigger
+		 * hmm_mirror_unregister() from this thread.
+		 */
+		if (mirror->ops->release)
 			mirror->ops->release(mirror);
-			down_write(&hmm->mirrors_sem);
-		}
-		mirror = list_first_entry_or_null(&hmm->mirrors,
-						  struct hmm_mirror, list);
 	}
-	up_write(&hmm->mirrors_sem);
+	up_read(&hmm->mirrors_sem);
 
 	hmm_put(hmm);
 }
@@ -287,7 +277,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
 	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
-	list_del_init(&mirror->list);
+	list_del(&mirror->list);
 	up_write(&hmm->mirrors_sem);
 	hmm_put(hmm);
 	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
-- 
2.21.0

