Return-Path: <linux-rdma+bounces-16333-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UALbDlungGlNAAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16333-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:32:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C9CCC05
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCF81300CA34
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D1369226;
	Mon,  2 Feb 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E4y3/E0k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741719E819
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039124; cv=none; b=Wj03H5yyPMkgZV6O7HT/89wJpSD6xVb6F8+XwkcRuEpCT/dG7zzzjzmHhRR+Xvfrs+EhHqKPP5sJKSWUdXhD1Lld+yQhS2OlLma2is2CjTDJAMPgKP9jdcPpx8dHBo2gBbEWH4YSsYlsbyA50cV2O03B9DvE+ke0ysYna8XM9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039124; c=relaxed/simple;
	bh=M86dHsDEmq2crUQXyhtZqjTtKKb/T4s/9m7VhECNsLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ/0geD/4A/xomH71OuE8mUA4CMapyl97v+MSMcoCnje9dljpeLbPv2zQ1G+5I+JiNElNX4DQL5unLH+T7hA/GmF4ORIgOwu/f1rxuw4p3q7hmRbBVSkf2H1aTXRawHrHenXg5D4oncVuK0sMetynffxzA/rjTC+DrKoTjCdfow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E4y3/E0k; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35456fcb79cso799088a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039122; x=1770643922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oY91yQwyvYafJOIjz8PhyyW4aC1u7jJpYz+idjPWi9U=;
        b=ENTm/nX/Zd/Kxe/P6d8w1RTNfa6eLjgPFPYV/cut4tram7OxgxMljT7soLrakpnVHB
         AWHXNt3vxjOvR1TcXKtKCj4Ik94xQux5ooVGb0KCbIncpeFmrr2lg4RVUphFEH5PSJ5Q
         qzrJrShCOeelkGXEToMMNSqQzCqGdQ+XMWRtekPaZK7viTWp3sxP6sAciiTEcjRDf8PF
         +BfoIliV3OG0WF5ZJS/hzkwcsoCZKk3SSLCTUggZ2CYL+oujo48fOe+FrT180s8WG8nJ
         //A86dPvyKBjag5tGyLzQrrZSZsKjGB4RD8EMIm7cv6gwCppJunUuU8qNFj/5D3s5Uf8
         as3g==
X-Gm-Message-State: AOJu0Ywp2K54sH0rbgASa/Uk/Wf8Ytwy/PCwI/O9edNE5q0fRHJLgHgC
	OKLSG7443gPEvNj6mv4sX3XJEkeV4XYchIb1DxkScm9JP3BYICBLpK/xKsFvwfgTF/am1FYKTYS
	0scvfngzQ/Qf11Q2GUwYqmwOEKYprlOhrjPHyT8p9EbT7TanzQszqqrsbQZ5Lg/ubBoqH3qiKob
	HZFsvexw0U3+4t+Teig1QrsNZGTFtEEE1+h5rsxX/AXti40C3yvfIWzxmYZqhoZKtwq8Sqy5lGH
	wzmJr5uIElWROlndKBSSXj45j5Adg==
X-Gm-Gg: AZuq6aJO9Pz73QayhrUaD+xwk17I/UfRZ4+m1lMbIZnlHp7sGFsInMRWTWW4QQGd7+F
	dWzd9hVlodvert6BlFrYPt4mSo7NT9iO/sldkRrTAcGFrKLCvtkGDxKLJh34/CYs2tpWvg03ryP
	zcyUcKknSS+hPG8TV3vTYWiE9qwgrXVSVm7TTQMehgQnUpwbvkHJ4mS3FGVEyDXtv7nzWY89HLj
	tDLppb/GinkAwx3oF1PGKUeGrMe6AITsjluB58LqdV63yZq64D/kuDshHS893JX185FEWrdJ2Fe
	bMU86IrJUzOUw+AtdgX32DH/1ntvgLJbydMDIGn8hZsQAn4HZd9xS6EBB50uVWwdvVFtsIPXMv/
	aHOMiZaJ5Dlsxz6/EJA3UjXt7YsRJd/QFTFCpvOCBZT1/H9n5mP/OadHJ/m0mfeFc0J8AxXrBaR
	7dFUBZNCpL3Idzl32i6r2ghmPEI8enIwKT2Fmccg/HPbHXGllC8ydvJGc=
X-Received: by 2002:a17:90a:fc4f:b0:352:b674:2592 with SMTP id 98e67ed59e1d1-3543b30564bmr12833724a91.7.1770039122189;
        Mon, 02 Feb 2026 05:32:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35458c070c3sm788320a91.0.2026.02.02.05.32.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 05:32:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c636238ec57so3004142a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770039120; x=1770643920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY91yQwyvYafJOIjz8PhyyW4aC1u7jJpYz+idjPWi9U=;
        b=E4y3/E0kGNdSx53sIXjrqVZgF+MZ9y9JCI+kOMh79BbuIDTIkeN9FxsLFMlFgTUYFm
         PjToCq/glQmS1KXjhsUKFiB2MrGMimPlRuoW8nxRDF4YHVB2W/zW+G3yI4dsp84P3Oeo
         8je59u+49c6iIFB/ILR5ksc4YhP/AJ0FxvY14=
X-Received: by 2002:a05:6a20:4327:b0:38d:f62a:a9e8 with SMTP id adf61e73a8af0-392e00007d9mr10994950637.7.1770039120219;
        Mon, 02 Feb 2026 05:32:00 -0800 (PST)
X-Received: by 2002:a05:6a20:4327:b0:38d:f62a:a9e8 with SMTP id adf61e73a8af0-392e00007d9mr10994932637.7.1770039119833;
        Mon, 02 Feb 2026 05:31:59 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0007sm18859382a91.12.2026.02.02.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:31:59 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Anantha Prabhu <anantha.prabhu@broadcom.com>
Subject: [PATCH rdma-rext V4 2/5] RDMA/bnxt_re: Report packet pacing capabilities when querying device
Date: Mon,  2 Feb 2026 19:04:10 +0530
Message-ID: <20260202133413.3182578-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16333-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D18C9CCC05
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
index 39dd18af86eb..c146f43ae875 100644
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
@@ -4401,6 +4418,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
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


