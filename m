Return-Path: <linux-rdma+bounces-22634-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SV2tICXuRGq13QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22634-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 12:38:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC86EC3F1
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 12:38:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=DHN6SrGT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22634-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22634-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 063313058BB0
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893AD3F23B5;
	Wed,  1 Jul 2026 10:37:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D67403EA0
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 10:37:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902226; cv=none; b=DydKAMgVgaJs5mtOX2o5SOAhCp6i62kIZzeVW/eHgrKjwjz5RoyyIoe7ddLEDwO95+PGamEdtXn7V/H0SjUwEWAYf4jMIflnL5Xv/v6CPGqWZOIwteVuI6NIwZm/rPNzv9AuzIhySRom/TmQeeLPxK92n8mZIUB37IWMVGlrn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902226; c=relaxed/simple;
	bh=hErOM6zz51cy2IjJGPH//e2JMNN1wNuiJn9tD0BR8s4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJXMyIJ31Zx87TUeVFxX1U6Bh+ivZgn7akRgTHiCICA37QDO5xYihzoshwDZIqxnp2dsoavwPD21q7uLF05vYp3lLButljgOUVHiNM9esAFw2IBj4rUSAmtc3RoLAmxu0b5YFpP7KeqBt/F6V4yNSQDoShE72mcFLBmVosXJLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DHN6SrGT; arc=none smtp.client-ip=35.162.73.231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782902224; x=1814438224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXzf0d/GlYHFUgBzBctzcqyKFdfBpgkVNGN5/Jwx/qM=;
  b=DHN6SrGTEaZ4Q27Ovi0uZXsxlADJ1WcMbMq1TSqz6mBFFs6yPDaAynn5
   zz8zX5Ko5KBI7pjB4pR0aUHfSucFHG70mkkxzCfoRI4l5rqTjfPVcrb3o
   Lk4+hEzxhwrOuevidENj0+OJbofo5nowsXKmc2HE4vY3yjdDh6Yt/QeDR
   5CifyWXxVWwVUdwJNDG6Zpc7epmyaouhmbNVukCN+c3Ltcuc1MC/GjdkG
   A/mZelscPtBxcyR83mCzLhp7yiOuoLdptT9TLkX4zVuJl/xEUwbKgyjHV
   S5GX6hra9lFAPtyggllPU4Mm0GFnoVjHmxx2SS1pJuWoivc4viRH8Mfa6
   g==;
X-CSE-ConnectionGUID: I6hZk+LGS6eH+WwXlg0sxg==
X-CSE-MsgGUID: +pN3rK34QbOnwhT4fvoNXw==
X-IronPort-AV: E=Sophos;i="6.25,141,1779148800"; 
   d="scan'208";a="22631916"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:37:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:11620]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 9a3530af-a3b2-448a-b31f-bdc5cf96ad82; Wed, 1 Jul 2026 10:37:00 +0000 (UTC)
X-Farcaster-Flow-ID: 9a3530af-a3b2-448a-b31f-bdc5cf96ad82
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 1 Jul 2026 10:37:00 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Wed, 1 Jul 2026
 10:36:58 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v7 5/5] RDMA/efa: Add Completion Counters support
Date: Wed, 1 Jul 2026 10:34:48 +0000
Message-ID: <20260701103448.17895-6-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701103448.17895-1-mrgolin@amazon.com>
References: <20260701103448.17895-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22634-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qp_events.events:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBAC86EC3F1

Implement completion counters for the EFA device. Each completion
counter is backed by two EFA event counters, one for success
completions and one for error completions.

The driver creates umem for counters from private descriptor ioctl
attributes using core utility.

Read operations are not implemented as the counter values are accessed
directly from userspace through the mapped memory.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h         |  17 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c | 110 +++++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h |  36 +++++
 drivers/infiniband/hw/efa/efa_main.c    |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c   | 199 ++++++++++++++++++++++++
 include/uapi/rdma/efa-abi.h             |   6 +
 6 files changed, 373 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index f4586bb170c1..64986abdcc86 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_H_
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
@@ -164,6 +172,13 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
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
index 5db4f5805b59..85232abb6a19 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -520,6 +520,8 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 		}
 
 		result->inline_buf_size_ex = resp.u.queue_attr_2.inline_buf_size_ex;
+		result->max_event_counters = resp.u.queue_attr_2.max_event_counters;
+		result->event_counter_max_val = resp.u.queue_attr_2.event_counter_max_val;
 	} else {
 		result->inline_buf_size_ex = result->inline_buf_size;
 	}
@@ -855,3 +857,111 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 
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
index 97da8e828e34..f2fc41710d1e 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/module.h>
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
@@ -397,6 +401,7 @@ static const struct ib_device_ops efa_dev_ops = {
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, efa_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_comp_cntr, efa_comp_cntr, ibcc),
 	INIT_RDMA_OBJ_SIZE(ib_pd, efa_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_qp, efa_qp, ibqp),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, efa_ucontext, ibucontext),
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 06d3365aeb56..306613e56377 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -167,6 +167,11 @@ static inline struct efa_ah *to_eah(struct ib_ah *ibah)
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
@@ -240,6 +245,7 @@ int efa_query_device(struct ib_device *ibdev,
 	props->max_recv_sge = dev_attr->max_rq_sge;
 	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
 	props->max_pkeys = 1;
+	props->max_comp_cntr = dev_attr->max_event_counters / 2;
 
 	if (udata && udata->outlen) {
 		resp.max_sq_sge = dev_attr->max_sq_sge;
@@ -265,6 +271,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (EFA_DEV_CAP(dev, UNSOLICITED_WRITE_RECV))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV;
 
+		if (EFA_DEV_CAP(dev, EVENT_COUNTERS))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_COMP_CNTR;
+
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
@@ -2260,6 +2269,181 @@ enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
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
+	comp_umem = ib_umem_get_attr(ibcc->device, attrs, EFA_IB_ATTR_CREATE_COMP_CNTR_COMP_BUFFER,
+				     sizeof(u64), IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(comp_umem))
+		return PTR_ERR(comp_umem);
+
+	err_umem = ib_umem_get_attr(ibcc->device, attrs, EFA_IB_ATTR_CREATE_COMP_CNTR_ERR_BUFFER,
+				    sizeof(u64), IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(err_umem)) {
+		err = PTR_ERR(err_umem);
+		goto err_comp_umem;
+	}
+
+	comp_addr = ib_umem_start_dma_addr(comp_umem);
+	err_addr = ib_umem_start_dma_addr(err_umem);
+
+	if (!IS_ALIGNED(comp_addr, sizeof(u64)) || !IS_ALIGNED(err_addr, sizeof(u64))) {
+		ibdev_dbg(&dev->ibdev, "Completion Counter memory is unaligned\n");
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
+
+	efa_destroy_event_counter(dev, cc->comp_handle);
+	efa_destroy_event_counter(dev, cc->err_handle);
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
@@ -2282,8 +2466,23 @@ ADD_UVERBS_METHODS(efa_mr,
 		   UVERBS_OBJECT_MR,
 		   &UVERBS_METHOD(EFA_IB_METHOD_MR_QUERY));
 
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	efa_comp_cntr_create,
+	UVERBS_OBJECT_COMP_CNTR,
+	UVERBS_METHOD_COMP_CNTR_CREATE,
+	UVERBS_ATTR_PTR_IN(
+		EFA_IB_ATTR_CREATE_COMP_CNTR_COMP_BUFFER,
+		UVERBS_ATTR_STRUCT(struct ib_uverbs_buffer_desc, length),
+		UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(
+		EFA_IB_ATTR_CREATE_COMP_CNTR_ERR_BUFFER,
+		UVERBS_ATTR_STRUCT(struct ib_uverbs_buffer_desc, length),
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
index d5c18f8de182..c79b54aade23 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -133,6 +133,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
 	EFA_QUERY_DEVICE_CAPS_UNSOLICITED_WRITE_RECV = 1 << 6,
 	EFA_QUERY_DEVICE_CAPS_CQ_WITH_EXT_MEM = 1 << 7,
+	EFA_QUERY_DEVICE_CAPS_COMP_CNTR = 1 << 8,
 };
 
 struct efa_ibv_ex_query_device_resp {
@@ -163,4 +164,9 @@ enum efa_mr_methods {
 	EFA_IB_METHOD_MR_QUERY = (1U << UVERBS_ID_NS_SHIFT),
 };
 
+enum efa_comp_cntr_create_attrs {
+	EFA_IB_ATTR_CREATE_COMP_CNTR_COMP_BUFFER = (1U << UVERBS_ID_NS_SHIFT),
+	EFA_IB_ATTR_CREATE_COMP_CNTR_ERR_BUFFER,
+};
+
 #endif /* EFA_ABI_USER_H */
-- 
2.47.3


