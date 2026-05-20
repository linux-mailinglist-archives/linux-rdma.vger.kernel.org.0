Return-Path: <linux-rdma+bounces-21054-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJLcEXOiDWq10QUAu9opvQ
	(envelope-from <linux-rdma+bounces-21054-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 14:00:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2853858D27C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 14:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C299307D5C0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D87A3D9026;
	Wed, 20 May 2026 11:55:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CA3D4118
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278143; cv=none; b=NKmnmNAspYosNPO9IW5X/58mln7hvwRF9F+w+zCDb47UeHIt8cnmud6ZeYIP52JEO7VyzSFpgfwacJuEGhnGl/2dfkOARUQNLhILecjllx4VQyl00mGk0+G74bfNn8o8D8A3kgj9t6UngA23ciOFu5JTnPSAbP8n5LzUMo1An3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278143; c=relaxed/simple;
	bh=jnKwg0P2tk78bJgxcTtvuOTmMeeeEI2GiDsxX7QofG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUSgB9kOQyUSJrz5oP1hc4W96ne/9toN9Irdc4ndy6sal+B4nHda0VxI0H5bJAgVkQkn/qK00RlfPGWsOncfUG4X0v4EmIk36Pi1XFIA1+QOa68ZEDa/RtSZFXXqeKaPXToG4OmlYxASDfx7rd8SnCDjOy1nzK7lZ/78OTwA754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ce140c64544211f1aa26b74ffac11d73-20260520
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fab8831e-d4d2-4435-b587-0a621bfcfe94,IP:10,
	URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:fab8831e-d4d2-4435-b587-0a621bfcfe94,IP:10,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:6a9bec641c4b0ebbdb94016a5289e330,BulkI
	D:2605201955360SL4YNMW,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:11|95|82|1,File:nil,RT:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ce140c64544211f1aa26b74ffac11d73-20260520
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 970973790; Wed, 20 May 2026 19:55:32 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next v2] RDMA/cgroup: fix resource leak in DRIVER_FAILURE cleanup path
Date: Wed, 20 May 2026 19:55:06 +0800
Message-ID: <20260520115506.1782475-1-cuitao@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21054-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[kylinos.cn:query timed out];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,kylinos.cn:mid,kylinos.cn:email,cg_obj.cg:url]
X-Rspamd-Queue-Id: 2853858D27C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a driver fails to destroy an RDMA object during ufile cleanup,
the kernel retries and eventually falls back to the
RDMA_REMOVE_DRIVER_FAILURE path. This path sets obj->object = NULL
before calling uverbs_destroy_uobject(), which skips the destroy_hw
callback. Since ib_rdmacg_uncharge() lives inside destroy_hw_idr_uobject(),
the HCA_OBJECT cgroup charge is never released.

Add an explicit ib_rdmacg_uncharge() call in the DRIVER_FAILURE path
to prevent the resource counter leak.  Restrict this to IDR uobjects
(type_class == &uverbs_idr_class), since only IDR objects charge
RDMACG_RESOURCE_HCA_OBJECT in alloc_begin_idr_uobject().  FD objects
never charge this resource, so their cg_obj.cg remains NULL and must
not be passed to ib_rdmacg_uncharge(), which would otherwise dereference
a NULL pointer in rdmacg_uncharge_hierarchy().

Suggested-by: Sashiko AI
Link: https://sashiko.dev/#/patchset/20260518031541.1552942-1-cuitao%40kylinos.cn
Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
Changes in v2:
- Add type_class check to restrict ib_rdmacg_uncharge() to IDR uobjects
  only, as suggested by Sashiko AI.
---
 drivers/infiniband/core/rdma_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 5018ec837056..4fa14f27b76f 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -917,8 +917,12 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 		 * racing with a lookup_get.
 		 */
 		WARN_ON(uverbs_try_lock_object(obj, UVERBS_LOOKUP_WRITE));
-		if (reason == RDMA_REMOVE_DRIVER_FAILURE)
+		if (reason == RDMA_REMOVE_DRIVER_FAILURE) {
 			obj->object = NULL;
+			if (obj->uapi_object->type_class == &uverbs_idr_class)
+				ib_rdmacg_uncharge(&obj->cg_obj, ib_dev,
+						   RDMACG_RESOURCE_HCA_OBJECT);
+		}
 		if (!uverbs_destroy_uobject(obj, reason, &attrs))
 			ret = 0;
 		else
-- 
2.43.0


