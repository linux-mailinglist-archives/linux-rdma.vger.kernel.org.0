Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602F62768B7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIXGNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 02:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgIXGNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 02:13:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927AC0613CE
        for <linux-rdma@vger.kernel.org>; Wed, 23 Sep 2020 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xUOmc/3CCRTtDWaT3vJg5/1WR3h1cMIqFXtDqUrXINA=; b=XV84c9iA65oWV5i5VR6DBe1qAw
        7wZYZZEZWrafpnwghl2myYh0qUU6KufkG92RzyDfDxewrifXwtJ0892+w/1ZsFtJWul2tFwYKi57E
        2JEk/39mkBuEqCXQiKxxQg+0SPfTF4bjKxPHI83BcSFUX7wK1T+38zkW+ni/AFyESoehDkShaGtUk
        9qu0/QUp24D50uvSOJUsQ1zTB83Bv/vnbkCP3e08mG1B6UMlBvfKvm2cLMNwznwwdGDC80HxCD5PI
        4rfIhMJw4BegJbmzYgDtFYbupE5X+wrPmGdQDxdFTZUCjU7BHvck5EJwz9Jn+j1sg7uKBJypUCBJg
        otS8f0tA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLKVR-00075j-4P; Thu, 24 Sep 2020 06:13:25 +0000
Date:   Thu, 24 Sep 2020 07:13:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200924061325.GC22045@infradead.org>
References: <20200922101429.GF1223944@unreal>
 <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
 <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
 <20200922162206.GD3699@nvidia.com>
 <20200923053955.GB4809@infradead.org>
 <20200923183556.GB9475@nvidia.com>
 <20200924055345.GB22045@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924055345.GB22045@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 24, 2020 at 06:53:45AM +0100, Christoph Hellwig wrote:
> Because it isn't DMA, and not we need crappy workarounds like the one
> in the PCIe P2P code.  It also enforces the same size for dma_addr_t
> and a pointer, which is not true in various cases.  More importantly
> it forces a very strange design in the IB APIs (actually it seems the
> other way around - the weird IB Verbs APIs forced this decision, but
> it cements it in).  For example most modern Mellanox cards can include
> immediate data in the command capsule (sorry NVMe terms, I'm pretty
> sure you guys use something else) that is just copied into the BAR
> using MMIO.  But the IB API design still forces the ULP to dma map
> it, which is idiotic.

FYI, here is the quick patch to kill of dma_virt_ops on top of the
patch under discussion here.  I think the diffstat alone speaks for
itself, never mind the fact that we avoid indirect calls for the
drivers that don't want the DMA mapping.


diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index f8fc41ef921868..036b01bf047231 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1173,36 +1173,6 @@ static int assign_name(struct ib_device *device, const char *name)
 	return ret;
 }
 
-static void setup_dma_device(struct ib_device *device,
-			     struct device *dma_device)
-{
-	if (!dma_device) {
-		/*
-		 * If the caller does not provide a DMA capable device then the
-		 * IB device will be used. In this case the caller should fully
-		 * setup the ibdev for DMA. This usually means using
-		 * dma_virt_ops.
-		 */
-#ifdef CONFIG_DMA_OPS
-		if (WARN_ON(!device->dev.dma_ops))
-			return;
-#endif
-		if (WARN_ON(!device->dev.dma_parms))
-			return;
-
-		dma_device = &device->dev;
-	} else {
-		device->dev.dma_parms = dma_device->dma_parms;
-		/*
-		 * Auto setup the segment size if a DMA device was passed in.
-		 * The PCI core sets the maximum segment size to 64 KB. Increase
-		 * this parameter to 2 GB.
-		 */
-		dma_set_max_seg_size(dma_device, SZ_2G);
-	}
-	device->dma_device = dma_device;
-}
-
 /*
  * setup_device() allocates memory and sets up data that requires calling the
  * device ops, this is the only reason these actions are not done during
@@ -1345,7 +1315,18 @@ int ib_register_device(struct ib_device *device, const char *name,
 	if (ret)
 		return ret;
 
-	setup_dma_device(device, dma_device);
+	/*
+	 * Auto setup the segment size if a DMA device was passed in.  The PCI
+	 * core sets the maximum segment size to 64 KB.  Increase this parameter
+	 * to 2 GB.
+	 *
+	 * XXX: this really should move into the drivers, as some might support
+	 * a larger segment size for non-RDMA purposes.
+	 */
+	device->dma_device = dma_device;
+	if (dma_device)
+		dma_set_max_seg_size(dma_device, SZ_2G);
+
 	ret = setup_device(device);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
index 9ef5f5ce1ff6b0..2de31692885cf0 100644
--- a/drivers/infiniband/sw/rdmavt/Kconfig
+++ b/drivers/infiniband/sw/rdmavt/Kconfig
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_RDMAVT
 	tristate "RDMA verbs transport library"
-	depends on X86_64 && ARCH_DMA_ADDR_T_64BIT
+	depends on X86_64
 	depends on PCI
-	select DMA_VIRT_OPS
 	help
 	This is a common software verbs provider for RDMA networks.
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 2f7c25fea44a9d..e60a11b2f78b70 100644
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
index 2f117ac11c8b86..8dc9d980b172d8 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -580,13 +580,6 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 	/* Completion queues */
 	spin_lock_init(&rdi->n_cqs_lock);
 
-	/* DMA Operations */
-	rdi->ibdev.dev.dma_ops = &dma_virt_ops;
-	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
-	rdi->ibdev.dev.dma_mask = rdi->ibdev.dev.parent->dma_mask;
-	rdi->ibdev.dev.coherent_dma_mask =
-		rdi->ibdev.dev.parent->coherent_dma_mask;
-
 	/* Protection Domain */
 	spin_lock_init(&rdi->n_pds_lock);
 	rdi->n_pds_allocated = 0;
diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index a0c6c7dfc1814f..f12bb088a44453 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -2,10 +2,8 @@
 config RDMA_RXE
 	tristate "Software RDMA over Ethernet (RoCE) driver"
 	depends on INET && PCI && INFINIBAND
-	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
 	select NET_UDP_TUNNEL
 	select CRYPTO_CRC32
-	select DMA_VIRT_OPS
 	help
 	This driver implements the InfiniBand RDMA transport over
 	the Linux network stack. It enables a system with a
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 37fee72755be76..df4a5de6456906 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1128,12 +1128,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
-	dev->dev.dma_ops = &dma_virt_ops;
-	dev->dev.dma_parms = &rxe->dma_parms;
-	rxe->dma_parms = (struct device_dma_parameters)
-		{ .max_segment_size = SZ_2G };
-	dma_coerce_mask_and_coherent(&dev->dev,
-				     dma_get_required_mask(&dev->dev));
 
 	dev->uverbs_cmd_mask = BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
 	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 560a610bb0aa83..3cd58195191ddb 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -356,7 +356,6 @@ struct rxe_port {
 struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
-	struct device_dma_parameters dma_parms;
 	int			max_ucontext;
 	int			max_inline_data;
 	struct mutex	usdev_lock;
diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index b622fc62f2cd6d..8582ac6050c743 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,7 +1,6 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND && LIBCRC32C
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
index 0362d57b4db898..c62a7a0d423c0e 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -382,12 +382,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	 */
 	base_dev->phys_port_cnt = 1;
 	base_dev->dev.parent = parent;
-	base_dev->dev.dma_ops = &dma_virt_ops;
-	base_dev->dev.dma_parms = &sdev->dma_parms;
-	sdev->dma_parms = (struct device_dma_parameters)
-		{ .max_segment_size = SZ_2G };
-	dma_coerce_mask_and_coherent(&base_dev->dev,
-				     dma_get_required_mask(&base_dev->dev));
 	base_dev->num_comp_vectors = num_possible_cpus();
 
 	xa_init_flags(&sdev->qp_xa, XA_FLAGS_ALLOC1);
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index bf66b0622b49c8..f2621eaecb7211 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -556,15 +556,6 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		return -1;
 
 	for (i = 0; i < num_clients; i++) {
-#ifdef CONFIG_DMA_VIRT_OPS
-		if (clients[i]->dma_ops == &dma_virt_ops) {
-			if (verbose)
-				dev_warn(clients[i],
-					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
-			return -1;
-		}
-#endif
-
 		pci_client = find_parent_pci_dev(clients[i]);
 		if (!pci_client) {
 			if (verbose)
@@ -837,17 +828,6 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 	phys_addr_t paddr;
 	int i;
 
-	/*
-	 * p2pdma mappings are not compatible with devices that use
-	 * dma_virt_ops. If the upper layers do the right thing
-	 * this should never happen because it will be prevented
-	 * by the check in pci_p2pdma_distance_many()
-	 */
-#ifdef CONFIG_DMA_VIRT_OPS
-	if (WARN_ON_ONCE(dev->dma_ops == &dma_virt_ops))
-		return 0;
-#endif
-
 	for_each_sg(sg, s, nents, i) {
 		paddr = sg_phys(s);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index bb138ac6f5e63e..6d39b34b75b115 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -133,7 +133,6 @@ struct dma_map_ops {
 
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
-extern const struct dma_map_ops dma_virt_ops;
 extern const struct dma_map_ops dma_dummy_ops;
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index fe32ec9f4754ea..f8a4f88aae298f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3967,6 +3967,8 @@ static inline u64 ib_dma_map_single(struct ib_device *dev,
 				    void *cpu_addr, size_t size,
 				    enum dma_data_direction direction)
 {
+	if (!dev->dma_device)
+		return (uintptr_t)cpu_addr;
 	return dma_map_single(dev->dma_device, cpu_addr, size, direction);
 }
 
@@ -3981,6 +3983,8 @@ static inline void ib_dma_unmap_single(struct ib_device *dev,
 				       u64 addr, size_t size,
 				       enum dma_data_direction direction)
 {
+	if (!dev->dma_device)
+		return;
 	dma_unmap_single(dev->dma_device, addr, size, direction);
 }
 
@@ -3998,6 +4002,8 @@ static inline u64 ib_dma_map_page(struct ib_device *dev,
 				  size_t size,
 					 enum dma_data_direction direction)
 {
+	if (!dev->dma_device)
+		return (uintptr_t)(page_address(page) + offset);
 	return dma_map_page(dev->dma_device, page, offset, size, direction);
 }
 
@@ -4012,9 +4018,41 @@ static inline void ib_dma_unmap_page(struct ib_device *dev,
 				     u64 addr, size_t size,
 				     enum dma_data_direction direction)
 {
+	if (!dev->dma_device)
+		return;
 	dma_unmap_page(dev->dma_device, addr, size, direction);
 }
 
+static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
+				      struct scatterlist *sg, int nents,
+				      enum dma_data_direction direction,
+				      unsigned long dma_attrs)
+{
+	if (!dev->dma_device) {
+		struct scatterlist *s;
+		int i;
+
+		for_each_sg(sg, s, nents, i) {
+			sg_dma_address(s) = (uintptr_t)sg_virt(s);
+			sg_dma_len(s) = s->length;
+		}
+
+		return nents;
+	}
+	return dma_map_sg_attrs(dev->dma_device, sg, nents, direction,
+				dma_attrs);
+}
+
+static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
+					 struct scatterlist *sg, int nents,
+					 enum dma_data_direction direction,
+					 unsigned long dma_attrs)
+{
+	if (!dev->dma_device)
+		return;
+	dma_unmap_sg_attrs(dev->dma_device, sg, nents, direction, dma_attrs);
+}
+
 /**
  * ib_dma_map_sg - Map a scatter/gather list to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
@@ -4026,7 +4064,7 @@ static inline int ib_dma_map_sg(struct ib_device *dev,
 				struct scatterlist *sg, int nents,
 				enum dma_data_direction direction)
 {
-	return dma_map_sg(dev->dma_device, sg, nents, direction);
+	return ib_dma_map_sg_attrs(dev, sg, nents, direction, 0);
 }
 
 /**
@@ -4040,24 +4078,7 @@ static inline void ib_dma_unmap_sg(struct ib_device *dev,
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
@@ -4068,6 +4089,8 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
  */
 static inline unsigned int ib_dma_max_seg_size(struct ib_device *dev)
 {
+	if (!dev->dma_device)
+		return SZ_2G;
 	return dma_get_max_seg_size(dev->dma_device);
 }
 
@@ -4083,6 +4106,8 @@ static inline void ib_dma_sync_single_for_cpu(struct ib_device *dev,
 					      size_t size,
 					      enum dma_data_direction dir)
 {
+	if (!dev->dma_device)
+		return;
 	dma_sync_single_for_cpu(dev->dma_device, addr, size, dir);
 }
 
@@ -4098,6 +4123,8 @@ static inline void ib_dma_sync_single_for_device(struct ib_device *dev,
 						 size_t size,
 						 enum dma_data_direction dir)
 {
+	if (!dev->dma_device)
+		return;
 	dma_sync_single_for_device(dev->dma_device, addr, size, dir);
 }
 
@@ -4113,6 +4140,14 @@ static inline void *ib_dma_alloc_coherent(struct ib_device *dev,
 					   dma_addr_t *dma_handle,
 					   gfp_t flag)
 {
+	if (!dev->dma_device) {
+		void *ret = (void *)__get_free_pages(flag | __GFP_ZERO,
+				get_order(size));
+		if (ret)
+			*dma_handle = (uintptr_t)ret;
+		return ret;
+	}
+
 	return dma_alloc_coherent(dev->dma_device, size, dma_handle, flag);
 }
 
@@ -4127,7 +4162,10 @@ static inline void ib_dma_free_coherent(struct ib_device *dev,
 					size_t size, void *cpu_addr,
 					dma_addr_t dma_handle)
 {
-	dma_free_coherent(dev->dma_device, size, cpu_addr, dma_handle);
+	if (!dev->dma_device)
+		free_pages((unsigned long)cpu_addr, get_order(size));
+	else
+		dma_free_coherent(dev->dma_device, size, cpu_addr, dma_handle);
 }
 
 /* ib_reg_user_mr - register a memory region for virtual addresses from kernel
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 281785feb874db..0edf7845b4effa 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -78,11 +78,6 @@ config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 
-config DMA_VIRT_OPS
-	bool
-	depends on HAS_DMA
-	select DMA_OPS
-
 config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index dc755ab68aabf9..cd1d86358a7a62 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_DMA_OPS)			+= ops_helpers.o
 obj-$(CONFIG_DMA_OPS)			+= dummy.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
-obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
diff --git a/kernel/dma/virt.c b/kernel/dma/virt.c
deleted file mode 100644
index ebe128833af7b5..00000000000000
--- a/kernel/dma/virt.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DMA operations that map to virtual addresses without flushing memory.
- */
-#include <linux/export.h>
-#include <linux/mm.h>
-#include <linux/dma-mapping.h>
-#include <linux/scatterlist.h>
-
-static void *dma_virt_alloc(struct device *dev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t gfp,
-			    unsigned long attrs)
-{
-	void *ret;
-
-	ret = (void *)__get_free_pages(gfp | __GFP_ZERO, get_order(size));
-	if (ret)
-		*dma_handle = (uintptr_t)ret;
-	return ret;
-}
-
-static void dma_virt_free(struct device *dev, size_t size,
-			  void *cpu_addr, dma_addr_t dma_addr,
-			  unsigned long attrs)
-{
-	free_pages((unsigned long)cpu_addr, get_order(size));
-}
-
-static dma_addr_t dma_virt_map_page(struct device *dev, struct page *page,
-				    unsigned long offset, size_t size,
-				    enum dma_data_direction dir,
-				    unsigned long attrs)
-{
-	return (uintptr_t)(page_address(page) + offset);
-}
-
-static int dma_virt_map_sg(struct device *dev, struct scatterlist *sgl,
-			   int nents, enum dma_data_direction dir,
-			   unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg_page(sg));
-		sg_dma_address(sg) = (uintptr_t)sg_virt(sg);
-		sg_dma_len(sg) = sg->length;
-	}
-
-	return nents;
-}
-
-const struct dma_map_ops dma_virt_ops = {
-	.alloc			= dma_virt_alloc,
-	.free			= dma_virt_free,
-	.map_page		= dma_virt_map_page,
-	.map_sg			= dma_virt_map_sg,
-};
-EXPORT_SYMBOL(dma_virt_ops);
