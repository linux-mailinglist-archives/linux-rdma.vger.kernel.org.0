Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C3239D71C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFGIUi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhFGIUh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8C1061029;
        Mon,  7 Jun 2021 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053926;
        bh=ySIUCcbsUCMqc47adh3GmGxNIwJHOXchpKCHe5GfiVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGMsqIXPXlmqx1xYU6ezSpyJn2PHU52xZtX4p7kIi3wBrKVm5hQpWowVpvXgJjCKY
         AsCU2oShuQkIyg9toWU+iLSzZsVB6MdHhUKVKE7biYAkPUqX36qwIo1khHQlBRVT+I
         ysducKF4Y8YQxBz3Kyy4VTB2t/azcbh4zBbgt5YIRAf1OJOYLdWz5gMk4iKWoV8Bp7
         nFnDvwXnIuKEpvTv/w27kgycqaKRmh86lvUFWX212M3YAJ4O9uItriIWOwVQMQ+1zq
         KPLRvHcCWxYibNiUFAgqFKCdLBngW30LBO/O1dj0qLkZvOxU0OhYaOFHuGF9MvuEGS
         gZoQnb/ee/sGA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
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
Subject: [PATCH rdma-next v1 13/15] RDMA: Change ops->init_port to ops->port_groups
Date:   Mon,  7 Jun 2021 11:17:38 +0300
Message-Id: <95c71dde9f189a0cbde5a9fdd35a354e92ef18b1.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

init_port was only being used to register sysfs attributes against the
port kobject. Now that all users are creating static attribute_group's we can
simply set the attribute_group list in the ops and the core code can just
handle it directly.

This makes all the sysfs management quite straightforward and prevents any
driver from abusing the naked port kobject in future because no driver
code can access it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c      |  4 +--
 drivers/infiniband/core/sysfs.c       | 39 +++++++++------------------
 drivers/infiniband/hw/hfi1/hfi.h      |  3 +--
 drivers/infiniband/hw/hfi1/sysfs.c    | 12 +--------
 drivers/infiniband/hw/hfi1/verbs.c    |  2 +-
 drivers/infiniband/hw/qib/qib.h       |  4 +--
 drivers/infiniband/hw/qib/qib_sysfs.c | 20 +-------------
 drivers/infiniband/hw/qib/qib_verbs.c |  4 +--
 drivers/infiniband/sw/rdmavt/vt.c     |  2 +-
 include/rdma/ib_sysfs.h               |  4 ---
 include/rdma/ib_verbs.h               |  9 +++----
 11 files changed, 25 insertions(+), 78 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 030a4041b2e0..2cbd77933ea5 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1703,7 +1703,7 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 * port_cleanup infrastructure is implemented, this limitation will be
 	 * removed.
 	 */
-	if (!dev->ops.disassociate_ucontext || dev->ops.init_port ||
+	if (!dev->ops.disassociate_ucontext || dev->ops.port_groups ||
 	    ib_devices_shared_netns) {
 		ret = -EOPNOTSUPP;
 		goto ns_err;
@@ -2668,7 +2668,6 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_guid);
 	SET_DEVICE_OP(dev_ops, get_vf_stats);
-	SET_DEVICE_OP(dev_ops, init_port);
 	SET_DEVICE_OP(dev_ops, iw_accept);
 	SET_DEVICE_OP(dev_ops, iw_add_ref);
 	SET_DEVICE_OP(dev_ops, iw_connect);
@@ -2691,6 +2690,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, modify_wq);
 	SET_DEVICE_OP(dev_ops, peek_cq);
 	SET_DEVICE_OP(dev_ops, poll_cq);
+	SET_DEVICE_OP(dev_ops, port_groups);
 	SET_DEVICE_OP(dev_ops, post_recv);
 	SET_DEVICE_OP(dev_ops, post_send);
 	SET_DEVICE_OP(dev_ops, post_srq_recv);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index e550a7eb37f6..09a2e1066df0 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -128,22 +128,6 @@ static ssize_t port_attr_store(struct kobject *kobj,
 	return port_attr->store(p->ibdev, p->port_num, port_attr, buf, count);
 }
 
-int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
-				const struct attribute_group **groups)
-{
-	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
-				   groups);
-}
-EXPORT_SYMBOL_GPL(ib_port_sysfs_create_groups);
-
-void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
-				 const struct attribute_group **groups)
-{
-	return sysfs_remove_groups(&ibdev->port_data[port_num].sysfs->kobj,
-				   groups);
-}
-EXPORT_SYMBOL_GPL(ib_port_sysfs_remove_groups);
-
 struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
 					       u32 *port_num)
 {
@@ -1252,6 +1236,11 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	ret = sysfs_create_groups(&p->kobj, p->groups_list);
 	if (ret)
 		goto err_del;
+	if (is_full_dev) {
+		ret = sysfs_create_groups(&p->kobj, device->ops.port_groups);
+		if (ret)
+			goto err_groups;
+	}
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
 	if (device->port_data && is_full_dev)
@@ -1259,6 +1248,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 
 	return p;
 
+err_groups:
+	sysfs_remove_groups(&p->kobj, p->groups_list);
 err_del:
 	kobject_del(&p->kobj);
 err_put:
@@ -1266,12 +1257,16 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	return ERR_PTR(ret);
 }
 
-static void destroy_port(struct ib_port *port)
+static void destroy_port(struct ib_core_device *coredev, struct ib_port *port)
 {
+	bool is_full_dev = &port->ibdev->coredev == coredev;
+
 	if (port->ibdev->port_data &&
 	    port->ibdev->port_data[port->port_num].sysfs == port)
 		port->ibdev->port_data[port->port_num].sysfs = NULL;
 	list_del(&port->kobj.entry);
+	if (is_full_dev)
+		sysfs_remove_groups(&port->kobj, port->ibdev->ops.port_groups);
 	sysfs_remove_groups(&port->kobj, port->groups_list);
 	kobject_del(&port->kobj);
 	kobject_put(&port->kobj);
@@ -1397,7 +1392,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 		struct ib_port *port = container_of(p, struct ib_port, kobj);
 
 		destroy_gid_attrs(port);
-		destroy_port(port);
+		destroy_port(coredev, port);
 	}
 
 	kobject_put(coredev->ports_kobj);
@@ -1406,7 +1401,6 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 int ib_setup_port_attrs(struct ib_core_device *coredev)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
-	bool is_full_dev = &device->coredev == coredev;
 	u32 port_num;
 	int ret;
 
@@ -1432,13 +1426,6 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 		ret = setup_gid_attrs(port, &attr);
 		if (ret)
 			goto err_put;
-
-		if (device->ops.init_port && is_full_dev) {
-			ret = device->ops.init_port(device, port_num,
-						    &port->kobj);
-			if (ret)
-				goto err_put;
-		}
 	}
 	return 0;
 
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 4bb807c154b2..31664f43c27f 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -2184,12 +2184,11 @@ static inline bool hfi1_packet_present(struct hfi1_ctxtdata *rcd)
 
 extern const char ib_hfi1_version[];
 extern const struct attribute_group ib_hfi1_attr_group;
+extern const struct attribute_group *hfi1_attr_port_groups[];
 
 int hfi1_device_create(struct hfi1_devdata *dd);
 void hfi1_device_remove(struct hfi1_devdata *dd);
 
-int hfi1_create_port_files(struct ib_device *ibdev, u32 port_num,
-			   struct kobject *kobj);
 int hfi1_verbs_register_sysfs(struct hfi1_devdata *dd);
 void hfi1_verbs_unregister_sysfs(struct hfi1_devdata *dd);
 /* Hook for sysfs read of QSFP */
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 326c6c2842f2..96ec62ae5b72 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -599,19 +599,13 @@ const struct attribute_group ib_hfi1_attr_group = {
 	.attrs = hfi1_attributes,
 };
 
-static const struct attribute_group *hfi1_port_groups[] = {
+const struct attribute_group *hfi1_attr_port_groups[] = {
 	&port_sc2vl_group,
 	&port_sl2sc_group,
 	&port_vl2mtu_group,
 	NULL,
 };
 
-int hfi1_create_port_files(struct ib_device *ibdev, u32 port_num,
-			   struct kobject *kobj)
-{
-	return ib_port_sysfs_create_groups(ibdev, port_num, hfi1_port_groups);
-}
-
 struct sde_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct sdma_engine *sde, char *buf);
@@ -740,8 +734,4 @@ void hfi1_verbs_unregister_sysfs(struct hfi1_devdata *dd)
 	/* Unwind operations in hfi1_verbs_register_sysfs() */
 	for (i = 0; i < dd->num_sdma; i++)
 		kobject_put(&dd->per_sdma[i].kobj);
-
-	for (i = 0; i < dd->num_pports; i++)
-		ib_port_sysfs_remove_groups(&dd->verbs_dev.rdi.ibdev, i + 1,
-					    hfi1_port_groups);
 }
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 85deba07a675..49c6ed267a47 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1791,8 +1791,8 @@ static const struct ib_device_ops hfi1_dev_ops = {
 	.alloc_rdma_netdev = hfi1_vnic_alloc_rn,
 	.get_dev_fw_str = hfi1_get_dev_fw_str,
 	.get_hw_stats = get_hw_stats,
-	.init_port = hfi1_create_port_files,
 	.modify_device = modify_device,
+	.port_groups = hfi1_attr_port_groups,
 	/* keep process mad in the driver */
 	.process_mad = hfi1_process_mad,
 	.rdma_netdev_get_params = hfi1_ipoib_rn_get_params,
diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index b8a2deb5b4d2..9363bccfc6e7 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1361,13 +1361,11 @@ static inline u32 qib_get_rcvhdrtail(const struct qib_ctxtdata *rcd)
 
 extern const char ib_qib_version[];
 extern const struct attribute_group qib_attr_group;
+extern const struct attribute_group *qib_attr_port_groups[];
 
 int qib_device_create(struct qib_devdata *);
 void qib_device_remove(struct qib_devdata *);
 
-int qib_create_port_files(struct ib_device *ibdev, u32 port_num,
-			  struct kobject *kobj);
-void qib_verbs_unregister_sysfs(struct qib_devdata *);
 /* Hook for sysfs read of QSFP */
 extern int qib_qsfp_dump(struct qib_pportdata *ppd, char *buf, int len);
 
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index a1e22c498712..d57e49de6650 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -545,7 +545,7 @@ static const struct attribute_group port_diagc_group = {
 
 /* End diag_counters */
 
-static const struct attribute_group *qib_port_groups[] = {
+const struct attribute_group *qib_attr_port_groups[] = {
 	&port_linkcontrol_group,
 	&port_ccmgta_attribute_group,
 	&port_sl2vl_group,
@@ -733,21 +733,3 @@ static struct attribute *qib_attributes[] = {
 const struct attribute_group qib_attr_group = {
 	.attrs = qib_attributes,
 };
-
-int qib_create_port_files(struct ib_device *ibdev, u32 port_num,
-			  struct kobject *kobj)
-{
-	return ib_port_sysfs_create_groups(ibdev, port_num, qib_port_groups);
-}
-
-/*
- * Unregister and remove our files in /sys/class/infiniband.
- */
-void qib_verbs_unregister_sysfs(struct qib_devdata *dd)
-{
-	int i;
-
-	for (i = 0; i < dd->num_pports; i++)
-		ib_port_sysfs_remove_groups(&dd->verbs_dev.rdi.ibdev, i,
-					    qib_port_groups);
-}
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index d17d034ecdfd..8640a75d61d9 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1483,7 +1483,7 @@ static const struct ib_device_ops qib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_QIB,
 
-	.init_port = qib_create_port_files,
+	.port_groups = qib_attr_port_groups,
 	.modify_device = qib_modify_device,
 	.process_mad = qib_process_mad,
 };
@@ -1644,8 +1644,6 @@ void qib_unregister_ib_device(struct qib_devdata *dd)
 {
 	struct qib_ibdev *dev = &dd->verbs_dev;
 
-	qib_verbs_unregister_sysfs(dd);
-
 	rvt_unregister_device(&dd->verbs_dev.rdi);
 
 	if (!list_empty(&dev->piowait))
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 3749380ff193..ac17209816cd 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -418,7 +418,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
 		 * These functions are not part of verbs specifically but are
 		 * required for rdmavt to function.
 		 */
-		if ((!rdi->ibdev.ops.init_port) ||
+		if ((!rdi->ibdev.ops.port_groups) ||
 		    (!rdi->driver_f.get_pci_dev))
 			return -EINVAL;
 		break;
diff --git a/include/rdma/ib_sysfs.h b/include/rdma/ib_sysfs.h
index f869d0e4fd30..3b77cfd74d9a 100644
--- a/include/rdma/ib_sysfs.h
+++ b/include/rdma/ib_sysfs.h
@@ -31,10 +31,6 @@ struct ib_port_attribute {
 #define IB_PORT_ATTR_WO(_name)                                                 \
 	struct ib_port_attribute ib_port_attr_##_name = __ATTR_WO(_name)
 
-int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
-				const struct attribute_group **groups);
-void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
-				 const struct attribute_group **groups);
 struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
 					       u32 *port_num);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5ca1cb82a543..303471585dde 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2300,6 +2300,8 @@ struct ib_device_ops {
 	u32 uverbs_abi_ver;
 	unsigned int uverbs_no_driver_id_binding:1;
 
+	const struct attribute_group **port_groups;
+
 	int (*post_send)(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 			 const struct ib_send_wr **bad_send_wr);
 	int (*post_recv)(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
@@ -2546,12 +2548,7 @@ struct ib_device_ops {
 	 */
 	int (*get_hw_stats)(struct ib_device *device,
 			    struct rdma_hw_stats *stats, u32 port, int index);
-	/*
-	 * This function is called once for each port when a ib device is
-	 * registered.
-	 */
-	int (*init_port)(struct ib_device *device, u32 port_num,
-			 struct kobject *port_sysfs);
+
 	/**
 	 * Allows rdma drivers to add their own restrack attributes.
 	 */
-- 
2.31.1

