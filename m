Return-Path: <linux-rdma+bounces-306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF2808656
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F41C21F32
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4E364DD;
	Thu,  7 Dec 2023 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bLpEIrLU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B06ED1
	for <linux-rdma@vger.kernel.org>; Thu,  7 Dec 2023 03:04:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-286f8ee27aeso776185a91.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 Dec 2023 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701947083; x=1702551883; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YLkUnUNMsbLnU15xL1xpKtcKDRDutvyeiWbYGKa7WHI=;
        b=bLpEIrLUlAUdZqaQJCliMS4am0XhcSVbf8SPWCQurydloK0P2uYfJm66rP86PsnU0f
         H3PVxxQJySd/2EudOXqyHVWf+HnjhXxDoVsjBxWoOY8wc/VYvTNcQmnWpKfzApwzadV0
         IUywYPUrIbLZGxEjQDFJ+0jqpS3h5O5YI2p6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947083; x=1702551883;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLkUnUNMsbLnU15xL1xpKtcKDRDutvyeiWbYGKa7WHI=;
        b=BZXOIp0GZ8SMW8FyrxuibqMTeN9nKfed+BBdGTg5xQ6wp2bofYWq5tbiecp2FeOaJT
         UAZGhYko/LJIG9Au1UJv8pLi4H+t6JDPQ7KYi+dzxNyi+320tO8dCkoSJ0dvc7rzP8A1
         oRh1ivuQ1DzQo0fV9688L2I7KNy/sP6v/TPt5ZTg7xDBjlWPtjpjMoB+y5v6OxsDkxfG
         k8J3afljTkePgCiLs1wAIKNTXuqfkX0hPKGPoUUn52QCDXw6/wpVmvb18ZIKfiJEKPED
         s8bvnRft37/wkj3pAFkAkAdqexrEc4FHOPvU4PMBL2H77/8kWE+lyuKd3FLOmcY4r68h
         5VrA==
X-Gm-Message-State: AOJu0YyC9vW7jIVc2soOyFzgNKYR40nU9gjUnoW56MfqCfSEoOfO0FJY
	33BoWUZowj2eef9XAfwTeEAmhQ==
X-Google-Smtp-Source: AGHT+IGLivLxaOgM0EGbJUdHqmk9T9Otc9FHCpOr6uyNIl6DPcveQbUJQ5qRvQ3LFSUFASJPctCNDw==
X-Received: by 2002:a17:90b:1c0e:b0:286:bc8c:a23d with SMTP id oc14-20020a17090b1c0e00b00286bc8ca23dmr2701520pjb.45.1701947082936;
        Thu, 07 Dec 2023 03:04:42 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id pm2-20020a17090b3c4200b00285db538b17sm1034254pjb.41.2023.12.07.03.04.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:04:41 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH for-next 6/6] RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters
Date: Thu,  7 Dec 2023 02:47:40 -0800
Message-Id: <1701946060-13931-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
References: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005518bf060be96fca"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--0000000000005518bf060be96fca

GenP7 HW expects an MSN table instead of PSN table. Check
for the HW retransmission capability and populate the MSN
table if HW retansmission is supported.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 67 +++++++++++++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   | 14 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  2 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  9 ++++
 include/uapi/rdma/bnxt_re-abi.h            |  1 +
 5 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 177c6c1..c98e04f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -982,6 +982,9 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	u32 tbl_indx;
 	u16 nsge;
 
+	if (res->dattr)
+		qp->dev_cap_flags = res->dattr->dev_cap_flags;
+
 	sq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_QP,
@@ -997,6 +1000,11 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
 			 sizeof(struct sq_psn_search_ext) :
 			 sizeof(struct sq_psn_search);
+
+		if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
+			psn_sz = sizeof(struct sq_msn_search);
+			qp->msn = 0;
+		}
 	}
 
 	hwq_attr.res = res;
@@ -1005,6 +1013,13 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.aux_stride = psn_sz;
 	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
+	/* Update msn tbl size */
+	if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
+		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
+		qp->msn_tbl_sz = hwq_attr.aux_depth;
+		qp->msn = 0;
+	}
+
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
@@ -1587,6 +1602,27 @@ void *bnxt_qplib_get_qp1_rq_buf(struct bnxt_qplib_qp *qp,
 	return NULL;
 }
 
+/* Fil the MSN table into the next psn row */
+static void bnxt_qplib_fill_msn_search(struct bnxt_qplib_qp *qp,
+				       struct bnxt_qplib_swqe *wqe,
+				       struct bnxt_qplib_swq *swq)
+{
+	struct sq_msn_search *msns;
+	u32 start_psn, next_psn;
+	u16 start_idx;
+
+	msns = (struct sq_msn_search *)swq->psn_search;
+	msns->start_idx_next_psn_start_psn = 0;
+
+	start_psn = swq->start_psn;
+	next_psn = swq->next_psn;
+	start_idx = swq->slot_idx;
+	msns->start_idx_next_psn_start_psn |=
+		bnxt_re_update_msn_tbl(start_idx, next_psn, start_psn);
+	qp->msn++;
+	qp->msn %= qp->msn_tbl_sz;
+}
+
 static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 				       struct bnxt_qplib_swqe *wqe,
 				       struct bnxt_qplib_swq *swq)
@@ -1598,6 +1634,12 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 
 	if (!swq->psn_search)
 		return;
+	/* Handle MSN differently on cap flags  */
+	if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
+		bnxt_qplib_fill_msn_search(qp, wqe, swq);
+		return;
+	}
+	psns = (struct sq_psn_search *)swq->psn_search;
 	psns = swq->psn_search;
 	psns_ext = swq->psn_ext;
 
@@ -1706,8 +1748,8 @@ static u16 bnxt_qplib_required_slots(struct bnxt_qplib_qp *qp,
 	return slot;
 }
 
-static void bnxt_qplib_pull_psn_buff(struct bnxt_qplib_q *sq,
-				     struct bnxt_qplib_swq *swq)
+static void bnxt_qplib_pull_psn_buff(struct bnxt_qplib_qp *qp, struct bnxt_qplib_q *sq,
+				     struct bnxt_qplib_swq *swq, bool hw_retx)
 {
 	struct bnxt_qplib_hwq *hwq;
 	u32 pg_num, pg_indx;
@@ -1718,6 +1760,11 @@ static void bnxt_qplib_pull_psn_buff(struct bnxt_qplib_q *sq,
 	if (!hwq->pad_pg)
 		return;
 	tail = swq->slot_idx / sq->dbinfo.max_slot;
+	if (hw_retx) {
+		/* For HW retx use qp msn index */
+		tail = qp->msn;
+		tail %= qp->msn_tbl_sz;
+	}
 	pg_num = (tail + hwq->pad_pgofft) / (PAGE_SIZE / hwq->pad_stride);
 	pg_indx = (tail + hwq->pad_pgofft) % (PAGE_SIZE / hwq->pad_stride);
 	buff = (void *)(hwq->pad_pg[pg_num] + pg_indx * hwq->pad_stride);
@@ -1742,6 +1789,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
 	u16 wqe_sz, qdf = 0;
+	bool msn_update;
 	void *base_hdr;
 	void *ext_hdr;
 	__le32 temp32;
@@ -1769,7 +1817,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	}
 
 	swq = bnxt_qplib_get_swqe(sq, &wqe_idx);
-	bnxt_qplib_pull_psn_buff(sq, swq);
+	bnxt_qplib_pull_psn_buff(qp, sq, swq, BNXT_RE_HW_RETX(qp->dev_cap_flags));
 
 	idx = 0;
 	swq->slot_idx = hwq->prod;
@@ -1801,6 +1849,8 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 					       &idx);
 	if (data_len < 0)
 		goto queue_err;
+	/* Make sure we update MSN table only for wired wqes */
+	msn_update = true;
 	/* Specifics */
 	switch (wqe->type) {
 	case BNXT_QPLIB_SWQE_TYPE_SEND:
@@ -1841,6 +1891,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 						      SQ_SEND_DST_QP_MASK);
 			ext_sqe->avid = cpu_to_le32(wqe->send.avid &
 						    SQ_SEND_AVID_MASK);
+			msn_update = false;
 		} else {
 			sqe->length = cpu_to_le32(data_len);
 			if (qp->mtu)
@@ -1898,7 +1949,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		sqe->wqe_type = wqe->type;
 		sqe->flags = wqe->flags;
 		sqe->inv_l_key = cpu_to_le32(wqe->local_inv.inv_l_key);
-
+		msn_update = false;
 		break;
 	}
 	case BNXT_QPLIB_SWQE_TYPE_FAST_REG_MR:
@@ -1930,6 +1981,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 						PTU_PTE_VALID);
 		ext_sqe->pblptr = cpu_to_le64(wqe->frmr.pbl_dma_ptr);
 		ext_sqe->va = cpu_to_le64(wqe->frmr.va);
+		msn_update = false;
 
 		break;
 	}
@@ -1947,6 +1999,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		sqe->l_key = cpu_to_le32(wqe->bind.r_key);
 		ext_sqe->va = cpu_to_le64(wqe->bind.va);
 		ext_sqe->length_lo = cpu_to_le32(wqe->bind.length);
+		msn_update = false;
 		break;
 	}
 	default:
@@ -1954,8 +2007,10 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 		rc = -EINVAL;
 		goto done;
 	}
-	swq->next_psn = sq->psn & BTH_PSN_MASK;
-	bnxt_qplib_fill_psn_search(qp, wqe, swq);
+	if (!BNXT_RE_HW_RETX(qp->dev_cap_flags) || msn_update) {
+		swq->next_psn = sq->psn & BTH_PSN_MASK;
+		bnxt_qplib_fill_psn_search(qp, wqe, swq);
+	}
 queue_err:
 	bnxt_qplib_swq_mod_start(sq, wqe_idx);
 	bnxt_qplib_hwq_incr_prod(&sq->dbinfo, hwq, swq->slots);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 8a6bea20..967c669 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -338,6 +338,9 @@ struct bnxt_qplib_qp {
 	dma_addr_t			rq_hdr_buf_map;
 	struct list_head		sq_flush;
 	struct list_head		rq_flush;
+	u32				msn;
+	u32				msn_tbl_sz;
+	u16				dev_cap_flags;
 };
 
 #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
@@ -627,4 +630,15 @@ static inline u16 bnxt_qplib_calc_ilsize(struct bnxt_qplib_swqe *wqe, u16 max)
 
 	return size;
 }
+
+/* MSN table update inlin */
+static inline uint64_t bnxt_re_update_msn_tbl(u32 st_idx, u32 npsn, u32 start_psn)
+{
+	return cpu_to_le64((((u64)(st_idx) << SQ_MSN_SEARCH_START_IDX_SFT) &
+		SQ_MSN_SEARCH_START_IDX_MASK) |
+		(((u64)(npsn) << SQ_MSN_SEARCH_NEXT_PSN_SFT) &
+		SQ_MSN_SEARCH_NEXT_PSN_MASK) |
+		(((start_psn) << SQ_MSN_SEARCH_START_PSN_SFT) &
+		SQ_MSN_SEARCH_START_PSN_MASK));
+}
 #endif /* __BNXT_QPLIB_FP_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 403b679..0ea7ccc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -905,6 +905,8 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	req.max_gid_per_vf = cpu_to_le32(ctx->vf_res.max_gid_per_vf);
 
 skip_ctx_setup:
+	if (BNXT_RE_HW_RETX(rcfw->res->dattr->dev_cap_flags))
+		req.flags |= CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED;
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index c228870..382d89f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -539,6 +539,15 @@ static inline bool _is_ext_stats_supported(u16 dev_cap_flags)
 		CREQ_QUERY_FUNC_RESP_SB_EXT_STATS;
 }
 
+static inline bool _is_hw_retx_supported(u16 dev_cap_flags)
+{
+	return dev_cap_flags &
+		(CREQ_QUERY_FUNC_RESP_SB_HW_REQUESTER_RETX_ENABLED |
+		 CREQ_QUERY_FUNC_RESP_SB_HW_RESPONDER_RETX_ENABLED);
+}
+
+#define BNXT_RE_HW_RETX(a) _is_hw_retx_supported((a))
+
 static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
 {
 	return cctx->modes.dbr_pacing;
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index a1b896d..3342276 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -55,6 +55,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED = 0x04ULL,
 	BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
+	BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED = 0x40,
 };
 
 enum bnxt_re_wqe_mode {
-- 
2.5.5


--0000000000005518bf060be96fca
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIkdAQhqGmAi
M+DlHyVlCV9cfn87jWaMR8QYsIKvWUcoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIwNzExMDQ0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQADXkXGLL68YzV2kmrFn+QKTg2+TOwN
R47XS5l9dgRfLrBNAc29619bWu6EyzQFddscmpjbG0HO25hC9Z2lLuZZm1lRGQBvHcO8d4NJIAID
zhNN9WCYUdNgQ0O5yCSCqAJfFZj9j6eRK+I61CzLnmtiVe6ImMRbawmpNPl72W9/niVO9ZTzxCfT
ZshOnAaV9WiNqTici5OmZthzOaJ6dAsak4DBTjcAGVD3UfhgvLz4Gi9LyhHMPa/XXL+/WHt9mz1v
wdSaJgr+AgpZfpBqWydrOCW5A51TlvWLyT1w+Znn8al7yM5y0GsIGME6Owax0ZZpC/7m3AK1BMKy
8lHeh4EF
--0000000000005518bf060be96fca--

