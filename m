Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29A26BA2D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIPC3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 22:29:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbgIPC14 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 22:27:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75EA3D67445B38ACBA36;
        Wed, 16 Sep 2020 10:27:54 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:46 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] infiniband: ipoib: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:22 +0800
Message-ID: <20200916025022.3992627-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_fs.c | 50 ++-----------------------
 1 file changed, 4 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_fs.c b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
index 64c19f6fa931..12ba7a0fe0b5 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -124,35 +124,14 @@ static int ipoib_mcg_seq_show(struct seq_file *file, void *iter_ptr)
 	return 0;
 }
 
-static const struct seq_operations ipoib_mcg_seq_ops = {
+static const struct seq_operations ipoib_mcg_sops = {
 	.start = ipoib_mcg_seq_start,
 	.next  = ipoib_mcg_seq_next,
 	.stop  = ipoib_mcg_seq_stop,
 	.show  = ipoib_mcg_seq_show,
 };
 
-static int ipoib_mcg_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &ipoib_mcg_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private;
-
-	return 0;
-}
-
-static const struct file_operations ipoib_mcg_fops = {
-	.owner   = THIS_MODULE,
-	.open    = ipoib_mcg_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
+DEFINE_SEQ_ATTRIBUTE(ipoib_mcg);
 
 static void *ipoib_path_seq_start(struct seq_file *file, loff_t *pos)
 {
@@ -229,35 +208,14 @@ static int ipoib_path_seq_show(struct seq_file *file, void *iter_ptr)
 	return 0;
 }
 
-static const struct seq_operations ipoib_path_seq_ops = {
+static const struct seq_operations ipoib_path_sops = {
 	.start = ipoib_path_seq_start,
 	.next  = ipoib_path_seq_next,
 	.stop  = ipoib_path_seq_stop,
 	.show  = ipoib_path_seq_show,
 };
 
-static int ipoib_path_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &ipoib_path_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private;
-
-	return 0;
-}
-
-static const struct file_operations ipoib_path_fops = {
-	.owner   = THIS_MODULE,
-	.open    = ipoib_path_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
+DEFINE_SEQ_ATTRIBUTE(ipoib_path);
 
 void ipoib_create_debug_files(struct net_device *dev)
 {
-- 
2.25.1

