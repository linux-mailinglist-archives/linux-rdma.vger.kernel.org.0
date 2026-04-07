Return-Path: <linux-rdma+bounces-19085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG7ZMEzx1GkjywcAu9opvQ
	(envelope-from <linux-rdma+bounces-19085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 13:58:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 231153AE05D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 13:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460D3308F73F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF133ACF1C;
	Tue,  7 Apr 2026 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="T2GgEYKb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE283AA1BC
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562878; cv=none; b=jczNdWcU+MrrMT3Z+lXyeIp5tpt4F1N5DG4Tra18pcVnvXKAoWD80PgwRYvUQI4gXgELLMN8VVEn5cwQ7eUljczJVdCVwTxSrlfS5R4Lzv2gvoO8L2vXOBBR9AzYsk5+Qs3tmN/fk8S+WLiQCbsfgPsJ+7mpkVJxSYUWFvpsyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562878; c=relaxed/simple;
	bh=FpX9t5yUarMGeIgSK88SOWSa0ybzG8J9YtcM6EYv+EI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ip43Z96k7+61Uf3hVoz2sEgQhZFp0kEixOgvoEuLJF2UUgp/b5dppZEUCdO5pgBbz0pFtg+bYbs5EmfDX9pIkqQuBX60r6pXERRWl9Q6z/gT0LyL4c/laAL/u7+M/AVFLjh/pSC+aKxhSOMBWS5gwEIgHgzsJ8D2FQ0KLksELRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=T2GgEYKb; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775562876; x=1807098876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qq+VleEmX53dB09ujIQm5gLWBG43Qj9aqxqhY3rc+Vg=;
  b=T2GgEYKb48CUNNkO1SnPXToBSr1gcO+H9mHsIjXLZ+gvw6d+h+4/ZdSw
   VCFs8cm58wIgEHlttPkQs2AMOzKaOOg33aXrhdjkVgn7p1T8TpD6mQ1ql
   vmCwISp5/YZPtZx+yQl92uNhbNXszv1FkmhlWBSJgOaofM85xC5pFlXw9
   KIJP/DoqxXck2w/NBY5srplAovFJfzTnoiTh8dSEiUXd6oQw9epX63JNg
   xp/blm/G+WCncK6VZdHfQwX/AZyofUqwCGVK9QJys3d7KGheR1+SemEqY
   Wtt9rFC6NRfosRiwIKp2V4335kOGF1r5hH0exuTaUcjp5Ix8eCyS/jMgr
   Q==;
X-CSE-ConnectionGUID: ih/Wcc6NRE6fs/JPiVC2uw==
X-CSE-MsgGUID: Lc0fOBoISROpt/8hU0TptA==
X-IronPort-AV: E=Sophos;i="6.23,165,1770595200"; 
   d="scan'208";a="16733205"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 11:54:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:7468]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.23:2525] with esmtp (Farcaster)
 id 9ca38986-8f56-47a6-b8fc-e2b0549ca0e9; Tue, 7 Apr 2026 11:54:35 +0000 (UTC)
X-Farcaster-Flow-ID: 9ca38986-8f56-47a6-b8fc-e2b0549ca0e9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 7 Apr 2026 11:54:34 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 7 Apr 2026
 11:54:33 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next 4/4] RDMA/efa: Add Completion Counters support
Date: Tue, 7 Apr 2026 11:54:24 +0000
Message-ID: <20260407115424.13359-5-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407115424.13359-1-mrgolin@amazon.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19085-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 231153AE05D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement completion counters for the EFA device. Each completion
counter is backed by two EFA event counters, one for success
completions and one for error completions.

Set and inc operations are forwarded to the device via the modify
counter admin command. Read operations return EOPNOTSUPP as the
counter values are accessed directly from userspace through the
mapped memory.

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h         |  15 ++
 drivers/infiniband/hw/efa/efa_com_cmd.c | 106 ++++++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h |  36 +++++
 drivers/infiniband/hw/efa/efa_main.c    |   8 ++
 drivers/infiniband/hw/efa/efa_verbs.c   | 177 ++++++++++++++++++++++++
 include/uapi/rdma/efa-abi.h             |   1 +
 6 files changed, 343 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 00b19f2ba3da..d0c2c355f031 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -110,6 +110,12 @@ struct efa_cq {
 	struct ib_umem *umem;
 };
 
+struct efa_comp_cntr {
+	struct ib_comp_cntr ibcc;
+	u32 comp_handle;
+	u32 err_handle;
+};
+
 struct efa_qp {
 	struct ib_qp ibqp;
 	dma_addr_t rq_dma_addr;
@@ -163,6 +169,15 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		       struct uverbs_attr_bundle *attrs);
+int efa_create_comp_cntr(struct ib_comp_cntr *ibcc,
+			 struct uverbs_attr_bundle *attrs);
+int efa_destroy_comp_cntr(struct ib_comp_cntr *ibcc);
+int efa_set_comp_cntr(struct ib_comp_cntr *ibcc, u64 value);
+int efa_set_err_comp_cntr(struct ib_comp_cntr *ibcc, u64 value);
+int efa_inc_comp_cntr(struct ib_comp_cntr *ibcc, u64 amount);
+int efa_inc_err_comp_cntr(struct ib_comp_cntr *ibcc, u64 amount);
+int efa_qp_attach_comp_cntr(struct ib_qp *ibqp, struct ib_comp_cntr *ibcc,
+			    struct ib_comp_cntr_attach_attr *attr);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_dmah *dmah,
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 63c7f07806a8..e91c405e57d2 100644
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
@@ -851,3 +853,107 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 
 	return 0;
 }
+
+int efa_com_create_counter(struct efa_com_dev *edev,
+			   struct efa_com_create_counter_params *params,
+			   struct efa_com_create_counter_result *result)
+{
+	struct efa_admin_create_counter_cmd cmd = {};
+	struct efa_com_admin_queue *aq = &edev->aq;
+	struct efa_admin_create_counter_resp resp;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_CREATE_COUNTER;
+	cmd.uar = params->uarn;
+	cmd.paddr = params->dma_addr;
+
+	err = efa_com_cmd_exec(aq, (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to create counter [%d]\n", err);
+		return err;
+	}
+
+	result->cntr_handle = resp.cntr_handle;
+	return 0;
+}
+
+int efa_com_destroy_counter(struct efa_com_dev *edev,
+			    struct efa_com_destroy_counter_params *params)
+{
+	struct efa_admin_destroy_counter_cmd cmd = {};
+	struct efa_admin_destroy_counter_resp resp;
+	struct efa_com_admin_queue *aq = &edev->aq;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_DESTROY_COUNTER;
+	cmd.cntr_handle = params->cntr_handle;
+
+	err = efa_com_cmd_exec(aq, (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to destroy counter [%d]\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int efa_com_attach_counter(struct efa_com_dev *edev,
+			   struct efa_com_attach_counter_params *params)
+{
+	struct efa_admin_attach_counter_cmd cmd = {};
+	struct efa_com_admin_queue *aq = &edev->aq;
+	struct efa_admin_attach_counter_resp resp;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_ATTACH_COUNTER;
+	cmd.cntr_handle = params->cntr_handle;
+	cmd.attach_type = EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS;
+	cmd.u.qp_events.qp_handle = params->qp_handle;
+	cmd.u.qp_events.events = params->events;
+
+	err = efa_com_cmd_exec(aq, (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to attach counter [%d]\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int efa_com_modify_counter(struct efa_com_dev *edev,
+			   struct efa_com_modify_counter_params *params)
+{
+	struct efa_admin_modify_counter_cmd cmd = {};
+	struct efa_com_admin_queue *aq = &edev->aq;
+	struct efa_admin_modify_counter_resp resp;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_MODIFY_COUNTER;
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
+				      "Failed to modify counter [%d]\n", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index ef15b3c38429..9bce27d585d5 100644
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
 
+struct efa_com_create_counter_params {
+	dma_addr_t dma_addr;
+	u16 uarn;
+};
+
+struct efa_com_create_counter_result {
+	u32 cntr_handle;
+};
+
+struct efa_com_destroy_counter_params {
+	u32 cntr_handle;
+};
+
+struct efa_com_attach_counter_params {
+	u32 cntr_handle;
+	u32 qp_handle;
+	u32 events;
+};
+
+struct efa_com_modify_counter_params {
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
+int efa_com_create_counter(struct efa_com_dev *edev,
+			   struct efa_com_create_counter_params *params,
+			   struct efa_com_create_counter_result *result);
+int efa_com_destroy_counter(struct efa_com_dev *edev,
+			    struct efa_com_destroy_counter_params *params);
+int efa_com_attach_counter(struct efa_com_dev *edev,
+			   struct efa_com_attach_counter_params *params);
+int efa_com_modify_counter(struct efa_com_dev *edev,
+			   struct efa_com_modify_counter_params *params);
 
 #endif /* _EFA_COM_CMD_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 03c237c8c81e..e125120fe4ad 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -372,20 +372,25 @@ static const struct ib_device_ops efa_dev_ops = {
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
+	.inc_comp_cntr = efa_inc_comp_cntr,
+	.inc_err_comp_cntr = efa_inc_err_comp_cntr,
 	.mmap = efa_mmap,
 	.mmap_free = efa_mmap_free,
 	.modify_qp = efa_modify_qp,
+	.qp_attach_comp_cntr = efa_qp_attach_comp_cntr,
 	.query_device = efa_query_device,
 	.query_gid = efa_query_gid,
 	.query_pkey = efa_query_pkey,
@@ -393,9 +398,12 @@ static const struct ib_device_ops efa_dev_ops = {
 	.query_qp = efa_query_qp,
 	.reg_user_mr = efa_reg_mr,
 	.reg_user_mr_dmabuf = efa_reg_user_mr_dmabuf,
+	.set_comp_cntr = efa_set_comp_cntr,
+	.set_err_comp_cntr = efa_set_err_comp_cntr,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, efa_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_comp_cntr, efa_comp_cntr, ibcc),
 	INIT_RDMA_OBJ_SIZE(ib_pd, efa_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_qp, efa_qp, ibqp),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, efa_ucontext, ibucontext),
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 283c62d9cb3d..e9dbb08f3e02 100644
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
@@ -245,6 +250,7 @@ int efa_query_device(struct ib_device *ibdev,
 	props->max_recv_sge = dev_attr->max_rq_sge;
 	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
 	props->max_pkeys = 1;
+	props->max_comp_cntr = dev_attr->max_event_counters / 2;
 
 	if (udata && udata->outlen) {
 		resp.max_sq_sge = dev_attr->max_sq_sge;
@@ -270,6 +276,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (EFA_DEV_CAP(dev, UNSOLICITED_WRITE_RECV))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV;
 
+		if (EFA_DEV_CAP(dev, EVENT_COUNTERS))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_COMP_CNTR;
+
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
@@ -2307,6 +2316,174 @@ enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
 	return IB_LINK_LAYER_UNSPECIFIED;
 }
 
+static int efa_create_event_counter(struct efa_dev *dev, struct ib_umem *umem,
+				    u16 uarn, u32 *handle)
+{
+	struct efa_com_create_counter_params params = {};
+	struct efa_com_create_counter_result result;
+	int err;
+
+	params.uarn = uarn;
+	params.dma_addr = ib_umem_start_dma_addr(umem);
+
+	err = efa_com_create_counter(&dev->edev, &params, &result);
+	if (err)
+		return err;
+
+	*handle = result.cntr_handle;
+	return 0;
+}
+
+static int efa_destroy_event_counter(struct efa_dev *dev, u32 handle)
+{
+	struct efa_com_destroy_counter_params params = {
+		.cntr_handle = handle,
+	};
+
+	return efa_com_destroy_counter(&dev->edev, &params);
+}
+
+int efa_create_comp_cntr(struct ib_comp_cntr *ibcc, struct uverbs_attr_bundle *attrs)
+{
+	struct efa_dev *dev = to_edev(ibcc->device);
+	struct efa_comp_cntr *cc = to_ecc(ibcc);
+	struct efa_ucontext *ucontext;
+	int err;
+
+	if (!ibcc->comp_umem || !ibcc->err_umem) {
+		ibdev_dbg(&dev->ibdev, "Completion Counter without umem isn't supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	ucontext = rdma_udata_to_drv_context(&attrs->driver_udata, struct efa_ucontext,
+					     ibucontext);
+
+	err = efa_create_event_counter(dev, ibcc->comp_umem, ucontext->uarn, &cc->comp_handle);
+	if (err) {
+		ibdev_dbg(&dev->ibdev, "Failed to create comp event counter [%d]\n", err);
+		return err;
+	}
+
+	err = efa_create_event_counter(dev, ibcc->err_umem, ucontext->uarn, &cc->err_handle);
+	if (err) {
+		ibdev_dbg(&dev->ibdev, "Failed to create err event counter [%d]\n", err);
+		efa_destroy_event_counter(dev, cc->comp_handle);
+		return err;
+	}
+
+	ibcc->comp_count_max_value = dev->dev_attr.event_counter_max_val;
+	ibcc->err_count_max_value = dev->dev_attr.event_counter_max_val;
+
+	return 0;
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
+	return efa_destroy_event_counter(dev, cc->err_handle);
+}
+
+static int efa_modify_event_counter(struct efa_dev *dev, u32 handle, u8 operation, u64 value)
+{
+	struct efa_com_modify_counter_params params = {
+		.cntr_handle = handle,
+		.operation = operation,
+		.value = value,
+	};
+
+	return efa_com_modify_counter(&dev->edev, &params);
+}
+
+int efa_set_comp_cntr(struct ib_comp_cntr *ibcc, u64 value)
+{
+	return efa_modify_event_counter(to_edev(ibcc->device), to_ecc(ibcc)->comp_handle,
+					EFA_ADMIN_COUNTER_MODIFY_SET, value);
+}
+
+int efa_set_err_comp_cntr(struct ib_comp_cntr *ibcc, u64 value)
+{
+	return efa_modify_event_counter(to_edev(ibcc->device), to_ecc(ibcc)->err_handle,
+					EFA_ADMIN_COUNTER_MODIFY_SET, value);
+}
+
+int efa_inc_comp_cntr(struct ib_comp_cntr *ibcc, u64 amount)
+{
+	return efa_modify_event_counter(to_edev(ibcc->device), to_ecc(ibcc)->comp_handle,
+					EFA_ADMIN_COUNTER_MODIFY_ADD, amount);
+}
+
+int efa_inc_err_comp_cntr(struct ib_comp_cntr *ibcc, u64 amount)
+{
+	return efa_modify_event_counter(to_edev(ibcc->device), to_ecc(ibcc)->err_handle,
+					EFA_ADMIN_COUNTER_MODIFY_ADD, amount);
+}
+
+static u32 efa_comp_cntr_op_to_comp_events(u32 op_mask)
+{
+	u32 events = 0;
+
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_SEND_COMP, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_RECV_COMP, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_READ_COMP, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_READ)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_REMOTE_READ_COMP, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_REMOTE_RDMA_WRITE)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_REMOTE_WRITE_COMP, 1);
+
+	return events;
+}
+
+static u32 efa_comp_cntr_op_to_err_events(u32 op_mask)
+{
+	u32 events = 0;
+
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_SEND)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_SEND_COMP_ERR, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_RECV)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_RECV_COMP_ERR, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_READ)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_READ_COMP_ERR, 1);
+	if (op_mask & IB_UVERBS_COMP_CNTR_ATTACH_OP_RDMA_WRITE)
+		EFA_SET(&events, EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP_ERR, 1);
+
+	return events;
+}
+
+int efa_qp_attach_comp_cntr(struct ib_qp *ibqp, struct ib_comp_cntr *ibcc,
+			    struct ib_comp_cntr_attach_attr *attr)
+{
+	struct efa_com_attach_counter_params params;
+	struct efa_dev *dev = to_edev(ibqp->device);
+	struct efa_comp_cntr *cc = to_ecc(ibcc);
+	struct efa_qp *qp = to_eqp(ibqp);
+	int err;
+
+	params.cntr_handle = cc->comp_handle;
+	params.qp_handle = qp->qp_handle;
+	params.events = efa_comp_cntr_op_to_comp_events(attr->op_mask);
+
+	err = efa_com_attach_counter(&dev->edev, &params);
+	if (err)
+		return err;
+
+	params.cntr_handle = cc->err_handle;
+	params.events = efa_comp_cntr_op_to_err_events(attr->op_mask);
+
+	return efa_com_attach_counter(&dev->edev, &params);
+}
+
 DECLARE_UVERBS_NAMED_METHOD(EFA_IB_METHOD_MR_QUERY,
 			    UVERBS_ATTR_IDR(EFA_IB_ATTR_QUERY_MR_HANDLE,
 					    UVERBS_OBJECT_MR,
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index d5c18f8de182..492b2fa93467 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -133,6 +133,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
 	EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV = 1 << 6,
 	EFA_QUERY_DEVICE_CAPS_CQ_WITH_EXT_MEM = 1 << 7,
+	EFA_QUERY_DEVICE_CAPS_COMP_CNTR = 1 << 8,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.47.3


