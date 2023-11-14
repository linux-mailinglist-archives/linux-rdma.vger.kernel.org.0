Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889EE7EAFF4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjKNMiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Nov 2023 07:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjKNMiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Nov 2023 07:38:22 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4913A;
        Tue, 14 Nov 2023 04:38:18 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SV5Ls1SrQzMmPj;
        Tue, 14 Nov 2023 20:33:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 20:38:15 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Add debugfs to hns RoCE
Date:   Tue, 14 Nov 2023 20:34:48 +0800
Message-ID: <20231114123449.1106162-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
References: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add debugfs to hns RoCE. This patch only adds an empty directory
"hns_roce" to debugs root directory.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/Makefile           |  3 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 63 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h | 27 +++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h  |  2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  2 +
 drivers/infiniband/hw/hns/hns_roce_main.c    |  3 +
 6 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_debugfs.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_debugfs.h

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index a7d259238305..be1e1cdbcfa8 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -7,7 +7,8 @@ ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
 hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
-	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
+	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o \
+	hns_roce_debugfs.o
 
 ifdef CONFIG_INFINIBAND_HNS_HIP08
 hns-roce-hw-v2-objs := hns_roce_hw_v2.o $(hns-roce-objs)
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
new file mode 100644
index 000000000000..79825570cc35
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Hisilicon Limited.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+
+#include "hns_roce_device.h"
+
+static struct dentry *hns_roce_dbgfs_root;
+
+static int hns_debugfs_seqfile_open(struct inode *inode, struct file *f)
+{
+	struct hns_debugfs_seqfile *seqfile = inode->i_private;
+
+	return single_open(f, seqfile->read, seqfile->data);
+}
+
+static const struct file_operations hns_debugfs_seqfile_fops = {
+	.owner = THIS_MODULE,
+	.open = hns_debugfs_seqfile_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek
+};
+
+static void init_debugfs_seqfile(struct hns_debugfs_seqfile *seq,
+				 const char *name, struct dentry *parent,
+				 int (*read_fn)(struct seq_file *, void *),
+				 void *data)
+{
+	debugfs_create_file(name, 0400, parent, seq, &hns_debugfs_seqfile_fops);
+
+	seq->read = read_fn;
+	seq->data = data;
+}
+
+/* debugfs for device */
+void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_dev_debugfs *dbgfs = &hr_dev->dbgfs;
+
+	dbgfs->root = debugfs_create_dir(dev_name(&hr_dev->ib_dev.dev),
+					 hns_roce_dbgfs_root);
+}
+
+void hns_roce_unregister_debugfs(struct hns_roce_dev *hr_dev)
+{
+	debugfs_remove_recursive(hr_dev->dbgfs.root);
+}
+
+/* debugfs for hns module */
+void hns_roce_init_debugfs(void)
+{
+	hns_roce_dbgfs_root = debugfs_create_dir("hns_roce", NULL);
+}
+
+void hns_roce_cleanup_debugfs(void)
+{
+	debugfs_remove_recursive(hns_roce_dbgfs_root);
+	hns_roce_dbgfs_root = NULL;
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.h b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
new file mode 100644
index 000000000000..ece71fe6730c
--- /dev/null
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Hisilicon Limited.
+ */
+
+#ifndef __HNS_ROCE_DEBUGFS_H
+#define __HNS_ROCE_DEBUGFS_H
+
+/* debugfs seqfile */
+struct hns_debugfs_seqfile {
+	int (*read)(struct seq_file *seq, void *data);
+	void *data;
+};
+
+/* Debugfs for device */
+struct hns_roce_dev_debugfs {
+	struct dentry *root;
+};
+
+struct hns_roce_dev;
+
+void hns_roce_init_debugfs(void);
+void hns_roce_cleanup_debugfs(void);
+void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev);
+void hns_roce_unregister_debugfs(struct hns_roce_dev *hr_dev);
+
+#endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1627f3b0ef28..a847cdfb4ad6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -35,6 +35,7 @@
 
 #include <rdma/ib_verbs.h>
 #include <rdma/hns-abi.h>
+#include "hns_roce_debugfs.h"
 
 #define PCI_REVISION_ID_HIP08			0x21
 #define PCI_REVISION_ID_HIP09			0x30
@@ -979,6 +980,7 @@ struct hns_roce_dev {
 	u32 is_vf;
 	u32 cong_algo_tmpl_id;
 	u64 dwqe_page;
+	struct hns_roce_dev_debugfs dbgfs;
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c01307be06ab..8a5432bb0e85 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6958,12 +6958,14 @@ static struct hnae3_client hns_roce_hw_v2_client = {
 
 static int __init hns_roce_hw_v2_init(void)
 {
+	hns_roce_init_debugfs();
 	return hnae3_register_client(&hns_roce_hw_v2_client);
 }
 
 static void __exit hns_roce_hw_v2_exit(void)
 {
 	hnae3_unregister_client(&hns_roce_hw_v2_client);
+	hns_roce_cleanup_debugfs();
 }
 
 module_init(hns_roce_hw_v2_init);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index a4a10a4e1aab..c9f93ba522c9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -1079,6 +1079,8 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 	if (ret)
 		goto error_failed_register_device;
 
+	hns_roce_register_debugfs(hr_dev);
+
 	return 0;
 
 error_failed_register_device:
@@ -1108,6 +1110,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 
 void hns_roce_exit(struct hns_roce_dev *hr_dev)
 {
+	hns_roce_unregister_debugfs(hr_dev);
 	hns_roce_unregister_device(hr_dev);
 
 	if (hr_dev->hw->hw_exit)
-- 
2.30.0

