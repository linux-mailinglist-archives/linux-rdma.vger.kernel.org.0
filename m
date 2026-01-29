Return-Path: <linux-rdma+bounces-16190-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EpjJFs1e2mGCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16190-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:24:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B754AE99F
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66731304C485
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B033CE85;
	Thu, 29 Jan 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DYBWCvBR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7427E06C
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681939; cv=none; b=cqj25GaPzMp9UNcJ3Fv3ArlXGY+N0aHUUkKfELgshU249bEmpgil/ltwvHRCX/BL/4SO1ytyTbII9yNZmzhlWsYGIQNWimKWs4qODOjaS6Esckhu7K645ZB5QSZlnrOtOdTxi5zVtGGDAaPxmPwo+80FjIWD225tTyz5ZYCuALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681939; c=relaxed/simple;
	bh=sCU73x5GPx9m3yXlv7flR2QEmzzxM3XQ5hbhjnbijxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0atb55wk8mm+gKvc+9LZrc0e86fKi0myAok+zJ3UTp/Y8BhUjGh3/cYD8ELXwcF0nRRHZi2f34bdmwB30Z4PwnHLPgZ80Ofv9hwbP7SNIn1HmUHCdfR+NQ/DkVb5fEVuFwGQ+7o5IeVSK6russytO2l/KH0/6bCJ91xSDD/XAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DYBWCvBR; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a12ebe4b74so9213365ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681937; x=1770286737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BB3psb+REjQITzdF3KJba7P0CuvpAO7Oo/7rxMoU+M=;
        b=kLO7fvMOlFNYHbcmDOnl8ofeaArKXIEPthKiwOo7GnkmJi0kI620wHyP/22W7K3gdj
         0/q4SSVZr6Vln0Gs5TX2L8VWrzx0RDiQdS/Ku1h/pnkyng4GZS+PUDlyUHOPrTCbRqD7
         WHVys1MppFgQ8gUcJvB9a54zfkNoB1nr/85UOaI2JGh7pBFsYM95LBWrx5/HIrK0jT4k
         RVMyC/MZITrtrH6Bbc8H/Sktf2aKfBozK6qRro9sc9WKTBkdRN9WfWf5408HSWPLm1lJ
         VF/TWDANocAf9Vi9fNq4MbqzxWa5nNKVcTaymhYatbsKVhOq9bxi3vH+ysO0uYOx+uyT
         YT3g==
X-Gm-Message-State: AOJu0Yx0d5Zt+ODUACPSZ661KF/DWj4LvODHf1AfPdLT3JW56Hq81+fp
	+n1Bm+G66qq2EO0ZvnQ0tE4pfNp9CsuLt+eiNtuWhyJ8+ubp2sgn4YAbzrD7iFA3nfpY5h/QXQN
	8+Rb/2GH+PBmUcjKOEdL9nYhoE+XYcxZx1igC9VCfy1dCLx0p20ttVlJ82qpuAzEFepL8drbKbZ
	cG4GoKXWkCzpsqizIdnmuVD4mybPoHfYZi1/PysutipjogAMgUsyGfnxSDE/xboeyz9XNkSdB5W
	o6FopQX5zcaF66MwtSSX/YJWC2Prg==
X-Gm-Gg: AZuq6aIgU10ChI4j+3roZIoGIFpsM4EevwqiLVwt4bndC63Y7MePIRM7xjIcewmhNy8
	1LXbLY2aUp5DGOVJeZPRv22hTTT9QfFUm2DcQ31XwSBdbSAitWzpkUTI9XJshS9hIbVf/87itlb
	m0AKwbo7Q9mxiCFckFXdWBmBW81HDdgTnlLL/+uSL4P/FXrTuXh37zBhqVTAUKya78QVceFFxtN
	XzLzC9aAhyZt/rcfcpVJP/ievQ11Mj24cd7zwngGEh30DekoshDCR7CCz3Iks2np7Y8CqDNwThv
	4jALFNmC7mj1UJCTe0jqZr3dGePHTBt8Iak9Zz8fvTMSyaRGorlqOl7ZFAIaxLBYUNDRSuRoezz
	ej+OxXmPu5n6QE57YY8DwnJGK5b6AQCuSGf7FrgyFf8kgOcUdY3XOSM7yjKtAdg4lR7dj/yigO3
	9Hdc2/jrztK5Ner3Zg3JFAFnM6BB6YSyJwbUA0P8fjsIqf68r20w2DkEiqZA==
X-Received: by 2002:a17:902:d2c6:b0:295:9e4e:4092 with SMTP id d9443c01a7336-2a870e7614amr83763575ad.56.1769681937157;
        Thu, 29 Jan 2026 02:18:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b413cf9sm6568315ad.16.2026.01.29.02.18.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:18:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0e952f153so20160615ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769681936; x=1770286736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BB3psb+REjQITzdF3KJba7P0CuvpAO7Oo/7rxMoU+M=;
        b=DYBWCvBRwImL6dxzQxmj6jIHz5ftegdJCY/Fl0HOJaaMg9eNv6TTCB1mlV8BbkzhRn
         AJFZFIJ8c24rJ/1092MOKEjqWpc5eUpCuLXKdYniF+RNQDL1ERLqfxCvOwFUFIR30EM1
         Pn5GvFKw7aGxdKelQb59rOlzs5H9qL49kpld0=
X-Received: by 2002:a17:903:1250:b0:2a1:5785:4417 with SMTP id d9443c01a7336-2a870e1899bmr68477155ad.34.1769681935704;
        Thu, 29 Jan 2026 02:18:55 -0800 (PST)
X-Received: by 2002:a17:903:1250:b0:2a1:5785:4417 with SMTP id d9443c01a7336-2a870e1899bmr68477045ad.34.1769681935343;
        Thu, 29 Jan 2026 02:18:55 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm46155295ad.3.2026.01.29.02.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:18:54 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Anantha Prabhu <anantha.prabhu@broadcom.com>
Subject: [PATCH rdma-rext V2 3/5] RDMA/bnxt_re: Report packet pacing capabilities when querying device
Date: Thu, 29 Jan 2026 15:51:31 +0530
Message-ID: <20260129102133.2878811-4-kalesh-anakkur.purayil@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16190-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B754AE99F
X-Rspamd-Action: no action

Enable the support to report packet pacing capabilities
from kernel to user space. Packet pacing allows to limit
the rate to any number between the maximum and minimum.

The capabilities are exposed to user space through query_device.
The following capabilities are reported:

1. The maximum and minimum rate limit in kbps.
2. Bitmap showing which QP types support rate limit.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++++++++++++-
 include/uapi/rdma/bnxt_re-abi.h          | 16 ++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 859e5b4e0d85..ef2485226fe9 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -186,6 +186,9 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_re_query_device_ex_resp resp = {};
+	size_t outlen = (udata) ? udata->outlen : 0;
+	int rc = 0;
 
 	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
@@ -250,7 +253,21 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 
 	ib_attr->max_pkeys = 1;
 	ib_attr->local_ca_ack_delay = BNXT_RE_DEFAULT_ACK_DELAY;
-	return 0;
+
+	if ((offsetofend(typeof(resp), packet_pacing_caps) <= outlen) &&
+	    _is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2)) {
+		resp.packet_pacing_caps.qp_rate_limit_min =
+			dev_attr->rate_limit_min;
+		resp.packet_pacing_caps.qp_rate_limit_max =
+			dev_attr->rate_limit_max;
+		resp.packet_pacing_caps.supported_qpts =
+			1 << IB_QPT_RC;
+	}
+	if (outlen)
+		rc = ib_copy_to_udata(udata, &resp,
+				      min(sizeof(resp), outlen));
+
+	return rc;
 }
 
 int bnxt_re_modify_device(struct ib_device *ibdev,
@@ -4406,6 +4423,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED;
 
+	if (_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2))
+		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED;
+
 	if (udata->inlen >= sizeof(ureq)) {
 		rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
 		if (rc)
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index faa9d62b3b30..f24edf1c75eb 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -56,6 +56,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
+	BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED = 0x80ULL,
 };
 
 enum bnxt_re_wqe_mode {
@@ -215,4 +216,19 @@ enum bnxt_re_toggle_mem_methods {
 	BNXT_RE_METHOD_GET_TOGGLE_MEM = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
 };
+
+struct bnxt_re_packet_pacing_caps {
+	__u32 qp_rate_limit_min;
+	__u32 qp_rate_limit_max; /* In kbps */
+	/* Corresponding bit will be set if qp type from
+	 * 'enum ib_qp_type' is supported, e.g.
+	 * supported_qpts |= 1 << IB_QPT_RC
+	 */
+	__u32 supported_qpts;
+	__u32 reserved;
+};
+
+struct bnxt_re_query_device_ex_resp {
+	struct bnxt_re_packet_pacing_caps packet_pacing_caps;
+};
 #endif /* __BNXT_RE_UVERBS_ABI_H__*/
-- 
2.43.5


