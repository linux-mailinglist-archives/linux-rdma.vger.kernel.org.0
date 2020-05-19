Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D71D9316
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgESJQA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 05:16:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38470 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbgESJQA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 05:16:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5EA3BD88627DCCAA9F8F;
        Tue, 19 May 2020 17:15:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 17:15:48 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] RDMA/rtrs: server: fix some error return code
Date:   Tue, 19 May 2020 09:19:12 +0000
Message-ID: <20200519091912.134358-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return negative error code -ENOMEM from the some error handling
cases instead of 0, as done elsewhere in this function.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Fixes: 91b11610af8d ("RDMA/rtrs: server: sysfs interface functions")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 1 +
 2 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ba8ab33b94a2..526433580b96 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -660,8 +660,8 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 					GFP_KERNEL, sess->s.dev->ib_dev,
 					DMA_TO_DEVICE, rtrs_srv_rdma_done);
 			if (!srv_mr->iu) {
-				rtrs_err(ss, "rtrs_iu_alloc(), err: %d\n",
-					  -ENOMEM);
+				err = -ENOMEM;
+				rtrs_err(ss, "rtrs_iu_alloc(), err: %d\n", err);
 				goto free_iu;
 			}
 		}
@@ -2150,8 +2150,10 @@ static int __init rtrs_server_init(void)
 		goto out_chunk_pool;
 	}
 	rtrs_wq = alloc_workqueue("rtrs_server_wq", WQ_MEM_RECLAIM, 0);
-	if (!rtrs_wq)
+	if (!rtrs_wq) {
+		err = -ENOMEM;
 		goto out_dev_class;
+	}
 
 	return 0;

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 0cf015634338..3d7877534bcc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -189,6 +189,7 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 	}
 	srv->kobj_paths = kobject_create_and_add("paths", &srv->dev.kobj);
 	if (!srv->kobj_paths) {
+		err = -ENOMEM;
 		pr_err("kobject_create_and_add(): %d\n", err);
 		device_unregister(&srv->dev);
 		goto unlock;



