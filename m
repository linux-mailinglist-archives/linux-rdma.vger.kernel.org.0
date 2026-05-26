Return-Path: <linux-rdma+bounces-21281-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D1oJ1NjFWo9UwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21281-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:09:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03E5D30A2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 214F13048F03
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB403D3311;
	Tue, 26 May 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vj9QC5ss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A1356A12
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786451; cv=none; b=ieRK4Uo2F/N8SYgMettxECtdx8wGZz81SSHQJDRT0YiaueRK/JLMn/CdBN+Inywl1rKjfdLtcpk28fmiLvS2Mv6Unlube4Cup2N6qFJVaad11bMBZP+203micK1PbdEoxYv+jl+u0xthydOmqJhfjbK4oziuB43vRyXMRxtIYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786451; c=relaxed/simple;
	bh=PK/u6jLI9wQf9mLhV/QEU7K9e6hmk2DDdp0rfAk5828=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4E9gxALF0VDHUOlMg1k8/F1tpM6xgcD/nKlTwwRdH943s/ns/fbRSb6zkWaoc+9NCVojAgm0eKha71oUzCnYBYGoMloXITAna/5Mv/BM5+++YzQlxRFX6JBTWMFNEoiE/DCIQmEKMksuoxOR1fSdLa4iD1q4HnAbdcSJMx5cJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vj9QC5ss; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779786449; x=1811322449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EKUgnPMGFepJiDKMo/HwNtsmjbt9o8PByD9ATZkqM0U=;
  b=Vj9QC5ssJABAMLqqQcZCSnokpuNd60/Cr2/ivrAvf+314pwjuQSNDR9R
   B5lX69UyoMoKR/+Q3QzXibw3XMj98mte9xcIDtadqJ/h2kgLEYp4R/YxO
   aKop05lLhr4ptiYo69ToNxcjDa0Rakrl3aIS4U3TTxl6eCNbL38rg9DEq
   I/5FUAwOgUIXuqb5TuqP8wD64nKlNXnt8LW7fpRGqTF5sx+4TcG7QC6rk
   JbH1b03JN/iqyayJ9N1lOYgHvN01SCi7Hf8G9aWH9P5p93yqHdxVgBGJ+
   YrGG1x4JAqYRDnJc8TXdilXQwUAfiSjmQm5zAhbUIFbvfXbChFjchJO8I
   g==;
X-CSE-ConnectionGUID: twkhdaYVR6+JyBGpamUzkw==
X-CSE-MsgGUID: wIVL3eXsQbKxfZLc2o2MmA==
X-IronPort-AV: E=Sophos;i="6.24,169,1774310400"; 
   d="scan'208";a="20241296"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:07:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:16971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.23:2525] with esmtp (Farcaster)
 id 52a9102e-3556-4d67-82ca-6f8ce1516925; Tue, 26 May 2026 09:07:26 +0000 (UTC)
X-Farcaster-Flow-ID: 52a9102e-3556-4d67-82ca-6f8ce1516925
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 09:07:24 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 26 May 2026
 09:07:22 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v5 5/5] RDMA/efa: Add Completion Counters support
Date: Tue, 26 May 2026 09:07:12 +0000
Message-ID: <20260526090712.17575-6-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526090712.17575-1-mrgolin@amazon.com>
References: <20260526090712.17575-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21281-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A03E5D30A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement completion counters for the EFA device. Each completion
counter is backed by two EFA event counters, one for success
completions and one for error completions.

The driver creates umem for counters from private descriptor ioctl
attributes (efa_uverbs_buffer_desc). Umem creation can be later
replaced by a core utility being developed.

Read operations are not implemented as the counter values are accessed
directly from userspace through the mapped memory.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h         |  15 ++
 drivers/infiniband/hw/efa/efa_com_cmd.c | 110 +++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h |  36 ++++
 drivers/infiniband/hw/efa/efa_main.c    |   5 +
 drivers/infiniband/hw/efa/efa_verbs.c   | 234 ++++++++++++++++++++++++
 include/uapi/rdma/efa-abi.h             |  19 ++
 6 files changed, 419 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 00b19f2ba3da..1586c17e46e2 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -110,6 +110,14 @@ struct efa_cq {
 	struct ib_umem *umem;
 };
 
+struct efa_comp_cntr {
+	struct ib_comp_cntr ibcc;
+	struct ib_umem *comp_umem;
+	struct ib_umem *err_umem;
+	u32 comp_handle;
+	u32 err_handle;
+};
+
 struct efa_qp {
 	struct ib_qp ibqp;
 	dma_addr_t rq_dma_addr;
@@ -163,6 +171,13 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		       struct uverbs_attr_bundle *attrs);
+int efa_create_comp_cntr(struct ib_comp_cntr *ibcc,
+			 struct uverbs_attr_bundle *attrs);
+int efa_destroy_comp_cntr(struct ib_comp_cntr *ibcc);
+int efa_modify_comp_cntr(struct ib_comp_cntr *ibcc, enum ib_comp_cntr_entry entry,
+			 enum ib_comp_cntr_modify_op op, u64 value);
+int efa_qp_attach_comp_cntr(struct ib_qp *ibqp, struct ib_comp_cntr *ibcc,
+			    struct ib_qp_attach_comp_cntr_attr *attr);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_dmah *dmah,
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 63c7f07806a8..8261f90df477 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -516,6 +516,8 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 		}
 
 		result->inline_buf_size_ex = resp.u.queue_attr_2.inline_buf_size_ex;
+		result->max_event_counters = resp.u.queue_attr_2.max_event_counters;
+		result->event_counter_max_val = resp.u.queue_attr_2.event_counter_max_val;
 	} else {
 		result->inline_buf_size_ex = result->inline_buf_size;
 	}
@@ -851,3 +853,111 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 
 	return 0;
 }
+
+int efa_com_create_event_counter(struct efa_com_dev *edev,
+				 struct efa_com_create_event_counter_params *params,
+				 struct efa_com_create_event_counter_result *result)
+{
+	struct efa_admin_create_event_counter_cmd cmd = {};
+	struct efa_admin_create_event_counter_resp resp;
+	struct efa_com_admin_queue *aq = &edev->aq;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_CREATE_EVENT_COUNTER;
+	cmd.uar = params->uarn;
+	cmd.paddr = params->dma_addr;
+
+	err = efa_com_cmd_exec(aq, (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to create event counter [%d]\n",
+				      err);
+		return err;
+	}
+
+	result->cntr_handle = resp.cntr_handle;
+	return 0;
+}
+
+int efa_com_destroy_event_counter(struct efa_com_dev *edev,
+				  struct efa_com_destroy_event_counter_params *params)
+{
+	struct efa_admin_destroy_event_counter_cmd cmd = {};
+	struct efa_admin_destroy_event_counter_resp resp;
+	struct efa_com_admin_queue *aq = &edev->aq;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_DESTROY_EVENT_COUNTER;
+	cmd.cntr_handle = params->cntr_handle;
+
+	err = efa_com_cmd_exec(aq, (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to destroy event counter [%d]\n",
+				      err);
+		return err;
+	}
+
+	return 0;
+}
+
+int efa_com_attach_event_counter(struct efa_com_dev *edev,
+				 struct efa_com_attach_event_counter_params *params)
+{
+	struct efa_admin_attach_event_counter_cmd cmd = {};
+	struct efa_admin_attach_event_counter_resp resp;
+	struct efa_com_admin_queue *aq = &edev->aq;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_ATTACH_EVENT_COUNTER;
+	cmd.cntr_handle = params->cntr_handle;
+	cmd.attach_type = EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS;
+	cmd.u.qp_events.qp_handle = params->qp_handle;
+	cmd.u.qp_events.events = params->events;
+
+	err = efa_com_cmd_exec(aq, (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to attach event counter [%d]\n",
+				      err);
+		return err;
+	}
+
+	return 0;
+}
+
+int efa_com_modify_event_counter(struct efa_com_dev *edev,
+				 struct efa_com_modify_event_counter_params *params)
+{
+	struct efa_admin_modify_event_counter_cmd cmd = {};
+	struct efa_admin_modify_event_counter_resp resp;
+	struct efa_com_admin_queue *aq = &edev->aq;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_MODIFY_EVENT_COUNTER;
+	cmd.cntr_handle = params->cntr_handle;
+	cmd.operation = params->operation;
+	cmd.value = params->value;
+
+	err = efa_com_cmd_exec(aq, (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to modify event counter [%d]\n",
+				      err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index ef15b3c38429..8d31813b3c9f 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -145,6 +145,8 @@ struct efa_com_get_device_attr_result {
 	u16 min_sq_depth;
 	u16 max_link_speed_gbps;
 	u8 db_bar;
+	u32 max_event_counters;
+	u64 event_counter_max_val;
 };
 
 struct efa_com_get_hw_hints_result {
@@ -300,6 +302,31 @@ union efa_com_get_stats_result {
 	struct efa_com_network_stats network_stats;
 };
 
+struct efa_com_create_event_counter_params {
+	dma_addr_t dma_addr;
+	u16 uarn;
+};
+
+struct efa_com_create_event_counter_result {
+	u32 cntr_handle;
+};
+
+struct efa_com_destroy_event_counter_params {
+	u32 cntr_handle;
+};
+
+struct efa_com_attach_event_counter_params {
+	u32 cntr_handle;
+	u32 qp_handle;
+	u32 events;
+};
+
+struct efa_com_modify_event_counter_params {
+	u32 cntr_handle;
+	u8 operation;
+	u64 value;
+};
+
 int efa_com_create_qp(struct efa_com_dev *edev,
 		      struct efa_com_create_qp_params *params,
 		      struct efa_com_create_qp_result *res);
@@ -350,5 +377,14 @@ int efa_com_dealloc_uar(struct efa_com_dev *edev,
 int efa_com_get_stats(struct efa_com_dev *edev,
 		      struct efa_com_get_stats_params *params,
 		      union efa_com_get_stats_result *result);
+int efa_com_create_event_counter(struct efa_com_dev *edev,
+				 struct efa_com_create_event_counter_params *params,
+				 struct efa_com_create_event_counter_result *result);
+int efa_com_destroy_event_counter(struct efa_com_dev *edev,
+				  struct efa_com_destroy_event_counter_params *params);
+int efa_com_attach_event_counter(struct efa_com_dev *edev,
+				 struct efa_com_attach_event_counter_params *params);
+int efa_com_modify_event_counter(struct efa_com_dev *edev,
+				 struct efa_com_modify_event_counter_params *params);
 
 #endif /* _EFA_COM_CMD_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 03c237c8c81e..9ae6956e5600 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -372,20 +372,24 @@ static const struct ib_device_ops efa_dev_ops = {
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
 	.create_user_cq = efa_create_user_cq,
+	.create_comp_cntr = efa_create_comp_cntr,
 	.create_qp = efa_create_qp,
 	.create_user_ah = efa_create_ah,
 	.dealloc_pd = efa_dealloc_pd,
 	.dealloc_ucontext = efa_dealloc_ucontext,
 	.dereg_mr = efa_dereg_mr,
 	.destroy_ah = efa_destroy_ah,
+	.destroy_comp_cntr = efa_destroy_comp_cntr,
 	.destroy_cq = efa_destroy_cq,
 	.destroy_qp = efa_destroy_qp,
 	.get_hw_stats = efa_get_hw_stats,
 	.get_link_layer = efa_port_link_layer,
 	.get_port_immutable = efa_get_port_immutable,
+	.modify_comp_cntr = efa_modify_comp_cntr,
 	.mmap = efa_mmap,
 	.mmap_free = efa_mmap_free,
 	.modify_qp = efa_modify_qp,
+	.qp_attach_comp_cntr = efa_qp_attach_comp_cntr,
 	.query_device = efa_query_device,
 	.query_gid = efa_query_gid,
 	.query_pkey = efa_query_pkey,
@@ -396,6 +400,7 @@ static const struct ib_device_ops efa_dev_ops = {
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, efa_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_comp_cntr, efa_comp_cntr, ibcc),
 	INIT_RDMA_OBJ_SIZE(ib_pd, efa_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_qp, efa_qp, ibqp),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, efa_ucontext, ibucontext),
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 395290ab0584..d38799e34bb3 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -169,6 +169,11 @@ static inline struct efa_ah *to_eah(struct ib_ah *ibah)
 	return container_of(ibah, struct efa_ah, ibah);
 }
 
+static inline struct efa_comp_cntr *to_ecc(struct ib_comp_cntr *ibcc)
+{
+	return container_of(ibcc, struct efa_comp_cntr, ibcc);
+}
+
 static inline struct efa_user_mmap_entry *
 to_emmap(struct rdma_user_mmap_entry *rdma_entry)
 {
@@ -242,6 +247,7 @@ int efa_query_device(struct ib_device *ibdev,
 	props->max_recv_sge = dev_attr->max_rq_sge;
 	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
 	props->max_pkeys = 1;
+	props->max_comp_cntr = dev_attr->max_event_counters / 2;
 
 	if (udata && udata->outlen) {
 		resp.max_sq_sge = dev_attr->max_sq_sge;
@@ -267,6 +273,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (EFA_DEV_CAP(dev, UNSOLICITED_WRITE_RECV))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV;
 
+		if (EFA_DEV_CAP(dev, EVENT_COUNTERS))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_COMP_CNTR;
+
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
@@ -2231,6 +2240,216 @@ enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
 	return IB_LINK_LAYER_UNSPECIFIED;
 }
 
+static int efa_create_event_counter(struct efa_dev *dev, u16 uarn, dma_addr_t addr, u32 *handle)
+{
+	struct efa_com_create_event_counter_params params = {};
+	struct efa_com_create_event_counter_result result;
+	int err;
+
+	params.uarn = uarn;
+	params.dma_addr = addr;
+
+	err = efa_com_create_event_counter(&dev->edev, &params, &result);
+	if (err)
+		return err;
+
+	*handle = result.cntr_handle;
+	return 0;
+}
+
+static int efa_destroy_event_counter(struct efa_dev *dev, u32 handle)
+{
+	struct efa_com_destroy_event_counter_params params = {
+		.cntr_handle = handle,
+	};
+
+	return efa_com_destroy_event_counter(&dev->edev, &params);
+}
+
+static struct ib_umem *efa_comp_cntr_get_umem(struct ib_device *ib_dev,
+					      struct uverbs_attr_bundle *attrs, int attr)
+{
+	struct efa_uverbs_buffer_desc desc;
+	struct ib_umem_dmabuf *umem_dmabuf;
+	int ret;
+
+	ret = uverbs_copy_from(&desc, attrs, attr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (desc.reserved[0] || desc.reserved[1])
+		return ERR_PTR(-EINVAL);
+
+	switch (desc.type) {
+	case EFA_UVERBS_BUFFER_TYPE_VA:
+		return ib_umem_get(ib_dev, desc.addr, desc.length, IB_ACCESS_LOCAL_WRITE);
+	case EFA_UVERBS_BUFFER_TYPE_DMABUF:
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, desc.addr, desc.length, desc.fd,
+							IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem_dmabuf))
+			return ERR_CAST(umem_dmabuf);
+		return &umem_dmabuf->umem;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+}
+
+int efa_create_comp_cntr(struct ib_comp_cntr *ibcc, struct uverbs_attr_bundle *attrs)
+{
+	struct efa_dev *dev = to_edev(ibcc->device);
+	struct efa_comp_cntr *cc = to_ecc(ibcc);
+	struct efa_ucontext *ucontext;
+	struct ib_umem *comp_umem;
+	struct ib_umem *err_umem;
+	dma_addr_t comp_addr;
+	dma_addr_t err_addr;
+	int err;
+
+	ucontext = rdma_udata_to_drv_context(&attrs->driver_udata, struct efa_ucontext,
+					     ibucontext);
+
+	comp_umem = efa_comp_cntr_get_umem(ibcc->device, attrs,
+					   EFA_IB_ATTR_CREATE_COMP_CNTR_COMP_BUFFER);
+	if (IS_ERR(comp_umem))
+		return PTR_ERR(comp_umem);
+
+	err_umem = efa_comp_cntr_get_umem(ibcc->device, attrs,
+					  EFA_IB_ATTR_CREATE_COMP_CNTR_ERR_BUFFER);
+	if (IS_ERR(err_umem)) {
+		err = PTR_ERR(err_umem);
+		goto err_comp_umem;
+	}
+
+	comp_addr = ib_umem_start_dma_addr(comp_umem);
+	err_addr = ib_umem_start_dma_addr(err_umem);
+
+	if (comp_umem->length < sizeof(u64) || !IS_ALIGNED(comp_addr, sizeof(u64)) ||
+	    err_umem->length < sizeof(u64) || !IS_ALIGNED(err_addr, sizeof(u64))) {
+		ibdev_dbg(&dev->ibdev, "Completion Counter memory too small or unaligned\n");
+		err = -EINVAL;
+		goto err_err_umem;
+	}
+
+	err = efa_create_event_counter(dev, ucontext->uarn, comp_addr, &cc->comp_handle);
+	if (err) {
+		ibdev_dbg(&dev->ibdev, "Failed to create comp event counter [%d]\n", err);
+		goto err_err_umem;
+	}
+
+	err = efa_create_event_counter(dev, ucontext->uarn, err_addr, &cc->err_handle);
+	if (err) {
+		ibdev_dbg(&dev->ibdev, "Failed to create err event counter [%d]\n", err);
+		goto err_destroy_comp_event_cntr;
+	}
+
+	cc->comp_umem = comp_umem;
+	cc->err_umem = err_umem;
+	ibcc->comp_count_max_value = dev->dev_attr.event_counter_max_val;
+	ibcc->err_count_max_value = dev->dev_attr.event_counter_max_val;
+
+	return 0;
+
+err_destroy_comp_event_cntr:
+	efa_destroy_event_counter(dev, cc->comp_handle);
+err_err_umem:
+	ib_umem_release(err_umem);
+err_comp_umem:
+	ib_umem_release(comp_umem);
+	return err;
+}
+
+int efa_destroy_comp_cntr(struct ib_comp_cntr *ibcc)
+{
+	struct efa_dev *dev = to_edev(ibcc->device);
+	struct efa_comp_cntr *cc = to_ecc(ibcc);
+	int err;
+
+	err = efa_destroy_event_counter(dev, cc->comp_handle);
+	if (err)
+		return err;
+
+	err = efa_destroy_event_counter(dev, cc->err_handle);
+	if (err)
+		return err;
+
+	ib_umem_release(cc->comp_umem);
+	ib_umem_release(cc->err_umem);
+	return 0;
+}
+
+int efa_modify_comp_cntr(struct ib_comp_cntr *ibcc, enum ib_comp_cntr_entry entry,
+			 enum ib_comp_cntr_modify_op op, u64 value)
+{
+	struct efa_com_modify_event_counter_params params = {};
+	struct efa_comp_cntr *cc = to_ecc(ibcc);
+
+	params.cntr_handle = entry == IB_COMP_CNTR_ENTRY_ERR ? cc->err_handle : cc->comp_handle;
+	params.operation = op == IB_COMP_CNTR_MODIFY_OP_SET ?
+			   EFA_ADMIN_EVENT_COUNTER_MODIFY_SET : EFA_ADMIN_EVENT_COUNTER_MODIFY_ADD;
+	params.value = value;
+
+	return efa_com_modify_event_counter(&to_edev(ibcc->device)->edev, &params);
+}
+
+static u32 efa_comp_cntr_op_to_comp_events(u32 op_mask)
+{
+	u32 events = 0;
+
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_SEND)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_SEND_COMP, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_RECV)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_RECV_COMP, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_RDMA_READ)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_READ_COMP, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_READ)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_REMOTE_READ_COMP, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_RDMA_WRITE)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_REMOTE_RDMA_WRITE)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_REMOTE_WRITE_COMP, 1);
+
+	return events;
+}
+
+static u32 efa_comp_cntr_op_to_err_events(u32 op_mask)
+{
+	u32 events = 0;
+
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_SEND)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_SEND_COMP_ERR, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_RECV)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_RECV_COMP_ERR, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_RDMA_READ)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_READ_COMP_ERR, 1);
+	if (op_mask & IB_QP_ATTACH_COMP_CNTR_OP_RDMA_WRITE)
+		EFA_SET(&events, EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP_ERR, 1);
+
+	return events;
+}
+
+int efa_qp_attach_comp_cntr(struct ib_qp *ibqp, struct ib_comp_cntr *ibcc,
+			    struct ib_qp_attach_comp_cntr_attr *attr)
+{
+	struct efa_com_attach_event_counter_params params;
+	struct efa_dev *dev = to_edev(ibqp->device);
+	struct efa_comp_cntr *cc = to_ecc(ibcc);
+	struct efa_qp *qp = to_eqp(ibqp);
+	int err;
+
+	params.cntr_handle = cc->comp_handle;
+	params.qp_handle = qp->qp_handle;
+	params.events = efa_comp_cntr_op_to_comp_events(attr->op_mask);
+
+	err = efa_com_attach_event_counter(&dev->edev, &params);
+	if (err)
+		return err;
+
+	params.cntr_handle = cc->err_handle;
+	params.events = efa_comp_cntr_op_to_err_events(attr->op_mask);
+
+	return efa_com_attach_event_counter(&dev->edev, &params);
+}
+
 DECLARE_UVERBS_NAMED_METHOD(EFA_IB_METHOD_MR_QUERY,
 			    UVERBS_ATTR_IDR(EFA_IB_ATTR_QUERY_MR_HANDLE,
 					    UVERBS_OBJECT_MR,
@@ -2253,8 +2472,23 @@ ADD_UVERBS_METHODS(efa_mr,
 		   UVERBS_OBJECT_MR,
 		   &UVERBS_METHOD(EFA_IB_METHOD_MR_QUERY));
 
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	efa_comp_cntr_create,
+	UVERBS_OBJECT_COMP_CNTR,
+	UVERBS_METHOD_COMP_CNTR_CREATE,
+	UVERBS_ATTR_PTR_IN(
+		EFA_IB_ATTR_CREATE_COMP_CNTR_COMP_BUFFER,
+		UVERBS_ATTR_STRUCT(struct efa_uverbs_buffer_desc, length),
+		UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(
+		EFA_IB_ATTR_CREATE_COMP_CNTR_ERR_BUFFER,
+		UVERBS_ATTR_STRUCT(struct efa_uverbs_buffer_desc, length),
+		UA_MANDATORY));
+
 const struct uapi_definition efa_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_MR,
 				&efa_mr),
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_COMP_CNTR,
+				&efa_comp_cntr_create),
 	{},
 };
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index d5c18f8de182..a8a2cc09d964 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -133,6 +133,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
 	EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV = 1 << 6,
 	EFA_QUERY_DEVICE_CAPS_CQ_WITH_EXT_MEM = 1 << 7,
+	EFA_QUERY_DEVICE_CAPS_COMP_CNTR = 1 << 8,
 };
 
 struct efa_ibv_ex_query_device_resp {
@@ -163,4 +164,22 @@ enum efa_mr_methods {
 	EFA_IB_METHOD_MR_QUERY = (1U << UVERBS_ID_NS_SHIFT),
 };
 
+enum efa_uverbs_buffer_type {
+	EFA_UVERBS_BUFFER_TYPE_DMABUF = 0,
+	EFA_UVERBS_BUFFER_TYPE_VA = 1,
+};
+
+struct efa_uverbs_buffer_desc {
+	__s32 fd;
+	__u32 type;
+	__u32 reserved[2];
+	__aligned_u64 addr;
+	__aligned_u64 length;
+};
+
+enum efa_comp_cntr_create_attrs {
+	EFA_IB_ATTR_CREATE_COMP_CNTR_COMP_BUFFER = (1U << UVERBS_ID_NS_SHIFT),
+	EFA_IB_ATTR_CREATE_COMP_CNTR_ERR_BUFFER,
+};
+
 #endif /* EFA_ABI_USER_H */
-- 
2.47.3


