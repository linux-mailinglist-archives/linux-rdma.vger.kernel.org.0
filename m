Return-Path: <linux-rdma+bounces-13613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E72B985D0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 08:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5874A3351
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 06:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE9243370;
	Wed, 24 Sep 2025 06:15:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D720E704;
	Wed, 24 Sep 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694502; cv=none; b=hZmJqYVdzau0MWLUqWRnypqSii5L4Uyw7GPhjJlAzkI157/MwsxQVDrJhe7LK8XrwuOYomp9amV9KZZQIeQWK02+5fKcSvpQpY4Xl7kyisYibE8xuYcRMEBuWsPMwOo4FFk+g6Y/P/CYbU4AlVyGTEX2Sz4ask+Ye2zNa4SLlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694502; c=relaxed/simple;
	bh=JuZ91boBzNCp97Tdk4wyewrzGNj8ME1r0pRPOdXkgKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwLNOR00N187Vdq+1kosQiS5OU70slM545fwI75W1uX5XxLbDXk16mkVrPu2hXMDOVfGh0FH+h0IGF5PQCkxR7LVHz1PzLhOdiG6MCiRyYv2pTDgt7Rc2/Z1nrp07lfvueUEOz04mrZ7EMluF7A4m8HN/MASuJ9dKF2RWpKQdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c785fac4990d11f08b9f7d2eb6caa7cf-20250924
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:56f4f4f4-0150-4660-82c5-4257c2b6f80f,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:56f4f4f4-0150-4660-82c5-4257c2b6f80f,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:2e0c404bbe66cfb0706841bf459dd974,BulkI
	D:250924141003YSO35H6A,BulkQuantity:1,Recheck:0,SF:19|24|44|66|72|78|102|8
	50,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: c785fac4990d11f08b9f7d2eb6caa7cf-20250924
X-User: daiyanlong@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <daiyanlong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1310381125; Wed, 24 Sep 2025 14:14:50 +0800
From: YanLong Dai <daiyanlong@kylinos.cn>
To: kalesh-anakkur.purayil@broadcom.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com,
	daiyanlong@kylinos.cn,
	dyl_wlc@163.com
Subject: [PATCH v2 rdma-rc] RDMA/bnxt_re: Fix a potential memory leak in destroy_gsi_sqp
Date: Wed, 24 Sep 2025 14:14:44 +0800
Message-ID: <20250924061444.11288-1-daiyanlong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current error handling path in bnxt_re_destroy_gsi_sqp() could lead
to a resource leak. When bnxt_qplib_destroy_qp() fails, the function
jumps to the 'fail' label and returns immediately, skipping the call
to bnxt_qplib_free_qp_res().

Continue the resource teardown even if bnxt_qplib_destroy_qp() fails,
which aligns with the driver's general error handling strategy and
prevents the potential leak.

Fixes: 8dae419f9ec73 ("RDMA/bnxt_re: Refactor queue pair creation code")

Signed-off-by: YanLong Dai <daiyanlong@kylinos.cn>

---
 v2:
 - Updated subject prefix to 'rdma-rc'
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 260dc67b8b87..15d3f5d5c0ee 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -931,10 +931,9 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 
 	ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
-	if (rc) {
+	if (rc)
 		ibdev_err(&rdev->ibdev, "Destroy Shadow QP failed");
-		goto fail;
-	}
+
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
 
 	/* remove from active qp list */
@@ -951,8 +950,6 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	rdev->gsi_ctx.sqp_tbl = NULL;
 
 	return 0;
-fail:
-	return rc;
 }
 
 /* Queue Pairs */
-- 
2.43.0


