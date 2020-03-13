Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7891846E6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgCMMbz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:31:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41471 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMbz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 08:31:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14so11872691wrt.8
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgz2DihxvsOAX8tiSY4fxk2uMcXFREsDYCuDlOPhGkc=;
        b=DXQJ6N8QF5WbHhYRfGChPIcLY7Ns09sLuOZdWXhMJQlkimejGIv7XQIbiXEdy3qn58
         3hXHwE4hjivRH/Uv0GjtXvWoCnQGrbkVOFW26JHJCFzZH1qYmphgerR9tEkEWWUQXnNC
         f6nHptuu5EOyZ5MNqCd78hOExg8rJZAq4Xn7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgz2DihxvsOAX8tiSY4fxk2uMcXFREsDYCuDlOPhGkc=;
        b=dl61o09uYvu5r9jTxiwaLMIzsSebJy3nU7xnNHBG6IARUyiHRO6CX7FiiPBDaKSvd2
         8mUdc4s3RIUske7lkliAxeH0iZG+WTOT6oshwDYbJaTIhwpwYSgZxNmcTuLxT8Rexbtx
         fvUAjcPC3IOkA7hngzvjK8B6sTbJO/5JiepskAZT85IQv32a6aL+b5I2emhgcj526Nc9
         wyDaigRMFBcEJGs6qqVkjEnSkoNabcyvQ8StWQ9EIrGVZq1URRP3lh8cALMQ6Pr/JQcu
         k77hCupJIX+5m9ohG8uK2edmoggaKyhqfNzixlSnhNGmU3TP1M3vdDGnSxzYRR3L16R9
         Vi3w==
X-Gm-Message-State: ANhLgQ3IcFZYFFS1ne91/oI4D20CS3+u+a60QWaR2cI1F5qZRQ6Daxu8
        GRNQltWgMMuckBm4yn8tL3UFpw==
X-Google-Smtp-Source: ADFU+vt5ZLYfV98RSFWUGPP7Br9EFkBlWBG7dKAWRuXO3zMTmMfSV9r7j4PseHLeTGCJyjNYzQnERg==
X-Received: by 2002:adf:e804:: with SMTP id o4mr17327398wrm.24.1584102713301;
        Fri, 13 Mar 2020 05:31:53 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g129sm18015910wmg.12.2020.03.13.05.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:31:52 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/3] RDMA/bnxt_re: Use ib_device_try_get()
Date:   Fri, 13 Mar 2020 05:31:32 -0700
Message-Id: <1584102694-32544-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
References: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

There are a couple places in this driver running from a work queue that
need the ib_device to be registered. Instead of using a broken internal
bit rely on the new core code to guarantee device registration.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 415693f..d5019b3 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1171,12 +1171,13 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 	u16 gid_idx, index;
 	int rc = 0;
 
-	if (!test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
+	if (!ib_device_try_get(&rdev->ibdev))
 		return 0;
 
 	if (!sgid_tbl) {
 		ibdev_err(&rdev->ibdev, "QPLIB: SGID table not allocated");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	for (index = 0; index < sgid_tbl->active; index++) {
@@ -1196,7 +1197,8 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 		rc = bnxt_qplib_update_sgid(sgid_tbl, &gid, gid_idx,
 					    rdev->qplib_res.netdev->dev_addr);
 	}
-
+out:
+	ib_device_put(&rdev->ibdev);
 	return rc;
 }
 
@@ -1630,12 +1632,7 @@ static void bnxt_re_task(struct work_struct *work)
 	re_work = container_of(work, struct bnxt_re_work, work);
 	rdev = re_work->rdev;
 
-	if (re_work->event != NETDEV_REGISTER &&
-	    !test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
-		goto done;
-
-	switch (re_work->event) {
-	case NETDEV_REGISTER:
+	if (re_work->event == NETDEV_REGISTER) {
 		rc = bnxt_re_ib_init(rdev);
 		if (rc) {
 			ibdev_err(&rdev->ibdev,
@@ -1645,7 +1642,13 @@ static void bnxt_re_task(struct work_struct *work)
 			rtnl_unlock();
 			goto exit;
 		}
-		break;
+		goto exit;
+	}
+
+	if (!ib_device_try_get(&rdev->ibdev))
+		goto exit;
+
+	switch (re_work->event) {
 	case NETDEV_UP:
 		bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
 				       IB_EVENT_PORT_ACTIVE);
@@ -1665,7 +1668,7 @@ static void bnxt_re_task(struct work_struct *work)
 	default:
 		break;
 	}
-done:
+	ib_device_put(&rdev->ibdev);
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
 exit:
-- 
2.5.5

