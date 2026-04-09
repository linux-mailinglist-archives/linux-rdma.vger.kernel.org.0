Return-Path: <linux-rdma+bounces-19142-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA0QKu4V12k1KwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19142-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:58:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DD3C5CF5
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B2830A814E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 02:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E8B37E2FE;
	Thu,  9 Apr 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IkbgZ1UJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED59352C39;
	Thu,  9 Apr 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703120; cv=none; b=lSn8gwBAmPTuSbwKJL3xkwruDJNZQ7EtMv4rdQLyeFzowWnJiW0/xiojCFrW1n3aZsdAny5A6FVcYmOFBTFOwdwuQyo2uEFbqW282XoMGjJ1GNqdW3Ei46QVfrxc1c4saXdZg7nzp97RuDhdJ8rePfyPmHfN2zG1MEmvbxEFa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703120; c=relaxed/simple;
	bh=hMnDm69Du2yu0vrl7IJ2+PVffa4vvwS/ioYK6fbvh7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G03zRJgO02SR2a92XfSJROx3W6AMsITTp+oCudP/Oa8ypMPbNbAGM80AqjgOlgPU/SEVt+z7yIwlVshgx2Nh5AnFEW/j+A2STgucN7zvBs6Q7o3oOKi3pNc4yCzCdj9+Bdjk6pbaUq2uwy52GgyETDs4JvlThPLtc0UT/0h4Otg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IkbgZ1UJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638GmU8S3661925;
	Wed, 8 Apr 2026 19:51:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	isi9xxvkXj3PKtBL86kw1zZHXxL2ms8sNOOlyHtXxo=; b=IkbgZ1UJ7+ZPmb/7f
	wmasB7OJUnm/JJtGXBnygRpNEwtcrKJ2/CNtIv1hwAKNPLUVVa+ZY2yMyjLAuZmq
	vuDH/AaEEVfew3w2QwkyaJWq58nPwiZ6DQtgP3FM3Po/ydD96Jm5XB4Y8KRMQ8Zq
	HSruG4AFO5q3cFEPFUyB/4E4F9CYBXsqFaKQzP6ffmCP9+n/1Yg/4TPALylPhOrI
	1W5psaUiNkJTHoQfOWvrfLJp/E0TYuvAliagDxNwRiHmPrTd5gJhrNLQ6jYx4YrL
	DaeVzN7A4veNcmnz72/Qdf/6GaSUzZQFlQsYdoVkM52jD7zVvUDgPlLPI2Jk2uFE
	zshbg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ddtb31e42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 19:51:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Apr 2026 19:51:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Apr 2026 19:51:46 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 49F313F7055;
	Wed,  8 Apr 2026 19:51:40 -0700 (PDT)
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
Subject: [PATCH v11 net-next 6/7] octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries
Date: Thu, 9 Apr 2026 08:20:54 +0530
Message-ID: <20260409025055.1664053-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409025055.1664053-1-rkannoth@marvell.com>
References: <20260409025055.1664053-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K7wS2SWI c=1 sm=1 tr=0 ts=69d71443 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=OQ0u4SyIz9oFantGSkkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAyNCBTYWx0ZWRfXxY1tWuxVxlaB
 ciTVpLqUXdGGa9UnJVvmQb62E1ztbroWWTaOymVOAuQTiyHMn+DBMKlHem1cmn4VPDvHityOqNp
 VdyrBaICgPk/8WzscK7HSD0dh57VtssjzdDn6eV/VBGIa8c95OTF6dxKzsjh1p6dYriNS+JkJz9
 NYraJNPOrOGvsm1/N8vGSwNN/pfIl/V1SZQRtsmGZabAlmFRDANd6SHVWfpQRL2XG675aYXbese
 0E04nS7M0FhshywxUAowq/nzcG3AUBRua0Eyxikx6oLRbmluvHoKivwyS7AhECKRJl9me0fQwJx
 F3IMnhXgamHCwPq+vbo80+anst3gKgpArKqgHyVT7Oe558AA3RUo/1mStAMQOIiiDNWrzLMPjGr
 /sTyOWiH8NgOdiHHunMGOF96TDMHGD+ron8+VErjkyaK9YrlFJyBjk8bWP0W16+J/i00o5kyctW
 pAQYEVPl4hCL4OTGiEQ==
X-Proofpoint-GUID: Zs-ACAlylLnHqihUL5UiHBOwp9G4lf1t
X-Proofpoint-ORIG-GUID: Zs-ACAlylLnHqihUL5UiHBOwp9G4lf1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19142-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 478DD3C5CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Improve MCAM utilization by tying default (broadcast, multicast,
promisc, ucast) entry lifetime to NIX LF usage.

- On NIX LF alloc (e.g. kernel or DPDK), allocate default MCAM entries
  if missing; on NIX LF free, release them so they return to the pool.
- Add NIX_LF_DONT_FREE_DFT_IDXS so the kernel PF driver can free the
  NIX LF without releasing default entries (e.g. across suspend/resume).
- When NIX LF is used by DPDK, default entries are allocated on first
  use and freed when the LF is released if NIX_LF_DONT_FREE_DFT_IDXS is
  not set

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 108 ++++++++++-----
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  69 ++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 126 +++++++++++++-----
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   4 +-
 6 files changed, 219 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 153765b3e504..40c6c17054b0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -808,6 +808,11 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	u64 cfg, hw_prio;
 	u8 kw_type;
 
+	if (index < 0 || index >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index %d\n", index);
+		return;
+	}
+
 	enable ? set_bit(index, npc_priv.en_map) :
 		clear_bit(index, npc_priv.en_map);
 
@@ -1053,6 +1058,11 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	int kw = 0;
 	u8 kw_type;
 
+	if (index < 0 || index >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index %d\n", index);
+		return;
+	}
+
 	/* Disable before mcam entry update */
 	npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
 
@@ -1132,6 +1142,11 @@ void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 	int bank, i, sb, db;
 	int dbank, sbank;
 
+	if (src >= mcam->total_entries || dest >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index src=%u dest=%u\n", src, dest);
+		return;
+	}
+
 	dbank = npc_get_bank(mcam, dest);
 	sbank = npc_get_bank(mcam, src);
 	npc_mcam_idx_2_key_type(rvu, src, &src_kwtype);
@@ -1190,11 +1205,24 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	int kw = 0, bank;
 	u8 kw_type;
 
+	if (index >= mcam->total_entries) {
+		WARN(1, "Wrong mcam index %u\n", index);
+		return;
+	}
+
 	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
 
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
 
+	cfg = rvu_read64(rvu, blkaddr,
+			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 0));
+	entry->action = cfg;
+
+	cfg = rvu_read64(rvu, blkaddr,
+			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 1));
+	entry->vtag_action = cfg;
+
 	cfg = rvu_read64(rvu, blkaddr,
 			 NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index,
 								 bank, 1)) & 3;
@@ -1244,7 +1272,7 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 									bank,
 									0));
 		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
-		goto read_action;
+		return;
 	}
 
 	for (bank = 0; bank < mcam->banks_per_entry; bank++, kw = kw + 4) {
@@ -1289,17 +1317,6 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
 	}
 
-read_action:
-	/* 'action' is set to same value for both bank '0' and '1'.
-	 * Hence, reading bank '0' should be enough.
-	 */
-	cfg = rvu_read64(rvu, blkaddr,
-			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 0));
-	entry->action = cfg;
-
-	cfg = rvu_read64(rvu, blkaddr,
-			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 1));
-	entry->vtag_action = cfg;
 }
 
 int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
@@ -1671,8 +1688,8 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type)
 
 	/* mcam_idx should be less than (2 * bank depth) */
 	if (mcam_idx >= npc_priv.bank_depth * 2) {
-		dev_err(rvu->dev, "%s: bad params\n",
-			__func__);
+		dev_err(rvu->dev, "%s: bad params mcam_idx=%u\n",
+			__func__, mcam_idx);
 		return -EINVAL;
 	}
 
@@ -4024,6 +4041,13 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 	void *val;
 	int i, j;
 
+	for (i = 0; i < ARRAY_SIZE(ptr); i++) {
+		if (!ptr[i])
+			continue;
+
+		*ptr[i] = USHRT_MAX;
+	}
+
 	if (!npc_priv.init_done)
 		return 0;
 
@@ -4039,7 +4063,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
 				 pcifunc);
 
-			*ptr[0] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4059,7 +4082,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
 				 pcifunc);
 
-			*ptr[3] = USHRT_MAX;
 			return -ESRCH;
 		}
 
@@ -4079,7 +4101,6 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				 __func__,
 				 npc_dft_rule_name[i], pcifunc);
 
-			*ptr[j] = USHRT_MAX;
 			continue;
 		}
 
@@ -4174,7 +4195,7 @@ int rvu_mbox_handler_npc_get_dft_rl_idxs(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
-static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
+bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 {
 	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
 		is_lbk_vf(rvu, pcifunc);
@@ -4182,9 +4203,10 @@ static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 
 void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 {
-	struct npc_mcam_free_entry_req free_req = { 0 };
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_npc_mcam_rule *rule, *tmp;
 	unsigned long index;
-	struct msg_rsp rsp;
+	int blkaddr;
 	u16 ptr[4];
 	int rc, i;
 	void *map;
@@ -4209,7 +4231,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
 		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
 		if (!map)
-			dev_dbg(rvu->dev,
+			dev_err(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
 				__func__,
 				npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
@@ -4223,7 +4245,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
 		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
 		if (!map)
-			dev_dbg(rvu->dev,
+			dev_err(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
 				__func__,
 				npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
@@ -4237,21 +4259,47 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
 		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
 		if (!map)
-			dev_dbg(rvu->dev,
+			dev_err(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
 				__func__, npc_dft_rule_name[i],
 				pcifunc);
 	}
 
 free_rules:
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return;
 
-	free_req.hdr.pcifunc = pcifunc;
-	free_req.all = 1;
-	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
-	if (rc)
-		dev_err(rvu->dev,
-			"%s: Error deleting default entries (pcifunc=%#x\n",
-			__func__, pcifunc);
+	for (int i = 0; i < 4; i++) {
+		if (ptr[i] == USHRT_MAX)
+			continue;
+
+		mutex_lock(&mcam->lock);
+		npc_mcam_clear_bit(mcam, ptr[i]);
+		mcam->entry2pfvf_map[ptr[i]] = NPC_MCAM_INVALID_MAP;
+		npc_cn20k_enable_mcam_entry(rvu, blkaddr, ptr[i], false);
+		mcam->entry2target_pffunc[ptr[i]] = 0x0;
+		mutex_unlock(&mcam->lock);
+
+		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
+		if (rc)
+			dev_err(rvu->dev,
+				"%s:%d Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
+				__func__, __LINE__, pcifunc, ptr[i]);
+	}
+
+	mutex_lock(&mcam->lock);
+	list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
+		for (int i = 0; i < 4; i++) {
+			if (ptr[i] != rule->entry)
+				continue;
+
+			list_del(&rule->list);
+			kfree(rule);
+			break;
+		}
+	}
+	mutex_unlock(&mcam->lock);
 }
 
 int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 6f9f796940f3..1b4b4a6fa378 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -345,5 +345,6 @@ int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
 			       int *sb_off);
 const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz);
 int npc_cn20k_search_order_set(struct rvu *rvu, u64 arr[32], int cnt);
+bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index dc42c81c0942..e07fbf842b94 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1009,6 +1009,7 @@ struct nix_lf_free_req {
 	struct mbox_msghdr hdr;
 #define NIX_LF_DISABLE_FLOWS		BIT_ULL(0)
 #define NIX_LF_DONT_FREE_TX_VTAG	BIT_ULL(1)
+#define NIX_LF_DONT_FREE_DFT_IDXS	BIT_ULL(2)
 	u64 flags;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index ef5b081162eb..584e98e25f11 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -16,6 +16,7 @@
 #include "cgx.h"
 #include "lmac_common.h"
 #include "rvu_npc_hash.h"
+#include "cn20k/npc.h"
 
 static void nix_free_tx_vtag_entries(struct rvu *rvu, u16 pcifunc);
 static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
@@ -1499,7 +1500,7 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 				  struct nix_lf_alloc_req *req,
 				  struct nix_lf_alloc_rsp *rsp)
 {
-	int nixlf, qints, hwctx_size, intf, err, rc = 0;
+	int nixlf, qints, hwctx_size, intf, rc = 0;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
 	struct rvu_block *block;
@@ -1555,8 +1556,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 		return NIX_AF_ERR_RSS_GRPS_INVALID;
 
 	/* Reset this NIX LF */
-	err = rvu_lf_reset(rvu, block, nixlf);
-	if (err) {
+	rc = rvu_lf_reset(rvu, block, nixlf);
+	if (rc) {
 		dev_err(rvu->dev, "Failed to reset NIX%d LF%d\n",
 			block->addr - BLKADDR_NIX0, nixlf);
 		return NIX_AF_ERR_LF_RESET;
@@ -1566,13 +1567,15 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 
 	/* Alloc NIX RQ HW context memory and config the base */
 	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
-	err = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
-	if (err)
+	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
+	if (rc)
 		goto free_mem;
 
 	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
-	if (!pfvf->rq_bmap)
+	if (!pfvf->rq_bmap) {
+		rc = -ENOMEM;
 		goto free_mem;
+	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_BASE(nixlf),
 		    (u64)pfvf->rq_ctx->iova);
@@ -1583,13 +1586,15 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 
 	/* Alloc NIX SQ HW context memory and config the base */
 	hwctx_size = 1UL << (ctx_cfg & 0xF);
-	err = qmem_alloc(rvu->dev, &pfvf->sq_ctx, req->sq_cnt, hwctx_size);
-	if (err)
+	rc = qmem_alloc(rvu->dev, &pfvf->sq_ctx, req->sq_cnt, hwctx_size);
+	if (rc)
 		goto free_mem;
 
 	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
-	if (!pfvf->sq_bmap)
+	if (!pfvf->sq_bmap) {
+		rc = -ENOMEM;
 		goto free_mem;
+	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_SQS_BASE(nixlf),
 		    (u64)pfvf->sq_ctx->iova);
@@ -1599,13 +1604,15 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 
 	/* Alloc NIX CQ HW context memory and config the base */
 	hwctx_size = 1UL << ((ctx_cfg >> 8) & 0xF);
-	err = qmem_alloc(rvu->dev, &pfvf->cq_ctx, req->cq_cnt, hwctx_size);
-	if (err)
+	rc = qmem_alloc(rvu->dev, &pfvf->cq_ctx, req->cq_cnt, hwctx_size);
+	if (rc)
 		goto free_mem;
 
 	pfvf->cq_bmap = kcalloc(req->cq_cnt, sizeof(long), GFP_KERNEL);
-	if (!pfvf->cq_bmap)
+	if (!pfvf->cq_bmap) {
+		rc = -ENOMEM;
 		goto free_mem;
+	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CQS_BASE(nixlf),
 		    (u64)pfvf->cq_ctx->iova);
@@ -1615,18 +1622,18 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 
 	/* Initialize receive side scaling (RSS) */
 	hwctx_size = 1UL << ((ctx_cfg >> 12) & 0xF);
-	err = nixlf_rss_ctx_init(rvu, blkaddr, pfvf, nixlf, req->rss_sz,
-				 req->rss_grps, hwctx_size, req->way_mask,
-				 !!(req->flags & NIX_LF_RSS_TAG_LSB_AS_ADDER));
-	if (err)
+	rc = nixlf_rss_ctx_init(rvu, blkaddr, pfvf, nixlf, req->rss_sz,
+				req->rss_grps, hwctx_size, req->way_mask,
+				!!(req->flags & NIX_LF_RSS_TAG_LSB_AS_ADDER));
+	if (rc)
 		goto free_mem;
 
 	/* Alloc memory for CQINT's HW contexts */
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
 	qints = (cfg >> 24) & 0xFFF;
 	hwctx_size = 1UL << ((ctx_cfg >> 24) & 0xF);
-	err = qmem_alloc(rvu->dev, &pfvf->cq_ints_ctx, qints, hwctx_size);
-	if (err)
+	rc = qmem_alloc(rvu->dev, &pfvf->cq_ints_ctx, qints, hwctx_size);
+	if (rc)
 		goto free_mem;
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_BASE(nixlf),
@@ -1639,8 +1646,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
 	qints = (cfg >> 12) & 0xFFF;
 	hwctx_size = 1UL << ((ctx_cfg >> 20) & 0xF);
-	err = qmem_alloc(rvu->dev, &pfvf->nix_qints_ctx, qints, hwctx_size);
-	if (err)
+	rc = qmem_alloc(rvu->dev, &pfvf->nix_qints_ctx, qints, hwctx_size);
+	if (rc)
 		goto free_mem;
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_BASE(nixlf),
@@ -1684,10 +1691,16 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (is_sdp_pfvf(rvu, pcifunc))
 		intf = NIX_INTF_TYPE_SDP;
 
-	err = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
-				 !!(req->flags & NIX_LF_LBK_BLK_SEL));
-	if (err)
-		goto free_mem;
+	if (is_cn20k(rvu->pdev)) {
+		rc = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
+		if (rc)
+			goto free_mem;
+	}
+
+	rc = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
+				!!(req->flags & NIX_LF_LBK_BLK_SEL));
+	if (rc)
+		goto free_dft;
 
 	/* Disable NPC entries as NIXLF's contexts are not initialized yet */
 	rvu_npc_disable_default_entries(rvu, pcifunc, nixlf);
@@ -1699,9 +1712,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 
 	goto exit;
 
+free_dft:
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_dft_rules_free(rvu, pcifunc);
+
 free_mem:
 	nix_ctx_free(rvu, pfvf);
-	rc = -ENOMEM;
 
 exit:
 	/* Set macaddr of this PF/VF */
@@ -1775,6 +1791,9 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
 
 	nix_ctx_free(rvu, pfvf);
 
+	if (is_cn20k(rvu->pdev) && !(req->flags & NIX_LF_DONT_FREE_DFT_IDXS))
+		npc_cn20k_dft_rules_free(rvu, pcifunc);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c2ca5ed1d028..de1cdc5d3a4d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -165,12 +165,20 @@ int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
 
 		switch (type) {
 		case NIXLF_BCAST_ENTRY:
+			if (bcast == USHRT_MAX)
+				return -EINVAL;
 			return bcast;
 		case NIXLF_ALLMULTI_ENTRY:
+			if (mcast == USHRT_MAX)
+				return -EINVAL;
 			return mcast;
 		case NIXLF_PROMISC_ENTRY:
+			if (promisc == USHRT_MAX)
+				return -EINVAL;
 			return promisc;
 		case NIXLF_UCAST_ENTRY:
+			if (ucast == USHRT_MAX)
+				return -EINVAL;
 			return ucast;
 		default:
 			return -EINVAL;
@@ -237,12 +245,8 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank = npc_get_bank(mcam, index);
 	int actbank = bank;
 
-	if (is_cn20k(rvu->pdev)) {
-		if (index < 0 || index >= mcam->banksize * mcam->banks)
-			return;
-
+	if (is_cn20k(rvu->pdev))
 		return npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable);
-	}
 
 	index &= (mcam->banksize - 1);
 	for (; bank < (actbank + mcam->banks_per_entry); bank++) {
@@ -1113,7 +1117,7 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 		index = mcam_index;
 	}
 
-	if (index >= mcam->total_entries)
+	if (index < 0 || index >= mcam->total_entries)
 		return;
 
 	bank = npc_get_bank(mcam, index);
@@ -1158,16 +1162,18 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 		/* If PF's promiscuous  entry is enabled,
 		 * Set RSS action for that entry as well
 		 */
-		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
-						  blkaddr, alg_idx);
+		if (index >= 0)
+			npc_update_rx_action_with_alg_idx(rvu, action, pfvf,
+							  index, blkaddr, alg_idx);
 
 		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
 						 nixlf, NIXLF_ALLMULTI_ENTRY);
 		/* If PF's allmulti  entry is enabled,
 		 * Set RSS action for that entry as well
 		 */
-		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
-						  blkaddr, alg_idx);
+		if (index >= 0)
+			npc_update_rx_action_with_alg_idx(rvu, action, pfvf,
+							  index, blkaddr, alg_idx);
 	}
 }
 
@@ -1184,6 +1190,11 @@ void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
 	if (blkaddr < 0)
 		return;
 
+	/* only CGX or LBK interfaces have default entries */
+	if (is_cn20k(rvu->pdev) &&
+	    !npc_is_cgx_or_lbk(rvu, pcifunc & ~RVU_PFVF_FUNC_MASK))
+		return;
+
 	index = npc_get_nixlf_mcam_index(mcam, pcifunc & ~RVU_PFVF_FUNC_MASK,
 					 nixlf, type);
 
@@ -1212,8 +1223,13 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int type = NIXLF_UCAST_ENTRY;
 	int index, blkaddr;
 
+	/* only CGX or LBK interfaces have default entries */
+	if (is_cn20k(rvu->pdev) && !npc_is_cgx_or_lbk(rvu, pcifunc))
+		return;
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return;
@@ -1221,8 +1237,11 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 	/* Ucast MCAM match entry of this PF/VF */
 	if (npc_is_feature_supported(rvu, BIT_ULL(NPC_DMAC),
 				     pfvf->nix_rx_intf)) {
+		if (is_cn20k(rvu->pdev) && is_lbk_vf(rvu, pcifunc))
+			type = NIXLF_PROMISC_ENTRY;
+
 		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
-						 nixlf, NIXLF_UCAST_ENTRY);
+						 nixlf, type);
 		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
 	}
 
@@ -1232,9 +1251,13 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 	if ((pcifunc & RVU_PFVF_FUNC_MASK) && !rvu->hw->cap.nix_rx_multicast)
 		return;
 
+	type = NIXLF_BCAST_ENTRY;
+	if (is_cn20k(rvu->pdev) && is_lbk_vf(rvu, pcifunc))
+		type = NIXLF_PROMISC_ENTRY;
+
 	/* add/delete pf_func to broadcast MCE list */
 	npc_enadis_default_mce_entry(rvu, pcifunc, nixlf,
-				     NIXLF_BCAST_ENTRY, enable);
+				     type, enable);
 }
 
 void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
@@ -1244,6 +1267,9 @@ void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
 
 	npc_enadis_default_entries(rvu, pcifunc, nixlf, false);
 
+	if (is_cn20k(rvu->pdev) && is_vf(pcifunc))
+		return;
+
 	/* Delete multicast and promisc MCAM entries */
 	npc_enadis_default_mce_entry(rvu, pcifunc, nixlf,
 				     NIXLF_ALLMULTI_ENTRY, false);
@@ -2504,33 +2530,58 @@ void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
 static void npc_mcam_free_all_entries(struct rvu *rvu, struct npc_mcam *mcam,
 				      int blkaddr, u16 pcifunc)
 {
+	u16 dft_idxs[NPC_DFT_RULE_MAX_ID] = {[0 ... NPC_DFT_RULE_MAX_ID - 1] = USHRT_MAX};
 	u16 index, cntr;
+	bool dft_rl;
 	int rc;
 
+	npc_cn20k_dft_rules_idx_get(rvu, pcifunc,
+				    &dft_idxs[NPC_DFT_RULE_BCAST_ID],
+				    &dft_idxs[NPC_DFT_RULE_MCAST_ID],
+				    &dft_idxs[NPC_DFT_RULE_PROMISC_ID],
+				    &dft_idxs[NPC_DFT_RULE_UCAST_ID]);
+
 	/* Scan all MCAM entries and free the ones mapped to 'pcifunc' */
 	for (index = 0; index < mcam->bmap_entries; index++) {
-		if (mcam->entry2pfvf_map[index] == pcifunc) {
-			mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
-			/* Free the entry in bitmap */
-			npc_mcam_clear_bit(mcam, index);
-			/* Disable the entry */
-			npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
-
-			/* Update entry2counter mapping */
-			cntr = mcam->entry2cntr_map[index];
-			if (cntr != NPC_MCAM_INVALID_MAP)
-				npc_unmap_mcam_entry_and_cntr(rvu, mcam,
-							      blkaddr, index,
-							      cntr);
-			mcam->entry2target_pffunc[index] = 0x0;
-			if (is_cn20k(rvu->pdev)) {
-				rc = npc_cn20k_idx_free(rvu, &index, 1);
-				if (rc)
-					dev_err(rvu->dev,
-						"Failed to free mcam idx=%u pcifunc=%#x\n",
-						index, pcifunc);
+		if (mcam->entry2pfvf_map[index] != pcifunc)
+			continue;
+
+		mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
+
+		dft_rl = false;
+		if (is_cn20k(rvu->pdev)) {
+			if (dft_idxs[NPC_DFT_RULE_BCAST_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_MCAST_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_PROMISC_ID] == index ||
+			    dft_idxs[NPC_DFT_RULE_UCAST_ID] == index) {
+				dft_rl = true;
 			}
 		}
+
+		/* Free the entry in bitmap.*/
+		if (!dft_rl)
+			npc_mcam_clear_bit(mcam, index);
+
+		/* Disable the entry */
+		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
+
+		/* Update entry2counter mapping */
+		cntr = mcam->entry2cntr_map[index];
+		if (cntr != NPC_MCAM_INVALID_MAP)
+			npc_unmap_mcam_entry_and_cntr(rvu, mcam,
+						      blkaddr, index,
+						      cntr);
+		mcam->entry2target_pffunc[index] = 0x0;
+		if (is_cn20k(rvu->pdev)) {
+			if (dft_rl)
+				continue;
+
+			rc = npc_cn20k_idx_free(rvu, &index, 1);
+			if (rc)
+				dev_err(rvu->dev,
+					"Failed to free mcam idx=%u pcifunc=%#x\n",
+					index, pcifunc);
+		}
 	}
 }
 
@@ -3917,13 +3968,22 @@ void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_npc_mcam_rule *rule;
 	int ucast_idx, blkaddr;
+	u8 type;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return;
 
+	type = NIXLF_UCAST_ENTRY;
+	if (is_cn20k(rvu->pdev) && is_lbk_vf(rvu, pcifunc))
+		type = NIXLF_PROMISC_ENTRY;
+
 	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
-					     nixlf, NIXLF_UCAST_ENTRY);
+					     nixlf, type);
+
+	/* In cn20k, default rules are freed before detach rsrc */
+	if (ucast_idx < 0)
+		return;
 
 	npc_enable_mcam_entry(rvu, mcam, blkaddr, ucast_idx, false);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..366850742862 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1729,7 +1729,7 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	mutex_lock(&mbox->lock);
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
-		free_req->flags = NIX_LF_DISABLE_FLOWS;
+		free_req->flags = NIX_LF_DISABLE_FLOWS | NIX_LF_DONT_FREE_DFT_IDXS;
 		if (otx2_sync_mbox_msg(mbox))
 			dev_err(pf->dev, "%s failed to free nixlf\n", __func__);
 	}
@@ -1803,7 +1803,7 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	/* Reset NIX LF */
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
-		free_req->flags = NIX_LF_DISABLE_FLOWS;
+		free_req->flags = NIX_LF_DISABLE_FLOWS | NIX_LF_DONT_FREE_DFT_IDXS;
 		if (!(pf->flags & OTX2_FLAG_PF_SHUTDOWN))
 			free_req->flags |= NIX_LF_DONT_FREE_TX_VTAG;
 		if (otx2_sync_mbox_msg(mbox))
-- 
2.43.0


