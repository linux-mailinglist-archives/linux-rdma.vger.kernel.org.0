Return-Path: <linux-rdma+bounces-6432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B749EC8EB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D17F188CC76
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57197211A06;
	Wed, 11 Dec 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="odg8gKDC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE59233685;
	Wed, 11 Dec 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908900; cv=none; b=BDwe7yD0trQ6BgO7+pE6cbY1X80kkdmnYl8DEtNqVOxmWziWVPj/wkdtVd/N+pZ7YkgQOK2QifsyG9aeHyCOgtsnzLu5xNpMe9t/79EIaq/v9mTNPj9iYa4np7T4mTCDdtQYJSRt7ONc/FRV4CW/ucMiRO+juDR1SHERVVh7AAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908900; c=relaxed/simple;
	bh=GSlSWzgoX7ItH/Oew8p8SjY1gbNwFnUvhXD+SKu3i3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=St0nBnzYDiyYHecacy2CnhK/SzhKczTmhNEBzAzUbEv9LpK+tTyAzBhTsClco6UvEheoGayI51Rf6PkutOBhlwsdFhhzHX3dBCN46LBoTQKH+WnQ58bs+SfET+BX4DTdqVsVDGUEyaY9A6VmqRUzerVGVwL5cYnqTmOPk/P09bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=odg8gKDC; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733908894; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=P65UEp/MrPRNafOPV595tAG7Iii6NIDpHn3smyQHKnI=;
	b=odg8gKDCEalgNqrpIvukfwEUGPIKi60mrttmefLvZDEWKxQd/kVm+EpgQuP6bNRRw1DUBWWgqsM/6+xcQ9GlxM7dpoF2Kv+cIBWm7NPq9HU6rhnsYZt9k8yE+kGO0YmNHds3KTZuVyIxN8VmpNSRWkOuc1pFOiFfVMtiVbxkorw=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLHtOoL_1733908893 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 17:21:33 +0800
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
Subject: [PATCH net v2 4/6] net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving proposal msg
Date: Wed, 11 Dec 2024 17:21:19 +0800
Message-Id: <20241211092121.19412-5-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
References: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving proposal msg in server, the fields v2_ext_offset/
eid_cnt/ism_gid_cnt in proposal msg are from the remote client
and can not be fully trusted. Especially the field v2_ext_offset,
once exceed the max value, there has the chance to access wrong
address, and crash may happen.

This patch checks the fields v2_ext_offset/eid_cnt/ism_gid_cnt
before using them.

Fixes: 8c3dca341aea ("net/smc: build and send V2 CLC proposal")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c  | 3 ++-
 net/smc/smc_clc.c | 8 +++++++-
 net/smc/smc_clc.h | 8 +++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index a2d7dcaccbfc..a795acaa0780 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2276,7 +2276,8 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 		goto not_found;
 
 	smc_v2_ext = smc_get_clc_v2_ext(pclc);
-	if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext, NULL, NULL))
+	if (!smc_v2_ext ||
+	    !smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext, NULL, NULL))
 		goto not_found;
 
 	/* prepare RDMA check */
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 66a43b97eede..f721d03efcbd 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -352,7 +352,6 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 	struct smc_clc_msg_hdr *hdr = &pclc->hdr;
 	struct smc_clc_v2_extension *v2_ext;
 
-	v2_ext = smc_get_clc_v2_ext(pclc);
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
 	if (!pclc_prfx ||
 	    pclc_prfx->ipv6_prefixes_cnt > SMC_CLC_MAX_V6_PREFIX)
@@ -369,6 +368,13 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 			sizeof(struct smc_clc_msg_trail))
 			return false;
 	} else {
+		v2_ext = smc_get_clc_v2_ext(pclc);
+		if ((hdr->typev2 != SMC_TYPE_N &&
+		     (!v2_ext || v2_ext->hdr.eid_cnt > SMC_CLC_MAX_UEID)) ||
+		    (smcd_indicated(hdr->typev2) &&
+		     v2_ext->hdr.ism_gid_cnt > SMCD_CLC_MAX_V2_GID_ENTRIES))
+			return false;
+
 		if (ntohs(hdr->length) !=
 			sizeof(*pclc) +
 			sizeof(struct smc_clc_msg_smcd) +
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index ac8de6a177fa..23afa4df862e 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -380,8 +380,14 @@ static inline struct smc_clc_v2_extension *
 smc_get_clc_v2_ext(struct smc_clc_msg_proposal *prop)
 {
 	struct smc_clc_msg_smcd *prop_smcd = smc_get_clc_msg_smcd(prop);
+	u16 max_offset;
 
-	if (!prop_smcd || !ntohs(prop_smcd->v2_ext_offset))
+	max_offset = offsetof(struct smc_clc_msg_proposal_area, pclc_v2_ext) -
+		     offsetof(struct smc_clc_msg_proposal_area, pclc_smcd) -
+		     offsetofend(struct smc_clc_msg_smcd, v2_ext_offset);
+
+	if (!prop_smcd || !ntohs(prop_smcd->v2_ext_offset) ||
+	    ntohs(prop_smcd->v2_ext_offset) > max_offset)
 		return NULL;
 
 	return (struct smc_clc_v2_extension *)
-- 
2.24.3 (Apple Git-128)


