Return-Path: <linux-rdma+bounces-10974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163EACDAA4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB916FBF0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81428C2D5;
	Wed,  4 Jun 2025 09:12:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F01804A
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028377; cv=none; b=Q5HIO1xoYRhgVMArOp+E7DNhEQ9FXvQkdIG3o5D4MGk67KN9szvgGp9YsLbQuqcsexqgVUJE6pGeSvhDpdLOpyw+89beAHKwLKIsz5RGisBjLX5QrlvVAhDF3gSXWvN9jebJ2mrNGTuPVYdKllz8q1WlTY792ZtPg738j8i58VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028377; c=relaxed/simple;
	bh=KIdkHsub5MHYziwaPRWIqjBWxCBob4c1go9Pz5tsilw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=s3mRaqDDXosdJcLd74MurxPY84QVZaXJLX8lF3hov1N4ehdVWJ9+nPXVU9rdSkKWZSgmc3Pbx+nDb7ZA/TLaiBUDsTLuoK+ky2ymM5mxUb2R1x1q48er2FRp1YhCVCKK7WB8C8Z9di/gHyUEEFbLXnFqAmCDCS77cRazsl0sFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 155d40fa412411f0b29709d653e92f7d-20250604
X-CTIC-Tags:
	HR_CTE_7B, HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:38b47364-7ddc-45aa-b7ef-5f2a629e2151,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:38b47364-7ddc-45aa-b7ef-5f2a629e2151,IP:0,URL
	:0,TC:0,Content:0,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACTIO
	N:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:edf217485a025a20e8038ac1d044b50f,BulkI
	D:250604165615K9SNL2AM,BulkQuantity:5,Recheck:0,SF:17|19|38|66|78|102,TC:n
	il,Content:0|50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 155d40fa412411f0b29709d653e92f7d-20250604
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1222053920; Wed, 04 Jun 2025 17:12:48 +0800
Message-ID: <7ddad30c33cace54cf409f0d27bcb38881b796c9.camel@kylinos.cn>
Subject: [PATCH] infiniband: iser: remove the unnecessary var
From: lijun <lijun01@kylinos.cn>
To: sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org, lijun01@kylinos.cn
Date: Wed, 04 Jun 2025 17:12:38 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From c1129a053b33e6f85be3d7a26bf0dbb9bac64949 Mon Sep 17 00:00:00 2001
From: Li Jun <lijun01@kylinos.cn>
Date: Wed, 4 Jun 2025 16:45:10 +0800
Subject: [PATCH] infiniband: iser: remove the unnecessary var

In iscsi_iser_mtask_xmit, may return iser_send_control(conn, task)
directly,so del 'error'.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-
)                                                                      
                                                  

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c
b/drivers/infiniband/ulp/iser/iscsi_iser.c
index a5be6f1ba12b..2e3c0516ce8f 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -267,19 +267,15 @@ static int iscsi_iser_task_init(struct iscsi_task
*task)
 static int iscsi_iser_mtask_xmit(struct iscsi_conn *conn,
                 struct iscsi_task *task)
 {
-   int error = 0;
-
    iser_dbg("mtask xmit [cid %d itt 0x%x]\n", conn->id, task->itt);

-   error = iser_send_control(conn, task);
-
    /* since iser xmits control with zero copy, tasks can not be
recycled
     * right after sending them.
     * The recycling scheme is based on whether a response is expected
     * - if yes, the task is recycled at iscsi_complete_pdu
     * - if no,  the task is recycled at iser_snd_completion
     */
-   return error;
+   return iser_send_control(conn, task);
 }

 static int iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
-- 
2.25.1


