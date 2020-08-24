Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9D250736
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHXSOw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSOu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:14:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E3C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m34so4936755pgl.11
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NMFjrrrZ5kdGGmiYr4AxMiGj88sZRju8WrPsO7rK+g=;
        b=aJSi7JpamexsHKHKt4AkNdZ9pQ3Buy+FhevT+5Z2nfMjg9frSnQccYzY9tcQCmho6j
         DgRkVEDwEx1AIuFAzRto1/aN18i1/Rgvzbyv9xt2USL1gOiL956UwzDIjkNnT8PHjVLW
         awol67Ea2qlw+TnNpF2uoWe/KVqBuO1Rdnfvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NMFjrrrZ5kdGGmiYr4AxMiGj88sZRju8WrPsO7rK+g=;
        b=bQIzSKJ1tAhrTgJnhTSy5Qd++uWN9TgJfXFLGX59pfB4JnKyIOm/8aR7xc/YFqVllr
         +SvL44ZavzyO7w3Mi//HvIsPe474+AoYtT6p7mBeLUqf0uLN/V6s6lK6TkhHwYhMju1k
         rvYU/9RA5CfM55GNIl7d9Y55fMCFcQ319AuO23zlb/+9wFHHK8Ncs/V7HHULGNmOmoFD
         3bGhv8nW0mq30DliYNXjCakB6O/Yoybjf+X80tDGg1EyTQAhu3Uud5qs4Em6rcCJvJvc
         2Na3JbOhzoluSXqPaQ30fgNHAm5wpFqMAgId2jLKjkuF/pT+pIirnBvbDPBz1fWNLBpc
         a8aw==
X-Gm-Message-State: AOAM532UvAomtXqNa1DaMOJaxlDysL2SVGEFkrU3oJXS4hdZKeXLk6Z7
        6px9PgvU4Uel9bg7+7EYSfdiug==
X-Google-Smtp-Source: ABdhPJzW2l9BCFHaGN7IWeZjD3gpELp28bwZRvqJSR1OXFeYEDY3hfKe9E6znePq057tnk4dei0dzA==
X-Received: by 2002:a17:902:700b:: with SMTP id y11mr4487097plk.311.1598292889799;
        Mon, 24 Aug 2020 11:14:49 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q5sm5027811pfu.16.2020.08.24.11.14.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:14:49 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 1/6] RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds
Date:   Mon, 24 Aug 2020 11:14:31 -0700
Message-Id: <1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver crashes when destroy_qp is re-tried because of an
error returned. This is because the qp entry was  removed
from the qp list during the first call.

Remove qp from the list only if destroy_qp returns success.

Fixes: 8dae419f9ec7 ("RDMA/bnxt_re: Refactor queue pair creation code")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 3f18efc..2f5aac0 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -752,12 +752,6 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	gsi_sqp = rdev->gsi_ctx.gsi_sqp;
 	gsi_sah = rdev->gsi_ctx.gsi_sah;
 
-	/* remove from active qp list */
-	mutex_lock(&rdev->qp_lock);
-	list_del(&gsi_sqp->list);
-	mutex_unlock(&rdev->qp_lock);
-	atomic_dec(&rdev->qp_count);
-
 	ibdev_dbg(&rdev->ibdev, "Destroy the shadow AH\n");
 	bnxt_qplib_destroy_ah(&rdev->qplib_res,
 			      &gsi_sah->qplib_ah,
@@ -772,6 +766,12 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	}
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
 
+	/* remove from active qp list */
+	mutex_lock(&rdev->qp_lock);
+	list_del(&gsi_sqp->list);
+	mutex_unlock(&rdev->qp_lock);
+	atomic_dec(&rdev->qp_count);
+
 	kfree(rdev->gsi_ctx.sqp_tbl);
 	kfree(gsi_sah);
 	kfree(gsi_sqp);
@@ -792,11 +792,6 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
-	mutex_lock(&rdev->qp_lock);
-	list_del(&qp->list);
-	mutex_unlock(&rdev->qp_lock);
-	atomic_dec(&rdev->qp_count);
-
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
 
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
@@ -819,6 +814,11 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 			goto sh_fail;
 	}
 
+	mutex_lock(&rdev->qp_lock);
+	list_del(&qp->list);
+	mutex_unlock(&rdev->qp_lock);
+	atomic_dec(&rdev->qp_count);
+
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
-- 
2.5.5

