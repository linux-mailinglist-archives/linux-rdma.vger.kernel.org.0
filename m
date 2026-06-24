Return-Path: <linux-rdma+bounces-22438-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOpkG0dIO2oSVggAu9opvQ
	(envelope-from <linux-rdma+bounces-22438-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 05:00:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E446BB008
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 05:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22438-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22438-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 109463027342
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE32FA0DF;
	Wed, 24 Jun 2026 03:00:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A5191F98
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 03:00:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270019; cv=none; b=ePR01NjCG2Qt/cq8mZsbO0BLQqBJ/kNHl/eQMMe6UMswGcxnWs+/p72m2m/GCfNz6t7Gb7JyFotqUytZU4LECCJBqT/7u0JHVaG/zdRyaDqGtZtPBNRKa2SMlWmnbxd2UqihVeQRbYS0LKZhYrHa2Z35RjG7dtMWH2XlF1vb1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270019; c=relaxed/simple;
	bh=jnqZZsQWWSq/IOjfbEkfW7sjWKA3bHt7fVxb6xMvlj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSigJiydGGXIjAzTAqiwXcFbvwk2SdFEAKUJL1xLLoU32sMsgSIgpLOXekkSF6c7i/5jVe/ddfRhXSpLGDAHa26HsuGtdP9VLzH4HL5Alkrnbg/V2kKhTPP5Qiib7OmSDTkwAdWLqjHX1UwgmseTJ+6wLKx6X+ghlGOBDv/4cQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: cc9414a06f7811f1aa26b74ffac11d73-20260624
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4899fd3d-21fb-489a-bc82-9e9d5efd82c5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:4899fd3d-21fb-489a-bc82-9e9d5efd82c5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:687265faee5036e6b004dfdb0067ea82,BulkI
	D:26062411000590AHP5YK,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc9414a06f7811f1aa26b74ffac11d73-20260624
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 849774465; Wed, 24 Jun 2026 11:00:04 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: edwards@nvidia.com,
	mbloch@nvidia.com,
	michaelgur@nvidia.com,
	msanalla@nvidia.com,
	ohartoov@nvidia.com,
	jiri@resnulli.us,
	kalesh-anakkur.purayil@broadcom.com,
	linux-rdma@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH] RDMA/core: Fix memory leak in __ib_create_cq() on invalid cqe
Date: Wed, 24 Jun 2026 10:59:49 +0800
Message-Id: <20260624025949.306783-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22438-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:edwards@nvidia.com,m:mbloch@nvidia.com,m:michaelgur@nvidia.com,m:msanalla@nvidia.com,m:ohartoov@nvidia.com,m:jiri@resnulli.us,m:kalesh-anakkur.purayil@broadcom.com,m:linux-rdma@vger.kernel.org,m:zhaochenguang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4E446BB008

Free the allocated CQ object when cqe is zero before returning
-EINVAL.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/infiniband/core/verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3b613b57e269..d6b2eb820061 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2200,8 +2200,10 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
 
-	if (WARN_ON_ONCE(!cq_attr->cqe))
+	if (WARN_ON_ONCE(!cq_attr->cqe)) {
+		kfree(cq);
 		return ERR_PTR(-EINVAL);
+	}
 
 	cq->device = device;
 	cq->comp_handler = comp_handler;
-- 
2.25.1


