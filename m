Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D08581BA3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jul 2022 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbiGZVWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiGZVWK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 17:22:10 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46972FFE0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:08 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso185972pjo.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+XwHQzye+jtxaG55S5bN36tM1aIuajGKPATkZWDoyk=;
        b=1iMQgM9kO6/WMBseDwK1+8Rdm4jOv4g6kwTyV3odbCr2SA2eQAv1Kh7dZImIfveV2w
         Ov4S6dtvfU4AzR+YykusO8grgHnlb/9SPa88Pb2xG9cLwHl4q5wBChPKhFangXFUFUtR
         JJ/qr0poBNahERQsBdeKsl+pYrJXXfLRmEpbgj5uBEKwopzL0yUSpcB+Fa3MQ/twMXXS
         ht+ced67GJrcognxB0FouR7nU6bA0v9jNdT0zB86UjmOLDjkSB/U41XCfzBnMKYpiXq/
         V7+7bQfqbEZj+OO6gm/YfPfUdHZW//vA1+xyc058apfUsrq7136PadHf+KXSaD/BNyv4
         bCrQ==
X-Gm-Message-State: AJIora/e2sng05vDry6SbG6LRji27cjhxx9TWMTgXquIJ5ki40GIzrCp
        D0ncmoCJvyLKn4HB5erYva8=
X-Google-Smtp-Source: AGRyM1tsCHCtMNJcHkXIuXSiccpie3RIViY3XvMU4dgAUo7w0Fc0/pyU46YVV/710md0LpaqpNDaEQ==
X-Received: by 2002:a17:90a:f285:b0:1f2:620b:d9d8 with SMTP id fs5-20020a17090af28500b001f2620bd9d8mr1012210pjb.24.1658870528186;
        Tue, 26 Jul 2022 14:22:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:34f4:7aa8:57:d456])
        by smtp.gmail.com with ESMTPSA id g5-20020aa796a5000000b00528999fba99sm12398983pfk.175.2022.07.26.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:22:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] RDMA/srpt: Introduce a reference count in struct srpt_device
Date:   Tue, 26 Jul 2022 14:21:55 -0700
Message-Id: <20220726212156.1318010-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220726212156.1318010-1-bvanassche@acm.org>
References: <20220726212156.1318010-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This will be used to keep struct srpt_device around as long as either
the RDMA port exists or a LIO target port is associated with the struct
srpt_device.

Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 17 +++++++++++++++--
 drivers/infiniband/ulp/srpt/ib_srpt.h |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 8253d55b9c26..1fbce9225424 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3104,6 +3104,18 @@ static int srpt_use_srq(struct srpt_device *sdev, bool use_srq)
 	return ret;
 }
 
+static void srpt_free_sdev(struct kref *refcnt)
+{
+	struct srpt_device *sdev = container_of(refcnt, typeof(*sdev), refcnt);
+
+	kfree(sdev);
+}
+
+static void srpt_sdev_put(struct srpt_device *sdev)
+{
+	kref_put(&sdev->refcnt, srpt_free_sdev);
+}
+
 /**
  * srpt_add_one - InfiniBand device addition callback function
  * @device: Describes a HCA.
@@ -3122,6 +3134,7 @@ static int srpt_add_one(struct ib_device *device)
 	if (!sdev)
 		return -ENOMEM;
 
+	kref_init(&sdev->refcnt);
 	sdev->device = device;
 	mutex_init(&sdev->sdev_mutex);
 
@@ -3217,7 +3230,7 @@ static int srpt_add_one(struct ib_device *device)
 	srpt_free_srq(sdev);
 	ib_dealloc_pd(sdev->pd);
 free_dev:
-	kfree(sdev);
+	srpt_sdev_put(sdev);
 	pr_info("%s(%s) failed.\n", __func__, dev_name(&device->dev));
 	return ret;
 }
@@ -3261,7 +3274,7 @@ static void srpt_remove_one(struct ib_device *device, void *client_data)
 
 	ib_dealloc_pd(sdev->pd);
 
-	kfree(sdev);
+	srpt_sdev_put(sdev);
 }
 
 static struct ib_client srpt_client = {
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 3844a7058559..0cb867d580f1 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -434,6 +434,7 @@ struct srpt_port {
 
 /**
  * struct srpt_device - information associated by SRPT with a single HCA
+ * @refcnt:	   Reference count for this device.
  * @device:        Backpointer to the struct ib_device managed by the IB core.
  * @pd:            IB protection domain.
  * @lkey:          L_Key (local key) with write access to all local memory.
@@ -449,6 +450,7 @@ struct srpt_port {
  * @port:          Information about the ports owned by this HCA.
  */
 struct srpt_device {
+	struct kref		refcnt;
 	struct ib_device	*device;
 	struct ib_pd		*pd;
 	u32			lkey;
