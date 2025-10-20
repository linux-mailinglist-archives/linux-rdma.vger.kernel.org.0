Return-Path: <linux-rdma+bounces-13942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D3BEF33D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 05:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD29418951A0
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 03:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2EC2BD590;
	Mon, 20 Oct 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vo2Gnkn7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDD1E492A;
	Mon, 20 Oct 2025 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931806; cv=none; b=Ei3KEv+B3uJkAlSqJbjrhAwXPaE1/64j4CjNhHlY+0qAit/3wSFQ+rbwmqCyWHHmWe9Fb1D/ImcJji9K8md8o5GV8JbkoWdMvVnXTERE6aulc35Znp8Jai5FiDTpZ4ysFdroQV/X/m0Aha4n6Pm7qp13K3ws102IHwoo+zsabUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931806; c=relaxed/simple;
	bh=EELSp0e4u/t2PwmMMaQK64kfmkIYSGUX+6rmgFt5TPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4xxf3K5MfPjFCp7YXDFgrIUJIKWUdwOKzzbrJ7osvzcxabs0vRkaa8FqH9C8xeCu5k+7SnHywfjLAOHR7c6fF07tprtlVA/uCnlnNdEFUgPv8M+luooahLOEj0Wx9+DCpsgka5BnXVP0e4mfsTzlaVq4zGtyRwvvJvrczWHeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vo2Gnkn7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q2fHDmpjGirvmD8Nbcl1QUzDEwjd/BCXqKRdF38wsyM=; b=vo2Gnkn7K83HqUWE8LGflMMN4U
	fublcaQMtGyo4MwxefZEUK0hZ+LVvm40c4k67FFGoexIY0Qw/IvuxG3ES2bMaw42xGU70X5QXCWXT
	vL72uONe+j0wDJDzJVbhlNyRJnlIzV6jSbJg0wPFIFV3s7S6gDShdbg9MDGi+J1sTa3+/52hZ1a+N
	Jbvalpz+4VnTfo+tbW0aL4yjjDP+PRoNIwl6r6K+UsqL903iTAg2KfyeXacdAQ/mT1tvJ88yvw97Y
	VqbC8V2znYzPnfjuYovjpelGHLzJKLfwxcc/5TC0Bohm/9NP9pQ9jgZ6hG/QkbThNgSvDJ1ud0b1l
	imoSl3pw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAgnp-0000000Bnbc-0Uzc;
	Mon, 20 Oct 2025 03:43:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: fix some kernel-doc warnings
Date: Sun, 19 Oct 2025 20:43:20 -0700
Message-ID: <20251020034320.3011094-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 49 kernel-doc warnings in ib_verbs.h:

- Add struct short description for rdma_stat_desc, rdma_hw_stats.
- Fix kernel-doc format for struct members (use ':' instead of '-') for
  several structs.
- Don't use "/**" kernel-doc notation for struct members in ib_device_ops
  (most members are not documented and most of the kernel-doc was
  not formatted correctly).
- Spell function parameters correctly in ib_dma_map_sgtable_attrs(),
  ib_device_try_get(), rdma_roce_rescan_device().
- Add kernel-doc for the function parameter in
  rdma_flow_label_to_udp_sport().

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
---
 include/rdma/ib_verbs.h |   99 +++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 49 deletions(-)

--- linux-next-20251016.orig/include/rdma/ib_verbs.h
+++ linux-next-20251016/include/rdma/ib_verbs.h
@@ -586,10 +586,10 @@ enum ib_stat_flag {
 };
 
 /**
- * struct rdma_stat_desc
- * @name - The name of the counter
- * @flags - Flags of the counter; For example, IB_STAT_FLAG_OPTIONAL
- * @priv - Driver private information; Core code should not use
+ * struct rdma_stat_desc - description of one rdma stat/counter
+ * @name: The name of the counter
+ * @flags: Flags of the counter; For example, IB_STAT_FLAG_OPTIONAL
+ * @priv: Driver private information; Core code should not use
  */
 struct rdma_stat_desc {
 	const char *name;
@@ -598,24 +598,24 @@ struct rdma_stat_desc {
 };
 
 /**
- * struct rdma_hw_stats
- * @lock - Mutex to protect parallel write access to lifespan and values
+ * struct rdma_hw_stats - collection of hardware stats and their management
+ * @lock: Mutex to protect parallel write access to lifespan and values
  *    of counters, which are 64bits and not guaranteed to be written
  *    atomicaly on 32bits systems.
- * @timestamp - Used by the core code to track when the last update was
- * @lifespan - Used by the core code to determine how old the counters
+ * @timestamp: Used by the core code to track when the last update was
+ * @lifespan: Used by the core code to determine how old the counters
  *   should be before being updated again.  Stored in jiffies, defaults
  *   to 10 milliseconds, drivers can override the default be specifying
  *   their own value during their allocation routine.
- * @descs - Array of pointers to static descriptors used for the counters
+ * @descs: Array of pointers to static descriptors used for the counters
  *   in directory.
- * @is_disabled - A bitmap to indicate each counter is currently disabled
+ * @is_disabled: A bitmap to indicate each counter is currently disabled
  *   or not.
- * @num_counters - How many hardware counters there are.  If name is
+ * @num_counters: How many hardware counters there are.  If name is
  *   shorter than this number, a kernel oops will result.  Driver authors
  *   are encouraged to leave BUILD_BUG_ON(ARRAY_SIZE(@name) < num_counters)
  *   in their code to prevent this.
- * @value - Array of u64 counters that are accessed by the sysfs code and
+ * @value: Array of u64 counters that are accessed by the sysfs code and
  *   filled in by the drivers get_stats routine
  */
 struct rdma_hw_stats {
@@ -2405,7 +2405,7 @@ struct ib_device_ops {
 	int (*modify_port)(struct ib_device *device, u32 port_num,
 			   int port_modify_mask,
 			   struct ib_port_modify *port_modify);
-	/**
+	/*
 	 * The following mandatory functions are used only at device
 	 * registration.  Keep functions such as these at the end of this
 	 * structure to avoid cache line misses when accessing struct ib_device
@@ -2415,7 +2415,7 @@ struct ib_device_ops {
 				  struct ib_port_immutable *immutable);
 	enum rdma_link_layer (*get_link_layer)(struct ib_device *device,
 					       u32 port_num);
-	/**
+	/*
 	 * When calling get_netdev, the HW vendor's driver should return the
 	 * net device of device @device at port @port_num or NULL if such
 	 * a net device doesn't exist. The vendor driver should call dev_hold
@@ -2425,7 +2425,7 @@ struct ib_device_ops {
 	 */
 	struct net_device *(*get_netdev)(struct ib_device *device,
 					 u32 port_num);
-	/**
+	/*
 	 * rdma netdev operation
 	 *
 	 * Driver implementing alloc_rdma_netdev or rdma_netdev_get_params
@@ -2439,14 +2439,14 @@ struct ib_device_ops {
 	int (*rdma_netdev_get_params)(struct ib_device *device, u32 port_num,
 				      enum rdma_netdev_t type,
 				      struct rdma_netdev_alloc_params *params);
-	/**
+	/*
 	 * query_gid should be return GID value for @device, when @port_num
 	 * link layer is either IB or iWarp. It is no-op if @port_num port
 	 * is RoCE link layer.
 	 */
 	int (*query_gid)(struct ib_device *device, u32 port_num, int index,
 			 union ib_gid *gid);
-	/**
+	/*
 	 * When calling add_gid, the HW vendor's driver should add the gid
 	 * of device of port at gid index available at @attr. Meta-info of
 	 * that gid (for example, the network device related to this gid) is
@@ -2460,7 +2460,7 @@ struct ib_device_ops {
 	 * roce_gid_table is used.
 	 */
 	int (*add_gid)(const struct ib_gid_attr *attr, void **context);
-	/**
+	/*
 	 * When calling del_gid, the HW vendor's driver should delete the
 	 * gid of device @device at gid index gid_index of port port_num
 	 * available in @attr.
@@ -2475,7 +2475,7 @@ struct ib_device_ops {
 			      struct ib_udata *udata);
 	void (*dealloc_ucontext)(struct ib_ucontext *context);
 	int (*mmap)(struct ib_ucontext *context, struct vm_area_struct *vma);
-	/**
+	/*
 	 * This will be called once refcount of an entry in mmap_xa reaches
 	 * zero. The type of the memory that was mapped may differ between
 	 * entries and is opaque to the rdma_user_mmap interface.
@@ -2516,12 +2516,12 @@ struct ib_device_ops {
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
 	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
-	/**
+	/*
 	 * pre_destroy_cq - Prevent a cq from generating any new work
 	 * completions, but not free any kernel resources
 	 */
 	int (*pre_destroy_cq)(struct ib_cq *cq);
-	/**
+	/*
 	 * post_destroy_cq - Free all kernel resources
 	 */
 	void (*post_destroy_cq)(struct ib_cq *cq);
@@ -2615,7 +2615,7 @@ struct ib_device_ops {
 			    struct scatterlist *meta_sg, int meta_sg_nents,
 			    unsigned int *meta_sg_offset);
 
-	/**
+	/*
 	 * alloc_hw_[device,port]_stats - Allocate a struct rdma_hw_stats and
 	 *   fill in the driver initialized data.  The struct is kfree()'ed by
 	 *   the sysfs core when the device is removed.  A lifespan of -1 in the
@@ -2624,7 +2624,7 @@ struct ib_device_ops {
 	struct rdma_hw_stats *(*alloc_hw_device_stats)(struct ib_device *device);
 	struct rdma_hw_stats *(*alloc_hw_port_stats)(struct ib_device *device,
 						     u32 port_num);
-	/**
+	/*
 	 * get_hw_stats - Fill in the counter value(s) in the stats struct.
 	 * @index - The index in the value array we wish to have updated, or
 	 *   num_counters if we want all stats updated
@@ -2639,14 +2639,14 @@ struct ib_device_ops {
 	int (*get_hw_stats)(struct ib_device *device,
 			    struct rdma_hw_stats *stats, u32 port, int index);
 
-	/**
+	/*
 	 * modify_hw_stat - Modify the counter configuration
 	 * @enable: true/false when enable/disable a counter
 	 * Return codes - 0 on success or error code otherwise.
 	 */
 	int (*modify_hw_stat)(struct ib_device *device, u32 port,
 			      unsigned int counter_index, bool enable);
-	/**
+	/*
 	 * Allows rdma drivers to add their own restrack attributes.
 	 */
 	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
@@ -2682,39 +2682,39 @@ struct ib_device_ops {
 			 u8 pdata_len);
 	int (*iw_create_listen)(struct iw_cm_id *cm_id, int backlog);
 	int (*iw_destroy_listen)(struct iw_cm_id *cm_id);
-	/**
+	/*
 	 * counter_bind_qp - Bind a QP to a counter.
 	 * @counter - The counter to be bound. If counter->id is zero then
 	 *   the driver needs to allocate a new counter and set counter->id
 	 */
 	int (*counter_bind_qp)(struct rdma_counter *counter, struct ib_qp *qp,
 			       u32 port);
-	/**
+	/*
 	 * counter_unbind_qp - Unbind the qp from the dynamically-allocated
 	 *   counter and bind it onto the default one
 	 */
 	int (*counter_unbind_qp)(struct ib_qp *qp, u32 port);
-	/**
+	/*
 	 * counter_dealloc -De-allocate the hw counter
 	 */
 	int (*counter_dealloc)(struct rdma_counter *counter);
-	/**
+	/*
 	 * counter_alloc_stats - Allocate a struct rdma_hw_stats and fill in
 	 * the driver initialized data.
 	 */
 	struct rdma_hw_stats *(*counter_alloc_stats)(
 		struct rdma_counter *counter);
-	/**
+	/*
 	 * counter_update_stats - Query the stats value of this counter
 	 */
 	int (*counter_update_stats)(struct rdma_counter *counter);
 
-	/**
+	/*
 	 * counter_init - Initialize the driver specific rdma counter struct.
 	 */
 	void (*counter_init)(struct rdma_counter *counter);
 
-	/**
+	/*
 	 * Allows rdma drivers to add their own restrack attributes
 	 * dumped via 'rdma stat' iproute2 command.
 	 */
@@ -2730,25 +2730,25 @@ struct ib_device_ops {
 	 */
 	int (*get_numa_node)(struct ib_device *dev);
 
-	/**
+	/*
 	 * add_sub_dev - Add a sub IB device
 	 */
 	struct ib_device *(*add_sub_dev)(struct ib_device *parent,
 					 enum rdma_nl_dev_type type,
 					 const char *name);
 
-	/**
+	/*
 	 * del_sub_dev - Delete a sub IB device
 	 */
 	void (*del_sub_dev)(struct ib_device *sub_dev);
 
-	/**
+	/*
 	 * ufile_cleanup - Attempt to cleanup ubojects HW resources inside
 	 * the ufile.
 	 */
 	void (*ufile_hw_cleanup)(struct ib_uverbs_file *ufile);
 
-	/**
+	/*
 	 * report_port_event - Drivers need to implement this if they have
 	 * some private stuff to handle when link status changes.
 	 */
@@ -3157,8 +3157,8 @@ static inline u32 rdma_start_port(const
 
 /**
  * rdma_for_each_port - Iterate over all valid port numbers of the IB device
- * @device - The struct ib_device * to iterate over
- * @iter - The unsigned int to store the port number
+ * @device: The struct ib_device * to iterate over
+ * @iter: The unsigned int to store the port number
  */
 #define rdma_for_each_port(device, iter)                                       \
 	for (iter = rdma_start_port(device +				       \
@@ -3524,7 +3524,7 @@ static inline bool rdma_core_cap_opa_por
 /**
  * rdma_mtu_enum_to_int - Return the mtu of the port as an integer value.
  * @device: Device
- * @port_num: Port number
+ * @port: Port number
  * @mtu: enum value of MTU
  *
  * Return the MTU size supported by the port as an integer value. Will return
@@ -3542,7 +3542,7 @@ static inline int rdma_mtu_enum_to_int(s
 /**
  * rdma_mtu_from_attr - Return the mtu of the port from the port attribute.
  * @device: Device
- * @port_num: Port number
+ * @port: Port number
  * @attr: port attribute
  *
  * Return the MTU size supported by the port as an integer value.
@@ -3919,7 +3919,7 @@ static inline int ib_destroy_qp(struct i
 
 /**
  * ib_open_qp - Obtain a reference to an existing sharable QP.
- * @xrcd - XRC domain
+ * @xrcd: XRC domain
  * @qp_open_attr: Attributes identifying the QP to open.
  *
  * Returns a reference to a sharable QP.
@@ -4273,9 +4273,9 @@ static inline void ib_dma_unmap_sg_attrs
 /**
  * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
- * @sg: The sg_table object describing the buffer
+ * @sgt: The sg_table object describing the buffer
  * @direction: The direction of the DMA
- * @attrs: Optional DMA attributes for the map operation
+ * @dma_attrs: Optional DMA attributes for the map operation
  */
 static inline int ib_dma_map_sgtable_attrs(struct ib_device *dev,
 					   struct sg_table *sgt,
@@ -4419,8 +4419,8 @@ struct ib_mr *ib_alloc_mr_integrity(stru
 /**
  * ib_update_fast_reg_key - updates the key portion of the fast_reg MR
  *   R_Key and L_Key.
- * @mr - struct ib_mr pointer to be updated.
- * @newkey - new key to be used.
+ * @mr: struct ib_mr pointer to be updated.
+ * @newkey: new key to be used.
  */
 static inline void ib_update_fast_reg_key(struct ib_mr *mr, u8 newkey)
 {
@@ -4431,7 +4431,7 @@ static inline void ib_update_fast_reg_ke
 /**
  * ib_inc_rkey - increments the key portion of the given rkey. Can be used
  * for calculating a new rkey for type 2 memory windows.
- * @rkey - the rkey to increment.
+ * @rkey: the rkey to increment.
  */
 static inline u32 ib_inc_rkey(u32 rkey)
 {
@@ -4525,7 +4525,7 @@ int ib_check_mr_status(struct ib_mr *mr,
 
 /**
  * ib_device_try_get: Hold a registration lock
- * device: The device to lock
+ * @dev: The device to lock
  *
  * A device under an active registration lock cannot become unregistered. It
  * is only possible to obtain a registration lock on a device that is fully
@@ -4832,7 +4832,7 @@ ib_get_vector_affinity(struct ib_device
  * rdma_roce_rescan_device - Rescan all of the network devices in the system
  * and add their gids, as needed, to the relevant RoCE devices.
  *
- * @device:         the rdma device
+ * @ibdev:         the rdma device
  */
 void rdma_roce_rescan_device(struct ib_device *ibdev);
 void rdma_roce_rescan_port(struct ib_device *ib_dev, u32 port);
@@ -4885,7 +4885,7 @@ static inline struct ib_device *rdma_dev
 
 /**
  * ibdev_to_node - return the NUMA node for a given ib_device
- * @dev:	device to get the NUMA node for.
+ * @ibdev:	device to get the NUMA node for.
  */
 static inline int ibdev_to_node(struct ib_device *ibdev)
 {
@@ -4923,6 +4923,7 @@ static inline struct net *rdma_dev_net(s
 /**
  * rdma_flow_label_to_udp_sport - generate a RoCE v2 UDP src port value based
  *                               on the flow_label
+ * @fl: flow_label value
  *
  * This function will convert the 20 bit flow_label input to a valid RoCE v2
  * UDP src port 14 bit value. All RoCE V2 drivers should use this same

