Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB462BBA6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 12:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiKPL0A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 06:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiKPLY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 06:24:28 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D3101FA
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 03:14:34 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668597273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FHza1rvrmLrZtFWGWRw6X8+BrLZ2Z3GIR74RWWuK+A=;
        b=JzxxZJUmywzuB2tTcFCV/rxqFCef7M8JPm98UsB0nlXUhOwTONbm/hi3oAF+EepCsgP3Rx
        oKXQatHIThdlI2Tb+GePmpPqeMa8/xnejvfTHn3OAdUvd9mZeMuldaXCd7X4JJE76krHHW
        BgeCfrq1F4yiH/ue66FoA3u3KTCQ0TI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 8/8] RDMA/rtrs-srv: Remove kobject_del from rtrs_srv_destroy_once_sysfs_root_folders
Date:   Wed, 16 Nov 2022 19:14:00 +0800
Message-Id: <20221116111400.7203-9-guoqing.jiang@linux.dev>
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

The kobj_paths which is created dynamically by kobject_create_and_add,
and per the comment above kobject_create_and_add, we only need to call
kobject_put which is not same as other kobjs such as stats->kobj_stats
and srv_path->kobj.

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index da8e205ce331..c76ba29da1e2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -203,7 +203,6 @@ rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_path *srv_path)
 
 	mutex_lock(&srv->paths_mutex);
 	if (!--srv->dev_ref) {
-		kobject_del(srv->kobj_paths);
 		kobject_put(srv->kobj_paths);
 		mutex_unlock(&srv->paths_mutex);
 		device_del(&srv->dev);
-- 
2.31.1

