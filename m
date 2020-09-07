Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA10E25F7EB
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgIGKWx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgIGKWq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 06:22:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF5C061573
        for <linux-rdma@vger.kernel.org>; Mon,  7 Sep 2020 03:22:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so3375815pjd.3
        for <linux-rdma@vger.kernel.org>; Mon, 07 Sep 2020 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wa8fBi5Qo5Zzyi5r1pxDO78jzMK6KONO0C1w5+zAVPs=;
        b=GEAhx+GQQoepO/xfEET3+dnD4OlqGedFg17Qbv16nPd0ky9vNRAbGeHnKlkLzM24Q+
         KfrtkZxixp1sW3u6nToQXV5W/0rXqr0VDrpTQ+Kh6q06Z023m4tCiFrvEX4zAE6wn8MB
         ZTg0ik8af02hhf782UU0K2LKomXhtdrfEKB3PcQo8FGz1Es5RWVLWp9t56UXUQlEci14
         5UtFrVFZaIwnlDelyE74qXeBwLrFzLah8aIbyXK4ZhxJF2Vyqp8VSqHHFHr6y0Nw7FDi
         Av0xE4d2CFto+8vPdpAZJyHNBFqtQtqnQ7WUEc4AWzfqwAa2/bNskM3kIE7iFubiOGAZ
         7VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wa8fBi5Qo5Zzyi5r1pxDO78jzMK6KONO0C1w5+zAVPs=;
        b=LUimguC/GvHN0DBPYXJlwG7OCzKzPT+mhnuYeETndZhPWc+YEJrHDU1UM2U3G8EMn4
         SV6cMMksW3GKOsUE1qe8fy6+jmLYzfAtjLTkx8pXnzIuI95y+4JZlUznmjxRag2/vJeh
         uyqsHmGGsnEeOqliehRuuMPRuHGZrbDU4cOPekaWr9MhjBQjrZSca9th/R1XHAM/25xX
         indqp9O5HNyI6lV6sisl1Gz1p080MbsSKXtjJD3ohtNhZmqquXR8yVH0bq/6CbKAnDBg
         pzTMcj3XBJbO4KJG/tdergIp1LTj38oi3ocaQUPwkTR5JiPfuOmFKMCjMuYfHOb6RUyH
         Brrw==
X-Gm-Message-State: AOAM532rO1lYyzzHu4OP59o4yOOMv5dHPSu+oDzM1Nd9JPmEfXnqZza5
        NS70/dqjv6JhIVLD666t6LTRHw==
X-Google-Smtp-Source: ABdhPJwrNeRczpE20Wa4NBPaqpRVOTjRR2+kDfxvJk4EzsAUrDur60LPJ2AQfKDV7L8CLn8tHgx+hQ==
X-Received: by 2002:a17:90b:1487:: with SMTP id js7mr19432253pjb.187.1599474163770;
        Mon, 07 Sep 2020 03:22:43 -0700 (PDT)
Received: from nb01533.domain.name ([43.224.130.246])
        by smtp.gmail.com with ESMTPSA id z23sm3868707pfg.220.2020.09.07.03.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 03:22:43 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH v2] RDMA/rtrs-srv: Set .release function for rtrs srv device during device init
Date:   Mon,  7 Sep 2020 15:52:16 +0530
Message-Id: <20200907102216.104041-1-haris.iqbal@cloud.ionos.com>
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

Fixes: baa5b28b7a47 ("RDMA/rtrs-srv: Replace device_register with device_initialize and device_add")
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
Change in v2:
        Use the complete Fixes line

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

