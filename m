Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC52DD2D8
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLQOUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgLQOUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E63C0611C5
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q16so28785726edv.10
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81PSqEKTzeewp1eFw0SkbXHJmtuB6a/3wq15G2WR/5g=;
        b=UGSJK+TgAS6TFUfzUW4qLPGelqd549ZlCmWX3kFm4sFy5rag8aY17HFo1N/bBygJEQ
         oqGMwNI0FBwieo3oL3CgSTAGQyzecKrx7CH9sgMB2g4EssKar2Kvc54YiK69uBtSvPTu
         AjTMtXRpmMAt3DaFpcbQNtJd8864hhHLZ0gyqf4lKJFAHVdudTaxmwHMd2l1/279Py3U
         fpbtJi5zOlVX3sUbwQilcTxb3UL+MTAuJdLT3UUg/TTwgPkaqJg1Qc+owPIaHBPJdC5s
         2sQ37jVkRuxYDCcKQcY0/dcxNNoUsxCFtTKm9IS8mvN+Yiwk8ZZiX9bb9c67Sivd4Evo
         1wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81PSqEKTzeewp1eFw0SkbXHJmtuB6a/3wq15G2WR/5g=;
        b=CQ+aKc3iRdiykyYIwMXo9w+FHJBA76vY+RnQQY2ywQpYPIYG/1QUnUs0ege2R5wFkm
         w6YXKKAJnHMDBmfIwZ04eR2Lo/O24vhYmedjasr7D7O+Y22/L0haTTcIFCk/fyp6BbhH
         9MYK/WWRHf+QKc7XOrUS42cucvOswu1MUWlCllv60dbYox8hpN5VkS08mzA5WHPrRNPr
         ljB7q7HZ3JnoOX5KdxJexs4zNnyTozNRRM5fJEkX70UaS3NjmwS9jxar4xI0lcCdd2go
         eWVuTAgUxuMi8Y4tvSTReW0aBxnHt7f6RkOYQukjA7SR1sLnemQizt0r35MBZyqVx6qz
         t8Hw==
X-Gm-Message-State: AOAM532rV1fWIabG39fOl7VEzN/E0h+V3V+3nsNc7ps8ClndjFkrEFEP
        The9osPEQ/PiDIlpd110zJ274Yomyq+rkg==
X-Google-Smtp-Source: ABdhPJyJWnpfhlyu5uZtqDnsMoKmZVBbDpnJe72U7OIX55AI7FzVA6/pXfp0zyNY7ZuZzLsAj8/rZQ==
X-Received: by 2002:a05:6402:310f:: with SMTP id dc15mr38625528edb.225.1608214764515;
        Thu, 17 Dec 2020 06:19:24 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:24 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 08/19] RDMA/rtrs-clt: Consolidate rtrs_clt_destroy_sysfs_root_{folder,files}
Date:   Thu, 17 Dec 2020 15:19:04 +0100
Message-Id: <20201217141915.56989-9-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since the two functions are called together, let's consolidate them in
a new function rtrs_clt_destroy_sysfs_root.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 9 +++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 6 ++----
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 3 +--
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index ad77659800cd..b6a0abf40589 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -471,15 +471,12 @@ int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt)
 	return sysfs_create_group(&clt->dev.kobj, &rtrs_clt_attr_group);
 }
 
-void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt)
+void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt)
 {
+	sysfs_remove_group(&clt->dev.kobj, &rtrs_clt_attr_group);
+
 	if (clt->kobj_paths) {
 		kobject_del(clt->kobj_paths);
 		kobject_put(clt->kobj_paths);
 	}
 }
-
-void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt)
-{
-	sysfs_remove_group(&clt->dev.kobj, &rtrs_clt_attr_group);
-}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b3fb5fb93815..99fc34950032 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2707,8 +2707,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		rtrs_clt_close_conns(sess, true);
 		kobject_put(&sess->kobj);
 	}
-	rtrs_clt_destroy_sysfs_root_files(clt);
-	rtrs_clt_destroy_sysfs_root_folders(clt);
+	rtrs_clt_destroy_sysfs_root(clt);
 	free_clt(clt);
 
 out:
@@ -2725,8 +2724,7 @@ void rtrs_clt_close(struct rtrs_clt *clt)
 	struct rtrs_clt_sess *sess, *tmp;
 
 	/* Firstly forbid sysfs access */
-	rtrs_clt_destroy_sysfs_root_files(clt);
-	rtrs_clt_destroy_sysfs_root_folders(clt);
+	rtrs_clt_destroy_sysfs_root(clt);
 
 	/* Now it is safe to iterate over all paths without locks */
 	list_for_each_entry_safe(sess, tmp, &clt->paths_list, s.entry) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index b8dbd701b3cb..a97a068c4c28 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -243,8 +243,7 @@ ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *stats,
 /* rtrs-clt-sysfs.c */
 
 int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt);
-void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt);
-void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt);
+void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt);
 
 int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess);
 void rtrs_clt_destroy_sess_files(struct rtrs_clt_sess *sess,
-- 
2.25.1

