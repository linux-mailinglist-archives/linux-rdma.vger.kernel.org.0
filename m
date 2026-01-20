Return-Path: <linux-rdma+bounces-15785-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMOMCTn0b2m+UQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15785-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 22:31:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4684C49F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 22:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C1DAA1BC5
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFD033D4F2;
	Tue, 20 Jan 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIUA4/Yr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC93D412F
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768944350; cv=none; b=EGUwy0oRxFv5NCGgAcprTgij/YlRUKNjNRIIIBXF+jJyIupTJusyKP6kEMTyUp6mNpBB254QZFMbOxnTeWO9TFCeo7GOXYEZkPYep/SgzoVKsgzz65pg6NTrfSnnE+mkrscHgOBSy0senKfEpT5D+rwdovG6y94trus2rKnfXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768944350; c=relaxed/simple;
	bh=4icvR2YXH/2v4o0P9p9L+pluW43nrSnlpz6KhezFVQM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NHKqH/KSOgupat8rw0F9AgMnzZqhMxwLJ7ZkaRh2Y2Wq/srToM4C9s6iD8dvFSVuPo14f+uITAKizy5JMnfbzSAoGFJTf6dEigsOIuGSI8QYk3RtbVzYyLwFFR65vJVQvriNEoWRdoWlevF45BASHJuSwjltffeLjNZGbR669p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIUA4/Yr; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88fcbe2e351so11927956d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 13:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768944348; x=1769549148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pttCg3UbxdRZlMnj0jN2aEJjrI8XoEmmXrZWazn3bDc=;
        b=tIUA4/YrGjnCI2nocLZkPKDhFjEls/oiI6Bmvt3aJ4ACwhNYXwjheTPhtV471lsaU1
         3KPMpnklL836gWylpcSRZ8unvcPmFeJhk02CeAGSPVFeIXY8wn7eTFlji/Xge6GrxU1V
         LhZQ9ttU4wog/RkYIeTS6DsMlkjrEujEJYv02tHZGmw4Dd4tq4HiByE0d8GQyNqR/akc
         MyhC4D3pFNaRulqQlZbqQgmGQiRVZbdKZYlbotY7x7ZBmu4crSRziQ7UulWBysvcITdq
         iG+/QIK/3uw23dulyw92kW+hcbWay728ECKfy6iimbdUresUyyGh04fATAvhveuRgmCa
         cENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768944348; x=1769549148;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pttCg3UbxdRZlMnj0jN2aEJjrI8XoEmmXrZWazn3bDc=;
        b=uTUjwFeNKgWCwEq/MgCQuOezlzew27ECJdgf8Qsm69UBsTZWIynxaoArhZtlLjrLS8
         MBa+2rj5QVzp/D+BGxlj01UkhrLU7TrOQSzkru87xp4Ja2hTCqJPo2A43NoD1UHJuklQ
         uL5b2ge8H4itwvq8wmD8xyb/S6CaeWP/B4HpXsnXodUe/ulmFU66Gm4VCwsbd2AkOWeA
         +SQfRYOa5m9h3jNV5ChEp6uhfTJaZwMMN+zfBsKw/fU9089kaYV/Owm9F64FMIdVO6IA
         wdtctd0TOTdRBdfXQYAk0wKivoyLWq3dCX3pNq7o8PHN4SjMDUN8YDucm8NRYZwy7isJ
         2xvg==
X-Forwarded-Encrypted: i=1; AJvYcCVQhJLF4ybY0mZ2psXIi836C63G0Dqgks+9M0jDw2tQ+ByfC7wuWbC03PgCCIKlVQrLIovOpbOYIvsK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2WYjOizMYpIoRCYpS+uYlLgEZLbldCphtE3rvnyXlVvAvyxEC
	p38XfZMkHnomr72TbpvSSDkm2AZ467ptTBjpeUsAyXBpM3vnTYFj1V/JGam7h2dxlQf2qru0PJa
	uDcPaqk/TBg==
X-Received: from qvcu8.prod.google.com ([2002:a05:6214:1c08:b0:88f:ca76:451b])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:226f:b0:88a:2b3d:31f
 with SMTP id 6a1803df08f44-89398272f01mr292017506d6.31.1768944347640; Tue, 20
 Jan 2026 13:25:47 -0800 (PST)
Date: Tue, 20 Jan 2026 21:25:45 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120212546.1893076-1-jmoroni@google.com>
Subject: [PATCH rdma-next 1/2] RDMA/irdma: Add enum defs for reserved CQs/QPs
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15785-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5D4684C49F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Added definitions for the special reserved CQs and QPs.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/hw.c   | 20 ++++++++++----------
 drivers/infiniband/hw/irdma/type.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index d1fc5726b..5d418ef5c 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1532,8 +1532,8 @@ static int irdma_initialize_ilq(struct irdma_device *iwdev)
 	int status;
 
 	info.type = IRDMA_PUDA_RSRC_TYPE_ILQ;
-	info.cq_id = 1;
-	info.qp_id = 1;
+	info.cq_id = IRDMA_RSVD_CQ_ID_ILQ;
+	info.qp_id = IRDMA_RSVD_QP_ID_GSI_ILQ;
 	info.count = 1;
 	info.pd_id = 1;
 	info.abi_ver = IRDMA_ABI_VER;
@@ -1562,7 +1562,7 @@ static int irdma_initialize_ieq(struct irdma_device *iwdev)
 	int status;
 
 	info.type = IRDMA_PUDA_RSRC_TYPE_IEQ;
-	info.cq_id = 2;
+	info.cq_id = IRDMA_RSVD_CQ_ID_IEQ;
 	info.qp_id = iwdev->vsi.exception_lan_q;
 	info.count = 1;
 	info.pd_id = 2;
@@ -1868,7 +1868,7 @@ int irdma_rt_init_hw(struct irdma_device *iwdev,
 	vsi_info.pf_data_vsi_num = iwdev->vsi_num;
 	vsi_info.register_qset = rf->gen_ops.register_qset;
 	vsi_info.unregister_qset = rf->gen_ops.unregister_qset;
-	vsi_info.exception_lan_q = 2;
+	vsi_info.exception_lan_q = IRDMA_RSVD_QP_ID_IEQ;
 	irdma_sc_vsi_init(&iwdev->vsi, &vsi_info);
 
 	status = irdma_setup_cm_core(iwdev, rf->rdma_ver);
@@ -2099,18 +2099,18 @@ u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf)
 	irdma_set_hw_rsrc(rf);
 
 	set_bit(0, rf->allocated_mrs);
-	set_bit(0, rf->allocated_qps);
-	set_bit(0, rf->allocated_cqs);
+	set_bit(IRDMA_RSVD_QP_ID_0, rf->allocated_qps);
+	set_bit(IRDMA_RSVD_CQ_ID_CQP, rf->allocated_cqs);
 	set_bit(0, rf->allocated_srqs);
 	set_bit(0, rf->allocated_pds);
 	set_bit(0, rf->allocated_arps);
 	set_bit(0, rf->allocated_ahs);
 	set_bit(0, rf->allocated_mcgs);
-	set_bit(2, rf->allocated_qps); /* qp 2 IEQ */
-	set_bit(1, rf->allocated_qps); /* qp 1 ILQ */
-	set_bit(1, rf->allocated_cqs);
+	set_bit(IRDMA_RSVD_QP_ID_IEQ, rf->allocated_qps);
+	set_bit(IRDMA_RSVD_QP_ID_GSI_ILQ, rf->allocated_qps);
+	set_bit(IRDMA_RSVD_CQ_ID_ILQ, rf->allocated_cqs);
 	set_bit(1, rf->allocated_pds);
-	set_bit(2, rf->allocated_cqs);
+	set_bit(IRDMA_RSVD_CQ_ID_IEQ, rf->allocated_cqs);
 	set_bit(2, rf->allocated_pds);
 
 	INIT_LIST_HEAD(&rf->mc_qht_list.list);
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index cab489664..3de9240b7 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -239,6 +239,18 @@ enum irdma_queue_type {
 	IRDMA_QUEUE_TYPE_SRQ,
 };
 
+enum irdma_rsvd_cq_id {
+	IRDMA_RSVD_CQ_ID_CQP,
+	IRDMA_RSVD_CQ_ID_ILQ,
+	IRDMA_RSVD_CQ_ID_IEQ,
+};
+
+enum irdma_rsvd_qp_id {
+	IRDMA_RSVD_QP_ID_0,
+	IRDMA_RSVD_QP_ID_GSI_ILQ,
+	IRDMA_RSVD_QP_ID_IEQ,
+};
+
 struct irdma_sc_dev;
 struct irdma_vsi_pestat;
 
-- 
2.52.0.457.g6b5491de43-goog


