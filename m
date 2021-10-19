Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6A433E5E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 20:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJSS2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 14:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233944AbhJSS2p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 14:28:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC000613A6;
        Tue, 19 Oct 2021 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634667992;
        bh=WYRpMfZtc/m/krry1yHID/cpDVhGPljbYEAMGJd8pVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htVr2WGcQS10+piLpzxbRBXcuAatdaFtdkKB6Z2+ya/VtTVgbxtUkl387/EEO1LYQ
         Jo5rTMk0xUK3BIHzUrJOc1ZCedgFtdytMywE72WftbtlKu0IJ120ZjSC3KDdxfpqBB
         bRWPIMyBC4NOqcG/aG73AZS4IQqtYIMCC/ZUhixJUcxJbDRRdCas/Abm7dqpbbzAqA
         0VbM9CKRAKVmGBjzZqEauw8xhknTsSsRabF/VlclmnShkHD0ble+LNLytHVAlqKMii
         hv9PdvorjxE0k+QnylHGTZnPF8d5tAUcJKNvMWrhO8jBrJexLQv9ULFKmVINYpZRGX
         ptpgPcOt8cWTA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com, benve@cisco.com,
        neescoba@cisco.com
Subject: [PATCH rdma-next 3/3] RDMA: constify netdev->dev_addr accesses
Date:   Tue, 19 Oct 2021 11:26:04 -0700
Message-Id: <20211019182604.1441387-4-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019182604.1441387-1-kuba@kernel.org>
References: <20211019182604.1441387-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

netdev->dev_addr will become const soon, make sure
drivers propagate the qualifier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mike.marciniszyn@cornelisnetworks.com
CC: dennis.dalessandro@cornelisnetworks.com
CC: dledford@redhat.com
CC: jgg@ziepe.ca
CC: liangwenpeng@huawei.com
CC: liweihang@huawei.com
CC: mustafa.ismail@intel.com
CC: shiraz.saleem@intel.com
CC: benve@cisco.com
CC: neescoba@cisco.com
CC: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  5 +++--
 drivers/infiniband/hw/hfi1/ipoib_main.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 10 +++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_main.c   |  3 ++-
 drivers/infiniband/hw/irdma/cm.h            |  4 ++--
 drivers/infiniband/hw/irdma/hw.c            |  7 ++++---
 drivers/infiniband/hw/irdma/main.h          |  5 +++--
 drivers/infiniband/hw/irdma/trace_cm.h      |  8 +++++---
 drivers/infiniband/hw/irdma/utils.c         |  4 ++--
 drivers/infiniband/hw/irdma/verbs.c         |  2 +-
 drivers/infiniband/hw/usnic/usnic_fwd.c     |  2 +-
 drivers/infiniband/hw/usnic/usnic_fwd.h     |  2 +-
 17 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index bf49363f590e..a1d8a87dc678 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -573,7 +573,7 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 }
 
 /* GUID */
-void bnxt_qplib_get_guid(u8 *dev_addr, u8 *guid)
+void bnxt_qplib_get_guid(const u8 *dev_addr, u8 *guid)
 {
 	u8 mac[ETH_ALEN];
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index c39b20236f16..d2951a713cc8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -346,7 +346,7 @@ void bnxt_qplib_free_hwq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_hwq *hwq);
 int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			      struct bnxt_qplib_hwq_attr *hwq_attr);
-void bnxt_qplib_get_guid(u8 *dev_addr, u8 *guid);
+void bnxt_qplib_get_guid(const u8 *dev_addr, u8 *guid);
 int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pd_tbl,
 			struct bnxt_qplib_pd *pd);
 int bnxt_qplib_dealloc_pd(struct bnxt_qplib_res *res,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index cbe83e9bce5c..379e715ebd30 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -287,8 +287,8 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 }
 
 int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
-			struct bnxt_qplib_gid *gid, u8 *smac, u16 vlan_id,
-			bool update, u32 *index)
+			struct bnxt_qplib_gid *gid, const u8 *smac,
+			u16 vlan_id, bool update, u32 *index)
 {
 	struct bnxt_qplib_res *res = to_bnxt_qplib(sgid_tbl,
 						   struct bnxt_qplib_res,
@@ -379,7 +379,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			   struct bnxt_qplib_gid *gid, u16 gid_idx,
-			   u8 *smac)
+			   const u8 *smac)
 {
 	struct bnxt_qplib_res *res = to_bnxt_qplib(sgid_tbl,
 						   struct bnxt_qplib_res,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 3d5c41841668..a18f568cb23e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -250,10 +250,11 @@ int bnxt_qplib_get_sgid(struct bnxt_qplib_res *res,
 int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			struct bnxt_qplib_gid *gid, u16 vlan_id, bool update);
 int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
-			struct bnxt_qplib_gid *gid, u8 *mac, u16 vlan_id,
+			struct bnxt_qplib_gid *gid, const u8 *mac, u16 vlan_id,
 			bool update, u32 *index);
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
-			   struct bnxt_qplib_gid *gid, u16 gid_idx, u8 *smac);
+			   struct bnxt_qplib_gid *gid, u16 gid_idx,
+			   const u8 *smac);
 int bnxt_qplib_get_pkey(struct bnxt_qplib_res *res,
 			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 index,
 			u16 *pkey);
diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index e594a961f513..e1a2b02bbd91 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -11,7 +11,7 @@
 #include "ipoib.h"
 #include "hfi.h"
 
-static u32 qpn_from_mac(u8 *mac_arr)
+static u32 qpn_from_mac(const u8 *mac_arr)
 {
 	return (u32)mac_arr[1] << 16 | mac_arr[2] << 8 | mac_arr[3];
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 9467c39e3d28..e5dadcd118ac 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -898,7 +898,8 @@ struct hns_roce_hw {
 	bool (*chk_mbox_avail)(struct hns_roce_dev *hr_dev, bool *is_busy);
 	int (*set_gid)(struct hns_roce_dev *hr_dev, u32 port, int gid_index,
 		       const union ib_gid *gid, const struct ib_gid_attr *attr);
-	int (*set_mac)(struct hns_roce_dev *hr_dev, u8 phy_port, u8 *addr);
+	int (*set_mac)(struct hns_roce_dev *hr_dev, u8 phy_port,
+		       const u8 *addr);
 	void (*set_mtu)(struct hns_roce_dev *hr_dev, u8 phy_port,
 			enum ib_mtu mtu);
 	int (*write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index e0f59b8d7d5d..f4af3992ba95 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -90,11 +90,11 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 	unsigned long flags = 0;
 	void *wqe = NULL;
 	__le32 doorbell[2];
+	const u8 *smac;
 	int ret = 0;
 	int loopback;
 	u32 wqe_idx;
 	int nreq;
-	u8 *smac;
 
 	if (unlikely(ibqp->qp_type != IB_QPT_GSI &&
 		ibqp->qp_type != IB_QPT_RC)) {
@@ -154,7 +154,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				       UD_SEND_WQE_U32_8_DMAC_5_S,
 				       ah->av.mac[5]);
 
-			smac = (u8 *)hr_dev->dev_addr[qp->port];
+			smac = (const u8 *)hr_dev->dev_addr[qp->port];
 			loopback = ether_addr_equal_unaligned(ah->av.mac,
 							      smac) ? 1 : 0;
 			roce_set_bit(ud_sq_wqe->u32_8,
@@ -1782,7 +1782,7 @@ static int hns_roce_v1_set_gid(struct hns_roce_dev *hr_dev, u32 port,
 }
 
 static int hns_roce_v1_set_mac(struct hns_roce_dev *hr_dev, u8 phy_port,
-			       u8 *addr)
+			       const u8 *addr)
 {
 	u32 reg_smac_l;
 	u16 reg_smac_h;
@@ -2743,12 +2743,12 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	__le32 doorbell[2] = {0};
 	u64 *mtts_2 = NULL;
 	int ret = -EINVAL;
+	const u8 *smac;
 	u64 sq_ba = 0;
 	u64 rq_ba = 0;
 	u32 port;
 	u32 port_num;
 	u8 *dmac;
-	u8 *smac;
 
 	if (!check_qp_state(cur_state, new_state)) {
 		ibdev_err(ibqp->device,
@@ -2947,7 +2947,7 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 
 		port = (attr_mask & IB_QP_PORT) ? (attr->port_num - 1) :
 			hr_qp->port;
-		smac = (u8 *)hr_dev->dev_addr[port];
+		smac = (const u8 *)hr_dev->dev_addr[port];
 		/* when dmac equals smac or loop_idc is 1, it should loopback */
 		if (ether_addr_equal_unaligned(dmac, smac) ||
 		    hr_dev->loop_idc == 0x1)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 91990fad7185..c2916b170a41 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2982,7 +2982,7 @@ static int hns_roce_v2_set_gid(struct hns_roce_dev *hr_dev, u32 port,
 }
 
 static int hns_roce_v2_set_mac(struct hns_roce_dev *hr_dev, u8 phy_port,
-			       u8 *addr)
+			       const u8 *addr)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_cfg_smac_tb *smac_tb =
@@ -4308,10 +4308,10 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
 	enum ib_mtu ib_mtu;
+	const u8 *smac;
 	u8 lp_pktn_ini;
 	u64 *mtts;
 	u8 *dmac;
-	u8 *smac;
 	u32 port;
 	int mtu;
 	int ret;
@@ -4364,7 +4364,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 
 	port = (attr_mask & IB_QP_PORT) ? (attr->port_num - 1) : hr_qp->port;
 
-	smac = (u8 *)hr_dev->dev_addr[port];
+	smac = (const u8 *)hr_dev->dev_addr[port];
 	dmac = (u8 *)attr->ah_attr.roce.dmac;
 	/* when dmac equals smac or loop_idc is 1, it should loopback */
 	if (ether_addr_equal_unaligned(dmac, smac) ||
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 5d39bd08582a..b3595b6079b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -42,7 +42,8 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
 
-static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u32 port, u8 *addr)
+static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u32 port,
+			    const u8 *addr)
 {
 	u8 phy_port;
 	u32 i;
diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma/cm.h
index 1fbe72e18625..3bf42728e9b7 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -389,7 +389,7 @@ int irdma_reject(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len);
 int irdma_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
 int irdma_create_listen(struct iw_cm_id *cm_id, int backlog);
 int irdma_destroy_listen(struct iw_cm_id *cm_id);
-int irdma_add_arp(struct irdma_pci_f *rf, u32 *ip, bool ipv4, u8 *mac);
+int irdma_add_arp(struct irdma_pci_f *rf, u32 *ip, bool ipv4, const u8 *mac);
 void irdma_cm_teardown_connections(struct irdma_device *iwdev, u32 *ipaddr,
 				   struct irdma_cm_info *nfo,
 				   bool disconnect_all);
@@ -398,7 +398,7 @@ int irdma_cm_stop(struct irdma_device *dev);
 bool irdma_ipv4_is_lpb(u32 loc_addr, u32 rem_addr);
 bool irdma_ipv6_is_lpb(u32 *loc_addr, u32 *rem_addr);
 int irdma_arp_table(struct irdma_pci_f *rf, u32 *ip_addr, bool ipv4,
-		    u8 *mac_addr, u32 action);
+		    const u8 *mac_addr, u32 action);
 void irdma_if_notify(struct irdma_device *iwdev, struct net_device *netdev,
 		     u32 *ipaddr, bool ipv4, bool ifup);
 bool irdma_port_in_use(struct irdma_cm_core *cm_core, u16 port);
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 7de525a5ccf8..4108dcabece2 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1057,7 +1057,7 @@ static enum irdma_status_code irdma_alloc_set_mac(struct irdma_device *iwdev)
 					     &iwdev->mac_ip_table_idx);
 	if (!status) {
 		status = irdma_add_local_mac_entry(iwdev->rf,
-						   (u8 *)iwdev->netdev->dev_addr,
+						   (const u8 *)iwdev->netdev->dev_addr,
 						   (u8)iwdev->mac_ip_table_idx);
 		if (status)
 			irdma_del_local_mac_entry(iwdev->rf,
@@ -2191,7 +2191,7 @@ void irdma_del_local_mac_entry(struct irdma_pci_f *rf, u16 idx)
  * @mac_addr: pointer to mac address
  * @idx: the index of the mac ip address to add
  */
-int irdma_add_local_mac_entry(struct irdma_pci_f *rf, u8 *mac_addr, u16 idx)
+int irdma_add_local_mac_entry(struct irdma_pci_f *rf, const u8 *mac_addr, u16 idx)
 {
 	struct irdma_local_mac_entry_info *info;
 	struct irdma_cqp *iwcqp = &rf->cqp;
@@ -2362,7 +2362,8 @@ void irdma_del_apbvt(struct irdma_device *iwdev,
  * @ipv4: flag inicating IPv4
  * @action: add, delete or modify
  */
-void irdma_manage_arp_cache(struct irdma_pci_f *rf, unsigned char *mac_addr,
+void irdma_manage_arp_cache(struct irdma_pci_f *rf,
+			    const unsigned char *mac_addr,
 			    u32 *ip_addr, bool ipv4, u32 action)
 {
 	struct irdma_add_arp_cache_entry_info *info;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index b678fe712447..91a497139ba3 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -467,7 +467,8 @@ void irdma_qp_rem_ref(struct ib_qp *ibqp);
 void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp);
 struct ib_qp *irdma_get_qp(struct ib_device *ibdev, int qpn);
 void irdma_flush_wqes(struct irdma_qp *iwqp, u32 flush_mask);
-void irdma_manage_arp_cache(struct irdma_pci_f *rf, unsigned char *mac_addr,
+void irdma_manage_arp_cache(struct irdma_pci_f *rf,
+			    const unsigned char *mac_addr,
 			    u32 *ip_addr, bool ipv4, u32 action);
 struct irdma_apbvt_entry *irdma_add_apbvt(struct irdma_device *iwdev, u16 port);
 void irdma_del_apbvt(struct irdma_device *iwdev,
@@ -479,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 void irdma_put_cqp_request(struct irdma_cqp *cqp,
 			   struct irdma_cqp_request *cqp_request);
 int irdma_alloc_local_mac_entry(struct irdma_pci_f *rf, u16 *mac_tbl_idx);
-int irdma_add_local_mac_entry(struct irdma_pci_f *rf, u8 *mac_addr, u16 idx);
+int irdma_add_local_mac_entry(struct irdma_pci_f *rf, const u8 *mac_addr, u16 idx);
 void irdma_del_local_mac_entry(struct irdma_pci_f *rf, u16 idx);
 
 u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf);
diff --git a/drivers/infiniband/hw/irdma/trace_cm.h b/drivers/infiniband/hw/irdma/trace_cm.h
index bcf10ec427d6..f633fb343328 100644
--- a/drivers/infiniband/hw/irdma/trace_cm.h
+++ b/drivers/infiniband/hw/irdma/trace_cm.h
@@ -144,7 +144,7 @@ DEFINE_EVENT(tos_template, irdma_dcb_tos,
 DECLARE_EVENT_CLASS(qhash_template,
 		    TP_PROTO(struct irdma_device *iwdev,
 			     struct irdma_cm_listener *listener,
-			     char *dev_addr),
+			     const char *dev_addr),
 		    TP_ARGS(iwdev, listener, dev_addr),
 		    TP_STRUCT__entry(__field(struct irdma_device *, iwdev)
 				     __field(u16, lport)
@@ -173,12 +173,14 @@ DECLARE_EVENT_CLASS(qhash_template,
 
 DEFINE_EVENT(qhash_template, irdma_add_mqh_6,
 	     TP_PROTO(struct irdma_device *iwdev,
-		      struct irdma_cm_listener *listener, char *dev_addr),
+		      struct irdma_cm_listener *listener,
+		      const char *dev_addr),
 	     TP_ARGS(iwdev, listener, dev_addr));
 
 DEFINE_EVENT(qhash_template, irdma_add_mqh_4,
 	     TP_PROTO(struct irdma_device *iwdev,
-		      struct irdma_cm_listener *listener, char *dev_addr),
+		      struct irdma_cm_listener *listener,
+		      const char *dev_addr),
 	     TP_ARGS(iwdev, listener, dev_addr));
 
 TRACE_EVENT(irdma_addr_resolve,
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 0ebce57e8756..8b42c43fc14f 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -11,7 +11,7 @@
  * @action: modify, delete or add
  */
 int irdma_arp_table(struct irdma_pci_f *rf, u32 *ip_addr, bool ipv4,
-		    u8 *mac_addr, u32 action)
+		    const u8 *mac_addr, u32 action)
 {
 	unsigned long flags;
 	int arp_index;
@@ -77,7 +77,7 @@ int irdma_arp_table(struct irdma_pci_f *rf, u32 *ip_addr, bool ipv4,
  * @ipv4: IPv4 flag
  * @mac: MAC address
  */
-int irdma_add_arp(struct irdma_pci_f *rf, u32 *ip, bool ipv4, u8 *mac)
+int irdma_add_arp(struct irdma_pci_f *rf, u32 *ip, bool ipv4, const u8 *mac)
 {
 	int arpidx;
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6a544c253603..aa38ace15c07 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4326,7 +4326,7 @@ static enum rdma_link_layer irdma_get_link_layer(struct ib_device *ibdev,
 
 static __be64 irdma_mac_to_guid(struct net_device *ndev)
 {
-	unsigned char *mac = ndev->dev_addr;
+	const unsigned char *mac = ndev->dev_addr;
 	__be64 guid;
 	unsigned char *dst = (unsigned char *)&guid;
 
diff --git a/drivers/infiniband/hw/usnic/usnic_fwd.c b/drivers/infiniband/hw/usnic/usnic_fwd.c
index 398c4c00b932..18a70850b738 100644
--- a/drivers/infiniband/hw/usnic/usnic_fwd.c
+++ b/drivers/infiniband/hw/usnic/usnic_fwd.c
@@ -103,7 +103,7 @@ void usnic_fwd_dev_free(struct usnic_fwd_dev *ufdev)
 	kfree(ufdev);
 }
 
-void usnic_fwd_set_mac(struct usnic_fwd_dev *ufdev, char mac[ETH_ALEN])
+void usnic_fwd_set_mac(struct usnic_fwd_dev *ufdev, const char mac[ETH_ALEN])
 {
 	spin_lock(&ufdev->lock);
 	memcpy(&ufdev->mac, mac, sizeof(ufdev->mac));
diff --git a/drivers/infiniband/hw/usnic/usnic_fwd.h b/drivers/infiniband/hw/usnic/usnic_fwd.h
index f0b71d593da5..a91200886922 100644
--- a/drivers/infiniband/hw/usnic/usnic_fwd.h
+++ b/drivers/infiniband/hw/usnic/usnic_fwd.h
@@ -74,7 +74,7 @@ struct usnic_filter_action {
 struct usnic_fwd_dev *usnic_fwd_dev_alloc(struct pci_dev *pdev);
 void usnic_fwd_dev_free(struct usnic_fwd_dev *ufdev);
 
-void usnic_fwd_set_mac(struct usnic_fwd_dev *ufdev, char mac[ETH_ALEN]);
+void usnic_fwd_set_mac(struct usnic_fwd_dev *ufdev, const char mac[ETH_ALEN]);
 void usnic_fwd_add_ipaddr(struct usnic_fwd_dev *ufdev, __be32 inaddr);
 void usnic_fwd_del_ipaddr(struct usnic_fwd_dev *ufdev);
 void usnic_fwd_carrier_up(struct usnic_fwd_dev *ufdev);
-- 
2.31.1

