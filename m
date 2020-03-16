Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E98187472
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 22:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbgCPVFF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 17:05:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:36738 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbgCPVFF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 17:05:05 -0400
IronPort-SDR: g5SI/rh922ACtdmPUm4Uw3va/zCfXqBX7HyccXdW03HFKoGCpot1x15VUaz5JE2TRPPVTeMpPV
 PjzMwETKPljA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 14:05:04 -0700
IronPort-SDR: A1Q7c7/6HdoDey7adfLfArf/7T8RMccqHEA/7qqgNy00VJZoWI6hXSCu1OWYJO7xARR8w/tuHD
 egZAFFf3w4WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="417300577"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2020 14:05:03 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02GL52FJ017738;
        Mon, 16 Mar 2020 14:05:03 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02GL50DI007938;
        Mon, 16 Mar 2020 17:05:01 -0400
Subject: [PATCH for-next 2/3] IB/hfi1: Remove kobj from hfi1_devdata
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 16 Mar 2020 17:05:00 -0400
Message-ID: <20200316210500.7753.4145.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

The field kobj was added to hfi1_devdata structure to manage the life
time of the hfi1_devdata structure for PSM accesses:

commit e11ffbd57520 ("IB/hfi1: Do not free hfi1 cdev parent structure early")

Later another mechanism user_refcount/user_comp was introduced to provide the same
functionality:

commit acd7c8fe1493 ("IB/hfi1: Fix an Oops on pci device force remove")

This patch will remove this kobj field, as it is no longer needed.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c |    4 +---
 drivers/infiniband/hw/hfi1/hfi.h      |    2 --
 drivers/infiniband/hw/hfi1/init.c     |   26 ++++----------------------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 2591158..e7fdd70 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -209,7 +209,6 @@ static int hfi1_file_open(struct inode *inode, struct file *fp)
 	fd->mm = current->mm;
 	mmgrab(fd->mm);
 	fd->dd = dd;
-	kobject_get(&fd->dd->kobj);
 	fp->private_data = fd;
 	return 0;
 nomem:
@@ -713,7 +712,6 @@ static int hfi1_file_close(struct inode *inode, struct file *fp)
 	deallocate_ctxt(uctxt);
 done:
 	mmdrop(fdata->mm);
-	kobject_put(&dd->kobj);
 
 	if (atomic_dec_and_test(&dd->user_refcount))
 		complete(&dd->user_comp);
@@ -1696,7 +1694,7 @@ static int user_add(struct hfi1_devdata *dd)
 	snprintf(name, sizeof(name), "%s_%d", class_name(), dd->unit);
 	ret = hfi1_cdev_init(dd->unit, name, &hfi1_file_ops,
 			     &dd->user_cdev, &dd->user_device,
-			     true, &dd->kobj);
+			     true, &dd->verbs_dev.rdi.ibdev.dev.kobj);
 	if (ret)
 		user_remove(dd);
 
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index cae12f4..b06c259 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1413,8 +1413,6 @@ struct hfi1_devdata {
 	bool aspm_enabled;	/* ASPM state: enabled/disabled */
 	struct rhashtable *sdma_rht;
 
-	struct kobject kobj;
-
 	/* vnic data */
 	struct hfi1_vnic_data vnic;
 	/* Lock to protect IRQ SRC register access */
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index e3acda7..3759d92 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1198,13 +1198,13 @@ static void finalize_asic_data(struct hfi1_devdata *dd,
 }
 
 /**
- * hfi1_clean_devdata - cleans up per-unit data structure
+ * hfi1_free_devdata - cleans up and frees per-unit data structure
  * @dd: pointer to a valid devdata structure
  *
- * It cleans up all data structures set up by
+ * It cleans up and frees all data structures set up by
  * by hfi1_alloc_devdata().
  */
-static void hfi1_clean_devdata(struct hfi1_devdata *dd)
+void hfi1_free_devdata(struct hfi1_devdata *dd)
 {
 	struct hfi1_asic_data *ad;
 	unsigned long flags;
@@ -1231,23 +1231,6 @@ static void hfi1_clean_devdata(struct hfi1_devdata *dd)
 	rvt_dealloc_device(&dd->verbs_dev.rdi);
 }
 
-static void __hfi1_free_devdata(struct kobject *kobj)
-{
-	struct hfi1_devdata *dd =
-		container_of(kobj, struct hfi1_devdata, kobj);
-
-	hfi1_clean_devdata(dd);
-}
-
-static struct kobj_type hfi1_devdata_type = {
-	.release = __hfi1_free_devdata,
-};
-
-void hfi1_free_devdata(struct hfi1_devdata *dd)
-{
-	kobject_put(&dd->kobj);
-}
-
 /**
  * hfi1_alloc_devdata - Allocate our primary per-unit data structure.
  * @pdev: Valid PCI device
@@ -1333,11 +1316,10 @@ static struct hfi1_devdata *hfi1_alloc_devdata(struct pci_dev *pdev,
 		goto bail;
 	}
 
-	kobject_init(&dd->kobj, &hfi1_devdata_type);
 	return dd;
 
 bail:
-	hfi1_clean_devdata(dd);
+	hfi1_free_devdata(dd);
 	return ERR_PTR(ret);
 }
 

