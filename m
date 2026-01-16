Return-Path: <linux-rdma+bounces-15618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B2D2E925
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 10:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A423011A7F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAE31CA46;
	Fri, 16 Jan 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ASoic2iy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D231A808
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554848; cv=none; b=ukUE9LHYKsaH1lVWyeWN9RXVuscjIeHQGKp1vV54S3O4zXey9a6gO1ilXWy29lA0wZcZZwgJvGoCmYh2xNgQ4l/pIUPbi/K9ibAF5PT09cLUVm32lJM8WXuIbGVpuR8zZmlHBdJLEn9hqNQSYIA97/foXbBd34t1GQWYtXGNl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554848; c=relaxed/simple;
	bh=JeP4GRkBT5it0puIrlWPrwk6PDN7E6xr5l9D+OdfNvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUr9Hz3wBlYo5JISMTMCoHo1dprj+VNk6qGTi7jwoBNKlfqKUeA2lADbF2WkgGVdk2Qa4/S7///lxex6easr4gRW6BmzYT2qAk4ack7ETzCfQLsXiIaoFCbuq08KPi2aCgGNRRzV5AZfSTIFNZXTw2AVEji+HlKmt/S4280CVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ASoic2iy; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-94120e0acbeso1148061241.2
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554845; x=1769159645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HgFzFamYQr67AUrkcsvfji0uVDpgsj9sptrA/3ouNA=;
        b=vxtqMwnmZ82qBToJCwMHvwxgNyIqfZA40K5NJ8DbPYb9k7EI8WwfzwbweMMeNhYB3L
         LzChOvKBg4+6T4p40A1u8wZIO17X3Ymvpu/B26YP5Fhisbc73ItxXaAX4Bbr4bETxu21
         F7XPDZR3KoWtuPhvnFO+kH5ZGHfNqPwkYzpMaT96al1iIXT2oPJZWeogEtxoHwzoQ5PT
         AH3yUQXqIwagbVZ8Hnek3DDjUuzjVO+2Z0CIf310Zah1WWRHEy6mHI7fTveepL2vKXoc
         hJFESfxHOL9YbCJVLOzFq6Ont3Er/aY+HsadXy1Vo9J6yOGNiz8xdIGIYMggL1MoZfB3
         9SiQ==
X-Gm-Message-State: AOJu0YziwMb4uxgNLwVl3QJtwUo+3azd1HUCsf8DEL7gNjlDV09HsqlG
	QNl7+GMB6K6KwoP3PVdnZSkSUDa0ucQhVE0mjlNB9bcyUf3vkYkdMslZ/svDAuGAARRFSPHcmzf
	R8gtCqEaSOH7HTe2ankSBma0rT3OEwQFtOuIuilm85JjzZpWNgSpczOkRRlT5RGLNWi5622h7/h
	jnRhycP9oXVRPXipCjeILizjwbm7RMCtqlG8YFg/MZ9NjJmO9GUO4ntvHGhje2aHu39tM04Aydh
	LV66g82vgU0wbOjMrrV4BZxENCrIg==
X-Gm-Gg: AY/fxX5YpDsVZKVvOBfJdDoHJiavWOadTR7XjeM32q7vLy+/v/ktTdOiUStpEVKK9zf
	x653GtnSKCKxI47UcBEhEoZA1+BpuyKGWW4k14pUbNbxUzfpGoYf9XBbA8pvKbe4mQyl7w0kMdB
	6aYI9yRPSAjjkTfnz3hw+/ESilbpUvTiJKRDLoNzyxUTbaGIKeAp4cNLxu4tubddLDYnQV6Mh0L
	a3uf0817HTIDyt5O3APUzbqHOjQBw5bl41BLeDp9AfaoZkSXRUYF36V7KKIGt0+7dDNqZLBfYeD
	5kgS7amtpgzSDR37CGZq+rdV4+LvBOM9H4UGA151ogaU/zpg9UCPr9QIKBrSXOqz+j6INhn563/
	s4+R1ZM5ALHehKwI3Efl+XW3zqqFLUzKX0ZYQlLD1RKiM4qHMwoaZpxyYLs+DQm2eR0b4LJVXtX
	sysxsncpZhfPF3pLE9mO029QjkIhC7bl0rryXju7zc7pccgLDsv4u2i06F8A==
X-Received: by 2002:a05:6102:2ad6:b0:5db:f615:1821 with SMTP id ada2fe7eead31-5f1a4db87c2mr910151137.10.1768554845508;
        Fri, 16 Jan 2026 01:14:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5f1a68fe9dbsm247531137.1.2026.01.16.01.14.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:14:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc88eca7eso1536700a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768554844; x=1769159644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HgFzFamYQr67AUrkcsvfji0uVDpgsj9sptrA/3ouNA=;
        b=ASoic2iywFvsbJRLPF0cAOLJtvev7x13ZbSDQ9cdpKtbFymoRHYno2fd+cJaOvR2ns
         MGxRB77hcCO6NqxeAgHencv8LfoN84Cjb7+jt6utSGfM4X0yRfK0MSYZ2fIlIJY5F83O
         A5ldffNE/RC4MZ3kqkxHWrtg3NdmZY5nX2f+g=
X-Received: by 2002:a17:90b:4d05:b0:34c:2db6:57ec with SMTP id 98e67ed59e1d1-35272fa53acmr2263872a91.17.1768554843883;
        Fri, 16 Jan 2026 01:14:03 -0800 (PST)
X-Received: by 2002:a17:90b:4d05:b0:34c:2db6:57ec with SMTP id 98e67ed59e1d1-35272fa53acmr2263861a91.17.1768554843489;
        Fri, 16 Jan 2026 01:14:03 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm4161100a91.13.2026.01.16.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:14:03 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Anantha Prabhu <anantha.prabhu@broadcom.com>
Subject: [PATCH rdma-rext 3/4] RDMA/bnxt_re: Report packet pacing capabilities when querying device
Date: Fri, 16 Jan 2026 14:48:07 +0530
Message-ID: <20260116091808.2028633-4-kalesh-anakkur.purayil@broadcom.com>
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
index 8be9413311b7..8e6afb72a5ab 100644
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


