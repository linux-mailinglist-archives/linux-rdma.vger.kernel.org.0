Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07A62BB8D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 12:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbiKPLYs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 06:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiKPLY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 06:24:28 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733A423E94
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 03:14:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668597271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNiq9I28TaJTiBREtnU7FhSV013Hf/tsOD07ObmZwuQ=;
        b=fHuhgdansuvq0rsDoC+aVQABtyBlRk3I6V4mxOkNcdLolwX9C1DXsKlHcdIo167z4JY4bS
        V008GQbA9xt0yzzwo0cMi8u9SIAtOPf0wAGJshadzN0jaPCawhyHi8BWZ6QZxcmQ8e1K0w
        zh1+YgNoDzEnBDsmZy++ESoG3f1tbqI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 7/8] RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files
Date:   Wed, 16 Nov 2022 19:13:59 +0800
Message-Id: <20221116111400.7203-8-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-1-guoqing.jiang@linux.dev>
References: <20221116111400.7203-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
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

