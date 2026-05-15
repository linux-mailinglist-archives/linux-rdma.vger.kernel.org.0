Return-Path: <linux-rdma+bounces-20764-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBYjNVfMBmrynwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20764-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:33:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCC154AA09
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD04A3003345
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09413D332C;
	Fri, 15 May 2026 07:33:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99A313E34;
	Fri, 15 May 2026 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830419; cv=none; b=NyjmrE8xHSWI+6ZZrCj8vNxB/NDsI7DB7vPjqr5feh+5xcl+54zaTAhsJZ7VGp0eUAZ1f+Gkkr3yGS/gRV3HyoZkCagSnL/tEWZF5hcW+tGUuDSABfygnrPWYge1JGtnZ/m343XYbURf8573ajQwaMaBWxbdXs71fAvT7sMp3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830419; c=relaxed/simple;
	bh=gcC6lSaaxlX13zGmVdPun6SN0RJNi/GyyzK5+CjXMOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgmYtWYoPUrvDeDLw+god3iXU4lGQ6cPuPOP+pAzQfLJh6dO59vRNrpBFR/abspANvHgPP4EyCXxmdkN9cKwq/tWJlr7NNwGNhMpA+SFNWKp35gyt0z9it5WiCq7zlPmarFORhDK8GL+06e0O3Ql9pu6amMt/pYkRFf0ktC/QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 59bb87ae503011f1aa26b74ffac11d73-20260515
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:267ad82b-2664-49df-ac78-1cc40e1a98e7,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:45
X-CID-INFO: VERSION:1.3.12,REQID:267ad82b-2664-49df-ac78-1cc40e1a98e7,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:45
X-CID-META: VersionHash:e7bac3a,CLOUDID:a6c629a9244277745f015386386475b9,BulkI
	D:260515153324VQDJUDBE,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:1,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 59bb87ae503011f1aa26b74ffac11d73-20260515
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1891413485; Fri, 15 May 2026 15:33:21 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next v2] RDMA/nldev: add resource summary max values for usage display
Date: Fri, 15 May 2026 15:33:07 +0800
Message-ID: <20260515073307.428768-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DCC154AA09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20764-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
the resource summary alongside the existing current count. This allows
userspace tools like iproute2's rdma to display resource usage in
curr/max format.

Expected output from "rdma resource show":
  Before: 0: mlx5_0: qp 123  cq 45  mr 200  pd 10
  After:  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768

In JSON output, both "curr" and "max" fields will be provided so that
scripts can compute percentages if needed.

The new attribute is optional and backward compatible - old userspace
tools will simply ignore it.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/nldev.c  | 29 ++++++++++++++++++++++++++---
 include/uapi/rdma/rdma_netlink.h |  5 +++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 96c745d5bac4..879aaa7960fe 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -187,6 +187,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX]	= { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -412,7 +413,7 @@ static int fill_port_info(struct sk_buff *msg,
 }
 
 static int fill_res_info_entry(struct sk_buff *msg,
-			       const char *name, u64 curr)
+			       const char *name, u64 curr, u64 max)
 {
 	struct nlattr *entry_attr;
 
@@ -426,6 +427,9 @@ static int fill_res_info_entry(struct sk_buff *msg,
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR, curr,
 			      RDMA_NLDEV_ATTR_PAD))
 		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX, max,
+			      RDMA_NLDEV_ATTR_PAD))
+		goto err;
 
 	nla_nest_end(msg, entry_attr);
 	return 0;
@@ -449,7 +453,7 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
 	};
 
 	struct nlattr *table_attr;
-	int ret, i, curr;
+	int ret, i, curr, max = 0;
 
 	if (fill_nldev_handle(msg, device))
 		return -EMSGSIZE;
@@ -462,7 +466,26 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
 		if (!names[i])
 			continue;
 		curr = rdma_restrack_count(device, i, show_details);
-		ret = fill_res_info_entry(msg, names[i], curr);
+		switch (i) {
+		case RDMA_RESTRACK_QP:
+			max = device->attrs.max_qp;
+			break;
+		case RDMA_RESTRACK_CQ:
+			max = device->attrs.max_cq;
+			break;
+		case RDMA_RESTRACK_MR:
+			max = device->attrs.max_mr;
+			break;
+		case RDMA_RESTRACK_PD:
+			max = device->attrs.max_pd;
+			break;
+		case RDMA_RESTRACK_SRQ:
+			max = device->attrs.max_srq;
+			break;
+		default:
+			max = 0;
+		}
+		ret = fill_res_info_entry(msg, names[i], curr, max);
 		if (ret)
 			goto err;
 	}
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index aac9782ddc09..3af946ecbac3 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -604,6 +604,11 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
+	/*
+	 * Resource summary entry maximum value.
+	 */
+	RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX,		/* u64 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.43.0


