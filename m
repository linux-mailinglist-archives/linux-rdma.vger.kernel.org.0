Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C42D4715
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgLIQrI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgLIQrI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:08 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BBDC0617B0
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:54 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so3080727ejk.2
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+ixKHzHTKsBZvAX0OK7xSXxQDyr1aV5shqn8qhWhFQ=;
        b=BolfRW4JXJ7cfdcMI/vJI9ppRqrkdobLUvEHXbVPV2VQkTfp+8uM3nsuFnAF0dUYrj
         iEmByrNrbCDlgn1NNCoy1+Pq8z924YKva35c7/djdJkVshGHD0c3Xhg7fdiqknSczclt
         f3DcUF5SJT3MKVZnfJDvabVsF4wC9JMN8Ay7nNJPvIeH6aCDCaLndAHxr4PSSBpPfJEd
         i7MTdwy9SxzvjURRDFqd/xCL75ebnoYd48AmhkNccTtKfNVWFv6NmUJszQwGPcxkfNV2
         XmYRUgmtMtJHzi39TyZIPfHURqCEjRn22BSrhuS0k1b1jXh6cqmwYBLM9gUSxTqaxKrV
         2HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+ixKHzHTKsBZvAX0OK7xSXxQDyr1aV5shqn8qhWhFQ=;
        b=cS2NZn/uvIH54nrIvj6CEGW9uLWcIhlZykvXg95NQw27hg1YMYdujl0+GhZRlYdhne
         AHL4jsF1Cwq90VCNi35F9HnaQLSpRwOc8badE88cFZT6R0oaqP1e/Ez27jLgkGA8UGB5
         fVxwgLeuuQWnyJ4KwiK19r05i0Aqf31t8nJYt8s+ADyYTFwuX87R5gU0dEyDOsJ2j7nx
         dBBjRbUeUeZxBkeevNSIsyyeh6fWU0U4lHAGmIEY+sjH3GgxE3QHaB/qnvJ7ZGgge7MU
         V8p7VwfcUuMLLUW1R3/t7t6Y5IK+OtkInRA2gUPUPl9RxKw9rHCJ6vtyjXdMAzoTphTC
         no6Q==
X-Gm-Message-State: AOAM531VLd4O1lUrLKsBh26kXbTEJMoIltnJM6/xMcKMrfPj9XggFXRK
        lyTqpJ9aY+OByKiXm9gpf+vGUCm1nWdWPA==
X-Google-Smtp-Source: ABdhPJy8spD9DCA9owoi5YzZc1fB2Oci1oTuOCXwlCUjohEQjdpH3ZAKYk4+Lk1czHph8SL6DkWotw==
X-Received: by 2002:a17:906:1752:: with SMTP id d18mr2834324eje.529.1607532353286;
        Wed, 09 Dec 2020 08:45:53 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:52 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 07/18] RDMA/rtrs: Call kobject_put in the failure path
Date:   Wed,  9 Dec 2020 17:45:31 +0100
Message-Id: <20201209164542.61387-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Per the comment of kobject_init_and_add, we need to free the memory
by call kobject_put.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 2 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index ba00f0de14ca..ad77659800cd 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -408,6 +408,7 @@ int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess)
 				   "%s", str);
 	if (err) {
 		pr_err("kobject_init_and_add: %d\n", err);
+		kobject_put(&sess->kobj);
 		return err;
 	}
 	err = sysfs_create_group(&sess->kobj, &rtrs_clt_sess_attr_group);
@@ -419,6 +420,7 @@ int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess)
 				   &sess->kobj, "stats");
 	if (err) {
 		pr_err("kobject_init_and_add: %d\n", err);
+		kobject_put(&sess->stats->kobj_stats);
 		goto remove_group;
 	}
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index cca3a0acbabc..0a3886629cae 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -236,6 +236,7 @@ static int rtrs_srv_create_stats_files(struct rtrs_srv_sess *sess)
 				   &sess->kobj, "stats");
 	if (err) {
 		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		kobject_put(&sess->stats->kobj_stats);
 		return err;
 	}
 	err = sysfs_create_group(&sess->stats->kobj_stats,
@@ -292,8 +293,8 @@ int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess)
 	sysfs_remove_group(&sess->kobj, &rtrs_srv_sess_attr_group);
 put_kobj:
 	kobject_del(&sess->kobj);
-	kobject_put(&sess->kobj);
 destroy_root:
+	kobject_put(&sess->kobj);
 	rtrs_srv_destroy_once_sysfs_root_folders(sess);
 
 	return err;
-- 
2.25.1

