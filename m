Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD725DB4D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgIDOUu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgIDNmc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 09:42:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2EC061245
        for <linux-rdma@vger.kernel.org>; Fri,  4 Sep 2020 06:30:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so1142727plk.13
        for <linux-rdma@vger.kernel.org>; Fri, 04 Sep 2020 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zEzxJFrL05lrktaxsWx4GbCXNTEcyg631XqfJCCVBTU=;
        b=I6q+E6Uw9uGBzuXMperYCw/4dMaq7i7CAIbpd4MrKco2H76UcNIurmuWo/Lx/M1O55
         MgSlslnOAsnL24kszsARKkXzOQXTs0Y2D+KNpxfsmOi1Ue08liC1u0+h08IiSMO0aipl
         Kzl0d0gLoytl+01nV4nm9S1olUfy27L0J1v9AI++5RSfB7BwSH3JQqyc9eOgF+UrR0HL
         t+f2bvc2O0plUwWAQ7aX4q4r4xIrcx49ASAXt32q3cDh7UK4pXUd64v9GVzVxUHe7V7v
         BuF9BuPw+GGpnurdl+kRM4MOqttvUcoo9qw0Zy0topsKWpMAJ9nQH5qwpSJ9Nf41rM+S
         GmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zEzxJFrL05lrktaxsWx4GbCXNTEcyg631XqfJCCVBTU=;
        b=AFmo+adXi7mpD3v+rPEWWkz0T3E5KJBigECknpVWrZXTm4lWpuJRkQW+Gdns8vWZoe
         H5y0+bAvKF3qAfYAkaj7r4zTVmB59/NqEZrFiA0sH3FtBTQfLI5Z+bMiFE1WkWVjcIHv
         9SSn21tIr+NVGPVmt0klakWWd5vYRBua3wGIVf1Au3OAKEu73qKVz23na4VNUza2mnH6
         VJMnfz1eUIr2o5UoN3ymBgAfxWcfuZQ5o9yqgFA7oRuVhd9tFtaF2+Bqscl+vgGyq9E3
         EGwZ9aFAU2TnRtEtr7e3KmZeP+fNGEllGKcNDZUhnDCouMf7f2Q4zl08ue8R6maGetdH
         PPQg==
X-Gm-Message-State: AOAM532jbrMBtUoXtoFgfAHcji1i4wQbAItuEphvkpSL1hmXu8+j4vKN
        w+tULYxKrNF2J/GqeYiNt72+hg==
X-Google-Smtp-Source: ABdhPJyLrJLP1RT2gJjDn6XMRtUHFoM/mrZSqot5BmiKK+nA6eC/FTja8qhlgjL1Mmws9Ezb++AItw==
X-Received: by 2002:a17:90a:4046:: with SMTP id k6mr8143814pjg.11.1599226255925;
        Fri, 04 Sep 2020 06:30:55 -0700 (PDT)
Received: from nb01533.fkb.profitbricks.net ([43.224.130.252])
        by smtp.gmail.com with ESMTPSA id n26sm6744992pff.30.2020.09.04.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:30:55 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH] RDMA/rtrs-srv: Set .release function for rtrs srv device during device init
Date:   Fri,  4 Sep 2020 19:00:38 +0530
Message-Id: <20200904133038.335680-1-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The device .release function was not being set during the device
initialization. This was leading to the below warning, in error cases when
put_srv was called before device_add was called.

Warning:

Device '(null)' does not have a release() function, it is broken and must
be fixed. See Documentation/kobject.txt.

So, set the device .release function during device initialization in the
__alloc_srv() function.

Fixes: baa5b28b7a474 ("RDMA/rtrs-srv: Replace device_register with..")
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 8 --------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 2f981ae97076..cf6a2be61695 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -152,13 +152,6 @@ static struct attribute_group rtrs_srv_stats_attr_group = {
 	.attrs = rtrs_srv_stats_attrs,
 };
 
-static void rtrs_srv_dev_release(struct device *dev)
-{
-	struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
-
-	kfree(srv);
-}
-
 static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 {
 	struct rtrs_srv *srv = sess->srv;
@@ -172,7 +165,6 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 		goto unlock;
 	}
 	srv->dev.class = rtrs_dev_class;
-	srv->dev.release = rtrs_srv_dev_release;
 	err = dev_set_name(&srv->dev, "%s", sess->s.sessname);
 	if (err)
 		goto unlock;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index b61a18e57aeb..28f6414dfa3d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1319,6 +1319,13 @@ static int rtrs_srv_get_next_cq_vector(struct rtrs_srv_sess *sess)
 	return sess->cur_cq_vector;
 }
 
+static void rtrs_srv_dev_release(struct device *dev)
+{
+	struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
+
+	kfree(srv);
+}
+
 static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
 				     const uuid_t *paths_uuid)
 {
@@ -1337,6 +1344,7 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
 	srv->queue_depth = sess_queue_depth;
 	srv->ctx = ctx;
 	device_initialize(&srv->dev);
+	srv->dev.release = rtrs_srv_dev_release;
 
 	srv->chunks = kcalloc(srv->queue_depth, sizeof(*srv->chunks),
 			      GFP_KERNEL);
-- 
2.25.1

