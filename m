Return-Path: <linux-rdma+bounces-6149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A09DB75C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 13:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806D0B231D4
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC201ADFED;
	Thu, 28 Nov 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rIvcyaPA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C251A286D;
	Thu, 28 Nov 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796101; cv=none; b=FRXYEPfxm+Jlush1/WJfE6k10VZyG+fW5Wl6jQPdEuHEdb5WfU8WfbKQ+PFAj0gUgUlqGoEd2q5Fux6GS+hma6lCRUYgYWB+LiZu/9e45oIX71ubgCUDTmlS2f0Z73EYfcsq+GEDgFI6l7uQ4Iz/hWU6vQuETMpN+Ke4Of5pFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796101; c=relaxed/simple;
	bh=NbjMqZDxwd5fwMDUQRMntD21nvqixRwspGsXvNUU4VY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMbahG/CdMAsnlZrhfk4Bevzv8BR4f3jAjM7egopU5+kaeCnrfxoeaI43IjHIw+Ywfs1ALadp3k3cDja4/4RAZhN3J8XwvBJQm0duUQwnmPHPD2E9Jy6G58JMQj98C+4k1aV/og1INmLN60Sx7SHJlQmT4z0xpjPVb6SDi5hPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rIvcyaPA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732796088; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a+2iRNxo+4wn8SyiCErQfyXgZ5G41KWwwTXasWh3J0E=;
	b=rIvcyaPAZUd5okZssQrjjKyWY4RYi2VoQAB/EAHPrdZJ7mCzsYTuFHhRYxlji0xHfmZ6XRnaAAe1xsYHP+xcRBnUbwIwDnZw8czOwRL2yfEIL4uMkzyvfYwpkDMhjY+7rVUJFi4DnQsDwwzI+tH6Bdm8MlnciIMSnYtXC9LTfcg=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKQ-9Tl_1732796087 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 20:14:48 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/6] net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg
Date: Thu, 28 Nov 2024 20:14:32 +0800
Message-Id: <20241128121435.73071-4-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving proposal msg in server, the field iparea_offset
and the field ipv6_prefixes_cnt in proposal msg are from the
remote client and can not be fully trusted. Especially the
field iparea_offset, once exceed the max value, there has the
chance to access wrong address, and crash may happen.

This patch checks iparea_offset and ipv6_prefixes_cnt before using them.

Fixes: e7b7a64a8493 ("smc: support variable CLC proposal messages")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c  | 6 +++++-
 net/smc/smc_clc.c | 4 ++++
 net/smc/smc_clc.h | 6 +++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..8a2f196ab995 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2032,6 +2032,8 @@ static int smc_listen_prfx_check(struct smc_sock *new_smc,
 	if (pclc->hdr.typev1 == SMC_TYPE_N)
 		return 0;
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
+	if (!pclc_prfx)
+		return -EPROTO;
 	if (smc_clc_prfx_match(newclcsock, pclc_prfx))
 		return SMC_CLC_DECL_DIFFPREFIX;
 
@@ -2221,7 +2223,9 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 	int rc = 0;
 
 	/* check if ISM V1 is available */
-	if (!(ini->smcd_version & SMC_V1) || !smcd_indicated(ini->smc_type_v1))
+	if (!(ini->smcd_version & SMC_V1) ||
+	    !smcd_indicated(ini->smc_type_v1) ||
+	    !pclc_smcd)
 		goto not_found;
 	ini->is_smcd = true; /* prepare ISM check */
 	ini->ism_peer_gid[0].gid = ntohll(pclc_smcd->ism.gid);
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 33fa787c28eb..66a43b97eede 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -354,6 +354,10 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 
 	v2_ext = smc_get_clc_v2_ext(pclc);
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
+	if (!pclc_prfx ||
+	    pclc_prfx->ipv6_prefixes_cnt > SMC_CLC_MAX_V6_PREFIX)
+		return false;
+
 	if (hdr->version == SMC_V1) {
 		if (hdr->typev1 == SMC_TYPE_N)
 			return false;
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 5fd6f5b8ef03..ac8de6a177fa 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -336,8 +336,12 @@ struct smc_clc_msg_decline_v2 {	/* clc decline message */
 static inline struct smc_clc_msg_proposal_prefix *
 smc_clc_proposal_get_prefix(struct smc_clc_msg_proposal *pclc)
 {
+	u16 offset = ntohs(pclc->iparea_offset);
+
+	if (offset > sizeof(struct smc_clc_msg_smcd))
+		return NULL;
 	return (struct smc_clc_msg_proposal_prefix *)
-	       ((u8 *)pclc + sizeof(*pclc) + ntohs(pclc->iparea_offset));
+	       ((u8 *)pclc + sizeof(*pclc) + offset);
 }
 
 static inline bool smcr_indicated(int smc_type)
-- 
2.24.3 (Apple Git-128)


