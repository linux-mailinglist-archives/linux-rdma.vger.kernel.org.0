Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B83A2A7A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFJLmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:42:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5373 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLmv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:42:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G124r1Qz2z6vFh;
        Thu, 10 Jun 2021 19:37:00 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:40:53 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:40:52 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/core: Fix incorrect print format specifier
Date:   Thu, 10 Jun 2021 19:40:32 +0800
Message-ID: <1623325232-30900-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

There are some '%u' for 'int' and '%d' for 'unsigend int', they should be
fixed.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/cache.c       | 10 +++++-----
 drivers/infiniband/core/cm.c          |  2 +-
 drivers/infiniband/core/iwpm_msg.c    | 22 +++++++++++-----------
 drivers/infiniband/core/iwpm_util.c   |  4 ++--
 drivers/infiniband/core/mad.c         | 10 +++++-----
 drivers/infiniband/core/netlink.c     |  2 +-
 drivers/infiniband/core/rw.c          |  8 ++++----
 drivers/infiniband/core/security.c    |  2 +-
 drivers/infiniband/core/sysfs.c       | 10 +++++-----
 drivers/infiniband/core/ud_header.c   |  8 ++++----
 drivers/infiniband/core/umem_odp.c    |  2 +-
 drivers/infiniband/core/user_mad.c    |  4 ++--
 drivers/infiniband/core/uverbs_cmd.c  |  2 +-
 drivers/infiniband/core/uverbs_uapi.c |  2 +-
 drivers/infiniband/core/verbs.c       |  2 +-
 15 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index d320459..f44a0d4 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -240,7 +240,7 @@ static void free_gid_entry_locked(struct ib_gid_table_entry *entry)
 	u32 port_num = entry->attr.port_num;
 	struct ib_gid_table *table = rdma_gid_table(device, port_num);
 
-	dev_dbg(&device->dev, "%s port=%u index=%d gid %pI6\n", __func__,
+	dev_dbg(&device->dev, "%s port=%u index=%u gid %pI6\n", __func__,
 		port_num, entry->attr.index, entry->attr.gid.raw);
 
 	write_lock_irq(&table->rwlock);
@@ -323,7 +323,7 @@ static void store_gid_entry(struct ib_gid_table *table,
 {
 	entry->state = GID_TABLE_ENTRY_VALID;
 
-	dev_dbg(&entry->attr.device->dev, "%s port=%d index=%d gid %pI6\n",
+	dev_dbg(&entry->attr.device->dev, "%s port=%u index=%u gid %pI6\n",
 		__func__, entry->attr.port_num, entry->attr.index,
 		entry->attr.gid.raw);
 
@@ -354,7 +354,7 @@ static int add_roce_gid(struct ib_gid_table_entry *entry)
 	int ret;
 
 	if (!attr->ndev) {
-		dev_err(&attr->device->dev, "%s NULL netdev port=%d index=%d\n",
+		dev_err(&attr->device->dev, "%s NULL netdev port=%u index=%u\n",
 			__func__, attr->port_num, attr->index);
 		return -EINVAL;
 	}
@@ -362,7 +362,7 @@ static int add_roce_gid(struct ib_gid_table_entry *entry)
 		ret = attr->device->ops.add_gid(attr, &entry->context);
 		if (ret) {
 			dev_err(&attr->device->dev,
-				"%s GID add failed port=%d index=%d\n",
+				"%s GID add failed port=%u index=%u\n",
 				__func__, attr->port_num, attr->index);
 			return ret;
 		}
@@ -805,7 +805,7 @@ static void release_gid_table(struct ib_device *device,
 			continue;
 		if (kref_read(&table->data_vec[i]->kref) > 1) {
 			dev_err(&device->dev,
-				"GID entry ref leak for index %d ref=%d\n", i,
+				"GID entry ref leak for index %d ref=%u\n", i,
 				kref_read(&table->data_vec[i]->kref));
 			leak = true;
 		}
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 80087e6..63d6d1a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1791,7 +1791,7 @@ static u16 cm_get_bth_pkey(struct cm_work *work)
 
 	ret = ib_get_cached_pkey(ib_dev, port_num, pkey_index, &pkey);
 	if (ret) {
-		dev_warn_ratelimited(&ib_dev->dev, "ib_cm: Couldn't retrieve pkey for incoming request (port %d, pkey index %d). %d\n",
+		dev_warn_ratelimited(&ib_dev->dev, "ib_cm: Couldn't retrieve pkey for incoming request (port %u, pkey index %u). %d\n",
 				     port_num, pkey_index, ret);
 		return 0;
 	}
diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 932b26f..12a9816 100644
--- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -123,7 +123,7 @@ int iwpm_register_pid(struct iwpm_dev_data *pm_msg, u8 nl_client)
 	ret = iwpm_wait_complete_req(nlmsg_request);
 	return ret;
 pid_query_error:
-	pr_info("%s: %s (client = %d)\n", __func__, err_str, nl_client);
+	pr_info("%s: %s (client = %u)\n", __func__, err_str, nl_client);
 	dev_kfree_skb(skb);
 	if (nlmsg_request)
 		iwpm_free_nlmsg_request(&nlmsg_request->kref);
@@ -211,7 +211,7 @@ int iwpm_add_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 	ret = iwpm_wait_complete_req(nlmsg_request);
 	return ret;
 add_mapping_error:
-	pr_info("%s: %s (client = %d)\n", __func__, err_str, nl_client);
+	pr_info("%s: %s (client = %u)\n", __func__, err_str, nl_client);
 add_mapping_error_nowarn:
 	dev_kfree_skb(skb);
 	if (nlmsg_request)
@@ -304,7 +304,7 @@ int iwpm_add_and_query_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 	ret = iwpm_wait_complete_req(nlmsg_request);
 	return ret;
 query_mapping_error:
-	pr_info("%s: %s (client = %d)\n", __func__, err_str, nl_client);
+	pr_info("%s: %s (client = %u)\n", __func__, err_str, nl_client);
 query_mapping_error_nowarn:
 	dev_kfree_skb(skb);
 	if (nlmsg_request)
@@ -372,7 +372,7 @@ int iwpm_remove_mapping(struct sockaddr_storage *local_addr, u8 nl_client)
 			"remove_mapping: Local sockaddr:");
 	return 0;
 remove_mapping_error:
-	pr_info("%s: %s (client = %d)\n", __func__, err_str, nl_client);
+	pr_info("%s: %s (client = %u)\n", __func__, err_str, nl_client);
 	if (skb)
 		dev_kfree_skb_any(skb);
 	return ret;
@@ -431,7 +431,7 @@ int iwpm_register_pid_cb(struct sk_buff *skb, struct netlink_callback *cb)
 			strcmp(iwpm_ulib_name, iwpm_name) ||
 			iwpm_version < IWPM_UABI_VERSION_MIN) {
 
-		pr_info("%s: Incorrect info (dev = %s name = %s version = %d)\n",
+		pr_info("%s: Incorrect info (dev = %s name = %s version = %u)\n",
 				__func__, dev_name, iwpm_name, iwpm_version);
 		nlmsg_request->err_code = IWPM_USER_LIB_INFO_ERR;
 		goto register_pid_response_exit;
@@ -439,7 +439,7 @@ int iwpm_register_pid_cb(struct sk_buff *skb, struct netlink_callback *cb)
 	iwpm_user_pid = cb->nlh->nlmsg_pid;
 	iwpm_ulib_version = iwpm_version;
 	if (iwpm_ulib_version < IWPM_UABI_VERSION)
-		pr_warn_once("%s: Down level iwpmd/pid %u.  Continuing...",
+		pr_warn_once("%s: Down level iwpmd/pid %d.  Continuing...",
 			__func__, iwpm_user_pid);
 	atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
 	pr_debug("%s: iWarp Port Mapper (pid = %d) is available!\n",
@@ -650,7 +650,7 @@ int iwpm_remote_info_cb(struct sk_buff *skb, struct netlink_callback *cb)
 
 	nl_client = RDMA_NL_GET_CLIENT(cb->nlh->nlmsg_type);
 	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid port mapper client = %d\n",
+		pr_info("%s: Invalid port mapper client = %u\n",
 				__func__, nl_client);
 		return ret;
 	}
@@ -731,13 +731,13 @@ int iwpm_mapping_info_cb(struct sk_buff *skb, struct netlink_callback *cb)
 	iwpm_version = nla_get_u16(nltb[IWPM_NLA_MAPINFO_ULIB_VER]);
 	if (strcmp(iwpm_ulib_name, iwpm_name) ||
 			iwpm_version < IWPM_UABI_VERSION_MIN) {
-		pr_info("%s: Invalid port mapper name = %s version = %d\n",
+		pr_info("%s: Invalid port mapper name = %s version = %u\n",
 				__func__, iwpm_name, iwpm_version);
 		return ret;
 	}
 	nl_client = RDMA_NL_GET_CLIENT(cb->nlh->nlmsg_type);
 	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid port mapper client = %d\n",
+		pr_info("%s: Invalid port mapper client = %u\n",
 				__func__, nl_client);
 		return ret;
 	}
@@ -746,7 +746,7 @@ int iwpm_mapping_info_cb(struct sk_buff *skb, struct netlink_callback *cb)
 	iwpm_user_pid = cb->nlh->nlmsg_pid;
 
 	if (iwpm_ulib_version < IWPM_UABI_VERSION)
-		pr_warn_once("%s: Down level iwpmd/pid %u.  Continuing...",
+		pr_warn_once("%s: Down level iwpmd/pid %d.  Continuing...",
 			__func__, iwpm_user_pid);
 
 	if (!iwpm_mapinfo_available())
@@ -864,7 +864,7 @@ int iwpm_hello_cb(struct sk_buff *skb, struct netlink_callback *cb)
 	abi_version = nla_get_u16(nltb[IWPM_NLA_HELLO_ABI_VERSION]);
 	nl_client = RDMA_NL_GET_CLIENT(cb->nlh->nlmsg_type);
 	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid port mapper client = %d\n",
+		pr_info("%s: Invalid port mapper client = %u\n",
 				__func__, nl_client);
 		return ret;
 	}
diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index b8f40e6..3f8c019 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -307,7 +307,7 @@ int iwpm_get_remote_info(struct sockaddr_storage *mapped_loc_addr,
 	int ret = -EINVAL;
 
 	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid client = %d\n", __func__, nl_client);
+		pr_info("%s: Invalid client = %u\n", __func__, nl_client);
 		return ret;
 	}
 	spin_lock_irqsave(&iwpm_reminfo_lock, flags);
@@ -655,7 +655,7 @@ static int send_mapinfo_num(u32 mapping_num, u8 nl_client, int iwpm_pid)
 		err_str = "Unable to send a nlmsg";
 		goto mapinfo_num_error;
 	}
-	pr_debug("%s: Sent mapping number = %d\n", __func__, mapping_num);
+	pr_debug("%s: Sent mapping number = %u\n", __func__, mapping_num);
 	return 0;
 mapinfo_num_error:
 	pr_info("%s: %s\n", __func__, err_str);
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index df6226f..1893aa6 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -351,7 +351,7 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	/* Validate device and port */
 	port_priv = ib_get_mad_port(device, port_num);
 	if (!port_priv) {
-		dev_dbg_ratelimited(&device->dev, "%s: Invalid port %d\n",
+		dev_dbg_ratelimited(&device->dev, "%s: Invalid port %u\n",
 				    __func__, port_num);
 		ret = ERR_PTR(-ENODEV);
 		goto error1;
@@ -1626,7 +1626,7 @@ static int validate_mad(const struct ib_mad_hdr *mad_hdr,
 	/* Make sure MAD base version is understood */
 	if (mad_hdr->base_version != IB_MGMT_BASE_VERSION &&
 	    (!opa || mad_hdr->base_version != OPA_MGMT_BASE_VERSION)) {
-		pr_err("MAD received with unsupported base version %d %s\n",
+		pr_err("MAD received with unsupported base version %u %s\n",
 		       mad_hdr->base_version, opa ? "(opa)" : "");
 		goto out;
 	}
@@ -2867,7 +2867,7 @@ static void qp_event_handler(struct ib_event *event, void *qp_context)
 
 	/* It's worse than that! He's dead, Jim! */
 	dev_err(&qp_info->port_priv->device->dev,
-		"Fatal error (%d) on MAD QP (%d)\n",
+		"Fatal error (%d) on MAD QP (%u)\n",
 		event->event, qp_info->qp->qp_num);
 }
 
@@ -3125,9 +3125,9 @@ static void ib_mad_remove_device(struct ib_device *device, void *client_data)
 
 		if (ib_agent_port_close(device, i))
 			dev_err(&device->dev,
-				"Couldn't close port %d for agents\n", i);
+				"Couldn't close port %u for agents\n", i);
 		if (ib_mad_port_close(device, i))
-			dev_err(&device->dev, "Couldn't close port %d\n", i);
+			dev_err(&device->dev, "Couldn't close port %u\n", i);
 	}
 }
 
diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
index 8cd31ef..1b2cc9e 100644
--- a/drivers/infiniband/core/netlink.c
+++ b/drivers/infiniband/core/netlink.c
@@ -98,7 +98,7 @@ get_cb_table(const struct sk_buff *skb, unsigned int type, unsigned int op)
 		 */
 		up_read(&rdma_nl_types[type].sem);
 
-		request_module("rdma-netlink-subsys-%d", type);
+		request_module("rdma-netlink-subsys-%u", type);
 
 		down_read(&rdma_nl_types[type].sem);
 		cb_table = READ_ONCE(rdma_nl_types[type].cb_table);
diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index a588c20..5221cce 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -389,7 +389,7 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	int count = 0, ret;
 
 	if (sg_cnt > pages_per_mr || prot_sg_cnt > pages_per_mr) {
-		pr_err("SG count too large: sg_cnt=%d, prot_sg_cnt=%d, pages_per_mr=%d\n",
+		pr_err("SG count too large: sg_cnt=%u, prot_sg_cnt=%u, pages_per_mr=%u\n",
 		       sg_cnt, prot_sg_cnt, pages_per_mr);
 		return -EINVAL;
 	}
@@ -429,7 +429,7 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sg_cnt, NULL, prot_sg,
 			      prot_sg_cnt, NULL, SZ_4K);
 	if (unlikely(ret)) {
-		pr_err("failed to map PI sg (%d)\n", sg_cnt + prot_sg_cnt);
+		pr_err("failed to map PI sg (%u)\n", sg_cnt + prot_sg_cnt);
 		goto out_destroy_sig_mr;
 	}
 
@@ -714,7 +714,7 @@ int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 				IB_MR_TYPE_MEM_REG,
 				max_num_sg, 0);
 		if (ret) {
-			pr_err("%s: failed to allocated %d MRs\n",
+			pr_err("%s: failed to allocated %u MRs\n",
 				__func__, nr_mrs);
 			return ret;
 		}
@@ -724,7 +724,7 @@ int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 		ret = ib_mr_pool_init(qp, &qp->sig_mrs, nr_sig_mrs,
 				IB_MR_TYPE_INTEGRITY, max_num_sg, max_num_sg);
 		if (ret) {
-			pr_err("%s: failed to allocated %d SIG MRs\n",
+			pr_err("%s: failed to allocated %u SIG MRs\n",
 				__func__, nr_sig_mrs);
 			goto out_free_rdma_mrs;
 		}
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index e5a78d1..b552885 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -586,7 +586,7 @@ int ib_security_modify_qp(struct ib_qp *qp,
 	WARN_ONCE((qp_attr_mask & IB_QP_PORT &&
 		   rdma_protocol_ib(real_qp->device, qp_attr->port_num) &&
 		   !real_qp->qp_sec),
-		   "%s: QP security is not initialized for IB QP: %d\n",
+		   "%s: QP security is not initialized for IB QP: %u\n",
 		   __func__, real_qp->qp_num);
 
 	/* The port/pkey settings are maintained only for the real QP. Open
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 05b702d..b66be1d 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -196,7 +196,7 @@ static ssize_t lid_mask_count_show(struct ib_port *p,
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", attr.lmc);
+	return sysfs_emit(buf, "%u\n", attr.lmc);
 }
 
 static ssize_t sm_lid_show(struct ib_port *p, struct port_attribute *unused,
@@ -222,7 +222,7 @@ static ssize_t sm_sl_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", attr.sm_sl);
+	return sysfs_emit(buf, "%u\n", attr.sm_sl);
 }
 
 static ssize_t cap_mask_show(struct ib_port *p, struct port_attribute *unused,
@@ -324,7 +324,7 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d: %s\n", attr.phys_state,
+	return sysfs_emit(buf, "%u: %s\n", attr.phys_state,
 			  phys_state_to_str(attr.phys_state));
 }
 
@@ -546,7 +546,7 @@ static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
 
 	switch (width) {
 	case 4:
-		len = sysfs_emit(buf, "%u\n",
+		len = sysfs_emit(buf, "%d\n",
 				 (*data >> (4 - (offset % 8))) & 0xf);
 		break;
 	case 8:
@@ -1259,7 +1259,7 @@ static ssize_t node_type_show(struct device *device,
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
 
-	return sysfs_emit(buf, "%d: %s\n", dev->node_type,
+	return sysfs_emit(buf, "%u: %s\n", dev->node_type,
 			  node_type_string(dev->node_type));
 }
 static DEVICE_ATTR_RO(node_type);
diff --git a/drivers/infiniband/core/ud_header.c b/drivers/infiniband/core/ud_header.c
index d65d541..64d9c49 100644
--- a/drivers/infiniband/core/ud_header.c
+++ b/drivers/infiniband/core/ud_header.c
@@ -479,7 +479,7 @@ int ib_ud_header_unpack(void                *buf,
 	buf += IB_LRH_BYTES;
 
 	if (header->lrh.link_version != 0) {
-		pr_warn("Invalid LRH.link_version %d\n",
+		pr_warn("Invalid LRH.link_version %u\n",
 			header->lrh.link_version);
 		return -EINVAL;
 	}
@@ -496,7 +496,7 @@ int ib_ud_header_unpack(void                *buf,
 		buf += IB_GRH_BYTES;
 
 		if (header->grh.ip_version != 6) {
-			pr_warn("Invalid GRH.ip_version %d\n",
+			pr_warn("Invalid GRH.ip_version %u\n",
 				header->grh.ip_version);
 			return -EINVAL;
 		}
@@ -508,7 +508,7 @@ int ib_ud_header_unpack(void                *buf,
 		break;
 
 	default:
-		pr_warn("Invalid LRH.link_next_header %d\n",
+		pr_warn("Invalid LRH.link_next_header %u\n",
 			header->lrh.link_next_header);
 		return -EINVAL;
 	}
@@ -530,7 +530,7 @@ int ib_ud_header_unpack(void                *buf,
 	}
 
 	if (header->bth.transport_header_version != 0) {
-		pr_warn("Invalid BTH.transport_header_version %d\n",
+		pr_warn("Invalid BTH.transport_header_version %u\n",
 			header->bth.transport_header_version);
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 323f6cf..9462dbe 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -445,7 +445,7 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 		if (hmm_order + PAGE_SHIFT < page_shift) {
 			ret = -EINVAL;
 			ibdev_dbg(umem_odp->umem.ibdev,
-				  "%s: un-expected hmm_order %d, page_shift %d\n",
+				  "%s: un-expected hmm_order %u, page_shift %u\n",
 				  __func__, hmm_order, page_shift);
 			break;
 		}
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 852efed..98cb594 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -700,7 +700,7 @@ static int ib_umad_reg_agent(struct ib_umad_file *file, void __user *arg,
 
 	if (ureq.qpn != 0 && ureq.qpn != 1) {
 		dev_notice(&file->port->dev,
-			   "%s: invalid QPN %d specified\n", __func__,
+			   "%s: invalid QPN %u specified\n", __func__,
 			   ureq.qpn);
 		ret = -EINVAL;
 		goto out;
@@ -800,7 +800,7 @@ static int ib_umad_reg_agent2(struct ib_umad_file *file, void __user *arg)
 	}
 
 	if (ureq.qpn != 0 && ureq.qpn != 1) {
-		dev_notice(&file->port->dev, "%s: invalid QPN %d specified\n",
+		dev_notice(&file->port->dev, "%s: invalid QPN %u specified\n",
 			   __func__, ureq.qpn);
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 74ab018..bc56036 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3314,7 +3314,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		ib_spec += ((union ib_flow_spec *) ib_spec)->size;
 	}
 	if (cmd.flow_attr.size || (i != flow_attr->num_of_specs)) {
-		pr_warn("create flow failed, flow %d: %d bytes left from uverb cmd\n",
+		pr_warn("create flow failed, flow %d: %u bytes left from uverb cmd\n",
 			i, cmd.flow_attr.size);
 		err = -EINVAL;
 		goto err_free;
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 62f5bcb..2f2c764 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -517,7 +517,7 @@ static void uapi_key_okay(u32 key)
 		count++;
 	if (uapi_key_is_attr(key))
 		count++;
-	WARN(count != 1, "Bad count %d key=%x", count, key);
+	WARN(count != 1, "Bad count %u key=%x", count, key);
 }
 
 static void uapi_finalize_disable(struct uverbs_api *uapi)
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index a2dfe2d..7036967 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1834,7 +1834,7 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 		netdev_speed = lksettings.base.speed;
 	} else {
 		netdev_speed = SPEED_1000;
-		pr_warn("%s speed is unknown, defaulting to %d\n", netdev->name,
+		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
 			netdev_speed);
 	}
 
-- 
2.7.4

