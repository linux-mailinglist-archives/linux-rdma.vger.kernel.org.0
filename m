Return-Path: <linux-rdma+bounces-12758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDEBB26410
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0AA17C92D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255328EA72;
	Thu, 14 Aug 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S6dCNtou"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1341EF39E
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170410; cv=none; b=W2QUj4I2etYt+9JcAsbok+X2h4IOn+ELxNUaDy9yC09W4cG/8Rb4xPYXCFsMPAigkfNeTbgNIK4sLHn2Tu+tlqmyZaXeZN2NyCXryDX44U0kM7F9AAuKLZ2B/kQMg5eDwSyklDs3Y053vtSSDPSNQdDBztXBVTYCPXddGMw/SjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170410; c=relaxed/simple;
	bh=ze/WxLQF1Pvwnobggn+ik7ifK69QrqI1hCMFhhHhGdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSZJPASJ/VERKokjGbtN4h1xEDWyOkpssxQaB0K8GT8GvTlTX0DeK5hQz1WrrQwjjMWhKAoLus0XOXSx+wUkIFAqBzgtuiGwGlcY8kDuDAcno14TQPU3GqMsy+eGRJFcMAariXhRThyOZiBu11hIoF8LTfoYnOJ8Bd/5cnQtN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S6dCNtou; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47174edb2bso507054a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170408; x=1755775208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLKOIqLuzZuG0nG+KeN2Sa70x9OvjryLd95EZOSQgcc=;
        b=S6dCNtouOQYyplDDqgTVwCU5rxb9OMSsSIQ+S9NQE4zofObF+MBBABr3NaYXkc8aIj
         ins/YmDm3kjIfJBr9yHkSs0DrpufbTYMFzD7oUmxFqv4NLSrQej5/KS/NpfARgHmC3KL
         HabD0V7D5fsJBdcc5AMEnKnbrLm4JMgYPPmv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170408; x=1755775208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLKOIqLuzZuG0nG+KeN2Sa70x9OvjryLd95EZOSQgcc=;
        b=gU3pEhH81KfBiWQ3JmIribL7OMnhbJShUH7Xac41Kwit1N/f2bvmp6n+Pbhiyy/X9m
         SvOWzP70Dk67vNFlAY86V9zDvNs/rXXO82uy613q8vZ5eD4wVPf3A/Ni4wmxlFRO1BF3
         05ubWFAyKjRCuupZhEfzkvneTPdmEmApLm7/W8YDyROgFSWWWt8FNfZgXK/V3wKxiAr5
         G+qtqJjAiNHIBSnclqoS2tF8Ftn3/WZYhb3UkQOqtg4XMCxcOWxE7lVl2xtl/hJZ4KG0
         r220SGnKBG0IEUL2QtJ+4Dogsyawna7bzyaf+FnGI1Ocy92NDLULRuOmEr9Ni5FHx3dq
         e42g==
X-Gm-Message-State: AOJu0YxsK4MOKRC2zcYls3PKPOTl1goecen3kxzDHC4Ya3Dx9vuwnVpY
	kas6sJtHu9hnCZT5hXmR2gRxmqg7njsV1kP+UHSBLy+SC9xfDEYf6hSQMdRTloGq3Q==
X-Gm-Gg: ASbGncs/6J3NT6rNqQDN1qOcxoni5We6QESGJEK73zLwLjIoHKLB3lGczDb9c31yxWk
	IKm+7hmBVbRxkngZMPVclwYX6e1Ds70EIghu1S3ce4v4kg1MiWS820rE2uezgvWHXTrKWrdfbtt
	ve7R2FMokS9ezf1Frz+mPNKBJaStc3/jzVepCo4ROEGaYVRUIDerjGa8RfKohyPZrG1Z/cHoUYe
	M55v6cu41aEG7oZNoIzGWcSarl/6geO3Od9LEbX+b1iHmDeXfj5sm5fGJ62A8q7jLDUzvdLjzbJ
	rqiXWwkBW6163AyzFpbC9ifSoyYPBCdTh1Whd4wT2X83GBmJk6wprufg9Z+RYghbSA2sbktfMk5
	zI3RByC8z9UE4uTIzcw/fuVEiz81QLmLY4fZtB1gyAMDxkyd69zlz4nCFyoLyf8wU/HyVIrW3+v
	z6bBNkuSIhXNb/a9fOjBzPunua/y1D1w==
X-Google-Smtp-Source: AGHT+IFzBzaqE343gs6wY9O0WNymqFcxM4867uyVnt8UK+Bwx3dXkqkNp6355IDU+hfvWNiYXJIMmg==
X-Received: by 2002:a17:903:3d06:b0:242:bfdd:4100 with SMTP id d9443c01a7336-244586d42b1mr38322165ad.47.1755170408298;
        Thu, 14 Aug 2025 04:20:08 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:20:07 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Vasuthevan Maheswaran <vasuthevan.maheswaran@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 6/9] RDMA/bnxt_re: RoCE related hardware counters update
Date: Thu, 14 Aug 2025 16:55:52 +0530
Message-ID: <20250814112555.221665-7-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasuthevan Maheswaran <vasuthevan.maheswaran@broadcom.com>

Support for new hardware counters added, and existing hardware
counters have been modified according to the design documents
for compatibility with open-source monitoring agents.

Signed-off-by: Vasuthevan Maheswaran <vasuthevan.maheswaran@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 51 ++++++++++++++-------
 drivers/infiniband/hw/bnxt_re/hw_counters.h |  3 ++
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 44bb082e0a60..32ec67e4d922 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -79,22 +79,22 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_TX_DISCARDS].name              =  "tx_roce_discards",
 	[BNXT_RE_RX_ERRORS].name		=  "rx_roce_errors",
 	[BNXT_RE_RX_DISCARDS].name		=  "rx_roce_discards",
-	[BNXT_RE_TO_RETRANSMITS].name        = "to_retransmits",
-	[BNXT_RE_SEQ_ERR_NAKS_RCVD].name     = "seq_err_naks_rcvd",
-	[BNXT_RE_MAX_RETRY_EXCEEDED].name    = "max_retry_exceeded",
-	[BNXT_RE_RNR_NAKS_RCVD].name         = "rnr_naks_rcvd",
-	[BNXT_RE_MISSING_RESP].name          = "missing_resp",
+	[BNXT_RE_TO_RETRANSMITS].name           =  "local_ack_timeout_err",
+	[BNXT_RE_SEQ_ERR_NAKS_RCVD].name        =  "packet_seq_err",
+	[BNXT_RE_MAX_RETRY_EXCEEDED].name	=  "max_retry_exceeded",
+	[BNXT_RE_RNR_NAKS_RCVD].name            =  "rnr_nak_retry_err",
+	[BNXT_RE_MISSING_RESP].name             =  "implied_nak_seq_err",
 	[BNXT_RE_UNRECOVERABLE_ERR].name     = "unrecoverable_err",
 	[BNXT_RE_BAD_RESP_ERR].name          = "bad_resp_err",
 	[BNXT_RE_LOCAL_QP_OP_ERR].name       = "local_qp_op_err",
 	[BNXT_RE_LOCAL_PROTECTION_ERR].name  = "local_protection_err",
 	[BNXT_RE_MEM_MGMT_OP_ERR].name       = "mem_mgmt_op_err",
-	[BNXT_RE_REMOTE_INVALID_REQ_ERR].name = "remote_invalid_req_err",
-	[BNXT_RE_REMOTE_ACCESS_ERR].name     = "remote_access_err",
+	[BNXT_RE_REMOTE_INVALID_REQ_ERR].name   = "req_remote_invalid_request",
+	[BNXT_RE_REMOTE_ACCESS_ERR].name        = "req_remote_access_errors",
 	[BNXT_RE_REMOTE_OP_ERR].name         = "remote_op_err",
-	[BNXT_RE_DUP_REQ].name               = "dup_req",
+	[BNXT_RE_DUP_REQ].name               = "duplicate_request",
 	[BNXT_RE_RES_EXCEED_MAX].name        = "res_exceed_max",
-	[BNXT_RE_RES_LENGTH_MISMATCH].name   = "res_length_mismatch",
+	[BNXT_RE_RES_LENGTH_MISMATCH].name   = "resp_local_length_error",
 	[BNXT_RE_RES_EXCEEDS_WQE].name       = "res_exceeds_wqe",
 	[BNXT_RE_RES_OPCODE_ERR].name        = "res_opcode_err",
 	[BNXT_RE_RES_RX_INVALID_RKEY].name   = "res_rx_invalid_rkey",
@@ -118,7 +118,7 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_RES_SRQ_LOAD_ERR].name      = "res_srq_load_err",
 	[BNXT_RE_RES_TX_PCI_ERR].name        = "res_tx_pci_err",
 	[BNXT_RE_RES_RX_PCI_ERR].name        = "res_rx_pci_err",
-	[BNXT_RE_OUT_OF_SEQ_ERR].name        = "oos_drop_count",
+	[BNXT_RE_OUT_OF_SEQ_ERR].name        = "out_of_sequence",
 	[BNXT_RE_TX_ATOMIC_REQ].name	     = "tx_atomic_req",
 	[BNXT_RE_TX_READ_REQ].name	     = "tx_read_req",
 	[BNXT_RE_TX_READ_RES].name	     = "tx_read_resp",
@@ -126,23 +126,26 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_TX_SEND_REQ].name	     = "tx_send_req",
 	[BNXT_RE_TX_ROCE_PKTS].name          = "tx_roce_only_pkts",
 	[BNXT_RE_TX_ROCE_BYTES].name         = "tx_roce_only_bytes",
-	[BNXT_RE_RX_ATOMIC_REQ].name	     = "rx_atomic_req",
-	[BNXT_RE_RX_READ_REQ].name	     = "rx_read_req",
+	[BNXT_RE_RX_ATOMIC_REQ].name	     = "rx_atomic_requests",
+	[BNXT_RE_RX_READ_REQ].name	     = "rx_read_requests",
 	[BNXT_RE_RX_READ_RESP].name	     = "rx_read_resp",
-	[BNXT_RE_RX_WRITE_REQ].name	     = "rx_write_req",
+	[BNXT_RE_RX_WRITE_REQ].name	     = "rx_write_requests",
 	[BNXT_RE_RX_SEND_REQ].name	     = "rx_send_req",
 	[BNXT_RE_RX_ROCE_PKTS].name          = "rx_roce_only_pkts",
 	[BNXT_RE_RX_ROCE_BYTES].name         = "rx_roce_only_bytes",
 	[BNXT_RE_RX_ROCE_GOOD_PKTS].name     = "rx_roce_good_pkts",
 	[BNXT_RE_RX_ROCE_GOOD_BYTES].name    = "rx_roce_good_bytes",
-	[BNXT_RE_OOB].name		     = "rx_out_of_buffer",
-	[BNXT_RE_TX_CNP].name                = "tx_cnp_pkts",
-	[BNXT_RE_RX_CNP].name                = "rx_cnp_pkts",
-	[BNXT_RE_RX_ECN].name                = "rx_ecn_marked_pkts",
+	[BNXT_RE_OOB].name		     = "out_of_buffer",
+	[BNXT_RE_TX_CNP].name                = "np_cnp_pkts",
+	[BNXT_RE_RX_CNP].name                = "rp_cnp_handled",
+	[BNXT_RE_RX_ECN].name                = "np_ecn_marked_roce_packets",
 	[BNXT_RE_PACING_RESCHED].name        = "pacing_reschedule",
 	[BNXT_RE_PACING_CMPL].name           = "pacing_complete",
 	[BNXT_RE_PACING_ALERT].name          = "pacing_alerts",
 	[BNXT_RE_DB_FIFO_REG].name           = "db_fifo_register",
+	[BNXT_RE_REQ_CQE_ERROR].name            = "req_cqe_error",
+	[BNXT_RE_RESP_CQE_ERROR].name           = "resp_cqe_error",
+	[BNXT_RE_RESP_REMOTE_ACCESS_ERRS].name  = "resp_remote_access_errors",
 };
 
 static void bnxt_re_copy_ext_stats(struct bnxt_re_dev *rdev,
@@ -273,6 +276,20 @@ static void bnxt_re_copy_err_stats(struct bnxt_re_dev *rdev,
 			err_s->res_rx_pci_err;
 	stats->value[BNXT_RE_OUT_OF_SEQ_ERR]    =
 			err_s->res_oos_drop_count;
+	stats->value[BNXT_RE_REQ_CQE_ERROR]     =
+			err_s->bad_resp_err +
+			err_s->local_qp_op_err +
+			err_s->local_protection_err +
+			err_s->mem_mgmt_op_err +
+			err_s->remote_invalid_req_err +
+			err_s->remote_access_err +
+			err_s->remote_op_err;
+	stats->value[BNXT_RE_RESP_CQE_ERROR] =
+			err_s->res_cmp_err +
+			err_s->res_cq_load_err;
+	stats->value[BNXT_RE_RESP_REMOTE_ACCESS_ERRS] =
+			err_s->res_rx_no_perm +
+			err_s->res_tx_no_perm;
 }
 
 static void bnxt_re_copy_db_pacing_stats(struct bnxt_re_dev *rdev,
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index e541b6f8ca9f..be8e69458734 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -133,6 +133,9 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_PACING_CMPL,
 	BNXT_RE_PACING_ALERT,
 	BNXT_RE_DB_FIFO_REG,
+	BNXT_RE_REQ_CQE_ERROR,
+	BNXT_RE_RESP_CQE_ERROR,
+	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
 	BNXT_RE_NUM_EXT_COUNTERS
 };
 
-- 
2.43.5


