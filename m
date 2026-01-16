Return-Path: <linux-rdma+bounces-15617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD3D2E921
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 10:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B66F3006E3A
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3E31B832;
	Fri, 16 Jan 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gh4FvqZK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0031A808
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554845; cv=none; b=oLx+vk6vzJCLQOnDxpiNidxC7Bgij2kFV5V3R1Xi9nlSZ30lWJAQiBYLAPV6QCO9+9nOVYtb9yW5JL/mZ0wU/rUjKKpmY4JkqXXeniuFbbeGkxOO7oxnjraKxcXRiKqDgj5N/d4hhalwXKns0wOzGLZPYEvyHoDgC1zzs/dILJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554845; c=relaxed/simple;
	bh=UIoao4NcT0+Bn565OpJL+kAMYuEx0h0cbKfPjOGJzls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0rOGdk6Xle/ZPhMPEYV9CtR648RtVyLvICLmYPetl57qdZPOMPQdTyAxB7L4m6PnoFRzUsTKJ5u8/mpZDF0QoCCVhFqJG0u8fEYbbFs38Nzo9VFJiA5jRWs63hTW1DNz7rwR9qOugWwb/A9mCkmppKJs7yz/fUzbEU+lkvO7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gh4FvqZK; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2b6b65c79aeso1128389eec.1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554843; x=1769159643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCNCrq3s0tdyfdebTIuHcYBMBaCp1/Y2FsAJey8g1Rw=;
        b=oMeptjYUZBZs86id+/8KpTkVpb914rJ1uTiYJIEcMnXMwZs+codbRT1AQzGqGIP5X5
         9+0CUQ3Q91Lr3LQubH4B0RdDmAcd6vMf2JymxF/iyxcrXDlv6/7I7yjWXatzXfuneaba
         7KE/xrWDXtt0zrdzqfhoFJbduFKqfBzobEjj1pNSK4fpc4eR+lPeyeqB1EuGFUxksY9Z
         8NgAs83gcO/Rnoub3TuPpNTHiuTmLXSuAvcmVixAxwUNFrug+GsLTm1/1HhMjzgOxLVW
         HnYJwEZNLjNUwKxXEjo3dgRCXtYvb3V8Ay6mPo4k6cVNd81b5XAeq+u0D8A7b5DIqGjo
         bxlA==
X-Gm-Message-State: AOJu0YwyeyaT73XMz+RaaV/ZvpSXAoeW0zHbISTALWZ354h4XslEigIB
	Nx9VwHkaAL062/7P6wlAM1mYUfAxHZwJHPKQmtgZArtAaHL/MZ2RY+OggOy7/vJv2mmVsYhTbEO
	PXlavAH9JSZ34wny/PooRbsr/bEDw9HJOWqkAt5iJYO4tz4DCgmboV2zZiWRl6OuOlNlPO9iGk6
	WOCrlNYf7IUYaVvJ9WU4YUVnp0yS/fUeSsM+t9vAKmv6sVljhh+lj16xbQ0oGKFjmvYm+EEjWSD
	Nc8hExl3xyFFkSkF9B0UqDiKtQPHw==
X-Gm-Gg: AY/fxX4sxokioyQGdGhsEDxm29Jq6L3dJaSMaDw+5l8UWatFcL71ddtfdQSWAuXR8d/
	qtL6A4loZulGYwH7p+STxZh0Q7ZmmAAYON7nwhM+YSomNI0JTpLms5JtFgyERPIE/1Gpj11kGZv
	Q5KT1tnkmA23TgdHhIXg/ZHfB35YyQHXuCFTGq8capJ59TuQrMWwLtTDZ4sWD1WeGntHEmAsncz
	4g0nCWtT8bTEidegsps4pYQ+3bMgE8tnmKP/1lINx2Tw5B7IC44crLOJS8bX2RIcZZV5vIc8/4u
	+IJZhEQetgjFMqg4pczkXQiudTNHn0qxzj8sCF3STxqICctzdmtr7V5Kgp15b1PI1B6cp5nRye+
	/LrKVgPctaV8sEVPhtHbAKarQ8MIICjqyxEBI/qcEz2U5167n46trt6EQRkmqHVApJrZdnta3V2
	WJwqbcUPZXpzZtmBXnvtdVUR3BJZz2ScTJtUt9SwooYp0iTuEXisDB2Pg=
X-Received: by 2002:a05:7301:d8f:b0:2ae:5a73:23d6 with SMTP id 5a478bee46e88-2b6b4053d20mr2069643eec.19.1768554842671;
        Fri, 16 Jan 2026 01:14:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b6b34ffff6sm222331eec.3.2026.01.16.01.14.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:14:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c21341f56so3299945a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768554841; x=1769159641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCNCrq3s0tdyfdebTIuHcYBMBaCp1/Y2FsAJey8g1Rw=;
        b=Gh4FvqZKayjTBT6DND8vnFihOsxR0dKojFOlH28CH2NQBp3rWIzQTcDh4gr2Jpr7do
         73FQV4N2cBArybwA6nFqucC6DdDOqSXn5q2lLbnHUa9RrWXoz2/3Yx/et/iA+v7moA18
         sDUBvRFU05mwsvCv5kMRyOD9l3AlxNOCJihSM=
X-Received: by 2002:a17:90b:1d4d:b0:34c:cb3c:f536 with SMTP id 98e67ed59e1d1-35272fc0123mr1852624a91.36.1768554840946;
        Fri, 16 Jan 2026 01:14:00 -0800 (PST)
X-Received: by 2002:a17:90b:1d4d:b0:34c:cb3c:f536 with SMTP id 98e67ed59e1d1-35272fc0123mr1852609a91.36.1768554840556;
        Fri, 16 Jan 2026 01:14:00 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm4161100a91.13.2026.01.16.01.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:14:00 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH rdma-rext 2/4] RDMA/bnxt_re: Add support for QP rate limiting
Date: Fri, 16 Jan 2026 14:48:06 +0530
Message-ID: <20260116091808.2028633-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Broadcom P7 chips supports applying rate limit to RC QPs.
It allows adjust shaper rate values during the INIT -> RTR,
RTR -> RTS, RTS -> RTS state changes or after QP transitions
to RTR or RTS.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 17 ++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 +++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 +++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++++++----
 7 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f19b55c13d58..8be9413311b7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2089,7 +2089,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	unsigned int flags;
 	u8 nw_type;
 
-	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+	if (qp_attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
 		return -EOPNOTSUPP;
 
 	qp->qplib_qp.modify_flags = 0;
@@ -2129,6 +2129,21 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 			bnxt_re_unlock_cqs(qp, flags);
 		}
 	}
+
+	if (qp_attr_mask & IB_QP_RATE_LIMIT) {
+		if (qp->qplib_qp.type == IB_QPT_RC &&
+		    _is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2)) {
+			/* check rate limit within device limits */
+			if (qp_attr->rate_limit > dev_attr->rate_limit_max ||
+			    qp_attr->rate_limit < dev_attr->rate_limit_min) {
+				dev_err(rdev_to_dev(rdev), "Invalid rate_limit value\n");
+				return -EINVAL;
+			}
+			qp->qplib_qp.ext_modify_flags |=
+				CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID;
+			qp->qplib_qp.rate_limit = qp_attr->rate_limit;
+		}
+	}
 	if (qp_attr_mask & IB_QP_EN_SQD_ASYNC_NOTIFY) {
 		qp->qplib_qp.modify_flags |=
 				CMDQ_MODIFY_QP_MODIFY_MASK_EN_SQD_ASYNC_NOTIFY;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index c88f049136fc..3e44311bf939 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1313,8 +1313,8 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_modify_qp req = {};
 	u16 vlan_pcp_vlan_dei_vlan_id;
+	u32 bmask, bmask_ext;
 	u32 temp32[4];
-	u32 bmask;
 	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -1329,9 +1329,16 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		    is_optimized_state_transition(qp))
 			bnxt_set_mandatory_attributes(res, qp, &req);
 	}
+
 	bmask = qp->modify_flags;
 	req.modify_mask = cpu_to_le32(qp->modify_flags);
+	bmask_ext = qp->ext_modify_flags;
+	req.ext_modify_mask = cpu_to_le32(qp->ext_modify_flags);
 	req.qp_cid = cpu_to_le32(qp->id);
+
+	if (bmask_ext & CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID)
+		req.rate_limit = cpu_to_le32(qp->rate_limit);
+
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_STATE) {
 		req.network_type_en_sqd_async_notify_new_state =
 				(qp->state & CMDQ_MODIFY_QP_NEW_STATE_MASK) |
@@ -1429,6 +1436,9 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
+
+	if (bmask_ext & CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID)
+		qp->shaper_allocation_status = resp.shaper_allocation_status;
 	qp->cur_qp_state = qp->state;
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 1b414a73b46d..30c3f99be07b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -280,6 +280,7 @@ struct bnxt_qplib_qp {
 	u8				state;
 	u8				cur_qp_state;
 	u64				modify_flags;
+	u32				ext_modify_flags;
 	u32				max_inline_data;
 	u32				mtu;
 	u8				path_mtu;
@@ -346,6 +347,8 @@ struct bnxt_qplib_qp {
 	bool				is_host_msn_tbl;
 	u8				tos_dscp;
 	u32				ugid_index;
+	u32				rate_limit;
+	u8				shaper_allocation_status;
 };
 
 #define BNXT_RE_MAX_MSG_SIZE	0x80000000
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 2ea3b7f232a3..43f9c564e97c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -623,4 +623,10 @@ static inline bool _is_max_srq_ext_supported(u16 dev_cap_ext_flags_2)
 	return !!(dev_cap_ext_flags_2 & CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED);
 }
 
+static inline bool _is_modify_qp_rate_limit_supported(u16 dev_cap_ext_flags2)
+{
+	return !!(dev_cap_ext_flags2 &
+		  CREQ_QUERY_FUNC_RESP_SB_MODIFY_QP_RATE_LIMIT_SUPPORTED);
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 408a34df2667..ec9eb52a8ebf 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -193,6 +193,11 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 		attr->max_dpi = le32_to_cpu(sb->max_dpi);
 
 	attr->is_atomic = bnxt_qplib_is_atomic_cap(rcfw);
+
+	if (_is_modify_qp_rate_limit_supported(attr->dev_cap_flags2)) {
+		attr->rate_limit_min = le16_to_cpu(sb->rate_limit_min);
+		attr->rate_limit_max = le32_to_cpu(sb->rate_limit_max);
+	}
 bail:
 	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
 			  sbuf.sb, sbuf.dma_addr);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 5a45c55c6464..9fadd637cb5b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -76,6 +76,8 @@ struct bnxt_qplib_dev_attr {
 	u16                             dev_cap_flags;
 	u16                             dev_cap_flags2;
 	u32                             max_dpi;
+	u16				rate_limit_min;
+	u32				rate_limit_max;
 };
 
 struct bnxt_qplib_pd {
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 99ecd72e72e2..aac338f2afd8 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -690,10 +690,11 @@ struct cmdq_modify_qp {
 	__le32	ext_modify_mask;
 	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_EXT_STATS_CTX     0x1UL
 	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_SCHQ_ID_VALID     0x2UL
+	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID  0x8UL
 	__le32	ext_stats_ctx_id;
 	__le16	schq_id;
 	__le16	unused_0;
-	__le32	reserved32;
+	__le32	rate_limit;
 };
 
 /* creq_modify_qp_resp (size:128b/16B) */
@@ -716,7 +717,8 @@ struct creq_modify_qp_resp {
 	#define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_INDEX_MASK  0xeUL
 	#define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_INDEX_SFT   1
 	#define CREQ_MODIFY_QP_RESP_PINGPONG_PUSH_STATE       0x10UL
-	u8	reserved8;
+	u8	shaper_allocation_status;
+	#define CREQ_MODIFY_QP_RESP_SHAPER_ALLOCATED          0x1UL
 	__le32	lag_src_mac;
 };
 
@@ -2179,7 +2181,7 @@ struct creq_query_func_resp {
 	u8	reserved48[6];
 };
 
-/* creq_query_func_resp_sb (size:1088b/136B) */
+/* creq_query_func_resp_sb (size:1280b/160B) */
 struct creq_query_func_resp_sb {
 	u8	opcode;
 	#define CREQ_QUERY_FUNC_RESP_SB_OPCODE_QUERY_FUNC 0x83UL
@@ -2256,12 +2258,15 @@ struct creq_query_func_resp_sb {
 	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST	\
 			CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
 	#define CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED                         0x40UL
+	#define CREQ_QUERY_FUNC_RESP_SB_MODIFY_QP_RATE_LIMIT_SUPPORTED           0x400UL
 	#define CREQ_QUERY_FUNC_RESP_SB_MIN_RNR_RTR_RTS_OPT_SUPPORTED            0x1000UL
 	__le16	max_xp_qp_size;
 	__le16	create_qp_batch_size;
 	__le16	destroy_qp_batch_size;
 	__le16  max_srq_ext;
-	__le64	reserved64;
+	__le16	reserved16;
+	__le16  rate_limit_min;
+	__le32  rate_limit_max;
 };
 
 /* cmdq_set_func_resources (size:448b/56B) */
-- 
2.43.5


