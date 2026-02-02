Return-Path: <linux-rdma+bounces-16317-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL8IGsUsgGlZ3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-16317-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF322C8358
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9167230022D6
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 04:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B62BDC1C;
	Mon,  2 Feb 2026 04:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AFiGeMaE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDA1C01
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007745; cv=none; b=UteZaLwRvYT4K2VwhE89zC1HlDqz7+1c18CfYLAGcwvq7vJrF82ZBypQhgKZAsRoOk4SqLWhqEwiUGE/tiHrLHDmeAcrebxagQm++g7ne5mtuIQ3cmJmj1QTArHv+mlMjKh//xPhBEEn983CCiZcyGqNuxHZ06hOEzkUww4kr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007745; c=relaxed/simple;
	bh=xdmNSqshllv+MhtT7u5+0rfjRhQ3KTX/XTwFH8zcDGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fvrey4GKju3Y+ExBPwT43pYleKrCNwSb9babia89b0YJAOe3bB4INB2vLCCzvJA1f5GIB2BfaCZJDctkTeM4E5NRMxt3M47KrnJsIDQaCpbuifeIYd6h1QNN7XeSLFpj3i1YmKtzRkWMQ5NvUPKlm+8LGyJZKqe7NMVIGEnSxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AFiGeMaE; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64937edbc9eso3444336d50.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007743; x=1770612543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNCEvz5uN9IonP3SWhvRsbP4cP43ctz5gFxPl20hPV4=;
        b=DC9d/WhZkGxMDSuhXHv4hrarYj6NUZXoOubyuh9PI6Hgy+BKoSlmEdriuCwwP4lk3l
         n4B6IF/+JBt9tjNBugZB5JMw9LuNQ5gTGqiMyQwkHADvmFq7AEtyG9P3ATFGLbrVJPqZ
         +m8O+Rk1UtALYsDoOftMxL4xq0poZM9LmkYQ3bscT72UnPCsOcxjTG8HDOTgwv36NUpQ
         ZYpFgsLS2FMZ+NpUxspzFHAaeXcQk3j/3nM337yYbGzLCFGJmjGh4aS52gGhcJ9+DQa7
         nDWKPexo6MIkam8dAWVzq31kv6xyWFWmMTX1hgLr+D43DZ0pgWBR1JUk+HDyLYePoaOz
         UXNQ==
X-Gm-Message-State: AOJu0YzyvmHTwrXFuohbvnm0A5JXUYrYaiVqMAZNninRLbhwaVE6Z/DK
	fBRwsoZax3xWjynt4I0ndgyh5IWd7yJGTgFCslgl/4z1Rj+0Emi8db32/hxBOvLB63BJqn3y9/d
	6HjZ4mIXNg2EAXqI8XPj9EKI0ktsVMwnP6qPg96uR1t7t0Q2qkAOq4fFbM5AipS41Hig+cxqCGO
	DYvx2f+Ne3y5D7fqHzIgfThHuu5N5SqLack0ofe5MAUSOKKnFtjI2dCLBeyydvZ5BESZyKnPRHE
	FDLimhLmotNUEaaxa041JjnlPcTrQ==
X-Gm-Gg: AZuq6aIyKWXUY3xhkOHBqysAEEh0I9UaKGo2Lv3dGHJlfZMSbUVtjK2+kQVA1JDes2t
	5SjfsRTIroC2ANfEXxX1NmR+/9j55/j8PfVmwuVnW+AheWLySW5mBiyr9xcyHiL60q23KLZrxE3
	kydru9jY4g3/tejIyO/S4bzByUsPAPpCMa7mhp8WzMFF3yF5bZVaKkuNzt129WhEBWRdqqB0p0a
	6QfQ4LQlhKlmuRkLtL3bPBYoGk09huCQ65OkpqBAxlUUTxCL8z36Z7uw05y8g9Ingyi/N7su3q2
	Cz/CGAHOaaACVCuZaBC9cdIPlyuei5X/xNtpwGVqp9PAlhGfNfhK6flpuySp1S58EKp7uOk40xx
	WPRqMFSYkHC6rrhIQ77hBbL1uvtF5MN6UqK68XWu54UcIHMHP1ESSPtooVE4Bq06qCK3RXocCrM
	bMUTKEsmLvEwgsg0PlEQvZanvN0CyaPBKkpwhk4Gnw11Q9saUYF0KjL/I5/w==
X-Received: by 2002:a05:690e:13c1:b0:649:bdfa:6338 with SMTP id 956f58d0204a3-649bdfa6e74mr3533492d50.35.1770007743158;
        Sun, 01 Feb 2026 20:49:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-649961004adsm1319717d50.11.2026.02.01.20.49.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:49:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso9990938a91.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770007741; x=1770612541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNCEvz5uN9IonP3SWhvRsbP4cP43ctz5gFxPl20hPV4=;
        b=AFiGeMaEjWnEhMC44YmOLhKPDcpbVlPWIayL0ZaYbKmPzf4zzljQoKbKqWXKgorpb+
         H8Azr6HDbCa6KkBaSRXUf9HvzbCLThlD3KdldlZa4Iaz91IOtCO4Je7rVjHKoG4xaYFS
         IVZvriJWVEjbalxI2jiHw51ngD7l3JSHNyVZ4=
X-Received: by 2002:a17:90b:5784:b0:352:cd8e:3ead with SMTP id 98e67ed59e1d1-3543b2fbb84mr11030015a91.10.1770007741519;
        Sun, 01 Feb 2026 20:49:01 -0800 (PST)
X-Received: by 2002:a17:90b:5784:b0:352:cd8e:3ead with SMTP id 98e67ed59e1d1-3543b2fbb84mr11029986a91.10.1770007741160;
        Sun, 01 Feb 2026 20:49:01 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm20282135a91.9.2026.02.01.20.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:49:00 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH rdma-rext V3 1/5] RDMA/bnxt_re: Add support for QP rate limiting
Date: Mon,  2 Feb 2026 10:21:16 +0530
Message-ID: <20260202045120.3139712-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16317-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF322C8358
X-Rspamd-Action: no action

Broadcom P7 chips supports applying rate limit to RC QPs.
It allows adjust shaper rate values during the INIT -> RTR,
RTR -> RTS, RTS -> RTS state changes or after QP transitions
to RTR or RTS.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 11 ++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 +++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 +++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++++++----
 7 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f19b55c13d58..2930461be20d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2089,7 +2089,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	unsigned int flags;
 	u8 nw_type;
 
-	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
+	if (qp_attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
 		return -EOPNOTSUPP;
 
 	qp->qplib_qp.modify_flags = 0;
@@ -2129,6 +2129,15 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 			bnxt_re_unlock_cqs(qp, flags);
 		}
 	}
+
+	if (qp_attr_mask & IB_QP_RATE_LIMIT) {
+		if (qp->qplib_qp.type != IB_QPT_RC ||
+		    !_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2))
+			return -EOPNOTSUPP;
+		qp->qplib_qp.ext_modify_flags |=
+			CMDQ_MODIFY_QP_EXT_MODIFY_MASK_RATE_LIMIT_VALID;
+		qp->qplib_qp.rate_limit = qp_attr->rate_limit;
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
index 2ea3b7f232a3..9a5dcf97b6f4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -623,4 +623,10 @@ static inline bool _is_max_srq_ext_supported(u16 dev_cap_ext_flags_2)
 	return !!(dev_cap_ext_flags_2 & CREQ_QUERY_FUNC_RESP_SB_MAX_SRQ_EXTENDED);
 }
 
+static inline bool _is_modify_qp_rate_limit_supported(u16 dev_cap_ext_flags2)
+{
+	return dev_cap_ext_flags2 &
+		CREQ_QUERY_FUNC_RESP_SB_MODIFY_QP_RATE_LIMIT_SUPPORTED;
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


