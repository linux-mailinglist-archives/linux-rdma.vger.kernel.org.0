Return-Path: <linux-rdma+bounces-21090-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CVvMkvaDmrmCgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21090-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:11:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD845A3027
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93D930A9CBA
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1C383C7B;
	Thu, 21 May 2026 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LaUNqkqZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A343803F2;
	Thu, 21 May 2026 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357299; cv=none; b=uwTs6kXr48KVbIe8tkZmtk8H/6XQTuyF7t7qYRqQWVHd5nvLRcbDCjKD1UoPGXAePuUfNng+rVwOwocho5AzIu8wta3L6WJY9uwOsGaFf1z0Ppp//GnCbgkq+JVA3h+ahWCyyM3M2nokuC6clKS3VcuVgzgT/fw0PP2Qw5Rfuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357299; c=relaxed/simple;
	bh=vnQCOsor9SOQy62UlTv11Pe8x0Uu1CpIB5GfgKu2zpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phXX7bDFbWMqlsqQ4FqO7A/vTohbJxNGxgKLgPT9bf5uybNuXNm7Zfs11qvXFkHqz0xmITGUuQjb4EEsmvJ8xkFLXVTT1rnIazhSmYVZGNidBb+b66GnM3M+e2zfWERqeO+fPZTuw4u1N3IIRnB0sIpH6iBHGNo/crSy7PjvYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LaUNqkqZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1kRcH2255589;
	Thu, 21 May 2026 02:54:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	gOYH0kHzcPSrK+AUpOvGg9HJJFvG+VmwEdV3tIaNOM=; b=LaUNqkqZ38ke3t00Q
	y6DlCCrGIq/lCGVEN23xPPC+z4WX59AmuW/ECIazrVPQ1LwjWLvr+n3cYaevRWkH
	8opDZSaREekGMtsdud2YeseT5RrEJvkLE9WxUZIILopk6BNFPjtqUE521lO+5znm
	dQbp57j81hnYtVNpd4B50r9QtPiuV8sImCBITVtDvXvK0kV/FarTf9F4/wph84x4
	grokZhS3r0oDu5MJipPxQKG/SjEYLD0BrVAkV+2rfo49prnfDlhn/y0T8/9ZdvXl
	0t59f60GBr0mUhFwsHB9jLZBvQe28e0unpWnaaFVpaIBdCFJ6f1Xm+95DvBfCkx8
	QP0VQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e94eummyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:54:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 21 May 2026 02:54:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 21 May 2026 02:54:35 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CA52B3F7063;
	Thu, 21 May 2026 02:54:26 -0700 (PDT)
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
Subject: [PATCH v16 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT alloc
Date: Thu, 21 May 2026 15:23:02 +0530
Message-ID: <20260521095303.2395584-9-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521095303.2395584-1-rkannoth@marvell.com>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5OCBTYWx0ZWRfX7Eo5prjQhTOo
 BodIuE04HV/0rVg77RYR8CZIafKozCR0Yp0XVfCBAyc1DUmOMQDoILsdOszZ9M9yzZfivv9Wpa9
 TZZMUq/jgKIMWrWm8IIcVETZoOIfEwjJuyjaJP02W5VKYxliVwYWmN0WUTwAxPjgvJR0adsZFiy
 cEzF82PhrYD9YbNeYnocbKwn0yjfXldVzKKgPm3vKLg3qAOBSRzZBD2Ot3mIwQEQdDWOIIP48RO
 eUicIl7QTwx83PgSpF5McnK2qRGbMqU0KMOSllAA4Vq2pCvtdRrSe11ySrZlGLfqmJcUjw6L70h
 du0dkgqMD2NZ24Axu96pZUsTTll7VIsKzszeJA3lJI+O2AOeZhimszuXbYFuTiwVqQoR/MLxb+B
 SiMmZIylmx5YtOSOmS0KcP9g89mrs3myrjB1dKf6F9S4aB58TB8EHzrkqYQT0mbWrrKBf2umSbN
 rIwWfRSn24VQZDDSgDQ==
X-Proofpoint-ORIG-GUID: QB6_hbsIc2IcKPVmywBrC0haDQcBduaG
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a0ed65c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=3zpKOMqohp-RhpYd6ikA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: QB6_hbsIc2IcKPVmywBrC0haDQcBduaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21090-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BFD845A3027
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
index 513e68711962..ae4683e0405d 100644
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


