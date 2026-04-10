Return-Path: <linux-rdma+bounces-19205-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKbZJa6p2GkhgggAu9opvQ
	(envelope-from <linux-rdma+bounces-19205-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 09:41:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 700CA3D3788
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 215883026114
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 07:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED53A4539;
	Fri, 10 Apr 2026 07:41:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D110322A
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806873; cv=none; b=rVHIf18a3PUoAqltMlofGYlKR8z1sI86aBt27sRFyjVpaZj0YpBMf2SiRdnLaFfpaTF98Z7AuhXl8YL5kessZj2YhRsAhLAIcBQBXBSYDn2jBTNzm2dMrHbN4MATZW1bacwolfM+EAWRJhoSxjY28FVt5nysnSn4yLvLhc74oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806873; c=relaxed/simple;
	bh=BzBsW2EoOiVXBwmRUYlTxU0hLaG00q8tOB6dZVDEswE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIusp2qKWj4wOBLB0+7nDwNKSq442xAdpnGYvVgkk2PnIUFOCCFx2YEr/Up9ihyyQAmDM9UI/fZQwgxYHY75tQJklYlOysXgH27aqOKo7tYqEprJqQOre7uVJN+CM5XbjnwEE1fF+zR0/l7jVNe21OnJIlJI6uL/oPPoI5+zd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a0a41f1e34b011f1aa26b74ffac11d73-20260410
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:75b51315-f806-465b-8e59-66e4dc58439a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.12,REQID:75b51315-f806-465b-8e59-66e4dc58439a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:3078db7089af39720d187dcbd27445c8,BulkI
	D:260410154105WSQHVMYT,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a0a41f1e34b011f1aa26b74ffac11d73-20260410
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 949656608; Fri, 10 Apr 2026 15:41:03 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: use QP port when decoding responder CQEs
Date: Fri, 10 Apr 2026 15:40:46 +0800
Message-Id: <20260410074046.2044595-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19205-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Queue-Id: 700CA3D3788
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The responder CQE path determines the link layer via
rdma_port_get_link_layer(). Use qp->port instead of
hardcoding port 1, which can mis-decode completions on
multi-port devices.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/infiniband/hw/mlx5/cq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index d0cd3f805bcb..2481b3361c1d 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -169,7 +169,8 @@ enum {
 static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
 			     struct mlx5_ib_qp *qp)
 {
-	enum rdma_link_layer ll = rdma_port_get_link_layer(qp->ibqp.device, 1);
+	enum rdma_link_layer ll =
+		rdma_port_get_link_layer(qp->ibqp.device, qp->port);
 	struct mlx5_ib_dev *dev = to_mdev(qp->ibqp.device);
 	struct mlx5_ib_srq *srq = NULL;
 	struct mlx5_ib_wq *wq;
-- 
2.25.1


