Return-Path: <linux-rdma+bounces-10976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E900FACDBDF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 12:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C684718965E8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FF28D8CA;
	Wed,  4 Jun 2025 10:21:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4728D85B
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032476; cv=none; b=mtO5aeJGTS6n3en8ZV7LZLB6qS+BjnV7Kr8MX0l6Y+jHaKv36dBNYIkwrFvrvqASCgpU5yejgcCx3DW/pQytTVhJKsbHYnPwIsDZNHlO8wTPvg5Ro2VWTdwUjS81dCjn9NpSZ+1q3ReC/LV9cHTUlKGd4ZmlhpzUXITRSZfEj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032476; c=relaxed/simple;
	bh=MJ3nMEFC7VaphdUIkZZBG0ClyxmaKGqfIwnb9cDpfb0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=W1O65tRnmkdZ+9/3FV7PJ6lxWbL/MaoVcCz1oT0QBmgXRiOh63oVg5mTeHvcsPPUc3RZag1w0siUm28ou9z+F9t8TgyaFSXKk1MYmdoRv6jNwn1xJ4SK/fFW4TfNVzH87yvvrbz6aTqlaWypgnQ4ZrMCpgf96oeqT5Qc+5ScX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9f17c2bc412d11f0b29709d653e92f7d-20250604
X-CTIC-Tags:
	HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:dce758fe-9eb9-4ca7-9482-11e48cb4db69,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:dce758fe-9eb9-4ca7-9482-11e48cb4db69,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:339804218c555a25b1603fd6962cedf5,BulkI
	D:250604182107PKMQ5HDJ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102,TC:n
	il,Content:0|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 9f17c2bc412d11f0b29709d653e92f7d-20250604
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2096030424; Wed, 04 Jun 2025 18:21:04 +0800
From: Li Jun <lijun01@kylinos.cn>
To: sagi@grimberg.me,
	mgurtovoy@nvidia.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	lijun01@kylinos.cn
Subject: [PATCH v2] IB/iser: remove unnecessary local variable
Date: Wed,  4 Jun 2025 18:20:49 +0800
Message-Id: <20250604102049.130039-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'error' variable is no longer needed,as iscsi_iser_mtask_xmit can
return the result of iser_send_control(conn,task) directly.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index a5be6f1ba12b..2e3c0516ce8f 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -267,19 +267,15 @@ static int iscsi_iser_task_init(struct iscsi_task *task)
 static int iscsi_iser_mtask_xmit(struct iscsi_conn *conn,
 				 struct iscsi_task *task)
 {
-	int error = 0;
-
 	iser_dbg("mtask xmit [cid %d itt 0x%x]\n", conn->id, task->itt);
 
-	error = iser_send_control(conn, task);
-
 	/* since iser xmits control with zero copy, tasks can not be recycled
 	 * right after sending them.
 	 * The recycling scheme is based on whether a response is expected
 	 * - if yes, the task is recycled at iscsi_complete_pdu
 	 * - if no,  the task is recycled at iser_snd_completion
 	 */
-	return error;
+	return iser_send_control(conn, task);
 }
 
 static int iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
-- 
2.25.1


