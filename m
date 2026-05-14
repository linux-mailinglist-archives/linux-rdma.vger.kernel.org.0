Return-Path: <linux-rdma+bounces-20659-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLy5MaZsBWo+WwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20659-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:33:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2051B53E5BA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6794930158AB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691CA3C4161;
	Thu, 14 May 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DKExLctT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33DE3B8950;
	Thu, 14 May 2026 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740042; cv=none; b=DBXEycN2nc8OkcZdBDcvv5rgSUcjQ46XZzgDukUCOQrGXx4Z+NzWpxcldnCq2+iMIr+qc7FPVziB+GwyWy5wVpRLs3WwO9ZdkwclNam0or0E7fQnQ1LGcOwBLzI3+qPR7T/xKupP34O0EESN6Rq+wXdo2xedhJ70Ub5GV0b+pGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740042; c=relaxed/simple;
	bh=hPBNfHhZAFWFaIUmgpa1q+YIblWWmoO5l/5Gvpe/xdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqmSNgki7Y6v6kJYG/A5m8AoHpMw/8aRi+B/rjwndtc4CpCy1mvmC63HFdwbh4jAW/yJyF9eMzecKhvkZ1MFnUccnBXRKWd0SqIR2a0zyoZYs5rD+zQQ+yA192dDjR3GB3lSp6VkDIV6+Hti2sSDJwREOm7u/D01t3w/6lQqwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DKExLctT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E26beV2549046;
	Wed, 13 May 2026 23:26:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	3kH+NSjaaD44YGbq62Y6VJpdYp1juvMaZzfYJvLZLM=; b=DKExLctT3MMpCcRxs
	hdd2TTqI/kXvYBsRhnrncabDdyTEYoSNPtDWTf1bfV47he4enRDMStKfxHBl0VlU
	rQ+veT/ycEH2O4afk1QAHSD9ggsJB9zPs5LffBNmOnE2C/q2qjT1QsIJio5cKkGl
	m7JU5/XeMuoz5dfCb7Wo+Wt/ymXxowv3Hg0xXE/9TGCrlkHI5df2jJ6Xw12AmT8S
	yeHSJQxBVttNGyMfVSkBoPVFMJ/AGyNKgFmUKCoO/T8S8R+PY7r1zR1J0WY1l63d
	jiI8OX66fvJ75wdOSAN3sVklpqWKiY1YLZWWJ6n5vdPhxxkRvhXjASn1rFu3lad5
	PfgNg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e45ybe4b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 23:26:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 23:26:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 23:26:56 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 735BB5B693F;
	Wed, 13 May 2026 23:26:48 -0700 (PDT)
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
Subject: [PATCH v14 net-next 7/9] octeontx2-af: npc: Support for custom KPU profile from filesystem
Date: Thu, 14 May 2026 11:55:35 +0530
Message-ID: <20260514062537.3813802-8-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514062537.3813802-1-rkannoth@marvell.com>
References: <20260514062537.3813802-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yYCMiYHhB3IUXZbtRgy5-2LXLFusuj0r
X-Proofpoint-ORIG-GUID: yYCMiYHhB3IUXZbtRgy5-2LXLFusuj0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2MCBTYWx0ZWRfX4memkmFQNFiU
 NkaLevL3s0iIm6xNlCE0qCYzgIZWQEZKnmvfj7z7+s5bkxJMiO2D+7H9HJh87MZE19H+Nt7odYX
 /+c0XzHBM5ii7AeS40wHN9NaBh3nejU5R8Xt4AemqsD08byyjH7BMcXwKIbTEMtn1OOPkkw4ksI
 /wZ7SjgGDcHrmqdS/f8n0+Fvum2Tk2NspFQeVdkxNGXYSRA2AaIsMGu3yqjXuHlyrZLkEstpfXJ
 X/vj8GxVtFPD0Q3818gJv2d7VVypVxgG54j4xYXA+KajE63+t1ULPA4BhC4lE4sMXliZcnIkTqW
 dybj7VX/gB+8Y0WSKvoVG3C/51LBAwqw4vVeZNLwpaRADD3mIgEvQgqALFYDN5An267JtdZlZAd
 adqQifx5yvsUJV13F4LYMc7NG+7K81cVGq956S7rVwGakWC+ERn974JlUdDpt23UrjgIkooqbci
 wdpkPu/wop80/UQBwKQ==
X-Authority-Analysis: v=2.4 cv=ZtTd7d7G c=1 sm=1 tr=0 ts=6a056b32 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=RqBH2XuCMo2EIviFO1EA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 2051B53E5BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20659-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Flashing updated firmware on deployed devices is cumbersome. Provide a
mechanism to load a custom KPU (Key Parse Unit) profile directly from
the filesystem at module load time.

When the rvu_af module is loaded with the kpu_profile parameter, the
specified profile is read from /lib/firmware/kpu and programmed into
the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
used by filesystem-loaded profiles and support ptype/ptype_mask in
npc_config_kpucam when profile->from_fs is set.

Usage:
  1. Copy the KPU profile file to /lib/firmware/kpu.
  2. Build OCTEONTX2_AF as a module.
  3. Load: insmod rvu_af.ko kpu_profile=<profile_name>

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  57 ++-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  17 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 466 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 6 files changed, 459 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7504d6f1ce16..90194201404a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -521,13 +521,17 @@ npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,
 			       int kpm, int start_entry,
 			       const struct npc_kpu_profile *profile)
 {
+	int num_cam_entries, num_action_entries;
 	int entry, num_entries, max_entries;
 	u64 idx;
 
-	if (profile->cam_entries != profile->action_entries) {
+	num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile);
+	num_action_entries = npc_get_num_kpu_action_entries(rvu, profile);
+
+	if (num_cam_entries != num_action_entries) {
 		dev_err(rvu->dev,
 			"kpm%d: CAM and action entries [%d != %d] not equal\n",
-			kpm, profile->cam_entries, profile->action_entries);
+			kpm, num_cam_entries, num_action_entries);
 
 		WARN(1, "Fatal error\n");
 		return;
@@ -536,16 +540,18 @@ npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,
 	max_entries = rvu->hw->npc_kpu_entries / 2;
 	entry = start_entry;
 	/* Program CAM match entries for previous kpm extracted data */
-	num_entries = min_t(int, profile->cam_entries, max_entries);
+	num_entries = min_t(int, num_cam_entries, max_entries);
 	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
-		npc_config_kpmcam(rvu, blkaddr, &profile->cam[idx],
+		npc_config_kpmcam(rvu, blkaddr,
+				  npc_get_kpu_cam_nth_entry(rvu, profile, idx),
 				  kpm, entry);
 
 	entry = start_entry;
 	/* Program this kpm's actions */
-	num_entries = min_t(int, profile->action_entries, max_entries);
+	num_entries = min_t(int, num_action_entries, max_entries);
 	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
-		npc_config_kpmaction(rvu, blkaddr, &profile->action[idx],
+		npc_config_kpmaction(rvu, blkaddr,
+				     npc_get_kpu_action_nth_entry(rvu, profile, idx),
 				     kpm, entry, false);
 }
 
@@ -611,20 +617,23 @@ npc_enable_kpm_entry(struct rvu *rvu, int blkaddr, int kpm, int num_entries)
 static void npc_program_kpm_profile(struct rvu *rvu, int blkaddr, int num_kpms)
 {
 	const struct npc_kpu_profile *profile1, *profile2;
+	int pfl1_num_cam_entries, pfl2_num_cam_entries;
 	int idx, total_cam_entries;
 
 	for (idx = 0; idx < num_kpms; idx++) {
 		profile1 = &rvu->kpu.kpu[idx];
+		pfl1_num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile1);
 		npc_program_single_kpm_profile(rvu, blkaddr, idx, 0, profile1);
 		profile2 = &rvu->kpu.kpu[idx + KPU_OFFSET];
+		pfl2_num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile2);
+
 		npc_program_single_kpm_profile(rvu, blkaddr, idx,
-					       profile1->cam_entries,
+					       pfl1_num_cam_entries,
 					       profile2);
-		total_cam_entries = profile1->cam_entries +
-			profile2->cam_entries;
+		total_cam_entries = pfl1_num_cam_entries + pfl2_num_cam_entries;
 		npc_enable_kpm_entry(rvu, blkaddr, idx, total_cam_entries);
 		rvu_write64(rvu, blkaddr, NPC_AF_KPMX_PASS2_OFFSET(idx),
-			    profile1->cam_entries);
+			    pfl1_num_cam_entries);
 		/* Enable the KPUs associated with this KPM */
 		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx), 0x01);
 		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx + KPU_OFFSET),
@@ -634,6 +643,7 @@ static void npc_program_kpm_profile(struct rvu *rvu, int blkaddr, int num_kpms)
 
 void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
 {
+	struct npc_kpu_profile_action *act;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int num_pkinds, idx;
 
@@ -665,9 +675,15 @@ void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
 	num_pkinds = rvu->kpu.pkinds;
 	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
 
-	for (idx = 0; idx < num_pkinds; idx++)
-		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
+	/* Cn20k does not support Custom profile from filesystem */
+	for (idx = 0; idx < num_pkinds; idx++) {
+		act = npc_get_ikpu_nth_entry(rvu, idx);
+		if (!act)
+			continue;
+
+		npc_config_kpmaction(rvu, blkaddr, act,
 				     0, idx, true);
+	}
 
 	/* Program KPM CAM and Action profiles */
 	npc_program_kpm_profile(rvu, blkaddr, hw->npc_kpms);
@@ -679,7 +695,7 @@ struct npc_priv_t *npc_priv_get(void)
 }
 
 static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
-				struct npc_mcam_kex_extr *mkex_extr,
+				const struct npc_mcam_kex_extr *mkex_extr,
 				u8 intf)
 {
 	u8 num_extr = rvu->hw->npc_kex_extr;
@@ -708,7 +724,7 @@ static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
 }
 
 static void npc_program_mkex_tx(struct rvu *rvu, int blkaddr,
-				struct npc_mcam_kex_extr *mkex_extr,
+				const struct npc_mcam_kex_extr *mkex_extr,
 				u8 intf)
 {
 	u8 num_extr = rvu->hw->npc_kex_extr;
@@ -737,7 +753,7 @@ static void npc_program_mkex_tx(struct rvu *rvu, int blkaddr,
 }
 
 static void npc_program_mkex_profile(struct rvu *rvu, int blkaddr,
-				     struct npc_mcam_kex_extr *mkex_extr)
+				     const struct npc_mcam_kex_extr *mkex_extr)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u8 intf;
@@ -1630,8 +1646,8 @@ npc_cn20k_update_action_entries_n_flags(struct rvu *rvu,
 int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
 			       struct npc_kpu_profile_adapter *profile)
 {
+	const struct npc_cn20k_kpu_profile_fwdata *fw = rvu->kpu_fwdata;
 	size_t hdr_sz = sizeof(struct npc_cn20k_kpu_profile_fwdata);
-	struct npc_cn20k_kpu_profile_fwdata *fw = rvu->kpu_fwdata;
 	struct npc_kpu_profile_action *action;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_fwdata *fw_kpu;
@@ -1676,8 +1692,15 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
 	}
 
 	/* Verify if profile fits the HW */
+	if (fw->kpus > rvu->hw->npc_kpus) {
+		dev_warn(rvu->dev, "Not enough KPUs: %d > %d\n", fw->kpus,
+			 rvu->hw->npc_kpus);
+		return -EINVAL;
+	}
+
+	/* Check if there is enough memory */
 	if (fw->kpus > profile->kpus) {
-		dev_warn(rvu->dev, "Not enough KPUs: %d > %ld\n", fw->kpus,
+		dev_warn(rvu->dev, "Not enough KPUs: %d > %zu\n", fw->kpus,
 			 profile->kpus);
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index cefc5d70f3e4..c8c0cb68535c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -265,6 +265,19 @@ struct npc_kpu_profile_cam {
 	u16 dp2_mask;
 } __packed;
 
+struct npc_kpu_profile_cam2 {
+	u8 state;
+	u8 state_mask;
+	u16 dp0;
+	u16 dp0_mask;
+	u16 dp1;
+	u16 dp1_mask;
+	u16 dp2;
+	u16 dp2_mask;
+	u8 ptype;
+	u8 ptype_mask;
+} __packed;
+
 struct npc_kpu_profile_action {
 	u8 errlev;
 	u8 errcode;
@@ -290,6 +303,10 @@ struct npc_kpu_profile {
 	int action_entries;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_profile_action *action;
+	int cam_entries2;
+	int action_entries2;
+	struct npc_kpu_profile_action *action2;
+	struct npc_kpu_profile_cam2 *cam2;
 };
 
 /* NPC KPU register formats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a466181cf908..2a2f2287e0c0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -553,17 +553,19 @@ struct npc_kpu_profile_adapter {
 	const char			*name;
 	u64				version;
 	const struct npc_lt_def_cfg	*lt_def;
-	const struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
-	const struct npc_kpu_profile	*kpu; /* array[kpus] */
+	struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
+	struct npc_kpu_profile_action	*ikpu2; /* array[pkinds] */
+	struct npc_kpu_profile	*kpu; /* array[kpus] */
 	union npc_mcam_key_prfl {
-		struct npc_mcam_kex		*mkex;
+		const struct npc_mcam_kex		*mkex;
 					/* used for cn9k and cn10k */
-		struct npc_mcam_kex_extr	*mkex_extr; /* used for cn20k */
+		const struct npc_mcam_kex_extr	*mkex_extr; /* used for cn20k */
 	} mcam_kex_prfl;
 	struct npc_mcam_kex_hash	*mkex_hash;
 	bool				custom;
 	size_t				pkinds;
 	size_t				kpus;
+	bool				from_fs;
 };
 
 #define RVU_SWITCH_LBK_CHAN	63
@@ -634,7 +636,7 @@ struct rvu {
 
 	/* Firmware data */
 	struct rvu_fwdata	*fwdata;
-	void			*kpu_fwdata;
+	const void		*kpu_fwdata;
 	size_t			kpu_fwdata_sz;
 	void __iomem		*kpu_prfl_addr;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index ec5b2d648246..21eb15f38c00 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1495,7 +1495,8 @@ void rvu_npc_free_mcam_entries(struct rvu *rvu, u16 pcifunc, int nixlf)
 }
 
 static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
-				struct npc_mcam_kex *mkex, u8 intf)
+				const struct npc_mcam_kex *mkex,
+				u8 intf)
 {
 	int lid, lt, ld, fl;
 
@@ -1524,7 +1525,8 @@ static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
 }
 
 static void npc_program_mkex_tx(struct rvu *rvu, int blkaddr,
-				struct npc_mcam_kex *mkex, u8 intf)
+				const struct npc_mcam_kex *mkex,
+				u8 intf)
 {
 	int lid, lt, ld, fl;
 
@@ -1553,7 +1555,7 @@ static void npc_program_mkex_tx(struct rvu *rvu, int blkaddr,
 }
 
 static void npc_program_mkex_profile(struct rvu *rvu, int blkaddr,
-				     struct npc_mcam_kex *mkex)
+				     const struct npc_mcam_kex *mkex)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u8 intf;
@@ -1693,8 +1695,12 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
 			      const struct npc_kpu_profile_cam *kpucam,
 			      int kpu, int entry)
 {
+	const struct npc_kpu_profile_cam2 *kpucam2 = (void *)kpucam;
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	struct npc_kpu_cam cam0 = {0};
 	struct npc_kpu_cam cam1 = {0};
+	u64 *val = (u64 *)&cam1;
+	u64 *mask = (u64 *)&cam0;
 
 	cam1.state = kpucam->state & kpucam->state_mask;
 	cam1.dp0_data = kpucam->dp0 & kpucam->dp0_mask;
@@ -1706,6 +1712,14 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
 	cam0.dp1_data = ~kpucam->dp1 & kpucam->dp1_mask;
 	cam0.dp2_data = ~kpucam->dp2 & kpucam->dp2_mask;
 
+	if (profile->from_fs) {
+		u8 ptype = kpucam2->ptype;
+		u8 pmask = kpucam2->ptype_mask;
+
+		*val |= FIELD_PREP(GENMASK_ULL(57, 56), ptype & pmask);
+		*mask |= FIELD_PREP(GENMASK_ULL(57, 56), ~ptype & pmask);
+	}
+
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_KPUX_ENTRYX_CAMX(kpu, entry, 0), *(u64 *)&cam0);
 	rvu_write64(rvu, blkaddr,
@@ -1717,34 +1731,104 @@ u64 npc_enable_mask(int count)
 	return (((count) < 64) ? ~(BIT_ULL(count) - 1) : (0x00ULL));
 }
 
+struct npc_kpu_profile_action *
+npc_get_ikpu_nth_entry(struct rvu *rvu, int n)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return &profile->ikpu2[n];
+
+	return &profile->ikpu[n];
+}
+
+int
+npc_get_num_kpu_cam_entries(struct rvu *rvu,
+			    const struct npc_kpu_profile *kpu_pfl)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return kpu_pfl->cam_entries2;
+
+	return kpu_pfl->cam_entries;
+}
+
+struct npc_kpu_profile_cam *
+npc_get_kpu_cam_nth_entry(struct rvu *rvu,
+			  const struct npc_kpu_profile *kpu_pfl, int n)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return (void *)&kpu_pfl->cam2[n];
+
+	return (void *)&kpu_pfl->cam[n];
+}
+
+int
+npc_get_num_kpu_action_entries(struct rvu *rvu,
+			       const struct npc_kpu_profile *kpu_pfl)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return kpu_pfl->action_entries2;
+
+	return kpu_pfl->action_entries;
+}
+
+struct npc_kpu_profile_action *
+npc_get_kpu_action_nth_entry(struct rvu *rvu,
+			     const struct npc_kpu_profile *kpu_pfl,
+			     int n)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return (void *)&kpu_pfl->action2[n];
+
+	return (void *)&kpu_pfl->action[n];
+}
+
 static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 				    const struct npc_kpu_profile *profile)
 {
+	int num_cam_entries, num_action_entries;
 	int entry, num_entries, max_entries;
 	u64 entry_mask;
 
-	if (profile->cam_entries != profile->action_entries) {
+	num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile);
+	num_action_entries = npc_get_num_kpu_action_entries(rvu, profile);
+
+	if (num_cam_entries != num_action_entries) {
 		dev_err(rvu->dev,
 			"KPU%d: CAM and action entries [%d != %d] not equal\n",
-			kpu, profile->cam_entries, profile->action_entries);
+			kpu, num_cam_entries, num_action_entries);
 	}
 
 	max_entries = rvu->hw->npc_kpu_entries;
 
+	WARN(num_cam_entries > max_entries,
+	     "KPU%u: err: hw max entries=%u, input entries=%u\n",
+	     kpu,  rvu->hw->npc_kpu_entries, num_cam_entries);
+
 	/* Program CAM match entries for previous KPU extracted data */
-	num_entries = min_t(int, profile->cam_entries, max_entries);
+	num_entries = min_t(int, num_cam_entries, max_entries);
 	for (entry = 0; entry < num_entries; entry++)
 		npc_config_kpucam(rvu, blkaddr,
-				  &profile->cam[entry], kpu, entry);
+				  (void *)npc_get_kpu_cam_nth_entry(rvu, profile, entry),
+				  kpu, entry);
 
 	/* Program this KPU's actions */
-	num_entries = min_t(int, profile->action_entries, max_entries);
+	num_entries = min_t(int, num_action_entries, max_entries);
 	for (entry = 0; entry < num_entries; entry++)
-		npc_config_kpuaction(rvu, blkaddr, &profile->action[entry],
+		npc_config_kpuaction(rvu, blkaddr,
+				     (void *)npc_get_kpu_action_nth_entry(rvu, profile, entry),
 				     kpu, entry, false);
 
 	/* Enable all programmed entries */
-	num_entries = min_t(int, profile->action_entries, profile->cam_entries);
+	num_entries = min_t(int, num_action_entries, num_cam_entries);
 	entry_mask = npc_enable_mask(num_entries);
 	/* Disable first KPU_MAX_CST_ENT entries for built-in profile */
 	if (!rvu->kpu.custom)
@@ -1788,26 +1872,175 @@ static void npc_prepare_default_kpu(struct rvu *rvu,
 	npc_cn20k_update_action_entries_n_flags(rvu, profile);
 }
 
-static int npc_apply_custom_kpu(struct rvu *rvu,
-				struct npc_kpu_profile_adapter *profile)
+static int npc_alloc_kpu_cam2_n_action2(struct rvu *rvu, int kpu_num,
+					int num_entries)
+{
+	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
+	struct npc_kpu_profile *kpu;
+
+	kpu = &adapter->kpu[kpu_num];
+
+	kpu->cam2 = devm_kcalloc(rvu->dev, num_entries,
+				 sizeof(*kpu->cam2), GFP_KERNEL);
+	if (!kpu->cam2)
+		return -ENOMEM;
+
+	kpu->action2 = devm_kcalloc(rvu->dev, num_entries,
+				    sizeof(*kpu->action2), GFP_KERNEL);
+	if (!kpu->action2)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int npc_apply_custom_kpu_from_fw(struct rvu *rvu,
+					struct npc_kpu_profile_adapter *profile)
 {
 	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
+	const struct npc_kpu_profile_fwdata *fw;
 	struct npc_kpu_profile_action *action;
-	struct npc_kpu_profile_fwdata *fw;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_fwdata *fw_kpu;
-	int entries;
-	u16 kpu, entry;
+	int entries, entry, kpu;
 
-	if (is_cn20k(rvu->pdev))
-		return npc_cn20k_apply_custom_kpu(rvu, profile);
+	fw = rvu->kpu_fwdata;
+
+	for (kpu = 0; kpu < fw->kpus; kpu++) {
+		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
+			dev_warn(rvu->dev,
+				 "Profile size mismatch on KPU%i parsing\n",
+				 kpu + 1);
+			return -EINVAL;
+		}
+
+		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
+		if (fw_kpu->entries < 0) {
+			dev_warn(rvu->dev,
+				 "Profile entries is negative on KPU%i parsing\n",
+				 kpu + 1);
+			return -EINVAL;
+		}
+
+		if (fw_kpu->entries > KPU_MAX_CST_ENT)
+			dev_warn(rvu->dev,
+				 "Too many custom entries on KPU%d: %d > %d\n",
+				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
+		entries = min_t(int, fw_kpu->entries, KPU_MAX_CST_ENT);
+		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
+		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
+		action = (struct npc_kpu_profile_action *)(fw->data + offset);
+		offset += fw_kpu->entries * sizeof(*action);
+		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
+			dev_warn(rvu->dev,
+				 "Profile size mismatch on KPU%i parsing.\n",
+				 kpu + 1);
+			return -EINVAL;
+		}
+		for (entry = 0; entry < entries; entry++) {
+			profile->kpu[kpu].cam[entry] = cam[entry];
+			profile->kpu[kpu].action[entry] = action[entry];
+		}
+	}
+
+	return 0;
+}
+
+static int npc_apply_custom_kpu_from_fs(struct rvu *rvu,
+					struct npc_kpu_profile_adapter *profile)
+{
+	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
+	const struct npc_kpu_profile_fwdata *fw;
+	struct npc_kpu_profile_action *action;
+	struct npc_kpu_profile_cam2 *cam2;
+	struct npc_kpu_fwdata *fw_kpu;
+	int entries, ret, entry, kpu;
 
 	fw = rvu->kpu_fwdata;
 
+	/* Binary blob contains ikpu actions entries at start of data[0] */
+	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
+				      sizeof(ikpu_action_entries),
+				      GFP_KERNEL);
+	if (!profile->ikpu2)
+		return -ENOMEM;
+
+	action = (struct npc_kpu_profile_action *)(fw->data + offset);
+
+	if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
+		return -EINVAL;
+
+	/* The firmware layout does dependent on the internal size of
+	 * ikpu_action_entries.
+	 */
+	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
+	offset += sizeof(ikpu_action_entries);
+
+	for (kpu = 0; kpu < fw->kpus; kpu++) {
+		if (rvu->kpu_fwdata_sz < hdr_sz + offset + sizeof(*fw_kpu)) {
+			dev_warn(rvu->dev,
+				 "profile size mismatch on kpu%i parsing\n",
+				 kpu + 1);
+			return -EINVAL;
+		}
+
+		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
+		if (fw_kpu->entries <= 0) {
+			dev_warn(rvu->dev,
+				 "Invalid kpu entries on KPU%d\n", kpu);
+			return -EINVAL;
+		}
+
+		entries = min_t(int, fw_kpu->entries, rvu->hw->npc_kpu_entries);
+		dev_info(rvu->dev,
+			 "Loading %u entries on KPU%d\n", entries, kpu);
+
+		cam2 = (struct npc_kpu_profile_cam2 *)fw_kpu->data;
+		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam2);
+		action = (struct npc_kpu_profile_action *)(fw->data + offset);
+		offset += fw_kpu->entries * sizeof(*action);
+		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
+			dev_warn(rvu->dev,
+				 "profile size mismatch on kpu%i parsing.\n",
+				 kpu + 1);
+			return -EINVAL;
+		}
+
+		profile->kpu[kpu].cam_entries2 = entries;
+		profile->kpu[kpu].action_entries2 = entries;
+		ret = npc_alloc_kpu_cam2_n_action2(rvu, kpu, entries);
+		if (ret) {
+			dev_warn(rvu->dev,
+				 "profile entry allocation failed for kpu=%d for %d entries\n",
+				 kpu, entries);
+			return -EINVAL;
+		}
+
+		for (entry = 0; entry < entries; entry++) {
+			profile->kpu[kpu].cam2[entry] = cam2[entry];
+			profile->kpu[kpu].action2[entry] = action[entry];
+		}
+	}
+
+	return 0;
+}
+
+static int npc_apply_custom_kpu(struct rvu *rvu,
+				struct npc_kpu_profile_adapter *profile,
+				bool from_fs, int *fw_kpus)
+{
+	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata);
+	const struct npc_kpu_profile_fwdata *fw;
+	struct npc_kpu_profile_fwdata *sfw;
+
+	if (is_cn20k(rvu->pdev))
+		return npc_cn20k_apply_custom_kpu(rvu, profile);
+
 	if (rvu->kpu_fwdata_sz < hdr_sz) {
 		dev_warn(rvu->dev, "Invalid KPU profile size\n");
 		return -EINVAL;
 	}
+
+	fw = rvu->kpu_fwdata;
 	if (le64_to_cpu(fw->signature) != KPU_SIGN) {
 		dev_warn(rvu->dev, "Invalid KPU profile signature %llx\n",
 			 fw->signature);
@@ -1835,42 +2068,38 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
 		return -EINVAL;
 	}
 	/* Verify if profile fits the HW */
+	if (fw->kpus > rvu->hw->npc_kpus) {
+		dev_warn(rvu->dev, "Not enough KPUs: %d > %d\n", fw->kpus,
+			 rvu->hw->npc_kpus);
+		return -EINVAL;
+	}
+
+	/* Check if there is enough memory for fw loading.
+	 * Check if there is enough entries for profile->kpu[] to
+	 * set cam_entries2 and action_entries2
+	 */
 	if (fw->kpus > profile->kpus) {
-		dev_warn(rvu->dev, "Not enough KPUs: %d > %ld\n", fw->kpus,
+		dev_warn(rvu->dev, "Not enough KPUs: %d > %zu\n", fw->kpus,
 			 profile->kpus);
 		return -EINVAL;
 	}
 
+	*fw_kpus = fw->kpus;
+
+	sfw = devm_kcalloc(rvu->dev, 1, sizeof(*sfw), GFP_KERNEL);
+	if (!sfw)
+		return -ENOMEM;
+
+	memcpy(sfw, fw, sizeof(*sfw));
+
 	profile->custom = 1;
-	profile->name = fw->name;
+	profile->name = sfw->name;
 	profile->version = le64_to_cpu(fw->version);
-	profile->mcam_kex_prfl.mkex = &fw->mkex;
-	profile->lt_def = &fw->lt_def;
-
-	for (kpu = 0; kpu < fw->kpus; kpu++) {
-		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
-		if (fw_kpu->entries > KPU_MAX_CST_ENT)
-			dev_warn(rvu->dev,
-				 "Too many custom entries on KPU%d: %d > %d\n",
-				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
-		entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
-		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
-		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
-		action = (struct npc_kpu_profile_action *)(fw->data + offset);
-		offset += fw_kpu->entries * sizeof(*action);
-		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
-			dev_warn(rvu->dev,
-				 "Profile size mismatch on KPU%i parsing.\n",
-				 kpu + 1);
-			return -EINVAL;
-		}
-		for (entry = 0; entry < entries; entry++) {
-			profile->kpu[kpu].cam[entry] = cam[entry];
-			profile->kpu[kpu].action[entry] = action[entry];
-		}
-	}
+	profile->mcam_kex_prfl.mkex = &sfw->mkex;
+	profile->lt_def = &sfw->lt_def;
 
-	return 0;
+	return from_fs ? npc_apply_custom_kpu_from_fs(rvu, profile) :
+		npc_apply_custom_kpu_from_fw(rvu, profile);
 }
 
 static int npc_load_kpu_prfl_img(struct rvu *rvu, void __iomem *prfl_addr,
@@ -1958,45 +2187,19 @@ static int npc_load_kpu_profile_fwdb(struct rvu *rvu, const char *kpu_profile)
 	return ret;
 }
 
-void npc_load_kpu_profile(struct rvu *rvu)
+static int npc_load_kpu_profile_from_fw(struct rvu *rvu)
 {
 	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	const char *kpu_profile = rvu->kpu_pfl_name;
-	const struct firmware *fw = NULL;
-	bool retry_fwdb = false;
-
-	/* If user not specified profile customization */
-	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))
-		goto revert_to_default;
-	/* First prepare default KPU, then we'll customize top entries. */
-	npc_prepare_default_kpu(rvu, profile);
-
-	/* Order of preceedence for load loading NPC profile (high to low)
-	 * Firmware binary in filesystem.
-	 * Firmware database method.
-	 * Default KPU profile.
-	 */
-	if (!request_firmware_direct(&fw, kpu_profile, rvu->dev)) {
-		dev_info(rvu->dev, "Loading KPU profile from firmware: %s\n",
-			 kpu_profile);
-		rvu->kpu_fwdata = kzalloc(fw->size, GFP_KERNEL);
-		if (rvu->kpu_fwdata) {
-			memcpy(rvu->kpu_fwdata, fw->data, fw->size);
-			rvu->kpu_fwdata_sz = fw->size;
-		}
-		release_firmware(fw);
-		retry_fwdb = true;
-		goto program_kpu;
-	}
+	int fw_kpus = 0;
 
-load_image_fwdb:
 	/* Loading the KPU profile using firmware database */
 	if (npc_load_kpu_profile_fwdb(rvu, kpu_profile))
-		goto revert_to_default;
+		return -EFAULT;
 
-program_kpu:
 	/* Apply profile customization if firmware was loaded. */
-	if (!rvu->kpu_fwdata_sz || npc_apply_custom_kpu(rvu, profile)) {
+	if (!rvu->kpu_fwdata_sz ||
+	    npc_apply_custom_kpu(rvu, profile, false, &fw_kpus)) {
 		/* If image from firmware filesystem fails to load or invalid
 		 * retry with firmware database method.
 		 */
@@ -2010,10 +2213,6 @@ void npc_load_kpu_profile(struct rvu *rvu)
 			}
 			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
-			if (retry_fwdb) {
-				retry_fwdb = false;
-				goto load_image_fwdb;
-			}
 		}
 
 		dev_warn(rvu->dev,
@@ -2021,22 +2220,101 @@ void npc_load_kpu_profile(struct rvu *rvu)
 			 kpu_profile);
 		kfree(rvu->kpu_fwdata);
 		rvu->kpu_fwdata = NULL;
-		goto revert_to_default;
+		return -EFAULT;
 	}
 
-	dev_info(rvu->dev, "Using custom profile '%s', version %d.%d.%d\n",
+	dev_info(rvu->dev, "Using custom profile '%.32s', version %d.%d.%d\n",
 		 profile->name, NPC_KPU_VER_MAJ(profile->version),
 		 NPC_KPU_VER_MIN(profile->version),
 		 NPC_KPU_VER_PATCH(profile->version));
 
-	return;
+	return 0;
+}
+
+static int npc_load_kpu_profile_from_fs(struct rvu *rvu)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+	const char *kpu_profile = rvu->kpu_pfl_name;
+	const struct firmware *fw = NULL;
+	int ret, fw_kpus = 0;
+	char path[512] = "kpu/";
+
+	if (strlen(kpu_profile) > sizeof(path) - strlen("kpu/") - 1) {
+		dev_err(rvu->dev, "kpu profile name is too big\n");
+		return -ENOSPC;
+	}
+
+	strcat(path, kpu_profile);
+
+	if (request_firmware_direct(&fw, path, rvu->dev))
+		return -ENOENT;
+
+	dev_info(rvu->dev, "Loading KPU profile from filesystem: %s\n",
+		 path);
+
+	rvu->kpu_fwdata = fw->data;
+	rvu->kpu_fwdata_sz = fw->size;
+
+	ret = npc_apply_custom_kpu(rvu, profile, true, &fw_kpus);
+	release_firmware(fw);
+	rvu->kpu_fwdata = NULL;
+
+	if (ret) {
+		rvu->kpu_fwdata_sz = 0;
+		dev_err(rvu->dev,
+			"Loading KPU profile from filesystem failed\n");
+		return ret;
+	}
+
+	/* In firmware loading from filesystem method, all entries are from
+	 * same binary blob.
+	 */
+	rvu->kpu.kpus = fw_kpus;
+	profile->kpus = fw_kpus;
+	profile->from_fs = true;
+	return 0;
+}
+
+void npc_load_kpu_profile(struct rvu *rvu)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+	const char *kpu_profile = rvu->kpu_pfl_name;
+
+	profile->from_fs = false;
+
+	npc_prepare_default_kpu(rvu, profile);
+
+	/* If user not specified profile customization */
+	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))
+		return;
+
+	/* Order of preceedence for load loading NPC profile (high to low)
+	 * Firmware binary in filesystem.
+	 * Firmware database method.
+	 * Default KPU profile.
+	 */
+
+	/* Filesystem-based KPU loading is not supported on cn20k.
+	 * npc_prepare_default_kpu() was invoked earlier, but control
+	 * reached this point because the default profile was not selected.
+	 * No need to call it again.
+	 */
+	if (!is_cn20k(rvu->pdev)) {
+		if (!npc_load_kpu_profile_from_fs(rvu))
+			return;
+	}
+
+	/* First prepare default KPU, then we'll customize top entries. */
+	npc_prepare_default_kpu(rvu, profile);
+	if (!npc_load_kpu_profile_from_fw(rvu))
+		return;
 
-revert_to_default:
 	npc_prepare_default_kpu(rvu, profile);
 }
 
 static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 {
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int num_pkinds, num_kpus, idx;
 
@@ -2060,7 +2338,9 @@ static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
 
 	for (idx = 0; idx < num_pkinds; idx++)
-		npc_config_kpuaction(rvu, blkaddr, &rvu->kpu.ikpu[idx], 0, idx, true);
+		npc_config_kpuaction(rvu, blkaddr,
+				     npc_get_ikpu_nth_entry(rvu, idx),
+				     0, idx, true);
 
 	/* Program KPU CAM and Action profiles */
 	num_kpus = rvu->kpu.kpus;
@@ -2068,6 +2348,11 @@ static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 
 	for (idx = 0; idx < num_kpus; idx++)
 		npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
+
+	if (profile->from_fs) {
+		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(54), 0x03);
+		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(58), 0x03);
+	}
 }
 
 void npc_mcam_rsrcs_deinit(struct rvu *rvu)
@@ -2297,18 +2582,21 @@ static void rvu_npc_hw_init(struct rvu *rvu, int blkaddr)
 
 static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 {
-	struct npc_mcam_kex_extr *mkex_extr = rvu->kpu.mcam_kex_prfl.mkex_extr;
-	struct npc_mcam_kex *mkex = rvu->kpu.mcam_kex_prfl.mkex;
+	const struct npc_mcam_kex_extr *mkex_extr;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
+	const struct npc_mcam_kex *mkex;
 	u64 nibble_ena, rx_kex, tx_kex;
 	u64 *keyx_cfg, reg;
 	u8 intf;
 
+	mkex_extr = rvu->kpu.mcam_kex_prfl.mkex_extr;
+	mkex = rvu->kpu.mcam_kex_prfl.mkex;
+
 	if (is_cn20k(rvu->pdev)) {
-		keyx_cfg = mkex_extr->keyx_cfg;
+		keyx_cfg = (u64 *)mkex_extr->keyx_cfg;
 	} else {
-		keyx_cfg = mkex->keyx_cfg;
+		keyx_cfg = (u64 *)mkex->keyx_cfg;
 		/* Reserve last counter for MCAM RX miss action which is set to
 		 * drop packet. This way we will know how many pkts didn't
 		 * match any MCAM entry.
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
index 83c5e32e2afc..662f6693cfe9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
@@ -18,4 +18,21 @@ int npc_fwdb_prfl_img_map(struct rvu *rvu, void __iomem **prfl_img_addr,
 
 void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index);
 void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index);
+
+struct npc_kpu_profile_action *
+npc_get_ikpu_nth_entry(struct rvu *rvu, int n);
+
+int
+npc_get_num_kpu_cam_entries(struct rvu *rvu,
+			    const struct npc_kpu_profile *kpu_pfl);
+struct npc_kpu_profile_cam *
+npc_get_kpu_cam_nth_entry(struct rvu *rvu,
+			  const struct npc_kpu_profile *kpu_pfl, int n);
+
+int
+npc_get_num_kpu_action_entries(struct rvu *rvu,
+			       const struct npc_kpu_profile *kpu_pfl);
+struct npc_kpu_profile_action *
+npc_get_kpu_action_nth_entry(struct rvu *rvu,
+			     const struct npc_kpu_profile *kpu_pfl, int n);
 #endif /* RVU_NPC_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index 62cdc714ba57..ab89b8c6e490 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -596,6 +596,7 @@
 #define NPC_AF_INTFX_KEX_CFG(a)		(0x01010 | (a) << 8)
 #define NPC_AF_PKINDX_ACTION0(a)	(0x80000ull | (a) << 6)
 #define NPC_AF_PKINDX_ACTION1(a)	(0x80008ull | (a) << 6)
+#define NPC_AF_PKINDX_TYPE(a)		(0x80010ull | (a) << 6)
 #define NPC_AF_PKINDX_CPI_DEFX(a, b)	(0x80020ull | (a) << 6 | (b) << 3)
 #define NPC_AF_KPUX_ENTRYX_CAMX(a, b, c) \
 		(0x100000 | (a) << 14 | (b) << 6 | (c) << 3)
-- 
2.43.0


