Return-Path: <linux-rdma+bounces-16318-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBgfJs4sgGlZ3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-16318-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E80C8375
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E3C7300461F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613942D8365;
	Mon,  2 Feb 2026 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O/kgBosS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2951C01
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007749; cv=none; b=P+JmIuqp01J0DnuaqUNnQBYQ+8/vzqa+Cv6+3kM3lOej7WrxPOIBotLklJw0reBwhgKuxERtpNn2hygbceVSdscouL6Xtwc6i1PnsMtcqmzE/9TCbfGKDGkcuAJhh/HxaqYRVmV1VlFam/q3kMqO7gRCd5/fgXU/m7ScrEC/A7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007749; c=relaxed/simple;
	bh=PJQ4jIkjX6NWaYwLMI4B+c0fpVMPblVkpBtuQ14pZd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/28/5TnLfpPc3GTU+DjAvBzKy0ReiVx/nqC9EB9U2w2NURx1/+jvbt+p5Az+Y8o3eut1DvXKz0VqSowK9ffRq7Pb+UHKP1SW5Pyv1xsJDYxNlTvL0hmNbfErlh3w8bfshl/cMVG/2C2HdX0dGcVMTppDR0kK8223pB8vkJrXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O/kgBosS; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7cfdf0c8908so2490988a34.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007746; x=1770612546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0trtwR3DSUKkRUAtpJHoAoO1R2dOcC+QB0Agqp5nYY=;
        b=n+Q3zQdlX0Vlg/5MtNTrb3jXPOmkWE7kEe0l2JW8B3gsZ2LNFqxLISZzE66Ns9vnzR
         DG17RPu1Nic7fj5tlT7mbCIgb7auUJDSswRy820Btr1L7uFI3nTDu9QzeSmqKvXT4W00
         pa6YiMljT3061F+ruAUpGq+MLRnjNIjv1poLr77wEkKVWbu3fY+KFV6m0/Wjcokpvgam
         0gQqn+zxnuHa4/obnZY8kouOfq1MP6m+OZjGKVKgIXKV7FveGJngT209A8YU6gLFwJl/
         u/SwIpDkivU7cUTg4tbuKNW7wrQu79eS6YEIp8OcHwbT1NAj8M+NARgWwt/vTYwoQJ4W
         raBQ==
X-Gm-Message-State: AOJu0Yzus9+r7GIxQcvS99yp6/3hGkPAryjt0MqSP/XvjSgP7RDAbMEU
	+Ykm5LbHbp2DCLtv5GGvVU9XRbENzlnsK8uOgLIztGtG61j3oP38O+p6niDaH9sBfQf9L3z629h
	aU7e9IVynPNZDDMapojX+dv+oMun5GYrWlU5QInfr7YXlb0T21OQdOgmOVzvihQ7XW4L45cmkNz
	r0S8PGgQdXRwS5s1WhXDZbdeDgi/ZiZXAt6T/zjcQgtGjFNyVueQqYjsu6Cv0ScdXW2XDCi04lJ
	ZD5qxaZXA+FuOFlxQGY/dv0E6t24Q==
X-Gm-Gg: AZuq6aINB3tnkFvMXqfSkw09nzfj7CQfd72Yw0nLx0dX4mCCFSlEE2h0HyUPIN7WnPg
	vtxVAij5CiWtWjTd8Kl/QwWyr/nBK0PX2c9t2KWsTRm9vA8np5IAtGcz5dZiOGwPZh+vciGj2xZ
	MwlWFeC9gNaSpVPl7uvIg8/HPZtxGZg+m0rG5PP8AjBxzAYvsMCt1HwGHmotsGYFzHj6DA0jAKu
	JsVdsVC9XA6EL29ayGEcDqMvdUX+IMhCk3Y2OPK0OEW+noOhXrchFAkknEgkfEntdksmTo7B4CK
	wvc2bp2tth9dB6Q7PDWXMeVz87FRwe8gxKXykCsGZnNrcf7Kwn4u7tslay5W69eBn4g05gzeNzp
	BKeKXfMIhjfZbnsqjsEtTp83oxFNMPcBn/0n/e1Q6FPhR9vTV+paPjnX9tnTgHgB38FqDzvWk4d
	mL53tv7ubywJ2REAIPu3ZaxYQu2a4Lbdf/l5H5WnkT9npszD3V1OZ/Osw=
X-Received: by 2002:a05:6830:8d0:b0:7cf:d819:a2d2 with SMTP id 46e09a7af769-7d1a534ebb2mr6433955a34.31.1770007746545;
        Sun, 01 Feb 2026 20:49:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40957188d37sm1554335fac.5.2026.02.01.20.49.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:49:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so4199536a91.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770007745; x=1770612545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0trtwR3DSUKkRUAtpJHoAoO1R2dOcC+QB0Agqp5nYY=;
        b=O/kgBosStj4I4/IJKQDZYJmDUvXness6EHzNdGyodIfpe4Z72scw/WcJXb4XP4zBC3
         8gh7VPpCenkhk9I6resAjt8HI405Hm5hEDxoBphtB9rxyZyUqTK77kqItjIc0jsIuY4R
         RqbicQuv0jO/wJWNBZXkxGE0ugLA/ai0vJZjQ=
X-Received: by 2002:a17:90b:3e86:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-3543b3cee92mr8526802a91.25.1770007745215;
        Sun, 01 Feb 2026 20:49:05 -0800 (PST)
X-Received: by 2002:a17:90b:3e86:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-3543b3cee92mr8526795a91.25.1770007744805;
        Sun, 01 Feb 2026 20:49:04 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm20282135a91.9.2026.02.01.20.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:49:04 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Anantha Prabhu <anantha.prabhu@broadcom.com>
Subject: [PATCH rdma-rext V3 2/5] RDMA/bnxt_re: Report packet pacing capabilities when querying device
Date: Mon,  2 Feb 2026 10:21:17 +0530
Message-ID: <20260202045120.3139712-3-kalesh-anakkur.purayil@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-16318-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 55E80C8375
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
index 2930461be20d..5a33afb30af5 100644
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
@@ -4400,6 +4417,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
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


