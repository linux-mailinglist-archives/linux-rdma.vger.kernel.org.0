Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39ED354E72
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhDFIWg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:22:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15489 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbhDFIWb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:22:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF0nn2MSXzwRN7;
        Tue,  6 Apr 2021 16:20:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 16:22:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/6] RDMA/core: Print the function name by __func__ instead of an fixed string
Date:   Tue, 6 Apr 2021 16:19:39 +0800
Message-ID: <1617697184-48683-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

It's better to use __func__ than a fixed string to print a function's
name.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/ucma.c     |  4 ++--
 drivers/infiniband/core/umem.c     |  4 ++--
 drivers/infiniband/core/user_mad.c | 26 +++++++++++---------------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index da2512c..21dda69 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1708,8 +1708,8 @@ static ssize_t ucma_write(struct file *filp, const char __user *buf,
 	ssize_t ret;
 
 	if (!ib_safe_file_access(filp)) {
-		pr_err_once("ucma_write: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
-			    task_tgid_vnr(current), current->comm);
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			    __func__, task_tgid_vnr(current), current->comm);
 		return -EACCES;
 	}
 
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 2cd6464..cedd03f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -305,8 +305,8 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 	int ret;
 
 	if (offset > umem->length || length > umem->length - offset) {
-		pr_err("ib_umem_copy_from not in range. offset: %zd umem length: %zd end: %zd\n",
-		       offset, umem->length, end);
+		pr_err("%s not in range. offset: %zd umem length: %zd end: %zd\n",
+		       __func__, offset, umem->length, end);
 		return -EINVAL;
 	}
 
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index a183b27..2e90517 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -688,8 +688,7 @@ static int ib_umad_reg_agent(struct ib_umad_file *file, void __user *arg,
 	mutex_lock(&file->mutex);
 
 	if (!file->port->ib_dev) {
-		dev_notice(&file->port->dev,
-			   "ib_umad_reg_agent: invalid device\n");
+		dev_notice(&file->port->dev, "%s: invalid device\n", __func__);
 		ret = -EPIPE;
 		goto out;
 	}
@@ -701,7 +700,7 @@ static int ib_umad_reg_agent(struct ib_umad_file *file, void __user *arg,
 
 	if (ureq.qpn != 0 && ureq.qpn != 1) {
 		dev_notice(&file->port->dev,
-			   "ib_umad_reg_agent: invalid QPN %d specified\n",
+			   "%s: invalid QPN %d specified\n", __func__,
 			   ureq.qpn);
 		ret = -EINVAL;
 		goto out;
@@ -711,9 +710,9 @@ static int ib_umad_reg_agent(struct ib_umad_file *file, void __user *arg,
 		if (!__get_agent(file, agent_id))
 			goto found;
 
-	dev_notice(&file->port->dev,
-		   "ib_umad_reg_agent: Max Agents (%u) reached\n",
+	dev_notice(&file->port->dev, "%s: Max Agents (%u) reached\n", __func__,
 		   IB_UMAD_MAX_AGENTS);
+
 	ret = -ENOMEM;
 	goto out;
 
@@ -790,8 +789,7 @@ static int ib_umad_reg_agent2(struct ib_umad_file *file, void __user *arg)
 	mutex_lock(&file->mutex);
 
 	if (!file->port->ib_dev) {
-		dev_notice(&file->port->dev,
-			   "ib_umad_reg_agent2: invalid device\n");
+		dev_notice(&file->port->dev, "%s: invalid device\n", __func__);
 		ret = -EPIPE;
 		goto out;
 	}
@@ -802,17 +800,16 @@ static int ib_umad_reg_agent2(struct ib_umad_file *file, void __user *arg)
 	}
 
 	if (ureq.qpn != 0 && ureq.qpn != 1) {
-		dev_notice(&file->port->dev,
-			   "ib_umad_reg_agent2: invalid QPN %d specified\n",
-			   ureq.qpn);
+		dev_notice(&file->port->dev, "%s: invalid QPN %d specified\n",
+			   __func__, ureq.qpn);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (ureq.flags & ~IB_USER_MAD_REG_FLAGS_CAP) {
 		dev_notice(&file->port->dev,
-			   "ib_umad_reg_agent2 failed: invalid registration flags specified 0x%x; supported 0x%x\n",
-			   ureq.flags, IB_USER_MAD_REG_FLAGS_CAP);
+			   "%s failed: invalid registration flags specified 0x%x; supported 0x%x\n",
+			   __func__, ureq.flags, IB_USER_MAD_REG_FLAGS_CAP);
 		ret = -EINVAL;
 
 		if (put_user((u32)IB_USER_MAD_REG_FLAGS_CAP,
@@ -827,8 +824,7 @@ static int ib_umad_reg_agent2(struct ib_umad_file *file, void __user *arg)
 		if (!__get_agent(file, agent_id))
 			goto found;
 
-	dev_notice(&file->port->dev,
-		   "ib_umad_reg_agent2: Max Agents (%u) reached\n",
+	dev_notice(&file->port->dev, "%s: Max Agents (%u) reached\n", __func__,
 		   IB_UMAD_MAX_AGENTS);
 	ret = -ENOMEM;
 	goto out;
@@ -840,7 +836,7 @@ static int ib_umad_reg_agent2(struct ib_umad_file *file, void __user *arg)
 		req.mgmt_class_version = ureq.mgmt_class_version;
 		if (ureq.oui & 0xff000000) {
 			dev_notice(&file->port->dev,
-				   "ib_umad_reg_agent2 failed: oui invalid 0x%08x\n",
+				   "%s failed: oui invalid 0x%08x\n", __func__,
 				   ureq.oui);
 			ret = -EINVAL;
 			goto out;
-- 
2.8.1

