Return-Path: <linux-rdma+bounces-19486-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Mf/Cv+46WlJigIAu9opvQ
	(envelope-from <linux-rdma+bounces-19486-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 08:15:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CA44D749
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 08:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FFB3014507
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32738F929;
	Thu, 23 Apr 2026 06:14:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198852E62A4
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924865; cv=none; b=PuvStzPFoB7UL5HJLGpz5BBA3WnEpXYRXgMYTEc+VDYqPfdz/pBj6EdNkqNeMxHOJjWJE97UOuEuzzmaMZt8z6fcRYLD07bAWi01XFJtRavwhStikkqP431nS3P+l7foyf9wjSGdjD1AbvI4wk7/pAHDBrgG5n5QvL/USizY5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924865; c=relaxed/simple;
	bh=UFLaNQT0I7DuHtgDya8ymZtjuyw37TwGfYNzrbymVUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EiiXcwHLvwIuW1oCODsJ2cGf3W+1AqFYxLyr58NkM2qGGiXYjH5rCWJJow4z1m3KcW6Ma6UEjYBOjLGtDIRCsdIApWDmby07gJ5BugJTm6HONK6KArpT2X80XEypTaO3UsAeITsAya3fT7MUIFBLPf0XMcshJAjoZvpizkGcKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a1b104dc3edb11f1aa26b74ffac11d73-20260423
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8c437727-03bd-41ab-97ae-9824bcf1cf82,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:8c437727-03bd-41ab-97ae-9824bcf1cf82,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a80c503ebd22b53e0d979b714de545ca,BulkI
	D:260423141408UHKFYTPX,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:1,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a1b104dc3edb11f1aa26b74ffac11d73-20260423
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 388451070; Thu, 23 Apr 2026 14:14:05 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] RDMA/nldev: add resource summary max values for usage rate display
Date: Thu, 23 Apr 2026 14:13:51 +0800
Message-ID: <20260423061352.359749-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19486-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E0CA44D749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
the resource summary alongside the existing current count. This allows
userspace tools like iproute2's rdma to display resource usage rates.

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
index aac9782ddc09..bf98e0d25007 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -604,6 +604,11 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
+	/*
+	 * Resource summary entry maximum value, used to calculate usage rate.
+	 */
+	RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX,		/* u64 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.43.0


