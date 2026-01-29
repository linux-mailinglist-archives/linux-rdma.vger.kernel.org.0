Return-Path: <linux-rdma+bounces-16189-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNoCF0k0e2lJCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16189-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:19:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1024AE823
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5926301A604
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C933B6D0;
	Thu, 29 Jan 2026 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dmtfCpAS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8712749ED
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681936; cv=none; b=hVwtozbPSmA7MSnEkiPmxxmGxxXi/ECCoKkYA1WEIfTJL+ocVMaUkiEOtHPuV8wTknQERr5hdZ3X9tk+2BjeXuMXi8jEdUrCYhLn277jNZhq+Dtj1WlBEoi0EXTRMWJWNi6iOWuwWvgtnU6JxVnABl3mFMw9LWv/nBPgwl51Rv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681936; c=relaxed/simple;
	bh=QK+y/tiwQ5wM7BP6t9EUcy6j562sv9t7kAJzZJH5Fvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYGmmnl3powf4Dtp45Lrf/vKoCzl2fZraMukKU/CqX+DDzv6sqLcT1FCUmy9Yn5jL7POnP4TXlzFitRlKdidp3RiIepSwD/WWUtLD7VKpjPYAeZg1MFvvtK1sU5esGr2SizxChfE+S9XlUgzXnwcnDqwZojz/8UfS5tV2WnCVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dmtfCpAS; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a1022dda33so4617345ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681934; x=1770286734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtDMAvofxXtjbZ3yEOuU+MDiEGGttDocQYWQJBxN/E0=;
        b=AkYPE8yp0UjPI7ONwfd1/2hmXHn1z5NRqddOhLsKjfO2HPKErkrFBXwiqpOK1jaRxj
         gh7nyH59J2DwDlXVvigYf3zrWJoOdIThdme523TyyH0JpbmUTC2LOaWlxYAEgLSuQW3F
         QoBnZgiwjWS+JUQtN7SPrX+Nj9Fjy1O2PSUKk4K7tYMQaBkVUM2E5EyFBlIBnTg0gVbC
         yaD1pnsctBIg6cviUaO0NSRE9Do7Ewsh9SxwaUrriBFaDV0hSMsvzbBbvMslAvA9BmQw
         YUWW63ycx59DFXKBfjV1Ue6nT4zd66Vc2TzjRug+o1hAR6Hjgjp0khR3nHLOom5VUHJW
         qwCg==
X-Gm-Message-State: AOJu0Yz2T5AWYzwYwQyudi9ECs5EeHZzCgSLgzGSZKIrIUY05XYB7RrE
	7qrpTUwIkeiHFzKdCTFCTNMtpDr3tU2EqHydrm0MjMj4EdHzSsbNGs4B5EQladrIkM9hlU+/AA6
	jFQEMfcCU5k5D/fOIWLV0FpIuBLGMIg2jlxUNQlex+LkMundXJX3mBShEpZIQ3GSv4eYQD2981I
	G2qtQGH9Np0ut4mmp0IBHY5aQ6lFp1JVyMmNXWGkxxWSD1IIaulsLEFYjfW6mvvQuemR78ksV+D
	AkQhO9kxE+HdPTX9b013/y7ywn7ig==
X-Gm-Gg: AZuq6aIWHOtP6GPUZUxfRcQBIBgXfPoQXDejALhGaxV0OWVz1a4K2hX/U45WWTJgK3S
	4HVAu45jHwlIrLR9jn4Z7kci8oKHA1iPUWJp2+cfhZFum7VoyH+g51u+Nb3HCKoQNKCzhHDH3SM
	qFSYcVlM8dDl1GUXqfdEVhje1fUdlTWQKSCL3QkipQwcQE9ExILApN9/WmWWDdHNF4RgEA4LPcE
	Gk78qGZWCm8KQq4olJUV5ZuVLzCYO+TZnrjUvZE9WTXJhuzlnEisrk8wmnxhC0IeMqPmYLMj6et
	BmkpR1VAJuO3h918pauNMCxsPeXCZhIEcznGxwdUDSeb3QIRF46fZLSVxWvZbSL2ol6CCyoUq0H
	nYDngDZ8gBfBsieTHsorGIseHpgenP4hBE2nXjuVmKXFx9LyP9DpceA1GECw4cL+zKaLevAOQTp
	IgTozXfI3Hl4XRwcki6P8JZW9rf8BRAFqfxSY6jew1SFxyeSjhVAd+BywjWA==
X-Received: by 2002:a17:902:ea09:b0:2a7:683c:afd3 with SMTP id d9443c01a7336-2a870d4cd85mr78067055ad.16.1769681934087;
        Thu, 29 Jan 2026 02:18:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b7f86c3sm6003305ad.53.2026.01.29.02.18.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:18:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0bae9acd4so6830375ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769681932; x=1770286732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtDMAvofxXtjbZ3yEOuU+MDiEGGttDocQYWQJBxN/E0=;
        b=dmtfCpASkR65bBHA16gsvIkq7ZWMk/8yENDdQizDl0WPowan4lA1bhECcHgF34VmfX
         Q9pd15MXJ6HlZw4y4+gWpWleDtSX/kNVgCiXMkIr9+qdvfI6f3BaOZO4cKlIbvh6VCS5
         JC5naZlrRvZF21bRkP1toN2sxnHDtjSRdHrJA=
X-Received: by 2002:a17:903:2d0:b0:2a7:3db0:6efe with SMTP id d9443c01a7336-2a870d2cbf8mr69292785ad.12.1769681932504;
        Thu, 29 Jan 2026 02:18:52 -0800 (PST)
X-Received: by 2002:a17:903:2d0:b0:2a7:3db0:6efe with SMTP id d9443c01a7336-2a870d2cbf8mr69292615ad.12.1769681932022;
        Thu, 29 Jan 2026 02:18:52 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm46155295ad.3.2026.01.29.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:18:51 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH rdma-rext V2 2/5] RDMA/bnxt_re: Add support for QP rate limiting
Date: Thu, 29 Jan 2026 15:51:30 +0530
Message-ID: <20260129102133.2878811-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16189-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F1024AE823
X-Rspamd-Action: no action

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
index f19b55c13d58..859e5b4e0d85 100644
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
+		if (qp->qplib_qp.type != IB_QPT_RC ||
+		    !_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2))
+			return -EOPNOTSUPP;
+		/* check rate limit within device limits */
+		if (qp_attr->rate_limit > dev_attr->rate_limit_max ||
+		    qp_attr->rate_limit < dev_attr->rate_limit_min) {
+			ibdev_err(&rdev->ibdev, "Invalid rate_limit value\n");
+			return -EINVAL;
+		}
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


