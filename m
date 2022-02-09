Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D6A4AF4E3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 16:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiBIPO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 10:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiBIPO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 10:14:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F7C06157B
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 07:14:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bx2so5701084edb.11
        for <linux-rdma@vger.kernel.org>; Wed, 09 Feb 2022 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7Kn9M+lFkcutoIJwTto7R8q28ka2hBIVwGS6ZgP7ZQ=;
        b=dTbl3EB6THAVv9YAUyVQT/DeBjrcj4lLihkbysHuN/N/rYeBEYdrFzQWHuSxd3r9nj
         uIkgaaSU4QxubTTdKTAscUiShAxwF7BX8XkBeOvLoKIOfapsHG1KAusK3LjJokiU9kEq
         pJA9JB1i1MFf5viE0ecaALSXcJHgUjSbotGc1+WsIX8FmIuKJ2jF03bg26YXuOBQhgoe
         4t+Je1YK6rtyc+uGN+OmB75PGLi3Sq7VBSr+W931O1kMiTJ3ieqST8f1/65RbhIweGXW
         dHQcdouPEHJw5QZvqYQht19faWaIbK2ez75OL8n9lUyU1TgxLmjB2hXEbYDKeNeag32s
         a4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7Kn9M+lFkcutoIJwTto7R8q28ka2hBIVwGS6ZgP7ZQ=;
        b=8L19eiqph3cr4l5SvZIJmWir7nuifOrEsCZuCFSOGHRsWIxPTQrmK+nUVBSaGz+ivJ
         QqhFXCHzR1k2dogMHSNGIuXz82jbt9oU+j+HmcrB5ozYK4MzkfEml9X9jknkQ0vdriFL
         o4zHDEJgfIIYVENvdp6OAhShVSbt84b4dZXn9t55SZhTtlzhDDWYtrVR+c/AFpzOOcLb
         xiXoJVEDf3is1Gtmm42f0eti/OoROToWtw7mKhsc+Vy4ig88jQIpA0ZbaYDbUoji3HAL
         fC01xWErYuD+zWKeFuUjpQMEcVYMszjie0Wzvo6HxQWeO39EUgrbQNzPDWUOOeT+PiOR
         GqCw==
X-Gm-Message-State: AOAM531QCHP3xeWYKGPLIM/iTlONcfVu62QR4HwAjgAoWTuaCsdmOYcP
        qt8pDBWQ/hLoT4cwiq/dhxbBYXz+JLMtDA==
X-Google-Smtp-Source: ABdhPJzMNFvevJftwY9HVP1SC2dHg8RddwWH3HxkkgoC42fUdSGXu2TC9Mlow/mrx65r6LlQduqHFg==
X-Received: by 2002:a05:6402:1d4d:: with SMTP id dz13mr2977453edb.56.1644419667535;
        Wed, 09 Feb 2022 07:14:27 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id z6sm6114967ejd.96.2022.02.09.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:14:27 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH v3 1/2] RDMA/rtrs-clt: Fix possible double free in error case
Date:   Wed,  9 Feb 2022 16:14:24 +0100
Message-Id: <20220209151425.142448-1-haris.iqbal@ionos.com>
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
 

base-commit: 2f1b2820b546c1eef07d15ed73db4177c0cf6d46
-- 
2.25.1

