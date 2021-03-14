Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D533A507
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Mar 2021 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhCNNjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Mar 2021 09:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhCNNjR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Mar 2021 09:39:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4A2E64EB3;
        Sun, 14 Mar 2021 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615729157;
        bh=yT+j1Q4zKkPqCjzmtG6o8k4merXnzv/mBDjKspZBM8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcL95cPBgHs9Du7cdog6XzlJvftIVqR9JNpaJlTs225i0GplnBhDop8kHeiSQcCGn
         v7d56YtHkD8Gyn1SyK5rmHDGepJpI6r69Q0NPPYB7ooWsPNqPqA+hBjPmImfO2zB5j
         4gntGeFdLIrt/9PhGLNnqh1M9NOm361CU/AnuPtohC30NbTnruLJDuCFXkEK/VRvWK
         +kGbymGkKqwi7i85k9VLtTVq0DomkGkUJEXJQ+pvglYRwPvmsb4SpxlApcNYL5CIfI
         fDS6/vHm2fEH5a3Vkuqcxav8i/FWRY2+W7UfNFAn98MEHU479gzb+KmQWlOKirKmHT
         ZFPWfnjqT6xuQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH rdma-next 1/2] RDMA: Fix kernel-doc compilation warnings
Date:   Sun, 14 Mar 2021 15:39:07 +0200
Message-Id: <20210314133908.291945-2-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314133908.291945-1-leon@kernel.org>
References: <20210314133908.291945-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

This patch fixes bunch of kernel-doc compilation warnings like below:

 drivers/infiniband/hw/i40iw/i40iw_cm.c:4372: warning: expecting
 prototype for i40iw_ifdown_notify(). Prototype was for i40iw_if_notify()
 instead

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/chip.c            |  4 ++--
 drivers/infiniband/hw/hfi1/driver.c          |  2 +-
 drivers/infiniband/hw/hfi1/exp_rcv.c         |  6 +++---
 drivers/infiniband/hw/hfi1/init.c            |  3 ++-
 drivers/infiniband/hw/hfi1/msix.c            | 12 ++++++------
 drivers/infiniband/hw/hfi1/netdev_rx.c       |  2 +-
 drivers/infiniband/hw/hfi1/sdma.c            |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c       |  4 ++--
 drivers/infiniband/hw/i40iw/i40iw_hmc.c      |  4 ++--
 drivers/infiniband/hw/i40iw/i40iw_main.c     |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.c     |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c    |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |  4 ++--
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c |  2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c     |  5 +++--
 drivers/infiniband/hw/qib/qib_iba6120.c      |  2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c      |  4 ++--
 drivers/infiniband/hw/qib/qib_iba7322.c      |  4 ++--
 drivers/infiniband/hw/qib/qib_init.c         |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  2 +-
 20 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 993cbf37e0b9..a1565223e3a7 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1322,7 +1322,7 @@ CNTR_ELEM(#name, \
 	  access_ibp_##cntr)
 
 /**
- * hfi_addr_from_offset - return addr for readq/writeq
+ * hfi1_addr_from_offset - return addr for readq/writeq
  * @dd: the dd device
  * @offset: the offset of the CSR within bar0
  *
@@ -8316,7 +8316,7 @@ static void is_interrupt(struct hfi1_devdata *dd, unsigned int source)
 }
 
 /**
- * gerneral_interrupt() -  General interrupt handler
+ * general_interrupt -  General interrupt handler
  * @irq: MSIx IRQ vector
  * @data: hfi1 devdata
  *
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 0b64aa87ab73..f88bb4af245f 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1026,7 +1026,7 @@ static bool __set_armed_to_active(struct hfi1_packet *packet)
 }
 
 /**
- * armed to active - the fast path for armed to active
+ * set_armed_to_active  - the fast path for armed to active
  * @packet: the packet structure
  *
  * Return true if packet processing needs to bail.
diff --git a/drivers/infiniband/hw/hfi1/exp_rcv.c b/drivers/infiniband/hw/hfi1/exp_rcv.c
index 91f13140ddf2..a414214f6035 100644
--- a/drivers/infiniband/hw/hfi1/exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/exp_rcv.c
@@ -49,7 +49,7 @@
 #include "trace.h"
 
 /**
- * exp_tid_group_init - initialize exp_tid_set
+ * hfi1_exp_tid_set_init - initialize exp_tid_set
  * @set: the set
  */
 static void hfi1_exp_tid_set_init(struct exp_tid_set *set)
@@ -70,7 +70,7 @@ void hfi1_exp_tid_group_init(struct hfi1_ctxtdata *rcd)
 }
 
 /**
- * alloc_ctxt_rcv_groups - initialize expected receive groups
+ * hfi1_alloc_ctxt_rcv_groups - initialize expected receive groups
  * @rcd: the context to add the groupings to
  */
 int hfi1_alloc_ctxt_rcv_groups(struct hfi1_ctxtdata *rcd)
@@ -100,7 +100,7 @@ int hfi1_alloc_ctxt_rcv_groups(struct hfi1_ctxtdata *rcd)
 }
 
 /**
- * free_ctxt_rcv_groups - free  expected receive groups
+ * hfi1_free_ctxt_rcv_groups - free  expected receive groups
  * @rcd: the context to free
  *
  * The routine dismantles the expect receive linked
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 48e9c8af579a..e84245482e62 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1852,7 +1852,8 @@ int hfi1_create_rcvhdrq(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 }
 
 /**
- * allocate eager buffers, both kernel and user contexts.
+ * hfi1_setup_eagerbufs - llocate eager buffers, both kernel and user
+ * contexts.
  * @rcd: the context we are setting up.
  *
  * Allocate the eager TID buffers and program them into hip.
diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index cf3040bb177f..57a5f02ebc77 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -206,7 +206,7 @@ int msix_request_rcd_irq(struct hfi1_ctxtdata *rcd)
 }
 
 /**
- * msix_request_rcd_irq() - Helper function for RCVAVAIL IRQs
+ * msix_netdev_request_rcd_irq  - Helper function for RCVAVAIL IRQs
  * for netdev context
  * @rcd: valid netdev contexti
  */
@@ -221,7 +221,7 @@ int msix_netdev_request_rcd_irq(struct hfi1_ctxtdata *rcd)
 }
 
 /**
- * msix_request_smda_ira() - Helper for getting SDMA IRQ resources
+ * msix_request_sdma_irq  - Helper for getting SDMA IRQ resources
  * @sde: valid sdma engine
  *
  */
@@ -243,7 +243,7 @@ int msix_request_sdma_irq(struct sdma_engine *sde)
 }
 
 /**
- * msix_request_general_irq(void) - Helper for getting general IRQ
+ * msix_request_general_irq - Helper for getting general IRQ
  * resources
  * @dd: valid device data
  */
@@ -269,7 +269,7 @@ int msix_request_general_irq(struct hfi1_devdata *dd)
 }
 
 /**
- * enable_sdma_src() - Helper to enable SDMA IRQ srcs
+ * enable_sdma_srcs - Helper to enable SDMA IRQ srcs
  * @dd: valid devdata structure
  * @i: index of SDMA engine
  */
@@ -349,7 +349,7 @@ void msix_free_irq(struct hfi1_devdata *dd, u8 msix_intr)
 }
 
 /**
- * hfi1_clean_up_msix_interrupts() - Free all MSIx IRQ resources
+ * msix_clean_up_interrupts  - Free all MSIx IRQ resources
  * @dd: valid device data data structure
  *
  * Free the MSIx and associated PCI resources, if they have been allocated.
@@ -372,7 +372,7 @@ void msix_clean_up_interrupts(struct hfi1_devdata *dd)
 }
 
 /**
- * msix_netdev_syncrhonize_irq() - netdev IRQ synchronize
+ * msix_netdev_synchronize_irq - netdev IRQ synchronize
  * @dd: valid devdata
  */
 void msix_netdev_synchronize_irq(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 1fb6e1a0e4e1..2c8bc02ef6df 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -464,7 +464,7 @@ void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id)
 }
 
 /**
- * hfi1_netdev_get_first_dat - Gets first entry with greater or equal id.
+ * hfi1_netdev_get_first_data - Gets first entry with greater or equal id.
  *
  * @dd: hfi1 dev data
  * @start_id: requested integer id up to INT_MAX
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 46b5290b2839..1fcc6e9666e0 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1285,7 +1285,7 @@ int sdma_map_init(struct hfi1_devdata *dd, u8 port, u8 num_vls, u8 *vl_engines)
 }
 
 /**
- * sdma_clean()  Clean up allocated memory
+ * sdma_clean - Clean up allocated memory
  * @dd:          struct hfi1_devdata
  * @num_engines: num sdma engines
  *
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index ac65c8237b2e..2450b7dd51f6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -905,7 +905,7 @@ static int i40iw_send_mpa_reject(struct i40iw_cm_node *cm_node,
 }
 
 /**
- * recv_mpa - process an IETF MPA frame
+ * i40iw_parse_mpa - process an IETF MPA frame
  * @cm_node: connection's node
  * @buffer: Data pointer
  * @type: to return accept or reject
@@ -4360,7 +4360,7 @@ void i40iw_cm_teardown_connections(struct i40iw_device *iwdev, u32 *ipaddr,
 }
 
 /**
- * i40iw_ifdown_notify - process an ifdown on an interface
+ * i40iw_if_notify - process an ifdown on an interface
  * @iwdev: device pointer
  * @netdev: network interface device structure
  * @ipaddr: Pointer to IPv4 or IPv6 address
diff --git a/drivers/infiniband/hw/i40iw/i40iw_hmc.c b/drivers/infiniband/hw/i40iw/i40iw_hmc.c
index 8bd72af9e099..b44bfc1d239b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hmc.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hmc.c
@@ -285,7 +285,7 @@ static enum i40iw_status_code i40iw_hmc_finish_add_sd_reg(struct i40iw_sc_dev *d
 }
 
 /**
- * i40iw_create_iw_hmc_obj - allocate backing store for hmc objects
+ * i40iw_sc_create_hmc_obj - allocate backing store for hmc objects
  * @dev: pointer to the device structure
  * @info: pointer to i40iw_hmc_iw_create_obj_info struct
  *
@@ -434,7 +434,7 @@ static enum i40iw_status_code i40iw_finish_del_sd_reg(struct i40iw_sc_dev *dev,
 }
 
 /**
- * i40iw_del_iw_hmc_obj - remove pe hmc objects
+ * i40iw_sc_del_hmc_obj - remove pe hmc objects
  * @dev: pointer to the device structure
  * @info: pointer to i40iw_hmc_del_obj_info struct
  * @reset: true if called before reset
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index ab4cb11950dc..2ebcbb1ddaa2 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -251,7 +251,7 @@ static void i40iw_destroy_cqp(struct i40iw_device *iwdev, bool free_hwcqp)
 }
 
 /**
- * i40iw_disable_irqs - disable device interrupts
+ * i40iw_disable_irq - disable device interrupts
  * @dev: hardware control device structure
  * @msix_vec: msix vector to disable irq
  * @dev_id: parameter to pass to free_irq (used during irq setup)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.c b/drivers/infiniband/hw/i40iw/i40iw_puda.c
index d1c8cc0a6236..88fb68e866ba 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -1000,7 +1000,7 @@ static void i40iw_ilq_putback_rcvbuf(struct i40iw_sc_qp *qp, u32 wqe_idx)
 }
 
 /**
- * i40iw_ieq_get_fpdu - given length return fpdu length
+ * i40iw_ieq_get_fpdu_length - given length return fpdu length
  * @length: length if fpdu
  */
 static u16 i40iw_ieq_get_fpdu_length(u16 length)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index 76f052b12c14..9ff825f7860b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -890,7 +890,7 @@ void i40iw_terminate_done(struct i40iw_sc_qp *qp, int timeout_occurred)
 }
 
 /**
- * i40iw_terminate_imeout - timeout happened
+ * i40iw_terminate_timeout - timeout happened
  * @t: points to iwarp qp
  */
 static void i40iw_terminate_timeout(struct timer_list *t)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 1a88a9e2a785..b876d722fcc8 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -647,7 +647,7 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 }
 
 /**
- * i40iw_query - query qp attributes
+ * i40iw_query_qp - query qp attributes
  * @ibqp: qp pointer
  * @attr: attributes pointer
  * @attr_mask: Not used
@@ -1846,7 +1846,7 @@ static struct ib_mr *i40iw_get_dma_mr(struct ib_pd *pd, int acc)
 }
 
 /**
- * i40iw_del_mem_list - Deleting pbl list entries for CQ/QP
+ * i40iw_del_memlist - Deleting pbl list entries for CQ/QP
  * @iwmr: iwmr for IB's user page addresses
  * @ucontext: ptr to user context
  */
diff --git a/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c b/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c
index aca9061688ae..e34a1522132c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c
@@ -333,7 +333,7 @@ static void pf_cqp_get_hmc_fcn_callback(struct i40iw_sc_dev *dev, void *callback
 }
 
 /**
- * pf_add_hmc_obj - Callback for Add HMC Object
+ * pf_add_hmc_obj_callback - Callback for Add HMC Object
  * @work_vf_dev: pointer to the VF Device
  */
 static void pf_add_hmc_obj_callback(void *work_vf_dev)
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index ff87a67dd7b7..c60e79d214a1 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -1758,7 +1758,8 @@ static int qib_do_user_init(struct file *fp,
 }
 
 /**
- * unlock_exptid - unlock any expected TID entries context still had in use
+ * unlock_expected_tids - unlock any expected TID entries context still had
+ * in use
  * @rcd: ctxt
  *
  * We don't actually update the chip here, because we do a bulk update
@@ -2247,7 +2248,7 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (!iter_is_iovec(from) || !from->nr_segs || !pq)
 		return -EINVAL;
-			 
+
 	return qib_user_sdma_writev(rcd, pq, from->iov, from->nr_segs);
 }
 
diff --git a/drivers/infiniband/hw/qib/qib_iba6120.c b/drivers/infiniband/hw/qib/qib_iba6120.c
index b35e1174be22..a9b83bc13f4a 100644
--- a/drivers/infiniband/hw/qib/qib_iba6120.c
+++ b/drivers/infiniband/hw/qib/qib_iba6120.c
@@ -2609,7 +2609,7 @@ static void qib_chk_6120_errormask(struct qib_devdata *dd)
 }
 
 /**
- * qib_get_faststats - get word counters from chip before they overflow
+ * qib_get_6120_faststats - get word counters from chip before they overflow
  * @t: contains a pointer to the qlogic_ib device qib_devdata
  *
  * This needs more work; in particular, decision on whether we really
diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index 229dcd6ead95..d1c0bc31869f 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -2236,7 +2236,7 @@ static void qib_7220_tidtemplate(struct qib_devdata *dd)
 }
 
 /**
- * qib_init_7220_get_base_info - set chip-specific flags for user code
+ * qib_7220_get_base_info - set chip-specific flags for user code
  * @rcd: the qlogic_ib ctxt
  * @kinfo: qib_base_info pointer
  *
@@ -4411,7 +4411,7 @@ static void writescratch(struct qib_devdata *dd, u32 val)
 
 #define VALID_TS_RD_REG_MASK 0xBF
 /**
- * qib_7220_tempsense_read - read register of temp sensor via TWSI
+ * qib_7220_tempsense_rd - read register of temp sensor via TWSI
  * @dd: the qlogic_ib device
  * @regnum: register to read from
  *
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 9fe6ea75b45e..5240f186feee 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -2513,7 +2513,7 @@ static int qib_7322_bringup_serdes(struct qib_pportdata *ppd)
 }
 
 /**
- * qib_7322_quiet_serdes - set serdes to txidle
+ * qib_7322_mini_quiet_serdes - set serdes to txidle
  * @ppd: the qlogic_ib device
  * Called when driver is being unloaded
  */
@@ -3859,7 +3859,7 @@ static void qib_7322_tidtemplate(struct qib_devdata *dd)
 }
 
 /**
- * qib_init_7322_get_base_info - set chip-specific flags for user code
+ * qib_7322_get_base_info - set chip-specific flags for user code
  * @rcd: the qlogic_ib ctxt
  * @kinfo: qib_base_info pointer
  *
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 43c8ee1f46e0..b5a78576c48b 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -1609,7 +1609,7 @@ int qib_create_rcvhdrq(struct qib_devdata *dd, struct qib_ctxtdata *rcd)
 }
 
 /**
- * allocate eager buffers, both kernel and user contexts.
+ * qib_setup_eagerbufs - allocate eager buffers, both kernel and user contexts.
  * @rcd: the context we are setting up.
  *
  * Allocate the eager TID buffers and program them into hip.
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 1d3bdd7bb51d..67769b715126 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -882,7 +882,7 @@ int pvrdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 }
 
 /**
- * pvrdma_post_receive - post receive work request entries on a QP
+ * pvrdma_post_recv - post receive work request entries on a QP
  * @ibqp: the QP
  * @wr: the work request list to post
  * @bad_wr: the first bad WR returned
-- 
2.30.2

