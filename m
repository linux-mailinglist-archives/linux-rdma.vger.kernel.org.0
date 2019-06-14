Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A2450FF
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 03:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfFNBEE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 21:04:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38281 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfFNBEE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 21:04:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so651548qkk.5
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8awC9I57ul4Ehs65t7/5PNP0ULl1lssVMkwIyYI5A4o=;
        b=d7bdApJpYLjcmtg3xYRxybVOfz2KS93AC0fzZ1fW4XyHVqwL3OM+gFQej1Ln9qn0DE
         xz1SgRMDXyVjAJ/iauLJS09acThOE7zN7n1V63w1pV4dNLuGqG3b8zAuTr/PFa4b30o3
         fbxyk9MLPAGnMTt8pryVLuPSPpy6jxJkRiEUy1WphR9OOkegUcdTJ5BDKJnvCM2Hh4yW
         n+3I8FhRNhZAxdrmmWxLdwqvz0zePJfQiNoLHWaFUtjNaqK8MbBX+kIYlUs31nGnJC6k
         xIJaEsma2lTn79hWn1/ETECrmvNZum8sX2V88MjB1tGUFrF/ZbWZmNodexZOS8frzOdP
         2fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8awC9I57ul4Ehs65t7/5PNP0ULl1lssVMkwIyYI5A4o=;
        b=IU4GEIfjS9CimknW+vHMY8dNmNzOdwE2FZL75fZSNJvF+B958QwznoAfELTQ5JLSn8
         NIyAJdkwKF4FUsaG12Fa3vv1+fUooMsmIjHVTByJBPgoy00TE8B6TIT1FgumPvGKNzOd
         B4qDqlDBIpTzKsvmYC7uAY1BKyb0IqAaGMTuRoCPqbsCe0FTm3iIcg2pb5gon5jk5bsJ
         v6faTQQiG9ItD2d2q3YsF/9Hv67+tjJUlPmkvpoDbn+GDvyxN5hs3WqAWXzpAD1lKvhj
         VtIQJwt36jiV6Cqcu9BxvziBM8YAZlVCvQ1fJEGO/fKsv16qVVxO5FcHPuN+lOzM13tl
         IttA==
X-Gm-Message-State: APjAAAUP5hCxeP4cQ+8ZMchWBZN9o8544DGxm53jbWLjPt80lLwMj9rE
        c7qHOSftbStzIj+EJS/fzb9fKg==
X-Google-Smtp-Source: APXvYqxXIo3h4su+d4IRSr2dLrSynk5yL3SLa1bT6tdawPdbOlK3JH39LvD6Y28mBndOcMefOVTFTQ==
X-Received: by 2002:a05:620a:5ad:: with SMTP id q13mr19545434qkq.154.1560474243703;
        Thu, 13 Jun 2019 18:04:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g53sm699466qtk.65.2019.06.13.18.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 18:04:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKs-0005KW-2y; Thu, 13 Jun 2019 21:44:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 11/12] mm/hmm: Remove confusing comment and logic from hmm_release
Date:   Thu, 13 Jun 2019 21:44:49 -0300
Message-Id: <20190614004450.20252-12-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614004450.20252-1-jgg@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
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
index 26af511cbdd075..c0d43302fd6b2f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -137,26 +137,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
@@ -286,7 +276,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
 	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
-	list_del_init(&mirror->list);
+	list_del(&mirror->list);
 	up_write(&hmm->mirrors_sem);
 	hmm_put(hmm);
 	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
-- 
2.21.0

