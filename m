Return-Path: <linux-rdma+bounces-22460-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Ve7OhuMPGolpQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22460-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 04:02:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 622486C24B0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 04:02:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22460-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22460-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 306FF301842C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 02:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E775B3A8753;
	Thu, 25 Jun 2026 02:02:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CAA374E42
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jun 2026 02:01:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352920; cv=none; b=Jl+diHBcnIV1jWTDrp8XJnHI5GaBPSIG8vBES90Hqng6+A3RLTwXh3SGoZX6Kakjmfi6pDOqdH6EvA6jODTN0mdxmKNB9D4M6qwTh/JwoceqvFEGs77tGcFzMIvgjn2Cjg50iY6LFgwcQUfuh8dsP7h3aNj2JdTxw7GIrs7SrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352920; c=relaxed/simple;
	bh=yfYjwzgS14uWyMEtrrrgnO91lSbaWswkKsKXmkeLlq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgqnf8sudmQ69WNuC5vGVup33uVfwgUW/0TgOWpSicu/eIdrwGloo4NAKKnQ19+gP1aXSpFTnP6vUDO+rSZBC9rJliOXkThXUC+oncKav3Ww0xyqyz0NWKMnQY4LeeQry6F5qXhlmSiNP1RwJUzh8YbZKPu9QO//JPiCvySu6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: d4d7e6f2703911f1aa26b74ffac11d73-20260625
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3e50353f-cc5b-4f01-860b-96521fd4fade,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:3e50353f-cc5b-4f01-860b-96521fd4fade,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:41b7058e7c499ffd5a66ab3e964f9cb4,BulkI
	D:260625100153IZV6APXN,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4d7e6f2703911f1aa26b74ffac11d73-20260625
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1193287302; Thu, 25 Jun 2026 10:01:51 +0800
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
	zhaochenguang@kylinos.cn
Subject: [PATCH v2] RDMA/core: Fix memory leak in __ib_create_cq() on invalid cqe
Date: Thu, 25 Jun 2026 10:01:48 +0800
Message-Id: <20260625020148.224537-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624025949.306783-1-zhaochenguang@kylinos.cn>
References: <20260624025949.306783-1-zhaochenguang@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-22460-lists,linux-rdma=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:edwards@nvidia.com,m:mbloch@nvidia.com,m:michaelgur@nvidia.com,m:msanalla@nvidia.com,m:ohartoov@nvidia.com,m:jiri@resnulli.us,m:kalesh-anakkur.purayil@broadcom.com,m:linux-rdma@vger.kernel.org,m:zhaochenguang@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 622486C24B0

Move the zero CQE validation before rdma_zalloc_drv_obj() to avoid
leaking the CQ object when returning -EINVAL.

Fixes: a2917582887a ("RDMA/core: Reject zero CQE count")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - move validation before rdma_zalloc_drv_obj() as suggested by Kalesh.
---
 drivers/infiniband/core/verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3b613b57e269..86811d31092c 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2196,13 +2196,13 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	struct ib_cq *cq;
 	int ret;
 
+	if (WARN_ON_ONCE(!cq_attr->cqe))
+		return ERR_PTR(-EINVAL);
+
 	cq = rdma_zalloc_drv_obj(device, ib_cq);
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
 
-	if (WARN_ON_ONCE(!cq_attr->cqe))
-		return ERR_PTR(-EINVAL);
-
 	cq->device = device;
 	cq->comp_handler = comp_handler;
 	cq->event_handler = event_handler;
-- 
2.25.1


