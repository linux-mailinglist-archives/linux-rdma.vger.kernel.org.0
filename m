Return-Path: <linux-rdma+bounces-13587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA63B948A8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 08:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CAA189AA09
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 06:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47FC30F546;
	Tue, 23 Sep 2025 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WrV6G2ms"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424A24BCF5
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608543; cv=none; b=dScSBS1r9Nf9t5du66J2jasCwTXRybfU4eJ4r5qmwyeQA0VTKXPLC8XmdXLLhjcAwhwGcTjKSiZT6/HafiuMigTYflB/QXBBhCJZIiHaEMtj1kh8eXmX9srHmTOH8o+F+hbic0N/JPI22VK6/qvKjM/fzAPtB/J939RsAvPLS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608543; c=relaxed/simple;
	bh=OK4n27W/LlhHNVbm9XPAlFDehG11nG8ZC7OaucdWObY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtyPvmKTn792Inw8Id8NyWXxaXXIplGATFfdgEhUKPGKfiuyDM+0Wk75U080ELptHVQ8dUWHdnkxPOAU6elIzTuSg6YKueL9NrCFAWyAKleO+DwZyocRvt3CZbRoo1yeTBT9l3jMgN9OlPPpvco3AldHsT6UGhRGuvvYqQqNoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WrV6G2ms; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b550eff972eso3104853a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 23:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608541; x=1759213341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqcrn3/WXl+8hbBcGDEMZXrCShO8Em+fxUkmCW7OXFI=;
        b=Iemj9rhX6yl336jQRg/0AnMqVRybWBiNrLIyTG6nr/424Vs0Fv6PejIiPUN6PxXCtD
         nu+3sxYzvg6IEtrdvFRLFZsjUmMckdgVlouvrF93lCVa/XPXtbOBrm8bIKahyFpnWKSd
         hnlRGIFk1rEtkJXyV3oubirsv4U97sjoFJ/eOwHFTtyzYdZjR5Z7HqDgWsWwxSbYTkQL
         +b1Ee8oD4LLveqi+93NcgH0Ohr/JGoSSXwcN8CwupOkx+mUeDP74Deyf3gU4qvQahZtj
         HS1m+6dj7KlLWscjsdVQdR2CZF5h4iNyKjtXNkjdYEpDTxrInuVrtCKXb3JxRHTzLVcO
         7vlA==
X-Gm-Message-State: AOJu0YxlUDQORTubOl0SholDF9b0zuzhHFJPmHNvk6gPWhs8bzbOr26d
	sDrNsXHk534VP3k5BtzgfiNmRP0VJwrrMnWpKXay4daGrL2pdlx9hbsNKiMQiv4KLHrZibsOijw
	tdCjNIyq72IXfeib12nyrea+oOdAa7zcVaNxCIcpKbnwJGWxXOxmRqk9FmWerNnC+UTlE6ZbZyO
	6voZusSz2Ik6ydTYS8/7LMpXxa3Uw+ShfjryyU3OfTNIIpj78+kWeViaX89OaXRinEecPu+3qfX
	7pWUB2pm0NJ9qctTF49U01ga7lzfw==
X-Gm-Gg: ASbGnctDU8ZzygcLiJzbzlqPOhT7MzzPoGMLjQOtz6/yKsCqJksK4a0kisWYeEI1QbP
	GOIFz3VLuQ1FWXOnbdoApVizbgfsOFDgCDHgkqZ3kUbGOHzmK2M5+JAXj+lUkRxZ4MVrt+h7zAY
	+8nOkM1ZX9jGTnSrSwKzlqE0gv0fVGmAjfmfAtMblBoyNhA3w/epVw4wQGSVWVECk/nx0SYNm7f
	DxaUYchCQfujn97iXhAF8CjNvRK4jiymmd7oKUaQ34qSUpCaQTfWG4kzh1GN2h+LXg6pvVh8450
	knEkZ7TV42xjZZdcdg4TVl/Ob/EqOvoG3OufV48Vd7bsH4iYLgTXmb+gFWRK1XpNaIFzUTat477
	NqUhceRElDIPBFak/AlVrmt5o5mjguS5RP6oP39jQ/fxetwoinfQIbx1aLlpytRQIwRrd0otZe7
	tA/T5ahKp1atVP
X-Google-Smtp-Source: AGHT+IGhGfXgtehIiuU9wqN30EoXJSe+epEf08UWnOHFWK3nvsOC2yVBy+YHrhN+UDiQFVz81sw/bHGpWZYg
X-Received: by 2002:a17:903:2449:b0:267:bd8d:1b1 with SMTP id d9443c01a7336-27cc678570amr16719535ad.50.1758608540817;
        Mon, 22 Sep 2025 23:22:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-26980163b44sm9169895ad.24.2025.09.22.23.22.20
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 23:22:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458345f5dso77373325ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 23:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758608539; x=1759213339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zqcrn3/WXl+8hbBcGDEMZXrCShO8Em+fxUkmCW7OXFI=;
        b=WrV6G2ms2gW2l9Yd+5VXt7kWFGqoDGqVPWP1HdlsYjXNV0u1KPc6lZjixzohllhRsG
         cWPTomMo5ZQs/xKdrOGIRpxzGMu7683hJW/mK886IDuCxSfN3wp2WpSt/tzdmg2vTB8Q
         7KHPEZXI6F1UE8ObpoTsgOvrhNn1nXTET0BT8=
X-Received: by 2002:a17:902:e951:b0:25c:76f1:b024 with SMTP id d9443c01a7336-27cc24e015cmr18225935ad.25.1758608539028;
        Mon, 22 Sep 2025 23:22:19 -0700 (PDT)
X-Received: by 2002:a17:902:e951:b0:25c:76f1:b024 with SMTP id d9443c01a7336-27cc24e015cmr18225655ad.25.1758608538610;
        Mon, 22 Sep 2025 23:22:18 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053db2sm152582285ad.2.2025.09.22.23.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:22:18 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 2/2] RDMA/bnxt_re: Remove non-statistics counters from hw_counters
Date: Tue, 23 Sep 2025 11:56:57 +0530
Message-ID: <20250923062657.981487-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250923062657.981487-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250923062657.981487-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Anantha Prabhu <anantha.prabhu@broadcom.com>

Remove non-statistics counters from the RDMA hw_counters framework.
The removed data includes:

- Active resource counts (ACTIVE_PD, ACTIVE_QP, etc.)
- Resource watermarks (WATERMARK_PD, WATERMARK_QP, etc.)
- Operational counters (RESIZE_CQ_CNT)
- DB pacing metrics (PACING_RESCHED, PACING_CMPL, etc.)

This change ensures hw_counters contains only true performance
and error statistics.

Signed-off-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 58 ---------------------
 drivers/infiniband/hw/bnxt_re/hw_counters.h | 23 --------
 2 files changed, 81 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 32ec67e4d922..651cf9d0e0c7 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -51,25 +51,6 @@
 #include "hw_counters.h"
 
 static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
-	[BNXT_RE_ACTIVE_PD].name		=  "active_pds",
-	[BNXT_RE_ACTIVE_AH].name		=  "active_ahs",
-	[BNXT_RE_ACTIVE_QP].name		=  "active_qps",
-	[BNXT_RE_ACTIVE_RC_QP].name             =  "active_rc_qps",
-	[BNXT_RE_ACTIVE_UD_QP].name             =  "active_ud_qps",
-	[BNXT_RE_ACTIVE_SRQ].name		=  "active_srqs",
-	[BNXT_RE_ACTIVE_CQ].name		=  "active_cqs",
-	[BNXT_RE_ACTIVE_MR].name		=  "active_mrs",
-	[BNXT_RE_ACTIVE_MW].name		=  "active_mws",
-	[BNXT_RE_WATERMARK_PD].name             =  "watermark_pds",
-	[BNXT_RE_WATERMARK_AH].name             =  "watermark_ahs",
-	[BNXT_RE_WATERMARK_QP].name             =  "watermark_qps",
-	[BNXT_RE_WATERMARK_RC_QP].name          =  "watermark_rc_qps",
-	[BNXT_RE_WATERMARK_UD_QP].name          =  "watermark_ud_qps",
-	[BNXT_RE_WATERMARK_SRQ].name            =  "watermark_srqs",
-	[BNXT_RE_WATERMARK_CQ].name             =  "watermark_cqs",
-	[BNXT_RE_WATERMARK_MR].name             =  "watermark_mrs",
-	[BNXT_RE_WATERMARK_MW].name             =  "watermark_mws",
-	[BNXT_RE_RESIZE_CQ_CNT].name            =  "resize_cq_cnt",
 	[BNXT_RE_RX_PKTS].name		=  "rx_pkts",
 	[BNXT_RE_RX_BYTES].name		=  "rx_bytes",
 	[BNXT_RE_TX_PKTS].name		=  "tx_pkts",
@@ -139,10 +120,6 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_TX_CNP].name                = "np_cnp_pkts",
 	[BNXT_RE_RX_CNP].name                = "rp_cnp_handled",
 	[BNXT_RE_RX_ECN].name                = "np_ecn_marked_roce_packets",
-	[BNXT_RE_PACING_RESCHED].name        = "pacing_reschedule",
-	[BNXT_RE_PACING_CMPL].name           = "pacing_complete",
-	[BNXT_RE_PACING_ALERT].name          = "pacing_alerts",
-	[BNXT_RE_DB_FIFO_REG].name           = "db_fifo_register",
 	[BNXT_RE_REQ_CQE_ERROR].name            = "req_cqe_error",
 	[BNXT_RE_RESP_CQE_ERROR].name           = "resp_cqe_error",
 	[BNXT_RE_RESP_REMOTE_ACCESS_ERRS].name  = "resp_remote_access_errors",
@@ -292,18 +269,6 @@ static void bnxt_re_copy_err_stats(struct bnxt_re_dev *rdev,
 			err_s->res_tx_no_perm;
 }
 
-static void bnxt_re_copy_db_pacing_stats(struct bnxt_re_dev *rdev,
-					 struct rdma_hw_stats *stats)
-{
-	struct bnxt_re_db_pacing_stats *pacing_s =  &rdev->stats.pacing;
-
-	stats->value[BNXT_RE_PACING_RESCHED] = pacing_s->resched;
-	stats->value[BNXT_RE_PACING_CMPL] = pacing_s->complete;
-	stats->value[BNXT_RE_PACING_ALERT] = pacing_s->alerts;
-	stats->value[BNXT_RE_DB_FIFO_REG] =
-		readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
-}
-
 int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
 {
 	struct ib_pma_portcounters_ext *pma_cnt_ext;
@@ -399,7 +364,6 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			    u32 port, int index)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_re_res_cntrs *res_s = &rdev->stats.res;
 	struct bnxt_qplib_roce_stats *err_s = NULL;
 	struct ctx_hw_stats *hw_stats = NULL;
 	int rc  = 0;
@@ -408,26 +372,6 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 	if (!port || !stats)
 		return -EINVAL;
 
-	stats->value[BNXT_RE_ACTIVE_QP] = atomic_read(&res_s->qp_count);
-	stats->value[BNXT_RE_ACTIVE_RC_QP] = atomic_read(&res_s->rc_qp_count);
-	stats->value[BNXT_RE_ACTIVE_UD_QP] = atomic_read(&res_s->ud_qp_count);
-	stats->value[BNXT_RE_ACTIVE_SRQ] = atomic_read(&res_s->srq_count);
-	stats->value[BNXT_RE_ACTIVE_CQ] = atomic_read(&res_s->cq_count);
-	stats->value[BNXT_RE_ACTIVE_MR] = atomic_read(&res_s->mr_count);
-	stats->value[BNXT_RE_ACTIVE_MW] = atomic_read(&res_s->mw_count);
-	stats->value[BNXT_RE_ACTIVE_PD] = atomic_read(&res_s->pd_count);
-	stats->value[BNXT_RE_ACTIVE_AH] = atomic_read(&res_s->ah_count);
-	stats->value[BNXT_RE_WATERMARK_QP] = res_s->qp_watermark;
-	stats->value[BNXT_RE_WATERMARK_RC_QP] = res_s->rc_qp_watermark;
-	stats->value[BNXT_RE_WATERMARK_UD_QP] = res_s->ud_qp_watermark;
-	stats->value[BNXT_RE_WATERMARK_SRQ] = res_s->srq_watermark;
-	stats->value[BNXT_RE_WATERMARK_CQ] = res_s->cq_watermark;
-	stats->value[BNXT_RE_WATERMARK_MR] = res_s->mr_watermark;
-	stats->value[BNXT_RE_WATERMARK_MW] = res_s->mw_watermark;
-	stats->value[BNXT_RE_WATERMARK_PD] = res_s->pd_watermark;
-	stats->value[BNXT_RE_WATERMARK_AH] = res_s->ah_watermark;
-	stats->value[BNXT_RE_RESIZE_CQ_CNT] = atomic_read(&res_s->resize_count);
-
 	if (hw_stats) {
 		stats->value[BNXT_RE_RECOVERABLE_ERRORS] =
 			le64_to_cpu(hw_stats->tx_bcast_pkts);
@@ -466,8 +410,6 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 				goto done;
 			}
 		}
-		if (rdev->pacing.dbr_pacing && bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
-			bnxt_re_copy_db_pacing_stats(rdev, stats);
 	}
 
 done:
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index be8e69458734..09d371d442aa 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -41,25 +41,6 @@
 #define __BNXT_RE_HW_STATS_H__
 
 enum bnxt_re_hw_stats {
-	BNXT_RE_ACTIVE_PD,
-	BNXT_RE_ACTIVE_AH,
-	BNXT_RE_ACTIVE_QP,
-	BNXT_RE_ACTIVE_RC_QP,
-	BNXT_RE_ACTIVE_UD_QP,
-	BNXT_RE_ACTIVE_SRQ,
-	BNXT_RE_ACTIVE_CQ,
-	BNXT_RE_ACTIVE_MR,
-	BNXT_RE_ACTIVE_MW,
-	BNXT_RE_WATERMARK_PD,
-	BNXT_RE_WATERMARK_AH,
-	BNXT_RE_WATERMARK_QP,
-	BNXT_RE_WATERMARK_RC_QP,
-	BNXT_RE_WATERMARK_UD_QP,
-	BNXT_RE_WATERMARK_SRQ,
-	BNXT_RE_WATERMARK_CQ,
-	BNXT_RE_WATERMARK_MR,
-	BNXT_RE_WATERMARK_MW,
-	BNXT_RE_RESIZE_CQ_CNT,
 	BNXT_RE_RX_PKTS,
 	BNXT_RE_RX_BYTES,
 	BNXT_RE_TX_PKTS,
@@ -129,10 +110,6 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_TX_CNP,
 	BNXT_RE_RX_CNP,
 	BNXT_RE_RX_ECN,
-	BNXT_RE_PACING_RESCHED,
-	BNXT_RE_PACING_CMPL,
-	BNXT_RE_PACING_ALERT,
-	BNXT_RE_DB_FIFO_REG,
 	BNXT_RE_REQ_CQE_ERROR,
 	BNXT_RE_RESP_CQE_ERROR,
 	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
-- 
2.43.5


