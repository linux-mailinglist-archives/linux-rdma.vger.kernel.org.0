Return-Path: <linux-rdma+bounces-18779-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DQZBVIMymmL4gUAu9opvQ
	(envelope-from <linux-rdma+bounces-18779-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 07:38:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3F355A02
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 07:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8222430624BA
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 05:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA4382361;
	Mon, 30 Mar 2026 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AoSHbyES"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E35381AE5;
	Mon, 30 Mar 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848750; cv=none; b=nSFivdUeK5z34Xu0AmYXZt6AocIqdwCyjvs4/yK892OEophZ/Az6ZDh0y5n3kHBMWRjUB9vXK99lTnAj2CzFlADwHUrqq2UDn6Ko/bvCa8oas58cj5jV1LCry6o4KqTjLeROPK/ynCTIRrGwM/6/rz6j5MBk5x34IeZiuAkeid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848750; c=relaxed/simple;
	bh=23GPt3rsLvgGZ1TK1h3/5uiA/gRvNChzvg7GYy00Tu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0eAvHd7rOV7V4BiQNR8R0K8QC6ArbB/v5QWIqjEUONc2KYNB0kJkCx9q9X+AC6ikiul7PUUmb/VuCOw2pDVLA89Kc/OGJtYWIAqr2sIoBb8ASPDGQKlVmSI7hHKVvxQKaZu2c6ZzgG29p8Ylq6tizQkhuMu2cgyL/y1jRhGB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AoSHbyES; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TNlunH285178;
	Sun, 29 Mar 2026 22:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	U7BkKVn5NBU8Yza9LLBmGfMoGWn2yewhah+XYzIVtw=; b=AoSHbyESuqvqPnRsI
	frHPjkFLPK7uXIaBKmeyETWfxtbEOls779eUVkYTBD06H7WIa7rNuuwDI5bB2BPK
	n7xQauFvyJISdleM1VZdWcOjGwEjxQvgPyqBAOwUbkiqMuoBq4ZZJsTShrG94Snq
	ttuJUqoV3qW9tRDOuVAyQYNzwrp/sSXK/hEZLyYURqtgsV1JNCcuM2IjShPhWDQz
	YPTLTim2Cx3MjLEGAB7hVgMa7gjTR+nt8X+8w2IyS7BtCirruX3HL1QrYSpOgg2C
	gNkGQxANS9wZNzKFW/5eEqDzRTHGSS8KB/m9GdbgciL+ASOv+1kRGtJ8/3BZKBdy
	fMtLA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d6cbjtxme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 22:32:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 22:32:08 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 22:32:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 29 Mar 2026 22:32:07 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 063343F706F;
	Sun, 29 Mar 2026 22:32:00 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
CC: <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <donald.hunter@gmail.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
        <mbloch@nvidia.com>, <dtatulea@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v9 net-next 4/6] octeontx2-af: npc: cn20k: add subbank search order control
Date: Mon, 30 Mar 2026 11:01:03 +0530
Message-ID: <20260330053105.2722453-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330053105.2722453-1-rkannoth@marvell.com>
References: <20260330053105.2722453-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA0MCBTYWx0ZWRfX7DV1J4B9yMtT
 nymPv+Hl+3hDsdpSYjp0HyvVYuHzYMeX5GZvqTqYMPxmeg7T8JAHbPjFaonXd3gJdrtDh7H4JSG
 VY5D0LKnJy7usHv4QroafXcFh1G37HsRpj7ThJZTzQB2XKHdU/OtepBIZ0qmnNwQR+qojtu0afv
 rtQGI+OFjuPqh7RGH0SnAq530CwbnAwqBXOGlebbl90TqwGaGwcDcPWKJ83pqrp51exo66BvsGg
 jzwl9D07kCrlfgJdSD4vvYiRa+iHUd2ryx2v6ZMy4+hI4yJMFosnjWluCd3UfYXAaFLp4+usS+A
 Q41fbk8RysMy1DCD3Xzm14m/d6jCtRfw0dFJoBWnWFDS89dIOdJ/EnBFKOJ8fgULvOxtvqZTlGc
 0yo9/nyxM/vJaPXP4jw/If6ke1BHWQZ1ynpG52LQa/STMwbfyXZrJTopltFIi1sx0o4ZzI0dYAa
 g/BoU9IvW/FeykGCPrw==
X-Proofpoint-GUID: 1YEgmMNVYqCEfj1CXpJLhFDP-NHThz3Z
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=69ca0ad8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=-COZLs7YStbzE7aUQ_YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 1YEgmMNVYqCEfj1CXpJLhFDP-NHThz3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-18779-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 73F3F355A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CN20K NPC MCAM is split into 32 subbanks that are searched in a
predefined order during allocation. Lower-numbered subbanks have
higher priority than higher-numbered ones.

Add a runtime devlink parameter "srch_order" (
DEVLINK_PARAM_TYPE_U32_ARRAY) to control the order in which
subbanks are searched during MCAM allocation.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 91 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  2 +
 .../marvell/octeontx2/af/rvu_devlink.c        | 92 +++++++++++++++++--
 3 files changed, 173 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index e854b85ced9e..153765b3e504 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3317,7 +3317,7 @@ rvu_mbox_handler_npc_cn20k_get_kex_cfg(struct rvu *rvu,
 	return 0;
 }
 
-static int *subbank_srch_order;
+static u32 *subbank_srch_order;
 
 static void npc_populate_restricted_idxs(int num_subbanks)
 {
@@ -3329,7 +3329,7 @@ static int npc_create_srch_order(int cnt)
 {
 	int val = 0;
 
-	subbank_srch_order = kcalloc(cnt, sizeof(int),
+	subbank_srch_order = kcalloc(cnt, sizeof(u32),
 				     GFP_KERNEL);
 	if (!subbank_srch_order)
 		return -ENOMEM;
@@ -3809,6 +3809,93 @@ static void npc_unlock_all_subbank(void)
 		mutex_unlock(&npc_priv.sb[i].lock);
 }
 
+int npc_cn20k_search_order_set(struct rvu *rvu,
+			       u64 arr[MAX_NUM_SUB_BANKS], int cnt)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u32 fslots[MAX_NUM_SUB_BANKS][2];
+	u32 uslots[MAX_NUM_SUB_BANKS][2];
+	int fcnt = 0, ucnt = 0;
+	struct npc_subbank *sb;
+	int idx, val, rc = 0;
+
+	unsigned long index;
+	void *v;
+
+	if (cnt != npc_priv.num_subbanks) {
+		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
+			cnt, npc_priv.num_subbanks);
+		return -EINVAL;
+	}
+
+	mutex_lock(&mcam->lock);
+	npc_lock_all_subbank();
+	restrict_valid = false;
+
+	for (int i = 0; i < cnt; i++)
+		subbank_srch_order[i] = (u32)arr[i];
+
+	xa_for_each(&npc_priv.xa_sb_used, index, v) {
+		val = xa_to_value(v);
+		uslots[ucnt][0] = index;
+		uslots[ucnt][1] = val;
+		xa_erase(&npc_priv.xa_sb_used, index);
+		ucnt++;
+	}
+
+	xa_for_each(&npc_priv.xa_sb_free, index, v) {
+		val = xa_to_value(v);
+		fslots[fcnt][0] = index;
+		fslots[fcnt][1] = val;
+		xa_erase(&npc_priv.xa_sb_free, index);
+		fcnt++;
+	}
+
+	/* xa_store() is done under lock. If xa_store fails
+	 * ,no rollback is planned as it might also fail.
+	 */
+	for (int i = 0; i < ucnt; i++) {
+		idx  = uslots[i][1];
+		sb = &npc_priv.sb[idx];
+		sb->arr_idx = subbank_srch_order[sb->idx];
+		rc = xa_err(xa_store(&npc_priv.xa_sb_used, sb->arr_idx,
+				     xa_mk_value(sb->idx), GFP_KERNEL));
+		if (rc) {
+			dev_err(rvu->dev,
+				"Error to insert index to used list %u\n",
+				sb->idx);
+			goto fail_used;
+		}
+	}
+
+	for (int i = 0; i < fcnt; i++) {
+		idx  = fslots[i][1];
+		sb = &npc_priv.sb[idx];
+		sb->arr_idx = subbank_srch_order[sb->idx];
+		rc = xa_err(xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
+				     xa_mk_value(sb->idx), GFP_KERNEL));
+		if (rc) {
+			dev_err(rvu->dev,
+				"Error to insert index to free list %u\n",
+				sb->idx);
+			goto fail_used;
+		}
+	}
+
+fail_used:
+	npc_unlock_all_subbank();
+	mutex_unlock(&mcam->lock);
+
+	return rc;
+}
+
+const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz)
+{
+	*restricted_order = restrict_valid;
+	*sz = npc_priv.num_subbanks;
+	return subbank_srch_order;
+}
+
 /* Only non-ref non-contigous mcam indexes
  * are picked for defrag process
  */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 004a556c7b90..6f9f796940f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -343,5 +343,7 @@ int npc_cn20k_defrag(struct rvu *rvu);
 int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
 			       struct npc_subbank **sb,
 			       int *sb_off);
+const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz);
+int npc_cn20k_search_order_set(struct rvu *rvu, u64 arr[32], int cnt);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 6494a9ee2f0d..0e8e33c836c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1258,6 +1258,7 @@ enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
+	RVU_AF_DEVLINK_PARAM_ID_NPC_SRCH_ORDER,
 	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
@@ -1619,12 +1620,83 @@ static int rvu_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	return 0;
 }
 
+static int rvu_af_dl_npc_srch_order_set(struct devlink *devlink, u32 id,
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+
+	return npc_cn20k_search_order_set(rvu,
+					  ctx->val.u64arr.val,
+					  ctx->val.u64arr.size);
+}
+
+static int rvu_af_dl_npc_srch_order_get(struct devlink *devlink, u32 id,
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
+{
+	bool restricted_order;
+	const u32 *order;
+	u32 sz;
+
+	order = npc_cn20k_search_order_get(&restricted_order, &sz);
+	ctx->val.u64arr.size = sz;
+	for (int i = 0; i < sz; i++)
+		ctx->val.u64arr.val[i] = order[i];
+
+	return 0;
+}
+
+static int rvu_af_dl_npc_srch_order_validate(struct devlink *devlink, u32 id,
+					     union devlink_param_value val,
+					     struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	bool restricted_order;
+	unsigned long w = 0;
+	u64 *arr;
+	u32 sz;
+
+	npc_cn20k_search_order_get(&restricted_order, &sz);
+	if (sz != val.u64arr.size) {
+		dev_err(rvu->dev,
+			"Wrong size %llu, should be %u\n",
+			val.u64arr.size, sz);
+		return -EINVAL;
+	}
+
+	arr = val.u64arr.val;
+	for (int i = 0; i < sz; i++) {
+		if (arr[i] >= sz)
+			return -EINVAL;
+
+		w |= BIT_ULL(arr[i]);
+	}
+
+	if (bitmap_weight(&w, sz) != sz) {
+		dev_err(rvu->dev,
+			"Duplicate or out-of-range subbank index. %lu\n",
+			find_first_zero_bit(&w, sz));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct devlink_ops rvu_devlink_ops = {
 	.eswitch_mode_get = rvu_devlink_eswitch_mode_get,
 	.eswitch_mode_set = rvu_devlink_eswitch_mode_set,
 };
 
-static const struct devlink_param rvu_af_dl_param_defrag[] = {
+static const struct devlink_param rvu_af_dl_cn20k_params[] = {
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_SRCH_ORDER,
+			     "npc_srch_order", DEVLINK_PARAM_TYPE_U64_ARRAY,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_dl_npc_srch_order_get,
+			     rvu_af_dl_npc_srch_order_set,
+			     rvu_af_dl_npc_srch_order_validate),
 	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
 			     "npc_defrag", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
@@ -1666,13 +1738,13 @@ int rvu_register_dl(struct rvu *rvu)
 	}
 
 	if (is_cn20k(rvu->pdev)) {
-		err = devlink_params_register(dl, rvu_af_dl_param_defrag,
-					      ARRAY_SIZE(rvu_af_dl_param_defrag));
+		err = devlink_params_register(dl, rvu_af_dl_cn20k_params,
+					      ARRAY_SIZE(rvu_af_dl_cn20k_params));
 		if (err) {
 			dev_err(rvu->dev,
-				"devlink defrag params register failed with error %d",
+				"devlink cn20k params register failed with error %d",
 				err);
-			goto err_dl_defrag;
+			goto err_dl_cn20k_params;
 		}
 	}
 
@@ -1695,10 +1767,10 @@ int rvu_register_dl(struct rvu *rvu)
 
 err_dl_exact_match:
 	if (is_cn20k(rvu->pdev))
-		devlink_params_unregister(dl, rvu_af_dl_param_defrag,
-					  ARRAY_SIZE(rvu_af_dl_param_defrag));
+		devlink_params_unregister(dl, rvu_af_dl_cn20k_params,
+					  ARRAY_SIZE(rvu_af_dl_cn20k_params));
 
-err_dl_defrag:
+err_dl_cn20k_params:
 	devlink_params_unregister(dl, rvu_af_dl_params, ARRAY_SIZE(rvu_af_dl_params));
 
 err_dl_health:
@@ -1717,8 +1789,8 @@ void rvu_unregister_dl(struct rvu *rvu)
 	devlink_params_unregister(dl, rvu_af_dl_params, ARRAY_SIZE(rvu_af_dl_params));
 
 	if (is_cn20k(rvu->pdev))
-		devlink_params_unregister(dl, rvu_af_dl_param_defrag,
-					  ARRAY_SIZE(rvu_af_dl_param_defrag));
+		devlink_params_unregister(dl, rvu_af_dl_cn20k_params,
+					  ARRAY_SIZE(rvu_af_dl_cn20k_params));
 
 	/* Unregister exact match devlink only for CN10K-B */
 	if (rvu_npc_exact_has_match_table(rvu))
-- 
2.43.0


