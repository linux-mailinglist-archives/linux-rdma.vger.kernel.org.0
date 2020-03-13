Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DE184C93
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 17:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMQdo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 12:33:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54525 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQdn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 12:33:43 -0400
Received: by mail-pj1-f66.google.com with SMTP id np16so4406184pjb.4
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CgmE5sqaMcsaNmVgGKGDMDJjMYE5ZC0sLmHpoJUsZUY=;
        b=M6tM+MecHK63D7g1O5WkypFBGU5AxD11xjCkHog6+ny+inqq2540wSzkR2+JM/Ffhh
         0IqM8OH8KOAt2iOaWgM8wKYlviVhc/2hsusQGWiZRL/QJn91x/4t6jcdCNzJi5Jgcidu
         pweSUWaF9WzJq0SrwasSp6/i6K4cAGaiN+gWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CgmE5sqaMcsaNmVgGKGDMDJjMYE5ZC0sLmHpoJUsZUY=;
        b=ZszpX3zgZNsMXaSIYwAOIVkB7CrNz3tbi675b5EwrKGOgv5PGfHLDPUFtYBV/f8Jmd
         FtWStUYhGoRFsH2TtKdg0qTDdO4rB1jZpvkvY4nCcO7cDmBpDWxevzYPnKROOZswG5yn
         0BPUEvSXewCDh0oU5saScvMrIu72J7qD7kK5u0FyhxFOHNe3UuNqTM0jn7MFWb/PAbSu
         tbcwSmsLDu/BdJ2ho5xRWREqW6gJ6TMRcw7a+qHj4fyZ0I4IrnoWTknjjQiA+HnCTxIk
         iblO1lYEQbRDGBiZGRxUD/WOsj0CYapOHxSSI1D2MQtPeRVEl1bAoSc26p580/xI/YNY
         2u6w==
X-Gm-Message-State: ANhLgQ0uMK1eW+AydlcZ7J9OQf+Axfa2Z7uIvrO5Yi+O01uGT4XmVqNT
        HXiqMykw7Zb8IHO8vOQMgBV7E93TEGQ=
X-Google-Smtp-Source: ADFU+vvXLhTd/RBcWftgMA2lp8LAwDJTl7q9fEwm7p3CJG+szwJpQmrdf6FPwMEQCOujNHIphmNA1Q==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr14560098plo.259.1584117222582;
        Fri, 13 Mar 2020 09:33:42 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v5sm2338344pjn.2.2020.03.13.09.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:33:41 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 1/3] RDMA/bnxt_re: Use ib_device_try_get()
Date:   Fri, 13 Mar 2020 09:33:25 -0700
Message-Id: <1584117207-2664-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
References: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  1 -
 drivers/infiniband/hw/bnxt_re/main.c    | 27 ++++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index c736e82..407141e 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -132,7 +132,6 @@ struct bnxt_re_dev {
 	struct list_head		list;
 	unsigned long			flags;
 #define BNXT_RE_FLAG_NETDEV_REGISTERED		0
-#define BNXT_RE_FLAG_IBDEV_REGISTERED		1
 #define BNXT_RE_FLAG_GOT_MSIX			2
 #define BNXT_RE_FLAG_HAVE_L2_REF		3
 #define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 415693f..885127c 100644
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
 
@@ -1319,7 +1321,6 @@ int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 		pr_err("Failed to register with IB: %#x\n", rc);
 		return rc;
 	}
-	set_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
 	dev_info(rdev_to_dev(rdev), "Device registered successfully");
 	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
 			 &rdev->active_width);
@@ -1612,7 +1613,6 @@ static void bnxt_re_dealloc_driver(struct ib_device *ib_dev)
 	struct bnxt_re_dev *rdev =
 		container_of(ib_dev, struct bnxt_re_dev, ibdev);
 
-	clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
 	dev_info(rdev_to_dev(rdev), "Unregistering Device");
 
 	rtnl_lock();
@@ -1630,12 +1630,7 @@ static void bnxt_re_task(struct work_struct *work)
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
@@ -1645,7 +1640,13 @@ static void bnxt_re_task(struct work_struct *work)
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
@@ -1665,7 +1666,7 @@ static void bnxt_re_task(struct work_struct *work)
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

