Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D980626D3D
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiKMBJB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiKMBI7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:59 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99518BCBE
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yq7ZFSi9lzPjjs62wkYKSpTdxeGjz5TAGbakjVWInAE=;
        b=RSFKl5HyKDJEb83bm6ZAzxFB9wR/U7E7ijr06pJ4LneM9gXyL4VPXm1hYIIiLzd/MyAsvh
        9VluQOZAzBbpCbAlCKD/m7BQ9wOsWcFsiyGdQXxMaw3DdDAWiaUkyaGWHOfP+PEJR2+X7G
        AC1rKMhMmnaWoWH4Kelf2GnDKgQEaEw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 11/12] RDMA/rtrs-srv: fix several issues in rtrs_srv_destroy_path_files
Date:   Sun, 13 Nov 2022 09:08:22 +0800
Message-Id: <20221113010823.6436-12-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are several issues in the function which is supposed to be paired
with rtrs_srv_create_path_files.

1. rtrs_srv_stats_attr_group is not removed though it is created in
   rtrs_srv_create_stats_files.

2. it makes more sense to check kobj_stats.state_in_sysfs before destroy
   kobj_stats instead of rely on kobj.state_in_sysfs.

3. kobject_init_and_add is used for both kobjs (srv_path->kobj and
   srv_path->stats->kobj_stats), however we missed to call kobject_del
   for srv_path->kobj which was called in free_path.

4. rtrs_srv_destroy_once_sysfs_root_folders is independant of either
   kobj or kobj_stats.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 2a3c9ac64a42..da8e205ce331 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -304,12 +304,18 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 
 void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
 {
-	if (srv_path->kobj.state_in_sysfs) {
+	if (srv_path->stats->kobj_stats.state_in_sysfs) {
+		sysfs_remove_group(&srv_path->stats->kobj_stats,
+				   &rtrs_srv_stats_attr_group);
 		kobject_del(&srv_path->stats->kobj_stats);
 		kobject_put(&srv_path->stats->kobj_stats);
+	}
+
+	if (srv_path->kobj.state_in_sysfs) {
 		sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
+		kobject_del(&srv_path->kobj);
 		kobject_put(&srv_path->kobj);
-
-		rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
 	}
+
+	rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
 }
-- 
2.31.1

