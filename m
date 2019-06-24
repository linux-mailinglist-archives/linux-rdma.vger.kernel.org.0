Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B4051CAE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfFXVCH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50183 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfFXVCH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so688165wmf.0
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yY5nuWFfvtGdjXx5X0jOTLVoM6UrkzhjnRnf2/dFDmQ=;
        b=F8IpBc2pCC9TRRcnAQyPopBTGejfFjN4O3manyf4o/rILQiqjMrQn93gZmQT0zfX3x
         5Z+FOf3huG56JiHRxImMjpmYUHWLJoUWRxsyiLyvuER8NJ6yXAhiFhmoMeS3xXIFDdo2
         S8cp9J0djUNYJQZ5sFZYQ/C2WzaQmeRBmrPgWsubS3c8Ie4OcoFe0BbQ1hX51zSmNWX8
         jRx4QvWLtE9d+wLs0Pn2yh3tjD1LsHbOoGDIFKF99fyOS9uFazFhPFuBYcSfa5SLimKH
         7oBiYCs7lU7Wqx9ujUyjct2anJPQXnJ7qZm2I66poFSkOkPL9DAIWEUtnwKp1WVc7xDc
         HnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yY5nuWFfvtGdjXx5X0jOTLVoM6UrkzhjnRnf2/dFDmQ=;
        b=lqPzpCajTfqUCJIXSOLffUTIIvDfiablaiO35CnrOCEmHr9i3OhDtBNykq6XVLbxWI
         e00K6Y0OzOafCEpjawGPlLdg7Jf+kaAgTl9DRpbNd3TGkP0+fiKEFu+Fq1oVHNA/dRsX
         +e0aL2xYflW3II5ebZqZhKlJeC/iPHUxqP7cxroCehAwhmta/pGPgk/Pj3G1whMuUIbh
         xogR473EOPhmF8P0HXcov1iqrZ5PqpQ92YEghlyQ0DUFeWVbjhWzTDJaYd+tvgPghYNi
         c/r9fEHCEs177X8geOzZObUdoIAR6QJTlRaGRbMZHnGkwpM+Ob/YZ65w+/4tLlqhPdRY
         1OKw==
X-Gm-Message-State: APjAAAXvlbH9ihTXfGjGyf3eEkKr6o8MiDdqwlwJEw9V4YC2fA2fPE+a
        hf6JX5n9Jd7rrlpE7hoPCq7WYQ==
X-Google-Smtp-Source: APXvYqyRMuYsh8UNUKwpWttANdd8lJKeiEYwmSXHHDDyx29FbNSbr+pndqxDZmcjLhM+HZNLBH9CVQ==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr17413906wma.78.1561410125081;
        Mon, 24 Jun 2019 14:02:05 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id f7sm6578766wrv.38.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6D-0001N1-4V; Mon, 24 Jun 2019 18:02:01 -0300
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
Subject: [PATCH v4 hmm 11/12] mm/hmm: Remove confusing comment and logic from hmm_release
Date:   Mon, 24 Jun 2019 18:01:09 -0300
Message-Id: <20190624210110.5098-12-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624210110.5098-1-jgg@ziepe.ca>
References: <20190624210110.5098-1-jgg@ziepe.ca>
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
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c30aa9403dbe4d..b224ea635a7716 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -130,26 +130,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	WARN_ON(!list_empty_careful(&hmm->ranges));
 
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
@@ -279,7 +269,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
 	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
-	list_del_init(&mirror->list);
+	list_del(&mirror->list);
 	up_write(&hmm->mirrors_sem);
 	hmm_put(hmm);
 }
-- 
2.22.0

