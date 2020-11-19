Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AF22B8F16
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Nov 2020 10:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgKSJfk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 04:35:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7953 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgKSJfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Nov 2020 04:35:40 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CcF0H3yPvzhYrk
        for <linux-rdma@vger.kernel.org>; Thu, 19 Nov 2020 17:35:27 +0800 (CST)
Received: from DESKTOP-9883QJJ.china.huawei.com (10.136.114.155) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 17:35:30 +0800
From:   zhudi <zhudi21@huawei.com>
To:     <jgg@ziepe.ca>, <faisal.latif@intel.com>, <shiraz.saleem@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <zhudi21@huawei.com>,
        <rose.chen@huawei.com>
Subject: [PATCH] RDMA/i40iw: Fix a mmap handler exploitation
Date:   Thu, 19 Nov 2020 17:35:23 +0800
Message-ID: <20201119093523.7588-1-zhudi21@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.114.155]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Di Zhu <zhudi21@huawei.com>

Notice that i40iw_mmap() is used as mmap for file
/dev/infiniband/uverbs%d and these files have access mode
with 0666 specified by uverbs_devnode() and vma->vm_pgoff
is directly used to calculate pfn which is passed in
remap_pfn_range function without any valid validation.

This would result in a malicious process being able to pass an arbitrary
physical address to ‘mmap’ which would allow for access to all of
kernel memory from user space and eventually gain root privileges.

So, we should check whether final calculated value of vm_pgoff is
in range of specified pci resource before we use it to calculate
pfn which is passed in remap_pfn_range

Signed-off-by: Di Zhu <zhudi21@huawei.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 5ad381800f4d..7ec8f221eadb 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -185,6 +185,10 @@ static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 	vma->vm_pgoff += db_addr_offset >> PAGE_SHIFT;
 
+	if (vma->vm_pgoff >
+		pci_resource_len(ucontext->iwdev->ldev->pcidev, 0) >> PAGE_SHIFT)
+		return -EINVAL;
+
 	if (vma->vm_pgoff == (db_addr_offset >> PAGE_SHIFT)) {
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	} else {
-- 
2.23.0

