Return-Path: <linux-rdma+bounces-21014-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICjcDZAZDWo5tQUAu9opvQ
	(envelope-from <linux-rdma+bounces-21014-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 04:16:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8949E586CA8
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 04:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04BBF30C6FE7
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BB2FF66B;
	Wed, 20 May 2026 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TTmqvCbj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C977175A5;
	Wed, 20 May 2026 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243105; cv=none; b=ccgBZSWUfZkGiGrfH6+ZAlwUnreLQoMLZZ1ylSkRLDmyOu0mQydkxRsnssbcqaAON6wc6aTcwq1ztWWbOHjbipa+/So7QstGYgemALuK3oDrDydfqLdleSw3qiZ3/xwU8fX0rf1m4n2uA08mNb1E97N0ggjkaHZXzgJni4L85CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243105; c=relaxed/simple;
	bh=g7x7jvNCH0nfbWb19YS25NxMgsXyjgZIWSVwyHHaHVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzXn3+TqBk3ibvsNmHCWI9SDC/AheaiKvgJHUtcXiQiYUPL3MjpnuVL8ShCbF+yRg3DMzVEjJJbRBrSlFdCL3fNVW4LzUiJ+Dcciss992fO+Lx4nZuRz7M8+n/nDyCLgulWEfBiYejNrMLahrQcm0Ao7XVhA91Mppe+XltYlHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TTmqvCbj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JNCqqw2498889;
	Tue, 19 May 2026 19:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
	RjuLtoCb99j9Hyyqizg552t8wzInS/qSqWKmQIn+9s=; b=TTmqvCbjWUhKaP1ZC
	Q43HY7Zl4kFphT7gRrGzMJA0Jxxp1TYFtP+q4wdFe/6cIklN+Fs44DTbL21NHePz
	mk6AuzI0YDsAWQwzRr0qj7E0uIWTxwjTzrjlyIQZLTk+8Ykv3HkGqpw//zIZb+kQ
	5RjlaOAlhaSm5HHiQmaChPJf7cB2+d8CSjysBz/v/950Q+GM2hGkJSk+zowKOuSN
	lQkbeM2xvG5b+aQQG/zJR7ts0skr6IgbIsNddz4aLlvVKiHj6pNhUTOie5qy9FbV
	X9+LLhHpvG52SNtrnnJT1dctUEGoGeAc65MHwGBdeEz23q+MJcY74AF0mLIAC82F
	WxvNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8k5rk4rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:11:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 May 2026 19:11:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 May 2026 19:11:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 006E35B6940;
	Tue, 19 May 2026 19:10:59 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v15 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT alloc
Date: Wed, 20 May 2026 07:39:38 +0530
Message-ID: <20260520020939.1457231-9-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520020939.1457231-1-rkannoth@marvell.com>
References: <20260520020939.1457231-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka7idwYD c=1 sm=1 tr=0 ts=6a0d183d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=3zpKOMqohp-RhpYd6ikA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOCBTYWx0ZWRfX5l4V9wKACWgR
 U817x34i/tVY6UpbY5Eh3dj5EypUEcqoalAxUY0/57Vmjzkl7udMyzMedqlwb9DqLxeMom0SUC9
 6dZdKwiZR0l4fWS7y5f9mqZMqp88mqqU9gGyQUkEzx6YV9CHD/CN02OmhY1DAOqh6Q2z7mPswMl
 1t+foV7wfxHSKYnXIZDG82smjKvY4yCeJPPi99Zc09hqmYK8LHm1ECna4a6pxfTzC6km01WNgi/
 sagkPbxLO438UxaLS7CzIkubtjqSU5X8DUcMtzCcFS1+jmF/nhbby0hT3GoQfKHPHl4rsQTZl3u
 px5RlBEM9z/UBtDOgt87tc+tdD+TZu7zqerOZnjS2l54jDz1Zb2htQepDKS3vZNLyjTuobSQNE1
 f3diDy55hE5xlIk+SuYtfQhcRH6cpE7FNEdoR0BgGrpZCispw0zS0G/BungpngQfumSaOHfSpOy
 ZHCzv5Xx2hN8vk3cpHw==
X-Proofpoint-GUID: 40eZXtOXT5Hsg6YFHw_yNmC4afmF1F0o
X-Proofpoint-ORIG-GUID: 40eZXtOXT5Hsg6YFHw_yNmC4afmF1F0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
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
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21014-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,npc_priv.kw:url];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8949E586CA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Default CN20K NPC rule allocation now keys off the active MCAM keyword
width: use X4 with a bank-masked reference index when the silicon uses
X4 keys, and X2 with the raw index otherwise (replacing the previous
always-X2 / eidx + 1 behaviour).

In the AF flow-install path, flows that need more than 256 key bits
query the NPC profile; if the platform is fixed to X2 entries, fail
with -EOPNOTSUPP instead of requesting X4. Otherwise select X4 for the
MCAM alloc.

On the PF, cache and pass the profile kw_type from npc_get_pfl_info
through otx2_mcam_pfl_info_get(), and use it when allocating MCAM
entries for RSS/defaults and when installing ethtool flows on CN20K,
including masking the reference index for X4 slot layout.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 21 ++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 12 ++++-
 .../marvell/octeontx2/nic/otx2_flows.c        | 48 +++++++++++++------
 3 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index d98b9fe73676..fa933bb5170b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -4500,10 +4500,16 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
 
+	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
+		req.kw_type = NPC_MCAM_KEY_X4;
+		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
+	} else {
+		req.kw_type = NPC_MCAM_KEY_X2;
+		req.ref_entry = eidx;
+	}
+
 	req.contig = false;
 	req.ref_prio = NPC_MCAM_HIGHER_PRIO;
-	req.ref_entry = eidx;
-	req.kw_type = NPC_MCAM_KEY_X2;
 	req.count = cnt;
 	req.hdr.pcifunc = pcifunc;
 
@@ -4533,11 +4539,18 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
 	 */
 	req.contig = false;
-	req.kw_type = NPC_MCAM_KEY_X2;
 	req.count = cnt;
 	req.hdr.pcifunc = pcifunc;
 	req.ref_prio = NPC_MCAM_LOWER_PRIO;
-	req.ref_entry = eidx + 1;
+
+	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
+		req.kw_type = NPC_MCAM_KEY_X4;
+		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
+	} else {
+		req.kw_type = NPC_MCAM_KEY_X2;
+		req.ref_entry = eidx;
+	}
+
 	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
 	if (ret) {
 		dev_err(rvu->dev,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 6ae9cdcb608b..d20eb0e47d7d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1671,9 +1671,11 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
 {
 	struct npc_mcam_alloc_entry_req entry_req;
 	struct npc_mcam_alloc_entry_rsp entry_rsp;
+	struct npc_get_pfl_info_rsp rsp = { 0 };
 	struct npc_get_num_kws_req kws_req;
 	struct npc_get_num_kws_rsp kws_rsp;
 	int off, kw_bits, rc;
+	struct msg_req req;
 	u8 *src, *dst;
 
 	if (!is_cn20k(rvu->pdev)) {
@@ -1697,8 +1699,16 @@ rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
 	kw_bits = kws_rsp.kws * 64;
 
 	*kw_type = NPC_MCAM_KEY_X2;
-	if (kw_bits > 256)
+	if (kw_bits > 256) {
+		rvu_mbox_handler_npc_get_pfl_info(rvu, &req, &rsp);
+		if (rsp.kw_type == NPC_MCAM_KEY_X2) {
+			dev_err(rvu->dev,
+				"Only X2 entries are supported in X2 profile\n");
+			return -EOPNOTSUPP;
+		}
+
 		*kw_type = NPC_MCAM_KEY_X4;
+	}
 
 	memset(&entry_req, 0, sizeof(entry_req));
 	memset(&entry_rsp, 0, sizeof(entry_rsp));
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 38cc539d724d..5dd0591fed99 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -37,14 +37,13 @@ static void otx2_clear_ntuple_flow_info(struct otx2_nic *pfvf, struct otx2_flow_
 	flow_cfg->max_flows = 0;
 }
 
-static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
-				  u16 *x4_slots)
+static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
 {
 	struct npc_get_pfl_info_rsp *rsp;
 	struct msg_req *req;
 	static struct {
 		bool is_set;
-		bool is_x2;
+		u8 kw_type;
 		u16 x4_slots;
 	} pfl_info;
 
@@ -53,8 +52,8 @@ static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
 	 */
 	mutex_lock(&pfvf->mbox.lock);
 	if (pfl_info.is_set) {
-		*is_x2 = pfl_info.is_x2;
 		*x4_slots = pfl_info.x4_slots;
+		*kw_type = pfl_info.kw_type;
 		mutex_unlock(&pfvf->mbox.lock);
 		return 0;
 	}
@@ -79,16 +78,16 @@ static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
 		return -EFAULT;
 	}
 
-	*is_x2 = (rsp->kw_type == NPC_MCAM_KEY_X2);
-	if (*is_x2)
-		*x4_slots = 0;
+	pfl_info.kw_type = rsp->kw_type;
+	if (rsp->kw_type == NPC_MCAM_KEY_X2)
+		pfl_info.x4_slots = 0;
 	else
-		*x4_slots = rsp->x4_slots;
-
-	pfl_info.is_x2 = *is_x2;
-	pfl_info.x4_slots = *x4_slots;
+		pfl_info.x4_slots = rsp->x4_slots;
 	pfl_info.is_set = true;
 
+	*x4_slots = pfl_info.x4_slots;
+	*kw_type = pfl_info.kw_type;
+
 	mutex_unlock(&pfvf->mbox.lock);
 	return 0;
 }
@@ -164,6 +163,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	u16 dft_idx = 0, x4_slots = 0;
 	int ent, allocated = 0, ref;
 	bool is_x2 = false;
+	u8 kw_type = 0;
 	int rc;
 
 	/* Free current ones and allocate new ones with requested count */
@@ -182,12 +182,14 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	}
 
 	if (is_cn20k(pfvf->pdev)) {
-		rc = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		rc = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
 		if (rc) {
 			netdev_err(pfvf->netdev, "Error to retrieve profile info\n");
 			return rc;
 		}
 
+		is_x2 = kw_type == NPC_MCAM_KEY_X2;
+
 		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
 		if (rc) {
 			netdev_err(pfvf->netdev,
@@ -289,6 +291,8 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	struct npc_mcam_alloc_entry_rsp *rsp;
 	int vf_vlan_max_flows, count;
 	int rc, ref, prio, ent;
+	u8 kw_type = 0;
+	u16 x4_slots;
 	u16 dft_idx;
 
 	ref = 0;
@@ -315,6 +319,16 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	if (!flow_cfg->def_ent)
 		return -ENOMEM;
 
+	kw_type = NPC_MCAM_KEY_X2;
+	if (is_cn20k(pfvf->pdev)) {
+		rc = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
+		if (rc) {
+			netdev_err(pfvf->netdev,
+				   "Error to get pfl info\n");
+			return rc;
+		}
+	}
+
 	mutex_lock(&pfvf->mbox.lock);
 
 	req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&pfvf->mbox);
@@ -324,6 +338,10 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	}
 
 	req->kw_type = NPC_MCAM_KEY_X2;
+	if (is_cn20k(pfvf->pdev) && kw_type == NPC_MCAM_KEY_X4) {
+		req->kw_type = NPC_MCAM_KEY_X4;
+		ref &= (x4_slots - 1);
+	}
 	req->contig = false;
 	req->count = count;
 	req->ref_prio = prio;
@@ -1174,15 +1192,14 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 #ifdef CONFIG_DCB
 	int vlan_prio, qidx, pfc_rule = 0;
 #endif
+	bool modify = false, is_x2;
 	int err, vf = 0, off, sz;
-	bool modify = false;
 	u8 kw_type = 0;
 	u8 *src, *dst;
 	u16 x4_slots;
-	bool is_x2;
 
 	if (is_cn20k(pfvf->pdev)) {
-		err = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		err = otx2_mcam_pfl_info_get(pfvf, &x4_slots, &kw_type);
 		if (err) {
 			netdev_err(pfvf->netdev,
 				   "Error to retrieve NPC profile info, pcifunc=%#x\n",
@@ -1190,6 +1207,7 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 			return -EFAULT;
 		}
 
+		is_x2 = kw_type == NPC_MCAM_KEY_X2;
 		if (!is_x2) {
 			err = otx2_prepare_flow_request(&flow->flow_spec,
 							&treq);
-- 
2.43.0


