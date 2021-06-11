Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BA3A45E6
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFKQCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 12:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhFKQCm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 12:02:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7C9A613F0;
        Fri, 11 Jun 2021 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623427244;
        bh=LRDhNxzToTeGKfczk5dEy3qOsOGOBiQSUpQHL/KuTLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9j9a5NCIkDnBpZ5MSWVrKkj+0CyHR/VtIXu1zn3o4A03PoOF5DWVOqz2AfTZVcZ6
         Klg7AofzLbQFyaJLs5Lro+/hX+VCSoB1TeXlaZCoCrqt+8Yg729ONsyTA2005sqYhq
         z6ifhbZyAYE3UfpM6LEjSCDIQd5OPlGP1uBgJNtK2gL05sLbEMelI53jQxiDEru5bw
         O6b4VaxIEjw0LDXB7YPs8gcvN7RXZ9rBl9r+hgYENMhVestaPAsHJpDf7DWIYOqgEn
         2Ad1bFE81MVvJiBuah5b3f6pjCycJdf4xUrqXOngB+EMwVwAvEPXrK6+6ZyuZj5C+x
         145f8VL2vZaAw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v2 01/15] RDMA: Split the alloc_hw_stats() ops to port and device variants
Date:   Fri, 11 Jun 2021 19:00:20 +0300
Message-Id: <1955c154197b2a159adc2dc97266ddc74afe420c.1623427137.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623427137.git.leonro@nvidia.com>
References: <cover.1623427137.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This is being used to implement both the port and device global stats,
which is causing some confusion in the drivers. For instance EFA and i40iw
both seem to be misusing the device stats.

Split it into two ops so drivers that don't support one or the other can
leave the op NULL'd, making the calling code a little simpler to
understand.

Tested-by: Gal Pressman <galpress@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c          |  4 +-
 drivers/infiniband/core/device.c            |  3 +-
 drivers/infiniband/core/nldev.c             |  2 +-
 drivers/infiniband/core/sysfs.c             | 10 ++-
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  7 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.h |  4 +-
 drivers/infiniband/hw/bnxt_re/main.c        |  2 +-
 drivers/infiniband/hw/cxgb4/provider.c      |  9 +--
 drivers/infiniband/hw/efa/efa.h             |  3 +-
 drivers/infiniband/hw/efa/efa_main.c        |  3 +-
 drivers/infiniband/hw/efa/efa_verbs.c       | 11 ++-
 drivers/infiniband/hw/hfi1/verbs.c          | 86 ++++++++++-----------
 drivers/infiniband/hw/irdma/verbs.c         | 11 +--
 drivers/infiniband/hw/mlx4/main.c           | 25 ++++--
 drivers/infiniband/hw/mlx5/counters.c       | 42 +++++++---
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  7 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  2 +-
 include/rdma/ib_verbs.h                     | 13 ++--
 19 files changed, 142 insertions(+), 106 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 15493357cfef..df9e6c5e4ddf 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -605,10 +605,10 @@ void rdma_counter_init(struct ib_device *dev)
 		port_counter->mode.mode = RDMA_COUNTER_MODE_NONE;
 		mutex_init(&port_counter->lock);
 
-		if (!dev->ops.alloc_hw_stats)
+		if (!dev->ops.alloc_hw_port_stats)
 			continue;
 
-		port_counter->hstats = dev->ops.alloc_hw_stats(dev, port);
+		port_counter->hstats = dev->ops.alloc_hw_port_stats(dev, port);
 		if (!port_counter->hstats)
 			goto fail;
 	}
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c660cef66ac6..86a16cd7d7fd 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2595,7 +2595,8 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, add_gid);
 	SET_DEVICE_OP(dev_ops, advise_mr);
 	SET_DEVICE_OP(dev_ops, alloc_dm);
-	SET_DEVICE_OP(dev_ops, alloc_hw_stats);
+	SET_DEVICE_OP(dev_ops, alloc_hw_device_stats);
+	SET_DEVICE_OP(dev_ops, alloc_hw_port_stats);
 	SET_DEVICE_OP(dev_ops, alloc_mr);
 	SET_DEVICE_OP(dev_ops, alloc_mr_integrity);
 	SET_DEVICE_OP(dev_ops, alloc_mw);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 34d0cc1a4147..01316926cef6 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2060,7 +2060,7 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 	if (!device)
 		return -EINVAL;
 
-	if (!device->ops.alloc_hw_stats || !device->ops.get_hw_stats) {
+	if (!device->ops.alloc_hw_port_stats || !device->ops.get_hw_stats) {
 		ret = -EINVAL;
 		goto err;
 	}
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 05b702de00e8..d11ceff2b4e4 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -981,8 +981,10 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	struct rdma_hw_stats *stats;
 	int i, ret;
 
-	stats = device->ops.alloc_hw_stats(device, port_num);
-
+	if (port_num)
+		stats = device->ops.alloc_hw_port_stats(device, port_num);
+	else
+		stats = device->ops.alloc_hw_device_stats(device);
 	if (!stats)
 		return;
 
@@ -1165,7 +1167,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	 * port, so holder should be device. Therefore skip per port conunter
 	 * initialization.
 	 */
-	if (device->ops.alloc_hw_stats && port_num && is_full_dev)
+	if (device->ops.alloc_hw_port_stats && port_num && is_full_dev)
 		setup_hw_stats(device, p, port_num);
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
@@ -1409,7 +1411,7 @@ int ib_device_register_sysfs(struct ib_device *device)
 	if (ret)
 		return ret;
 
-	if (device->ops.alloc_hw_stats)
+	if (device->ops.alloc_hw_device_stats)
 		setup_hw_stats(device, NULL, 0);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 3e54e1ae75b4..7ba07797845c 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -234,13 +234,10 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 	return ARRAY_SIZE(bnxt_re_stat_name);
 }
 
-struct rdma_hw_stats *bnxt_re_ib_alloc_hw_stats(struct ib_device *ibdev,
-						u32 port_num)
+struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(bnxt_re_stat_name) != BNXT_RE_NUM_COUNTERS);
-	/* We support only per port stats */
-	if (!port_num)
-		return NULL;
 
 	return rdma_alloc_hw_stats_struct(bnxt_re_stat_name,
 					  ARRAY_SIZE(bnxt_re_stat_name),
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index ede048607d6c..6f2d2f91d9ff 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -96,8 +96,8 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_NUM_COUNTERS
 };
 
-struct rdma_hw_stats *bnxt_re_ib_alloc_hw_stats(struct ib_device *ibdev,
-						u32 port_num);
+struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num);
 int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			    struct rdma_hw_stats *stats,
 			    u32 port, int index);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 58c2a7dfb438..58bd905048ae 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -629,7 +629,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.uverbs_abi_ver = BNXT_RE_ABI_VERSION,
 
 	.add_gid = bnxt_re_add_gid,
-	.alloc_hw_stats = bnxt_re_ib_alloc_hw_stats,
+	.alloc_hw_port_stats = bnxt_re_ib_alloc_hw_port_stats,
 	.alloc_mr = bnxt_re_alloc_mr,
 	.alloc_pd = bnxt_re_alloc_pd,
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 3f1893e180dd..4e453d1dde11 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -377,14 +377,11 @@ static const char * const names[] = {
 	[IP6OUTRSTS] = "ip6OutRsts"
 };
 
-static struct rdma_hw_stats *c4iw_alloc_stats(struct ib_device *ibdev,
-					      u32 port_num)
+static struct rdma_hw_stats *c4iw_alloc_device_stats(struct ib_device *ibdev)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(names) != NR_COUNTERS);
 
-	if (port_num != 0)
-		return NULL;
-
+	/* FIXME: these look like port stats */
 	return rdma_alloc_hw_stats_struct(names, NR_COUNTERS,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
@@ -455,7 +452,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.driver_id = RDMA_DRIVER_CXGB4,
 	.uverbs_abi_ver = C4IW_UVERBS_ABI_VERSION,
 
-	.alloc_hw_stats = c4iw_alloc_stats,
+	.alloc_hw_device_stats = c4iw_alloc_device_stats,
 	.alloc_mr = c4iw_alloc_mr,
 	.alloc_pd = c4iw_allocate_pd,
 	.alloc_ucontext = c4iw_alloc_ucontext,
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index ea322cec27d2..2b8ca099b381 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -157,7 +157,8 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		  int qp_attr_mask, struct ib_udata *udata);
 enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
 					 u32 port_num);
-struct rdma_hw_stats *efa_alloc_hw_stats(struct ib_device *ibdev, u32 port_num);
+struct rdma_hw_stats *efa_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num);
+struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev);
 int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 		     u32 port_num, int index);
 
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 816cfd65b7ac..203e6ddcacbc 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -242,7 +242,8 @@ static const struct ib_device_ops efa_dev_ops = {
 	.driver_id = RDMA_DRIVER_EFA,
 	.uverbs_abi_ver = EFA_UVERBS_ABI_VERSION,
 
-	.alloc_hw_stats = efa_alloc_hw_stats,
+	.alloc_hw_port_stats = efa_alloc_hw_port_stats,
+	.alloc_hw_device_stats = efa_alloc_hw_device_stats,
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
 	.create_cq = efa_create_cq,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 51572f1dc611..be6d3ff0f1be 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1904,13 +1904,22 @@ int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 	return 0;
 }
 
-struct rdma_hw_stats *efa_alloc_hw_stats(struct ib_device *ibdev, u32 port_num)
+struct rdma_hw_stats *efa_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
 {
 	return rdma_alloc_hw_stats_struct(efa_stats_names,
 					  ARRAY_SIZE(efa_stats_names),
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
+struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev)
+{
+	/*
+	 * It is probably a bug that efa reports its port stats as device
+	 * stats
+	 */
+	return efa_alloc_hw_port_stats(ibdev, 0);
+}
+
 int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 		     u32 port_num, int index)
 {
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 554294340caa..85deba07a675 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1693,54 +1693,53 @@ static int init_cntr_names(const char *names_in,
 	return 0;
 }
 
-static struct rdma_hw_stats *alloc_hw_stats(struct ib_device *ibdev,
-					    u32 port_num)
+static int init_counters(struct ib_device *ibdev)
 {
-	int i, err;
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+	int i, err = 0;
 
 	mutex_lock(&cntr_names_lock);
-	if (!cntr_names_initialized) {
-		struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
-
-		err = init_cntr_names(dd->cntrnames,
-				      dd->cntrnameslen,
-				      num_driver_cntrs,
-				      &num_dev_cntrs,
-				      &dev_cntr_names);
-		if (err) {
-			mutex_unlock(&cntr_names_lock);
-			return NULL;
-		}
-
-		for (i = 0; i < num_driver_cntrs; i++)
-			dev_cntr_names[num_dev_cntrs + i] =
-				driver_cntr_names[i];
-
-		err = init_cntr_names(dd->portcntrnames,
-				      dd->portcntrnameslen,
-				      0,
-				      &num_port_cntrs,
-				      &port_cntr_names);
-		if (err) {
-			kfree(dev_cntr_names);
-			dev_cntr_names = NULL;
-			mutex_unlock(&cntr_names_lock);
-			return NULL;
-		}
-		cntr_names_initialized = 1;
+	if (cntr_names_initialized)
+		goto out_unlock;
+
+	err = init_cntr_names(dd->cntrnames, dd->cntrnameslen, num_driver_cntrs,
+			      &num_dev_cntrs, &dev_cntr_names);
+	if (err)
+		goto out_unlock;
+
+	for (i = 0; i < num_driver_cntrs; i++)
+		dev_cntr_names[num_dev_cntrs + i] = driver_cntr_names[i];
+
+	err = init_cntr_names(dd->portcntrnames, dd->portcntrnameslen, 0,
+			      &num_port_cntrs, &port_cntr_names);
+	if (err) {
+		kfree(dev_cntr_names);
+		dev_cntr_names = NULL;
+		goto out_unlock;
 	}
+	cntr_names_initialized = 1;
+
+out_unlock:
 	mutex_unlock(&cntr_names_lock);
+	return err;
+}
 
-	if (!port_num)
-		return rdma_alloc_hw_stats_struct(
-				dev_cntr_names,
-				num_dev_cntrs + num_driver_cntrs,
-				RDMA_HW_STATS_DEFAULT_LIFESPAN);
-	else
-		return rdma_alloc_hw_stats_struct(
-				port_cntr_names,
-				num_port_cntrs,
-				RDMA_HW_STATS_DEFAULT_LIFESPAN);
+static struct rdma_hw_stats *hfi1_alloc_hw_device_stats(struct ib_device *ibdev)
+{
+	if (init_counters(ibdev))
+		return NULL;
+	return rdma_alloc_hw_stats_struct(dev_cntr_names,
+					  num_dev_cntrs + num_driver_cntrs,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static struct rdma_hw_stats *hfi_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num)
+{
+	if (init_counters(ibdev))
+		return NULL;
+	return rdma_alloc_hw_stats_struct(port_cntr_names, num_port_cntrs,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
 static u64 hfi1_sps_ints(void)
@@ -1787,7 +1786,8 @@ static const struct ib_device_ops hfi1_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_HFI1,
 
-	.alloc_hw_stats = alloc_hw_stats,
+	.alloc_hw_device_stats = hfi1_alloc_hw_device_stats,
+	.alloc_hw_port_stats = hfi_alloc_hw_port_stats,
 	.alloc_rdma_netdev = hfi1_vnic_alloc_rn,
 	.get_dev_fw_str = hfi1_get_dev_fw_str,
 	.get_hw_stats = get_hw_stats,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f81371901517..8ecacef8e88c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3727,20 +3727,17 @@ static void irdma_get_dev_fw_str(struct ib_device *dev, char *str)
 }
 
 /**
- * irdma_alloc_hw_stats - Allocate a hw stats structure
+ * irdma_alloc_hw_port_stats - Allocate a hw stats structure
  * @ibdev: device pointer from stack
  * @port_num: port number
  */
-static struct rdma_hw_stats *irdma_alloc_hw_stats(struct ib_device *ibdev,
-						  u32 port_num)
+static struct rdma_hw_stats *irdma_alloc_hw_port_stats(struct ib_device *ibdev,
+						       u32 port_num)
 {
 	int num_counters = IRDMA_HW_STAT_INDEX_MAX_32 +
 			   IRDMA_HW_STAT_INDEX_MAX_64;
 	unsigned long lifespan = RDMA_HW_STATS_DEFAULT_LIFESPAN;
 
-	if (!port_num)
-		return NULL;
-
 	BUILD_BUG_ON(ARRAY_SIZE(irdma_hw_stat_names) !=
 		     (IRDMA_HW_STAT_INDEX_MAX_32 + IRDMA_HW_STAT_INDEX_MAX_64));
 
@@ -4354,7 +4351,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.driver_id = RDMA_DRIVER_IRDMA,
 	.uverbs_abi_ver = IRDMA_ABI_VER,
 
-	.alloc_hw_stats = irdma_alloc_hw_stats,
+	.alloc_hw_port_stats = irdma_alloc_hw_port_stats,
 	.alloc_mr = irdma_alloc_mr,
 	.alloc_mw = irdma_alloc_mw,
 	.alloc_pd = irdma_alloc_pd,
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 22898d97ecbd..341162aa2175 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2105,17 +2105,29 @@ static const struct diag_counter diag_device_only[] = {
 	DIAG_COUNTER(rq_num_udsdprd, 0x118),
 };
 
-static struct rdma_hw_stats *mlx4_ib_alloc_hw_stats(struct ib_device *ibdev,
-						    u32 port_num)
+static struct rdma_hw_stats *
+mlx4_ib_alloc_hw_device_stats(struct ib_device *ibdev)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
 	struct mlx4_ib_diag_counters *diag = dev->diag_counters;
 
-	if (!diag[!!port_num].name)
+	if (!diag[0].name)
 		return NULL;
 
-	return rdma_alloc_hw_stats_struct(diag[!!port_num].name,
-					  diag[!!port_num].num_counters,
+	return rdma_alloc_hw_stats_struct(diag[0].name, diag[0].num_counters,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static struct rdma_hw_stats *
+mlx4_ib_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
+{
+	struct mlx4_ib_dev *dev = to_mdev(ibdev);
+	struct mlx4_ib_diag_counters *diag = dev->diag_counters;
+
+	if (!diag[1].name)
+		return NULL;
+
+	return rdma_alloc_hw_stats_struct(diag[1].name, diag[1].num_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
@@ -2206,7 +2218,8 @@ static void mlx4_ib_fill_diag_counters(struct mlx4_ib_dev *ibdev,
 }
 
 static const struct ib_device_ops mlx4_ib_hw_stats_ops = {
-	.alloc_hw_stats = mlx4_ib_alloc_hw_stats,
+	.alloc_hw_device_stats = mlx4_ib_alloc_hw_device_stats,
+	.alloc_hw_port_stats = mlx4_ib_alloc_hw_port_stats,
 	.get_hw_stats = mlx4_ib_get_hw_stats,
 };
 
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index e365341057cb..224ba36f2946 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -161,22 +161,29 @@ u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u32 port_num)
 	return cnts->set_id;
 }
 
-static struct rdma_hw_stats *mlx5_ib_alloc_hw_stats(struct ib_device *ibdev,
-						    u32 port_num)
+static struct rdma_hw_stats *
+mlx5_ib_alloc_hw_device_stats(struct ib_device *ibdev)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	const struct mlx5_ib_counters *cnts;
-	bool is_switchdev = is_mdev_switchdev_mode(dev->mdev);
+	const struct mlx5_ib_counters *cnts = &dev->port[0].cnts;
 
-	if ((is_switchdev && port_num) || (!is_switchdev && !port_num))
-		return NULL;
+	return rdma_alloc_hw_stats_struct(cnts->names,
+					  cnts->num_q_counters +
+						  cnts->num_cong_counters +
+						  cnts->num_ext_ppcnt_counters,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
 
-	cnts = get_counters(dev, port_num - 1);
+static struct rdma_hw_stats *
+mlx5_ib_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+	const struct mlx5_ib_counters *cnts = &dev->port[port_num - 1].cnts;
 
 	return rdma_alloc_hw_stats_struct(cnts->names,
 					  cnts->num_q_counters +
-					  cnts->num_cong_counters +
-					  cnts->num_ext_ppcnt_counters,
+						  cnts->num_cong_counters +
+						  cnts->num_ext_ppcnt_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
@@ -666,7 +673,17 @@ void mlx5_ib_counters_clear_description(struct ib_counters *counters)
 }
 
 static const struct ib_device_ops hw_stats_ops = {
-	.alloc_hw_stats = mlx5_ib_alloc_hw_stats,
+	.alloc_hw_port_stats = mlx5_ib_alloc_hw_port_stats,
+	.get_hw_stats = mlx5_ib_get_hw_stats,
+	.counter_bind_qp = mlx5_ib_counter_bind_qp,
+	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
+	.counter_dealloc = mlx5_ib_counter_dealloc,
+	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
+	.counter_update_stats = mlx5_ib_counter_update_stats,
+};
+
+static const struct ib_device_ops hw_switchdev_stats_ops = {
+	.alloc_hw_device_stats = mlx5_ib_alloc_hw_device_stats,
 	.get_hw_stats = mlx5_ib_get_hw_stats,
 	.counter_bind_qp = mlx5_ib_counter_bind_qp,
 	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
@@ -690,7 +707,10 @@ int mlx5_ib_counters_init(struct mlx5_ib_dev *dev)
 	if (!MLX5_CAP_GEN(dev->mdev, max_qp_cnt))
 		return 0;
 
-	ib_set_device_ops(&dev->ib_dev, &hw_stats_ops);
+	if (is_mdev_switchdev_mode(dev->mdev))
+		ib_set_device_ops(&dev->ib_dev, &hw_switchdev_stats_ops);
+	else
+		ib_set_device_ops(&dev->ib_dev, &hw_stats_ops);
 	return mlx5_ib_alloc_counters(dev);
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index f469fd1c753d..d5ceb706d964 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -40,13 +40,10 @@ int rxe_ib_get_hw_stats(struct ib_device *ibdev,
 	return ARRAY_SIZE(rxe_counter_name);
 }
 
-struct rdma_hw_stats *rxe_ib_alloc_hw_stats(struct ib_device *ibdev,
-					    u32 port_num)
+struct rdma_hw_stats *rxe_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						 u32 port_num)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(rxe_counter_name) != RXE_NUM_OF_COUNTERS);
-	/* We support only per port stats */
-	if (!port_num)
-		return NULL;
 
 	return rdma_alloc_hw_stats_struct(rxe_counter_name,
 					  ARRAY_SIZE(rxe_counter_name),
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 2f369acb46d7..71f4d4fa9dc8 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -29,8 +29,8 @@ enum rxe_counters {
 	RXE_NUM_OF_COUNTERS
 };
 
-struct rdma_hw_stats *rxe_ib_alloc_hw_stats(struct ib_device *ibdev,
-					    u32 port_num);
+struct rdma_hw_stats *rxe_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						 u32 port_num);
 int rxe_ib_get_hw_stats(struct ib_device *ibdev,
 			struct rdma_hw_stats *stats,
 			u32 port, int index);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 33731b5dd9c3..d3df59d897a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1104,7 +1104,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.driver_id = RDMA_DRIVER_RXE,
 	.uverbs_abi_ver = RXE_UVERBS_ABI_VERSION,
 
-	.alloc_hw_stats = rxe_ib_alloc_hw_stats,
+	.alloc_hw_port_stats = rxe_ib_alloc_hw_port_stats,
 	.alloc_mr = rxe_alloc_mr,
 	.alloc_pd = rxe_alloc_pd,
 	.alloc_ucontext = rxe_alloc_ucontext,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 05dbc216eb64..849a06441e29 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2522,13 +2522,14 @@ struct ib_device_ops {
 			    unsigned int *meta_sg_offset);
 
 	/**
-	 * alloc_hw_stats - Allocate a struct rdma_hw_stats and fill in the
-	 *   driver initialized data.  The struct is kfree()'ed by the sysfs
-	 *   core when the device is removed.  A lifespan of -1 in the return
-	 *   struct tells the core to set a default lifespan.
+	 * alloc_hw_[device,port]_stats - Allocate a struct rdma_hw_stats and
+	 *   fill in the driver initialized data.  The struct is kfree()'ed by
+	 *   the sysfs core when the device is removed.  A lifespan of -1 in the
+	 *   return struct tells the core to set a default lifespan.
 	 */
-	struct rdma_hw_stats *(*alloc_hw_stats)(struct ib_device *device,
-						u32 port_num);
+	struct rdma_hw_stats *(*alloc_hw_device_stats)(struct ib_device *device);
+	struct rdma_hw_stats *(*alloc_hw_port_stats)(struct ib_device *device,
+						     u32 port_num);
 	/**
 	 * get_hw_stats - Fill in the counter value(s) in the stats struct.
 	 * @index - The index in the value array we wish to have updated, or
-- 
2.31.1

