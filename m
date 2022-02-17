Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0694B965D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiBQDJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:09:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiBQDJx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:09:53 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8048F23D5D9
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:09:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m22so3824034pfk.6
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwZR6LRtxho1iN3bcrm5HrqN1h4bgwlCvcBXmGprprc=;
        b=UB9jxIh+JpZuSZBMIzEiJlYoeOmPr1LMczVg2/YBS8dfvYx71OGpl6yzfWunAtWWZF
         JWfJTJ3kOY/lv5/iduEvZ4LARXFLm/11D+Sj+6cl84yxcS+8s7v8XFnO9S/MLH2/qlkv
         7jDHwZWXhGZsaj7NT+xVSz3C2qGFvRJacCJatKMraWGuNhuDwro8ZTMf0ziiLnQM/miK
         78giSnHmZTyomJl5ePtttGeOLUit4IcVSrhRKecwTBf+RHI+VIjdbSHgq8BM54eLGFvo
         IwtOERwSsyOr0kFrqtLcsEdruWxOfAnUiW+g2F1/D1eoD+gwEA9YvlXFnINwGmNLkUXB
         chrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwZR6LRtxho1iN3bcrm5HrqN1h4bgwlCvcBXmGprprc=;
        b=7nUvFvwYSNaRC3yxaBZ6FMk1AHxZqrAUmc4AWMmqtPyNRO1faM5/txpF4/OqWb5S3A
         SIwc7Bu/SFfPnZYMAoceWYgBSJk5S2Pyf1ZGbXAWq0ijn5USXiHAJil2pboktA9N/x+n
         euCT2LqYC4gRK2oPm91htj5haKkNNngCnbkjhoW5+dR2cx1S5zAGco6EL+fwJyBVeVM8
         m6RWvddww4MKinWNRw4CfvBgQU0eY0l57AXNRwUVY0TFwCeVv60oE5WWCpj7hcSWQFTi
         +vS8lqPULvuJosKUS1SZQfKIdT/T1Aq0DFIIBDcSFO3ooBEfamvn9rmElWZXQ+KrQOEs
         diLw==
X-Gm-Message-State: AOAM5330z3229+y2UErZHPHHilnpK8VeA/Dk/jhk/spa7lUISQhvRnvn
        KxJf3XXrqlxmZoH8815yo/tIahCVk0kWiw==
X-Google-Smtp-Source: ABdhPJxpUgT+tva5RiHJI2xPBOdQmA+i7DCoxn+35HmpCG0UmTRXAYEPdiz+dp0hSYWWUHh8pyxyYw==
X-Received: by 2002:a63:4542:0:b0:340:e43c:3783 with SMTP id u2-20020a634542000000b00340e43c3783mr809233pgk.509.1645067378240;
        Wed, 16 Feb 2022 19:09:38 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3ee7:b146:5f19:2be7:bec0:4145])
        by smtp.gmail.com with ESMTPSA id oa10sm428756pjb.54.2022.02.16.19.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:09:37 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH v4 1/2] RDMA/rtrs-clt: Fix possible double free in error case
Date:   Thu, 17 Feb 2022 04:09:28 +0100
Message-Id: <20220217030929.323849-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Fixes: eab098246625 ("RDMA/rtrs-clt: Refactor the failure cases in alloc_clt")
Reported-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
v3>v4:
	Add Fixes line
v2>v3
	Fix dev_set_name
v1>v2:
	Free clt->pcpu_path

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
 

base-commit: 2f1b2820b546c1eef07d15ed73db4177c0cf6d46
-- 
2.25.1

