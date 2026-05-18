Return-Path: <linux-rdma+bounces-20874-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ISiCneECmqv2AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20874-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 05:16:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5655655C1
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 05:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 800C13014510
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CF3803CB;
	Mon, 18 May 2026 03:16:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7E37F8AD;
	Mon, 18 May 2026 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074160; cv=none; b=UQG3pTIbATCj2Elh26NmO5XVVb+YcwFz+fXcQ71c0wqZBLkjKaKJcMFWgVx4TC9vzkEHBchzHiJwFmP2+uX3utVD3Vvb9HtvLqk0kz2rPObN4sMcj28EclQdaEZsWdV7O2R+0qI1fG0fa6fd2Ehmux3+Vuw5hA+QJHhgtS2/4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074160; c=relaxed/simple;
	bh=QmgrWZh15YehuZ3Ti9S/QB9R23OWKZ9dV1E4OefO/38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Knqtk8EmKPXwskWmmZaOUU7jEYkp9elrwKFFLOWrkkNCnlSOr4R7jzjo9RFUuzu7Dm3xo6e8nTNskjzHDt4DwBnrrRnp8Q06Ssfn1HnA9dDGAwQjPmJXAb8X1rnz7KzYtXN3gDlrCAASDpduvq7iuyGhGo6Cgo/FwbBAiVyLfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e129cd5c526711f1aa26b74ffac11d73-20260518
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
X-CID-O-INFO: VERSION:1.3.12,REQID:10c80fd6-18c1-4767-877b-fa163ae5fe24,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:10c80fd6-18c1-4767-877b-fa163ae5fe24,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:6aaa27c9bf92dbb74b5106f35906ab54,BulkI
	D:260518111554TK7EPN9U,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e129cd5c526711f1aa26b74ffac11d73-20260518
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 576830931; Mon, 18 May 2026 11:15:53 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next] RDMA/cgroup: fix resource leak in DRIVER_FAILURE cleanup path
Date: Mon, 18 May 2026 11:15:41 +0800
Message-ID: <20260518031541.1552942-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D5655655C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-20874-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

When a driver fails to destroy an RDMA object during ufile cleanup,
the kernel retries and eventually falls back to the
RDMA_REMOVE_DRIVER_FAILURE path. This path sets obj->object = NULL
before calling uverbs_destroy_uobject(), which skips the destroy_hw
callback. Since ib_rdmacg_uncharge() lives inside destroy_hw_idr_uobject(),
the HCA_OBJECT cgroup charge is never released.

Add an explicit ib_rdmacg_uncharge() call in the DRIVER_FAILURE path
to prevent the resource counter leak.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/rdma_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 5018ec837056..347ec8f6976b 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -917,8 +917,11 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 		 * racing with a lookup_get.
 		 */
 		WARN_ON(uverbs_try_lock_object(obj, UVERBS_LOOKUP_WRITE));
-		if (reason == RDMA_REMOVE_DRIVER_FAILURE)
+		if (reason == RDMA_REMOVE_DRIVER_FAILURE) {
 			obj->object = NULL;
+			ib_rdmacg_uncharge(&obj->cg_obj, ib_dev,
+					   RDMACG_RESOURCE_HCA_OBJECT);
+		}
 		if (!uverbs_destroy_uobject(obj, reason, &attrs))
 			ret = 0;
 		else
-- 
2.43.0


