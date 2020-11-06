Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7782A9BD2
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 19:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgKFSUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 13:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgKFSUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 13:20:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA5C0613D2;
        Fri,  6 Nov 2020 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zICc/VAAql8HmYEgiBew6YV/9jhfnB8+uOknlvQv+qM=; b=diZPfyQghZ2fHF7jOtE9UOr2ql
        KG2F04+LrkSTk/ti7bR3SPXYo+wCXoPYcsxEHC6xxcmJAFbDMq+lc1/VroH86EYVhT7pCOSDkvLFE
        SqFKEZ0B8Mtk7ud9GDvCHbJRxB0X3v9lzk4FO4ixI6sldMUpT5B+7FgSJThQiOBsXjcblbz6tsHQh
        rFdn2ae/41BZ0uz37r8h6v1XM89HJFDUdYhhKlf+TqoKFIIy34Cw+qqd3g9Qye0eiisfA/R8nH/gW
        cZ9BlsTV+z/T7dWJQ8JwYfTEc4MY2mwm269M8Lf47Mk9bFe3guL/rwh6G/0XQuYJ5UwXDGK958h0K
        6qxcpvew==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb6L9-0005en-6G; Fri, 06 Nov 2020 18:20:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 07/10] RDMA/core: remove use of dma_virt_ops
Date:   Fri,  6 Nov 2020 19:19:38 +0100
Message-Id: <20201106181941.1878556-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the ib_dma_* helpers to skip the DMA translation instead.  This
removes the last user if dma_virt_ops and keeps the weird layering
violation inside the RDMA core instead of burderning the DMA mapping
subsystems with it.  This also means the software RDMA drivers now
don't have to mess with DMA parameters that are not relevant to them
at all, and that in the future we can use PCI P2P transfers even for
software RDMA, as there is no first fake layer of DMA mapping that
the P2P DMA support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/core/device.c      | 43 ++++++++--------
 drivers/infiniband/core/rw.c          |  5 +-
 drivers/infiniband/sw/rdmavt/Kconfig  |  1 -
 drivers/infiniband/sw/rdmavt/mr.c     |  6 +--
 drivers/infiniband/sw/rdmavt/vt.c     |  8 ---
 drivers/infiniband/sw/rxe/Kconfig     |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c |  7 ---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 drivers/infiniband/sw/siw/Kconfig     |  1 -
 drivers/infiniband/sw/siw/siw.h       |  1 -
 drivers/infiniband/sw/siw/siw_main.c  |  7 ---
 drivers/nvme/target/rdma.c            |  3 +-
 include/rdma/ib_verbs.h               | 73 ++++++++++++++++++---------
 13 files changed, 81 insertions(+), 76 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a3b1fc84cdcab9..562095a896bbc0 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1177,25 +1177,6 @@ static int assign_name(struct ib_device *device, const char *name)
 	return ret;
 }
 
-static void setup_dma_device(struct ib_device *device,
-			     struct device *dma_device)
-{
-	/*
-	 * If the caller does not provide a DMA capable device then the IB
-	 * device will be used. In this case the caller should fully setup the
-	 * ibdev for DMA. This usually means using dma_virt_ops.
-	 */
-#ifdef CONFIG_DMA_VIRT_OPS
-	if (!dma_device) {
-		device->dev.dma_ops = &dma_virt_ops;
-		dma_device = &device->dev;
-	}
-#endif
-	WARN_ON(!dma_device);
-	device->dma_device = dma_device;
-	WARN_ON(!device->dma_device->dma_parms);
-}
-
 /*
  * setup_device() allocates memory and sets up data that requires calling the
  * device ops, this is the only reason these actions are not done during
@@ -1341,7 +1322,14 @@ int ib_register_device(struct ib_device *device, const char *name,
 	if (ret)
 		return ret;
 
-	setup_dma_device(device, dma_device);
+	/*
+	 * If the caller does not provide a DMA capable device then the IB core
+	 * will set up ib_sge and scatterlist structures that stash the kernel
+	 * virtual address into the address field.
+	 */
+	WARN_ON(dma_device && !dma_device->dma_parms);
+	device->dma_device = dma_device;
+
 	ret = setup_device(device);
 	if (ret)
 		return ret;
@@ -2675,6 +2663,21 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 }
 EXPORT_SYMBOL(ib_set_device_ops);
 
+#ifdef CONFIG_INFINIBAND_VIRT_DMA
+int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i) {
+		sg_dma_address(s) = (uintptr_t)sg_virt(s);
+		sg_dma_len(s) = s->length;
+	}
+	return nents;
+}
+EXPORT_SYMBOL(ib_dma_virt_map_sg);
+#endif /* CONFIG_INFINIBAND_VIRT_DMA */
+
 static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 	[RDMA_NL_LS_OP_RESOLVE] = {
 		.doit = ib_nl_handle_resolve_resp,
diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 13f43ab7220b05..a96030b784eb21 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -285,8 +285,11 @@ static void rdma_rw_unmap_sg(struct ib_device *dev, struct scatterlist *sg,
 static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
 			  u32 sg_cnt, enum dma_data_direction dir)
 {
-	if (is_pci_p2pdma_page(sg_page(sg)))
+	if (is_pci_p2pdma_page(sg_page(sg))) {
+		if (WARN_ON_ONCE(ib_uses_virt_dma(dev)))
+			return 0;
 		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
+	}
 	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
 }
 
diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
index c8e268082952b0..0df48b3a6b56c5 100644
--- a/drivers/infiniband/sw/rdmavt/Kconfig
+++ b/drivers/infiniband/sw/rdmavt/Kconfig
@@ -4,6 +4,5 @@ config INFINIBAND_RDMAVT
 	depends on INFINIBAND_VIRT_DMA
 	depends on X86_64
 	depends on PCI
-	select DMA_VIRT_OPS
 	help
 	This is a common software verbs provider for RDMA networks.
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 8490fdb9c91e50..90fc234f489acd 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -324,8 +324,6 @@ static void __rvt_free_mr(struct rvt_mr *mr)
  * @acc: access flags
  *
  * Return: the memory region on success, otherwise returns an errno.
- * Note that all DMA addresses should be created via the functions in
- * struct dma_virt_ops.
  */
 struct ib_mr *rvt_get_dma_mr(struct ib_pd *pd, int acc)
 {
@@ -766,7 +764,7 @@ int rvt_lkey_ok(struct rvt_lkey_table *rkt, struct rvt_pd *pd,
 
 	/*
 	 * We use LKEY == zero for kernel virtual addresses
-	 * (see rvt_get_dma_mr() and dma_virt_ops).
+	 * (see rvt_get_dma_mr()).
 	 */
 	if (sge->lkey == 0) {
 		struct rvt_dev_info *dev = ib_to_rvt(pd->ibpd.device);
@@ -877,7 +875,7 @@ int rvt_rkey_ok(struct rvt_qp *qp, struct rvt_sge *sge,
 
 	/*
 	 * We use RKEY == zero for kernel virtual addresses
-	 * (see rvt_get_dma_mr() and dma_virt_ops).
+	 * (see rvt_get_dma_mr()).
 	 */
 	rcu_read_lock();
 	if (rkey == 0) {
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 670a9623b46e11..d1bbe66610cfe4 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -524,7 +524,6 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 int rvt_register_device(struct rvt_dev_info *rdi)
 {
 	int ret = 0, i;
-	u64 dma_mask;
 
 	if (!rdi)
 		return -EINVAL;
@@ -579,13 +578,6 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 	/* Completion queues */
 	spin_lock_init(&rdi->n_cqs_lock);
 
-	/* DMA Operations */
-	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
-	dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
-	ret = dma_coerce_mask_and_coherent(&rdi->ibdev.dev, dma_mask);
-	if (ret)
-		goto bail_wss;
-
 	/* Protection Domain */
 	spin_lock_init(&rdi->n_pds_lock);
 	rdi->n_pds_allocated = 0;
diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index 8810bfa680495a..4521490667925f 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -5,7 +5,6 @@ config RDMA_RXE
 	depends on INFINIBAND_VIRT_DMA
 	select NET_UDP_TUNNEL
 	select CRYPTO_CRC32
-	select DMA_VIRT_OPS
 	help
 	This driver implements the InfiniBand RDMA transport over
 	the Linux network stack. It enables a system with a
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f9c832e82552f9..9c66f76545b3c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1118,7 +1118,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	int err;
 	struct ib_device *dev = &rxe->ib_dev;
 	struct crypto_shash *tfm;
-	u64 dma_mask;
 
 	strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
 
@@ -1129,12 +1128,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
-	dev->dev.dma_parms = &rxe->dma_parms;
-	dma_set_max_seg_size(&dev->dev, UINT_MAX);
-	dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
-	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
-	if (err)
-		return err;
 
 	dev->uverbs_cmd_mask = BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
 	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 3414b341b7091f..4bf5d85a1ab3ce 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -352,7 +352,6 @@ struct rxe_port {
 struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
-	struct device_dma_parameters dma_parms;
 	int			max_ucontext;
 	int			max_inline_data;
 	struct mutex	usdev_lock;
diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index 3450ba5081df51..1b5105cbabaeed 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -2,7 +2,6 @@ config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND && LIBCRC32C
 	depends on INFINIBAND_VIRT_DMA
-	select DMA_VIRT_OPS
 	help
 	This driver implements the iWARP RDMA transport over
 	the Linux TCP/IP network stack. It enables a system with a
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index e9753831ac3f33..adda7899621962 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -69,7 +69,6 @@ struct siw_pd {
 
 struct siw_device {
 	struct ib_device base_dev;
-	struct device_dma_parameters dma_parms;
 	struct net_device *netdev;
 	struct siw_dev_cap attrs;
 
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 181e06c1c43d7e..c62a7a0d423c0e 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -306,7 +306,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	struct siw_device *sdev = NULL;
 	struct ib_device *base_dev;
 	struct device *parent = netdev->dev.parent;
-	u64 dma_mask;
 	int rv;
 
 	if (!parent) {
@@ -383,12 +382,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	 */
 	base_dev->phys_port_cnt = 1;
 	base_dev->dev.parent = parent;
-	base_dev->dev.dma_parms = &sdev->dma_parms;
-	dma_set_max_seg_size(&base_dev->dev, UINT_MAX);
-	dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
-	if (dma_coerce_mask_and_coherent(&base_dev->dev, dma_mask))
-		goto error;
-
 	base_dev->num_comp_vectors = num_possible_cpus();
 
 	xa_init_flags(&sdev->qp_xa, XA_FLAGS_ALLOC1);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ae6620489457d6..5c1e7cb7fe0dee 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
 		goto out_free_rsp;
 
-	r->req.p2p_client = &ndev->device->dev;
+	if (!ib_uses_virt_dma(ndev->device))
+		r->req.p2p_client = &ndev->device->dev;
 	r->send_sge.length = sizeof(*r->req.cqe);
 	r->send_sge.lkey = ndev->pd->local_dma_lkey;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 453793d1d2225f..18c67ba5c3b3e6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3943,6 +3943,16 @@ static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
 		-ENOSYS;
 }
 
+/*
+ * Drivers that don't need a DMA mapping at the RDMA layer, set dma_device to
+ * NULL. This causes the ib_dma* helpers to just stash the kernel virtual
+ * address into the dma address.
+ */
+static inline bool ib_uses_virt_dma(struct ib_device *dev)
+{
+	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
+}
+
 /**
  * ib_dma_mapping_error - check a DMA addr for error
  * @dev: The device for which the dma_addr was created
@@ -3950,6 +3960,8 @@ static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
  */
 static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
 {
+	if (ib_uses_virt_dma(dev))
+		return 0;
 	return dma_mapping_error(dev->dma_device, dma_addr);
 }
 
@@ -3964,6 +3976,8 @@ static inline u64 ib_dma_map_single(struct ib_device *dev,
 				    void *cpu_addr, size_t size,
 				    enum dma_data_direction direction)
 {
+	if (ib_uses_virt_dma(dev))
+		return (uintptr_t)cpu_addr;
 	return dma_map_single(dev->dma_device, cpu_addr, size, direction);
 }
 
@@ -3978,7 +3992,8 @@ static inline void ib_dma_unmap_single(struct ib_device *dev,
 				       u64 addr, size_t size,
 				       enum dma_data_direction direction)
 {
-	dma_unmap_single(dev->dma_device, addr, size, direction);
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_single(dev->dma_device, addr, size, direction);
 }
 
 /**
@@ -3995,6 +4010,8 @@ static inline u64 ib_dma_map_page(struct ib_device *dev,
 				  size_t size,
 					 enum dma_data_direction direction)
 {
+	if (ib_uses_virt_dma(dev))
+		return (uintptr_t)(page_address(page) + offset);
 	return dma_map_page(dev->dma_device, page, offset, size, direction);
 }
 
@@ -4009,7 +4026,30 @@ static inline void ib_dma_unmap_page(struct ib_device *dev,
 				     u64 addr, size_t size,
 				     enum dma_data_direction direction)
 {
-	dma_unmap_page(dev->dma_device, addr, size, direction);
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_page(dev->dma_device, addr, size, direction);
+}
+
+int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents);
+static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
+				      struct scatterlist *sg, int nents,
+				      enum dma_data_direction direction,
+				      unsigned long dma_attrs)
+{
+	if (ib_uses_virt_dma(dev))
+		return ib_dma_virt_map_sg(dev, sg, nents);
+	return dma_map_sg_attrs(dev->dma_device, sg, nents, direction,
+				dma_attrs);
+}
+
+static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
+					 struct scatterlist *sg, int nents,
+					 enum dma_data_direction direction,
+					 unsigned long dma_attrs)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_sg_attrs(dev->dma_device, sg, nents, direction,
+				   dma_attrs);
 }
 
 /**
@@ -4023,7 +4063,7 @@ static inline int ib_dma_map_sg(struct ib_device *dev,
 				struct scatterlist *sg, int nents,
 				enum dma_data_direction direction)
 {
-	return dma_map_sg(dev->dma_device, sg, nents, direction);
+	return ib_dma_map_sg_attrs(dev, sg, nents, direction, 0);
 }
 
 /**
@@ -4037,24 +4077,7 @@ static inline void ib_dma_unmap_sg(struct ib_device *dev,
 				   struct scatterlist *sg, int nents,
 				   enum dma_data_direction direction)
 {
-	dma_unmap_sg(dev->dma_device, sg, nents, direction);
-}
-
-static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
-				      struct scatterlist *sg, int nents,
-				      enum dma_data_direction direction,
-				      unsigned long dma_attrs)
-{
-	return dma_map_sg_attrs(dev->dma_device, sg, nents, direction,
-				dma_attrs);
-}
-
-static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
-					 struct scatterlist *sg, int nents,
-					 enum dma_data_direction direction,
-					 unsigned long dma_attrs)
-{
-	dma_unmap_sg_attrs(dev->dma_device, sg, nents, direction, dma_attrs);
+	ib_dma_unmap_sg_attrs(dev, sg, nents, direction, 0);
 }
 
 /**
@@ -4065,6 +4088,8 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
  */
 static inline unsigned int ib_dma_max_seg_size(struct ib_device *dev)
 {
+	if (ib_uses_virt_dma(dev))
+		return UINT_MAX;
 	return dma_get_max_seg_size(dev->dma_device);
 }
 
@@ -4080,7 +4105,8 @@ static inline void ib_dma_sync_single_for_cpu(struct ib_device *dev,
 					      size_t size,
 					      enum dma_data_direction dir)
 {
-	dma_sync_single_for_cpu(dev->dma_device, addr, size, dir);
+	if (!ib_uses_virt_dma(dev))
+		dma_sync_single_for_cpu(dev->dma_device, addr, size, dir);
 }
 
 /**
@@ -4095,7 +4121,8 @@ static inline void ib_dma_sync_single_for_device(struct ib_device *dev,
 						 size_t size,
 						 enum dma_data_direction dir)
 {
-	dma_sync_single_for_device(dev->dma_device, addr, size, dir);
+	if (!ib_uses_virt_dma(dev))
+		dma_sync_single_for_device(dev->dma_device, addr, size, dir);
 }
 
 /* ib_reg_user_mr - register a memory region for virtual addresses from kernel
-- 
2.28.0

