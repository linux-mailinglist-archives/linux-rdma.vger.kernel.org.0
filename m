Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A054A743D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Feb 2022 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbiBBPJB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Feb 2022 10:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiBBPJA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Feb 2022 10:09:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0DC061714
        for <linux-rdma@vger.kernel.org>; Wed,  2 Feb 2022 07:09:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so42930739edn.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Feb 2022 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgHkq3DvZny3BNar3jH1ignKEJ8NNiVYfZeGPSxh2XU=;
        b=D5y/AJCQt/91dyAYP3/+P2FFHzMvYvOQqZk2JpEvjnxMtNmxfPfwIWcj1OrnkslkMh
         9SByC04LZKkca88M+wpf0dsiw9EHi8rDY/RxRkcT99Dv6RoljSV05Um2e9ifM2aIeDn2
         AoHk0jPrwnFFsKKdRmbFlrAK9k1upcCiFLPY0WMCinhQryK1Mz8H9GRwfPvUyO1/g/HL
         pIRzcRRQiKmWWTUXBUrSr9Vb/d9z6OPkibCbT9E6lPV6FseFh2IkWJ7q8/CKanL6G3fg
         cTcpVhbes1phMw5NRYtSsvmQn4p5tHZBbIBZo6oQLXsBOsbCkOT0pRCPwsKWJezBvs5O
         Jihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zgHkq3DvZny3BNar3jH1ignKEJ8NNiVYfZeGPSxh2XU=;
        b=h0PqQYYy4jemNazJ7iPUi75ZFr+o73zS0DTPYf2cQFwnwHU4v5zADSyT6cvxNWg1eS
         EWTuQYiCiE5jGP0tilQ6TYdbCa1yd3XvLH/um5f2WzmWJ34WNP92k2QBxl5uitSJVGsd
         ag+SP/sEm0jnHf5OoxCKPBufwubHqHiMfIaqIl/xc3BOSSiZD22Ryn32rzb+QzlkfxhS
         f2+uo8gvWiw1XAuPIwYyokocB8Vlo/M4vGIgwDqbaS9+gsO/PpHjeaJ/2NSN/O6SiXMN
         hqqRnFF/lH9YUWHHn7r7VQm8KRJ2VlzW8AR/LaXrVr9mrXPkSUNoSkRpZmV+P9eM5JIK
         vNBg==
X-Gm-Message-State: AOAM533rOEyS/OZnvneJ/qS904dn5shCsu1IFSelymS9iOfWvlV/5+Yg
        elS7kOnitz4AMDcaHK2wpI/wCwvrwt/Cbw==
X-Google-Smtp-Source: ABdhPJzdt+Aa0QYLljtslxdxbq9TNPLtkkemwKgwzhm2fyrG/TWq88hkFyF1I+A60RYuCDCQ3Qgb9w==
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr30667602edw.293.1643814538772;
        Wed, 02 Feb 2022 07:08:58 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j19sm4883625ejm.111.2022.02.02.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:08:58 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH v3 1/2] RDMA/rtrs-clt: Fix possible double free in error case
Date:   Wed,  2 Feb 2022 16:08:54 +0100
Message-Id: <20220202150855.445973-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Callback function rtrs_clt_dev_release() for put_device() calls kfree(clt)
to free memory. We shouldn't call kfree(clt) again, and we can't use the
clt after kfree too.

Replace device_register with device_initialize and device_add so that
dev_set_name can be used appropriately.

Move mutex_destroy to release function so it can be called in alloc_clt err
path.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 37 ++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b696aa4abae4..d20bad345eff 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2685,6 +2685,8 @@ static void rtrs_clt_dev_release(struct device *dev)
 	struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
 						 dev);
 
+	mutex_destroy(&clt->paths_ev_mutex);
+	mutex_destroy(&clt->paths_mutex);
 	kfree(clt);
 }
 
@@ -2714,6 +2716,8 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	clt->dev.class = rtrs_clt_dev_class;
+	clt->dev.release = rtrs_clt_dev_release;
 	uuid_gen(&clt->paths_uuid);
 	INIT_LIST_HEAD_RCU(&clt->paths_list);
 	clt->paths_num = paths_num;
@@ -2730,43 +2734,41 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 	init_waitqueue_head(&clt->permits_wait);
 	mutex_init(&clt->paths_ev_mutex);
 	mutex_init(&clt->paths_mutex);
+	device_initialize(&clt->dev);
 
-	clt->dev.class = rtrs_clt_dev_class;
-	clt->dev.release = rtrs_clt_dev_release;
 	err = dev_set_name(&clt->dev, "%s", sessname);
 	if (err)
-		goto err;
+		goto err_put;
+
 	/*
 	 * Suppress user space notification until
 	 * sysfs files are created
 	 */
 	dev_set_uevent_suppress(&clt->dev, true);
-	err = device_register(&clt->dev);
-	if (err) {
-		put_device(&clt->dev);
-		goto err;
-	}
+	err = device_add(&clt->dev);
+	if (err)
+		goto err_put;
 
 	clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
 	if (!clt->kobj_paths) {
 		err = -ENOMEM;
-		goto err_dev;
+		goto err_del;
 	}
 	err = rtrs_clt_create_sysfs_root_files(clt);
 	if (err) {
 		kobject_del(clt->kobj_paths);
 		kobject_put(clt->kobj_paths);
-		goto err_dev;
+		goto err_del;
 	}
 	dev_set_uevent_suppress(&clt->dev, false);
 	kobject_uevent(&clt->dev.kobj, KOBJ_ADD);
 
 	return clt;
-err_dev:
-	device_unregister(&clt->dev);
-err:
+err_del:
+	device_del(&clt->dev);
+err_put:
 	free_percpu(clt->pcpu_path);
-	kfree(clt);
+	put_device(&clt->dev);
 	return ERR_PTR(err);
 }
 
@@ -2774,9 +2776,10 @@ static void free_clt(struct rtrs_clt_sess *clt)
 {
 	free_permits(clt);
 	free_percpu(clt->pcpu_path);
-	mutex_destroy(&clt->paths_ev_mutex);
-	mutex_destroy(&clt->paths_mutex);
-	/* release callback will free clt in last put */
+
+	/*
+	 * release callback will free clt and destroy mutexes in last put
+	 */
 	device_unregister(&clt->dev);
 }
 
-- 
2.25.1

