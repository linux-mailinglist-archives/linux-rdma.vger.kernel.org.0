Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13ECA187473
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 22:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgCPVFL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 17:05:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:40805 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbgCPVFL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 17:05:11 -0400
IronPort-SDR: IUdYb8hEfonnBb2L2Qx9UoPsHMw9CywTXWDW0tUY2UB1PCrvCw5ogqDZU8c+ZFHvkfm8ilOjFs
 BJJhKc1a3iNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 14:05:10 -0700
IronPort-SDR: 11lPcZN7MYtySgBwW2SIFHqsOs7uVnKAtRHHlLeLx3TqhniT6xCsVgwJP0dad6opF6gUkV3LYI
 d1A2hFVSMaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="417300615"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2020 14:05:10 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02GL59Ox017762;
        Mon, 16 Mar 2020 14:05:09 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02GL57mx007953;
        Mon, 16 Mar 2020 17:05:08 -0400
Subject: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as the
 parent of cdev
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 16 Mar 2020 17:05:07 -0400
Message-ID: <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
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

This patch is implemented to address the concerns raised in:
  https://marc.info/?l=linux-rdma&m=158101337614772&w=2

The hfi1 driver dynammically allocates a struct device to represent the
cdev in sysfs and devtmpfs (/dev/hfi1_x). On the other hand, the
hfi1_devdata already contains a struct device in its ibdev field
(hfi1_devdata.verbs_dev.rdi.ibdev.dev), and it is therefore possible to
eliminate the dynamical allocation when creating the cdev. Since each
device could be added to the sysfs only once and the function
device_add() is already called for the ibdev in ib_register_device(),
the function cdev_device_add() could not be used to create the cdev,
even though the hfi1_devdata contains both cdev and ibdev in the same
structure.

This patch eliminates the dynamic allocation by creating the cdev
first, setting up the ibdev, and then calling the ib_register_device()
to add the device to sysfs and devtmpfs.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/device.c   |   23 ++++++++++++++++-------
 drivers/infiniband/hw/hfi1/file_ops.c |    5 ++---
 drivers/infiniband/hw/hfi1/hfi.h      |    1 -
 drivers/infiniband/hw/hfi1/init.c     |   18 +++++++++---------
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index bbb6069..4e1ad5f 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -79,10 +79,12 @@ int hfi1_cdev_init(int minor, const char *name,
 		goto done;
 	}
 
-	if (user_accessible)
-		device = device_create(user_class, NULL, dev, NULL, "%s", name);
-	else
+	if (user_accessible) {
+		device = kobj_to_dev(parent);
+		device->devt = dev;
+	} else {
 		device = device_create(class, NULL, dev, NULL, "%s", name);
+	}
 
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
@@ -92,20 +94,27 @@ int hfi1_cdev_init(int minor, const char *name,
 		cdev_del(cdev);
 	}
 done:
-	*devp = device;
+	if (devp)
+		*devp = device;
 	return ret;
 }
 
+/*
+ * The pointer devp will be provided only if *devp is allocated
+ * dynamically, as shown in device_create().
+ */
 void hfi1_cdev_cleanup(struct cdev *cdev, struct device **devp)
 {
-	struct device *device = *devp;
+	struct device *device = NULL;
 
+	if (devp)
+		device = *devp;
 	if (device) {
 		device_unregister(device);
 		*devp = NULL;
-
-		cdev_del(cdev);
 	}
+	/* This will also decrement its parent's refcount */
+	cdev_del(cdev);
 }
 
 static const char *hfi1_class_name = "hfi1";
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index e7fdd70..38827e4 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1682,8 +1682,7 @@ static int ctxt_reset(struct hfi1_ctxtdata *uctxt)
 
 static void user_remove(struct hfi1_devdata *dd)
 {
-
-	hfi1_cdev_cleanup(&dd->user_cdev, &dd->user_device);
+	hfi1_cdev_cleanup(&dd->user_cdev, NULL);
 }
 
 static int user_add(struct hfi1_devdata *dd)
@@ -1693,7 +1692,7 @@ static int user_add(struct hfi1_devdata *dd)
 
 	snprintf(name, sizeof(name), "%s_%d", class_name(), dd->unit);
 	ret = hfi1_cdev_init(dd->unit, name, &hfi1_file_ops,
-			     &dd->user_cdev, &dd->user_device,
+			     &dd->user_cdev, NULL,
 			     true, &dd->verbs_dev.rdi.ibdev.dev.kobj);
 	if (ret)
 		user_remove(dd);
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index b06c259..8e63b11 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1084,7 +1084,6 @@ struct hfi1_devdata {
 	struct cdev user_cdev;
 	struct cdev diag_cdev;
 	struct cdev ui_cdev;
-	struct device *user_device;
 	struct device *diag_device;
 	struct device *ui_device;
 
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 3759d92..3c605dd 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1665,6 +1665,10 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* setup vnic */
 	hfi1_vnic_setup(dd);
+	
+	j = hfi1_device_create(dd);
+	if (j)
+		dd_dev_err(dd, "Failed to create /dev devices: %d\n", -j);
 
 	ret = hfi1_register_ib_device(dd);
 
@@ -1680,10 +1684,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		hfi1_dbg_ibdev_init(&dd->verbs_dev);
 	}
 
-	j = hfi1_device_create(dd);
-	if (j)
-		dd_dev_err(dd, "Failed to create /dev devices: %d\n", -j);
-
 	if (initfail || ret) {
 		msix_clean_up_interrupts(dd);
 		stop_timers(dd);
@@ -1700,11 +1700,11 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				ppd->link_wq = NULL;
 			}
 		}
-		if (!j)
-			hfi1_device_remove(dd);
 		if (!ret)
 			hfi1_unregister_ib_device(dd);
 		hfi1_vnic_cleanup(dd);
+		if (!j)
+			hfi1_device_remove(dd);
 		postinit_cleanup(dd);
 		if (initfail)
 			ret = initfail;
@@ -1740,9 +1740,6 @@ static void remove_one(struct pci_dev *pdev)
 	/* close debugfs files before ib unregister */
 	hfi1_dbg_ibdev_exit(&dd->verbs_dev);
 
-	/* remove the /dev hfi1 interface */
-	hfi1_device_remove(dd);
-
 	/* wait for existing user space clients to finish */
 	wait_for_clients(dd);
 
@@ -1751,6 +1748,9 @@ static void remove_one(struct pci_dev *pdev)
 
 	/* cleanup vnic */
 	hfi1_vnic_cleanup(dd);
+	
+	/* remove the /dev hfi1 interface */
+	hfi1_device_remove(dd);
 
 	/*
 	 * Disable the IB link, disable interrupts on the device,

