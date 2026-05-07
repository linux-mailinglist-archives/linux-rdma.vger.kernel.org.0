Return-Path: <linux-rdma+bounces-20123-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N/DGL5f/Gm7OwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20123-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:47:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6C4E639F
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A4E3013A5A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725383C870E;
	Thu,  7 May 2026 09:43:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314D3C060C
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147001; cv=none; b=RIgtQ1zQrbaBhpLJgcw8OWEXb0P3fPJS+62UDXodTkOcJfDczrc8g0mDEjHe+RrKytL+5MPKf+6SM5QzL/XnPUqjH2detHSlmKxDrsLMkEDtNsxAYsaw7RbQ8gd/b1F1jxfVAtavl2fWMW5bAad2MCw5s0Dg6FE6JIohGiHgpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147001; c=relaxed/simple;
	bh=0CGHeTFivBUDTQideJOAoOd53r2jpfJjlS4iMThMBpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFTETDJgzeybiZyUKyxzTp8gUEhHKPA0PNK9rIWNQW9ZEV7pkByEwzL2we6GnxJlFCxMmryPUISFKuEZq71DVagUVvcZGxWIWNwEB28rMXZozzv8qk4rZQnQ82IsWn38EytsclB2TdbBGCboPs2umXmFuVdSmmiULTkKkT/TxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 26717e0449f911f1aa26b74ffac11d73-20260507
X-CTIC-Tags:
	HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME
	HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:90af1d40-ed3f-42b2-8322-000c9c39a203,IP:10,
	URL:0,TC:0,Content:5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:90af1d40-ed3f-42b2-8322-000c9c39a203,IP:10,UR
	L:0,TC:0,Content:5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:1c2a17565a4006eac8e719fac9c0cdae,BulkI
	D:260507174308GPHP427J,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|7|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 26717e0449f911f1aa26b74ffac11d73-20260507
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1947598157; Thu, 07 May 2026 17:43:06 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Sean Hefty <shefty@nvidia.com>,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Kees Cook <kees@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/cm: fix timewait leak and AV cleanup on ib_send_cm_req() errors
Date: Thu,  7 May 2026 17:43:17 +0800
Message-Id: <20260507094317.1018853-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5B6C4E639F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20123-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Action: no action

cm_create_timewait_info() success was followed by error returns that
never freed cm_id_priv->timewait_info, leaking it and tripping the
WARN_ON(timewait_info) on a later ib_send_cm_req().

After cm_move_av_from_path(), cm_alloc_priv_msg() and ib_post_send_mad()
failures must cm_destroy_av() the moved primary/alternate cm_id_priv
state before unlock; fold both cases into shared cleanup with kfree of
timewait_info.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/infiniband/core/cm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 6ab9a0aee1ec..7544206fa057 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1542,13 +1542,13 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	ret = cm_init_av_by_path(param->primary_path,
 				 param->ppath_sgid_attr, &av);
 	if (ret)
-		return ret;
+		goto err_free_tw;
 	if (param->alternate_path) {
 		ret = cm_init_av_by_path(param->alternate_path, NULL,
 					 &alt_av);
 		if (ret) {
 			cm_destroy_av(&av);
-			return ret;
+			goto err_free_tw;
 		}
 	}
 	cm_id->service_id = param->service_id;
@@ -1577,7 +1577,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	msg = cm_alloc_priv_msg(cm_id_priv, IB_CM_REQ_SENT);
 	if (IS_ERR(msg)) {
 		ret = PTR_ERR(msg);
-		goto out_unlock;
+		goto err_destroy_id_av;
 	}
 
 	req_msg = (struct cm_req_msg *)msg->mad;
@@ -1590,15 +1590,21 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	trace_icm_send_req(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
-		goto out_free;
+		goto err_free_msg;
 	BUG_ON(cm_id->state != IB_CM_IDLE);
 	cm_id->state = IB_CM_REQ_SENT;
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return 0;
-out_free:
+err_free_msg:
 	cm_free_priv_msg(msg);
-out_unlock:
+err_destroy_id_av:
+	if (param->alternate_path)
+		cm_destroy_av(&cm_id_priv->alt_av);
+	cm_destroy_av(&cm_id_priv->av);
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+err_free_tw:
+	kfree(cm_id_priv->timewait_info);
+	cm_id_priv->timewait_info = NULL;
 	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_req);
-- 
2.25.1


