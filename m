Return-Path: <linux-rdma+bounces-2434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41888C3654
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B271C20A3A
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64620B0F;
	Sun, 12 May 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OGWKhAN9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67F20323
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515739; cv=none; b=UzYI+fvf8cQWx0Ux9yWheVet1Y/ZzI/BNihQEFaFXQe8rJVog/vJaUKSxi4RUsFu3Y+2lKe3Hy71sfy6vNgK8arPtF0PJNNA4XEQ1kXg0ydzyIUXc/D2GyYPSZYoJcUS+4eHrgQzX4cbE0UAS9IlxNZzqC0GicYmlAUeHmPF5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515739; c=relaxed/simple;
	bh=H89Nk3Tp+LF50IiV0ZjHYwDq/H6c9jejVbkDnDm/yac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=dwl4IyPiEmQgswZnBRFqpOj0mls4qqbQDAGOWyUYEW6etK6fkTMBgPTfaSOHSjYqSzqd3FHLiadd2QGV16RsyNxPHOVGkKkoXFSUSmkfyqiW/uPP6TsUnlzfS0XMig3xSov3M3O/NIoFwnEtgQae3h1YmHGn/ZK51HtFbCzKq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OGWKhAN9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed0abbf706so25452965ad.2
        for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715515737; x=1716120537; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1AB1v1wEQNtQeTMIr+SDhlZmPuNZ+eyHnVbD85FI7ZI=;
        b=OGWKhAN9Erq8sO1WBMkg/l7hkRBtmpK1eFVkKxWdDFJr9JxSFZX7ysWUfMo05xh7lB
         KtbSWx65HJe56i0AMwSAVZJLIWBkmIADjc5Cs2p7wl78zFBwyvMN3Pt9r2x9KHteP85w
         STuwlq3KqZfWV00dqvRsXwlDOWm50w+RBWapI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715515737; x=1716120537;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AB1v1wEQNtQeTMIr+SDhlZmPuNZ+eyHnVbD85FI7ZI=;
        b=QfgVxb9xN4P0VvQu7DK3P8jm0oMNag8rj9TLe15TUmIyBf3NVOUMFxkhEwXQRc34FL
         EUdUwSdKXzhcb/IcCE/mUJfjAZ7OIhQZpCIcUYxXa2jQbico4WpP82RYK08ZNh+PNhcO
         AWER/QFFpMp/t6n1dcR2TnHsgqtG/ZZORw/afHAalu6lwT+OebdzV6D8b3RpaN0S/Hxm
         FyaoEIc1j15oSbcp1G/n0swOdaBIcgT9o5vo2iRUtFPHe5nsilkhfLqRvpL6C8LVTh9M
         OvXx5PiknLcNFAK/HLQuevxJzYGlQO1wo3mmVF6pcpMGuIAt9n3mpZKhasMatRWAAYyr
         dHTA==
X-Gm-Message-State: AOJu0YzNV4osLOWD6QefRDWXbtehtj5uqUGrRhr/RwfIngEva+bujDro
	6SuwKRrLbJZq+wGG2qB+pruJ+WWxw7nvZKeB1C2D7FKS/en8NoSisRFuofTxgwOK98mmKWY6EKZ
	Upw==
X-Google-Smtp-Source: AGHT+IGW1c7o85uW7bpxsCHjQnpERux+gwllecdq2WAXDPiWzn0uTDOqFE1R0o0HQDu6Abaigps8mw==
X-Received: by 2002:a17:902:6b82:b0:1e3:dfdc:6972 with SMTP id d9443c01a7336-1ef43d15755mr80716245ad.9.1715515736822;
        Sun, 12 May 2024 05:08:56 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d484fsm61149435ad.39.2024.05.12.05.08.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2024 05:08:56 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v3 for-next 1/2] RDMA/bnxt_re: Allow MSN table capability check
Date: Sun, 12 May 2024 04:52:40 -0700
Message-Id: <1715514761-31694-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1715514761-31694-1-git-send-email-selvin.xavier@broadcom.com>
References: <1715514761-31694-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001f9fa8061840a2cc"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--0000000000001f9fa8061840a2cc

FW reports the HW capability to use PSN table or MSN table and
driver/library need to select it based on this capability.
Use the new capability instead of the older capability check for HW
retransmission while handling the MSN/PSN table. FW report
zero (PSN table) for older adapters to maintain backward compatibility.

Also, Updated the FW interface structures to handle the new fields.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
v2 -> v3 :
  Use data type bool instead of u16 for is_host_msn_tbl
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  1 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 30 +++++++++++++++++++++++++++++-
 6 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 439d0c7..3c961a8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -984,7 +984,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	u16 nsge;
 
 	if (res->dattr)
-		qp->dev_cap_flags = res->dattr->dev_cap_flags;
+		qp->is_host_msn_tbl = _is_host_msn_table(res->dattr->dev_cap_flags2);
 
 	sq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -1002,7 +1002,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 			 sizeof(struct sq_psn_search_ext) :
 			 sizeof(struct sq_psn_search);
 
-		if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
+		if (qp->is_host_msn_tbl) {
 			psn_sz = sizeof(struct sq_msn_search);
 			qp->msn = 0;
 		}
@@ -1015,7 +1015,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.aux_stride = psn_sz;
 	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
 	/* Update msn tbl size */
-	if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
+	if (qp->is_host_msn_tbl && psn_sz) {
 		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 		qp->msn_tbl_sz = hwq_attr.aux_depth;
 		qp->msn = 0;
@@ -1636,7 +1636,7 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	if (!swq->psn_search)
 		return;
 	/* Handle MSN differently on cap flags  */
-	if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
+	if (qp->is_host_msn_tbl) {
 		bnxt_qplib_fill_msn_search(qp, wqe, swq);
 		return;
 	}
@@ -1818,7 +1818,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	}
 
 	swq = bnxt_qplib_get_swqe(sq, &wqe_idx);
-	bnxt_qplib_pull_psn_buff(qp, sq, swq, BNXT_RE_HW_RETX(qp->dev_cap_flags));
+	bnxt_qplib_pull_psn_buff(qp, sq, swq, qp->is_host_msn_tbl);
 
 	idx = 0;
 	swq->slot_idx = hwq->prod;
@@ -2008,7 +2008,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		rc = -EINVAL;
 		goto done;
 	}
-	if (!BNXT_RE_HW_RETX(qp->dev_cap_flags) || msn_update) {
+	if (!qp->is_host_msn_tbl || msn_update) {
 		swq->next_psn = sq->psn & BTH_PSN_MASK;
 		bnxt_qplib_fill_psn_search(qp, wqe, swq);
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 7fd4506..4aaac84 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -340,7 +340,7 @@ struct bnxt_qplib_qp {
 	struct list_head		rq_flush;
 	u32				msn;
 	u32				msn_tbl_sz;
-	u16				dev_cap_flags;
+	bool				is_host_msn_tbl;
 };
 
 #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 61628f7..a0f78cd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -554,6 +554,12 @@ static inline bool _is_hw_retx_supported(u16 dev_cap_flags)
 
 #define BNXT_RE_HW_RETX(a) _is_hw_retx_supported((a))
 
+static inline bool _is_host_msn_table(u16 dev_cap_ext_flags2)
+{
+	return (dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK) ==
+		CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_MSN_TABLE;
+}
+
 static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
 {
 	return cctx->modes.dbr_pacing;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 8beeedd..9328db9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -156,6 +156,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 				    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
 	attr->max_sgid = BNXT_QPLIB_NUM_GIDS_SUPPORTED;
 	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
+	attr->dev_cap_flags2 = le16_to_cpu(sb->dev_cap_ext_flags_2);
 
 	bnxt_qplib_query_version(rcfw, attr->fw_ver);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index d33c78b..16a67d7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -72,6 +72,7 @@ struct bnxt_qplib_dev_attr {
 	u8				tqm_alloc_reqs[MAX_TQM_ALLOC_REQ];
 	bool				is_atomic;
 	u16                             dev_cap_flags;
+	u16                             dev_cap_flags2;
 	u32                             max_dpi;
 };
 
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 605c946..0425309 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -2157,8 +2157,36 @@ struct creq_query_func_resp_sb {
 	__le32	tqm_alloc_reqs[12];
 	__le32	max_dpi;
 	u8	max_sge_var_wqe;
-	u8	reserved_8;
+	u8	dev_cap_ext_flags;
+	#define CREQ_QUERY_FUNC_RESP_SB_ATOMIC_OPS_NOT_SUPPORTED         0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DRV_VERSION_RGTR_SUPPORTED       0x2UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_QP_BATCH_SUPPORTED        0x4UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DESTROY_QP_BATCH_SUPPORTED       0x8UL
+	#define CREQ_QUERY_FUNC_RESP_SB_ROCE_STATS_EXT_CTX_SUPPORTED     0x10UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_SRQ_SGE_SUPPORTED         0x20UL
+	#define CREQ_QUERY_FUNC_RESP_SB_FIXED_SIZE_WQE_DISABLED          0x40UL
+	#define CREQ_QUERY_FUNC_RESP_SB_DCN_SUPPORTED                    0x80UL
 	__le16	max_inline_data_var_wqe;
+	__le32	start_qid;
+	u8	max_msn_table_size;
+	u8	reserved8_1;
+	__le16	dev_cap_ext_flags_2;
+	#define CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED             0x1UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CHANGE_UDP_SRC_PORT_WQE_SUPPORTED        0x2UL
+	#define CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED                  0x4UL
+	#define CREQ_QUERY_FUNC_RESP_SB_MEMORY_REGION_RO_SUPPORTED               0x8UL
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK          0x30UL
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_SFT           4
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_PSN_TABLE  (0x0UL << 4)
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_MSN_TABLE  (0x1UL << 4)
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE   (0x2UL << 4)
+	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST	\
+			CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
+	__le16	max_xp_qp_size;
+	__le16	create_qp_batch_size;
+	__le16	destroy_qp_batch_size;
+	__le16	reserved16;
+	__le64	reserved64;
 };
 
 /* cmdq_set_func_resources (size:448b/56B) */
-- 
2.5.5


--0000000000001f9fa8061840a2cc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGym2lI/k08L
98S9CcZ5oa1103FSB9q73JK1FBy76aZUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDUxMjEyMDg1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB8Pi5Jb8Vsj+4pA0i9fy9BjeNQjdaj
ntREFyQ8kKhhcYOnR9ms4g/+vzSFH4T+/TPiJzctwlsQytL8Cw0NzdwxdBQpTE+lAjeZQlNfkgTp
8JWidzQeWNUx06y80z/+O3s0VvGuy5C0EclKv9MAdY65+jobGSCmn8u2xBHuFg0hV7GCqAeUY4kg
cHrSYwbfPNoZwe61z15FQc5VGAbYbf3Ltm6hmx42dh2lQ4aKXMvkJ1e2pM+sWXV5DoqrmYBEpu+y
qiMpVEhRl8cEr9gGUFziUtlHPTIlT6r6+bGJ9FX53eNP9Q8KZCPRJuZk/DGS64MXKLhnGYIWwFBb
WznG5MWV
--0000000000001f9fa8061840a2cc--

