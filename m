Return-Path: <linux-rdma+bounces-21091-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAb6MBrYDmr2CQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21091-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:02:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E20125A2DAC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C62B83013840
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579137F731;
	Thu, 21 May 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eWZoFtpH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85ED3603D3;
	Thu, 21 May 2026 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357312; cv=none; b=M9edDETmUgDw+PsCepGLqdJ3HXGJ93ad2BJfwjfo6/HT/lbobhC/LDZt+m/+Q6jhWbjZRva3USqlpbB9LvF/9kd+6A6rA7EQ45OjJWPuyuRht3ZxjFDOpwArEHsXDAmELpmJwKbSgV9Kb7qApAq5dnflfmgEO3jJC4BBFxNi4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357312; c=relaxed/simple;
	bh=6qvD156QoM6/NDmEua/epbcYYEFy+Uq6mcvxwSfhCqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgG1zB8ex0u12NBt5Mf9PPRB/gN0jwPBwSojCpVrgeykovCIX9QYBRPDCD5vhHd3GowVEpxZah0qUqgc7jhGYhbx8PHvgdjzvc/qtW+1o82SSRqcTP7iw1qhmc3dr7F1lJx3iBL/z77bFarsebDci0z2lCldtbIavvDOIXzyXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eWZoFtpH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6BjVO091636;
	Thu, 21 May 2026 02:54:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	5lwDq9TA0R32oOg9DLlO9nSXwTUrvfjYI/zVp/0AYI=; b=eWZoFtpHeRn0eXdq5
	ir887VwJ+n8JX0qmpfcNrZ6nnwM/kQIuXmru2rPhRTfs6mP6rerJv+lxZ266epS1
	F+0X0kFOug9ideW9lxkTYcwlBEWIz06FZGCTpvNLcDg+okwOB4VF8nLjtjd+UnLY
	tvvtfZdIm5fqDMSDrdYQXffImallRr0Vq+vz1U3eNDK69IDDyrZG21zC9wERixJ2
	FI6MvPWKT7C6eDcPlegG7PAfib8n80f2fcPUsKJjSTgQhhhMuoWW/BeoT6UHdIao
	91zPvz1g/eNaUdT6+iw3IulEgWxCj/BM6jN0N05E3cKQg9Ut39HIlQOx3tI9JLKK
	LvZrg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e9vjj8grh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:54:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 21 May 2026 02:54:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 21 May 2026 02:54:45 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 587583F7063;
	Thu, 21 May 2026 02:54:36 -0700 (PDT)
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
Subject: [PATCH v16 net-next 9/9] octeontx2-af: npc: cn20k: Allocate npc_priv and dstats dynamically.
Date: Thu, 21 May 2026 15:23:03 +0530
Message-ID: <20260521095303.2395584-10-rkannoth@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=O4kJeh9W c=1 sm=1 tr=0 ts=6a0ed667 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=S7HcfYHk9quoGn6NhDEA:9
 a=jzFzRQuv5CvcdMS1:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: hG-K9B3Vh1WuUXfpujFVSsBWhnwLDauL
X-Proofpoint-GUID: hG-K9B3Vh1WuUXfpujFVSsBWhnwLDauL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5OCBTYWx0ZWRfXxSVycdXhC83p
 /tVXHx4JCyR408zByd2mW3nzIRp8cN7f4MYALmkLs4MmjUWdbY7fgQY4IBm7DjEWoMTI/y94To5
 vYz2I7lQ6rI4DM7j4h1o2qUKGb+IOnOMxlTaVCaXzHsbG+OLtqiIGT9LHuw9ZdPggaq/7ubH3fX
 fv5Rrrw0Tr/KGk1cPnPxsOgt6b533WopooN3o+aDgN4Kj8/Fi7lFC0BPXWgpkoIDKYru/M1vyrv
 dBPF/Zyk6Dzg4Z7aNyq5KGYY7BtwEIKIVpWHq5NcJZQU2Ml5ub4xfZqeBfCBYOGPltTAB2dyd63
 wua6t9O6so0PyRw0LKSD9qWNKj60T5xJAx5ky4XWNTOUXwMbs5wvRixLofHQLLERPMc+PYjqCyv
 yAgowcomNh7fS32zV4X+CXuckd5Y5+Np5+it42pZFJ5f2B03dS0RnfPEmdslmjXKN4vkG3mys98
 jrTC+0lfCExUvlI5HJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21091-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim,npc_priv.sb:url,npc_priv.kw:url];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E20125A2DAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the file-scope static npc_priv with a kcalloc'd struct filled
from hardware bank/subbank geometry at init (num_banks is no longer a
const compile-time constant; drop init_done and use a non-NULL
npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
through the CN20K NPC code paths, extend teardown to kfree the root
struct on failure and in npc_cn20k_deinit, and adjust MCAM section
setup to use the discovered subbank count.

Allocate MCAM debugfs dstats via devm_kzalloc instead of a static matrix,
and use the allocated backing store consistently when computing deltas
(including the counter rollover compare).

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  17 +-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 442 +++++++++---------
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   3 +-
 3 files changed, 240 insertions(+), 222 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 730ef97a57e6..b6fda42e44c7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -176,7 +176,8 @@ static DEFINE_MUTEX(stats_lock);
  * hard limit on all silicon variants, preventing any possibility of
  * out-of-bounds access.
  */
-static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
+static u64 (*dstats)[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS];
+
 static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
 {
 	struct npc_priv_t *npc_priv;
@@ -212,24 +213,24 @@ static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
 					   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(idx, bank));
 			if (!stats)
 				continue;
-			if (stats == dstats[bank][idx])
+			if (stats == dstats[0][bank][idx])
 				continue;
 
-			if (stats < dstats[bank][idx])
-				dstats[bank][idx] = 0;
+			if (stats < dstats[0][bank][idx])
+				dstats[0][bank][idx] = 0;
 
 			pf = 0xFFFF;
 			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
 			if (map)
 				pf = xa_to_value(map);
 
-			delta = stats - dstats[bank][idx];
+			delta = stats - dstats[0][bank][idx];
 
 			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
 				 mcam_idx, pf, delta);
 			seq_puts(s, buff);
 
-			dstats[bank][idx] = stats;
+			dstats[0][bank][idx] = stats;
 		}
 	}
 
@@ -397,6 +398,10 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
 	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
 			    npc_priv, &npc_vidx2idx_map_fops);
 
+	dstats = devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
+	if (!dstats)
+		return -ENOMEM;
+
 	debugfs_create_file("dstats", 0444, rvu->rvu_dbg.npc, rvu,
 			    &npc_mcam_dstats_fops);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index ae4683e0405d..94a766b3ac07 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -16,9 +16,7 @@
 #include "cn20k/reg.h"
 #include "rvu_npc_fs.h"
 
-static struct npc_priv_t npc_priv = {
-	.num_banks = MAX_NUM_BANKS,
-};
+static struct npc_priv_t *npc_priv;
 
 static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 	[NPC_MCAM_KEY_DYN] = "DYNAMIC",
@@ -226,7 +224,7 @@ static u16 npc_idx2vidx(u16 idx)
 	vidx = idx;
 	index = idx;
 
-	map = xa_load(&npc_priv.xa_idx2vidx_map, index);
+	map = xa_load(&npc_priv->xa_idx2vidx_map, index);
 	if (!map)
 		goto done;
 
@@ -242,7 +240,7 @@ static u16 npc_idx2vidx(u16 idx)
 
 static bool npc_is_vidx(u16 vidx)
 {
-	return vidx >= npc_priv.bank_depth * 2;
+	return vidx >= npc_priv->bank_depth * 2;
 }
 
 static u16 npc_vidx2idx(u16 vidx)
@@ -256,7 +254,7 @@ static u16 npc_vidx2idx(u16 vidx)
 	idx = vidx;
 	index = vidx;
 
-	map = xa_load(&npc_priv.xa_vidx2idx_map, index);
+	map = xa_load(&npc_priv->xa_vidx2idx_map, index);
 	if (!map)
 		goto done;
 
@@ -272,7 +270,7 @@ static u16 npc_vidx2idx(u16 vidx)
 
 u16 npc_cn20k_vidx2idx(u16 idx)
 {
-	if (!npc_priv.init_done)
+	if (!npc_priv)
 		return idx;
 
 	if (!npc_is_vidx(idx))
@@ -283,7 +281,7 @@ u16 npc_cn20k_vidx2idx(u16 idx)
 
 u16 npc_cn20k_idx2vidx(u16 idx)
 {
-	if (!npc_priv.init_done)
+	if (!npc_priv)
 		return idx;
 
 	if (npc_is_vidx(idx))
@@ -306,7 +304,7 @@ static int npc_vidx_maps_del_entry(struct rvu *rvu, u16 vidx, u16 *old_midx)
 
 	mcam_idx = npc_vidx2idx(vidx);
 
-	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
+	map = xa_erase(&npc_priv->xa_vidx2idx_map, vidx);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: vidx(%u) does not map to proper mcam idx\n",
@@ -314,7 +312,7 @@ static int npc_vidx_maps_del_entry(struct rvu *rvu, u16 vidx, u16 *old_midx)
 		return -ESRCH;
 	}
 
-	map = xa_erase(&npc_priv.xa_idx2vidx_map, mcam_idx);
+	map = xa_erase(&npc_priv->xa_idx2vidx_map, mcam_idx);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: vidx(%u) is not valid\n",
@@ -341,7 +339,7 @@ static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
 		return -ESRCH;
 	}
 
-	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
+	map = xa_erase(&npc_priv->xa_vidx2idx_map, vidx);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: vidx(%u) could not be deleted from vidx2idx map\n",
@@ -351,7 +349,7 @@ static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
 
 	old_midx = xa_to_value(map);
 
-	rc = xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
+	rc = xa_insert(&npc_priv->xa_vidx2idx_map, vidx,
 		       xa_mk_value(new_midx), GFP_KERNEL);
 	if (rc) {
 		dev_err(rvu->dev,
@@ -360,7 +358,7 @@ static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
 		goto fail1;
 	}
 
-	map = xa_erase(&npc_priv.xa_idx2vidx_map, old_midx);
+	map = xa_erase(&npc_priv->xa_idx2vidx_map, old_midx);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: old_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
@@ -369,7 +367,7 @@ static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
 		goto fail2;
 	}
 
-	rc = xa_insert(&npc_priv.xa_idx2vidx_map, new_midx,
+	rc = xa_insert(&npc_priv->xa_idx2vidx_map, new_midx,
 		       xa_mk_value(vidx), GFP_KERNEL);
 	if (rc) {
 		dev_err(rvu->dev,
@@ -382,21 +380,21 @@ static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
 
 fail3:
 	/* Restore vidx at old_midx location */
-	if (xa_insert(&npc_priv.xa_idx2vidx_map, old_midx,
+	if (xa_insert(&npc_priv->xa_idx2vidx_map, old_midx,
 		      xa_mk_value(vidx), GFP_KERNEL))
 		dev_err(rvu->dev,
 			"%s: Error to roll back idx2vidx old_midx=%u vidx=%u\n",
 			__func__, old_midx, vidx);
 fail2:
 	/* Erase new_midx inserted at vidx */
-	if (!xa_erase(&npc_priv.xa_vidx2idx_map, vidx))
+	if (!xa_erase(&npc_priv->xa_vidx2idx_map, vidx))
 		dev_err(rvu->dev,
 			"%s: Failed to roll back vidx2idx vidx=%u\n",
 			__func__, vidx);
 
 fail1:
 	/* Restore old_midx at vidx location */
-	if (xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
+	if (xa_insert(&npc_priv->xa_vidx2idx_map, vidx,
 		      xa_mk_value(old_midx), GFP_KERNEL))
 		dev_err(rvu->dev,
 			"%s: Failed to roll back vidx2idx to old_midx=%u, vidx=%u\n",
@@ -412,10 +410,10 @@ static int npc_vidx_maps_add_entry(struct rvu *rvu, u16 mcam_idx, int pcifunc,
 	u32 id;
 
 	/* Virtual index start from maximum mcam index + 1 */
-	max = npc_priv.bank_depth * 2 * 2 - 1;
-	min = npc_priv.bank_depth * 2;
+	max = npc_priv->bank_depth * 2 * 2 - 1;
+	min = npc_priv->bank_depth * 2;
 
-	rc = xa_alloc(&npc_priv.xa_vidx2idx_map, &id,
+	rc = xa_alloc(&npc_priv->xa_vidx2idx_map, &id,
 		      xa_mk_value(mcam_idx),
 		      XA_LIMIT(min, max), GFP_KERNEL);
 	if (rc) {
@@ -425,7 +423,7 @@ static int npc_vidx_maps_add_entry(struct rvu *rvu, u16 mcam_idx, int pcifunc,
 		goto fail1;
 	}
 
-	rc = xa_insert(&npc_priv.xa_idx2vidx_map, mcam_idx,
+	rc = xa_insert(&npc_priv->xa_idx2vidx_map, mcam_idx,
 		       xa_mk_value(id), GFP_KERNEL);
 	if (rc) {
 		dev_err(rvu->dev,
@@ -440,7 +438,7 @@ static int npc_vidx_maps_add_entry(struct rvu *rvu, u16 mcam_idx, int pcifunc,
 	return 0;
 
 fail2:
-	xa_erase(&npc_priv.xa_vidx2idx_map, id);
+	xa_erase(&npc_priv->xa_vidx2idx_map, id);
 fail1:
 	return rc;
 }
@@ -691,7 +689,7 @@ void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
 
 struct npc_priv_t *npc_priv_get(void)
 {
-	return &npc_priv;
+	return npc_priv;
 }
 
 static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
@@ -860,9 +858,9 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 
 update_en_map:
 	if (enable)
-		set_bit(index, npc_priv.en_map);
+		set_bit(index, npc_priv->en_map);
 	else
-		clear_bit(index, npc_priv.en_map);
+		clear_bit(index, npc_priv->en_map);
 
 	return 0;
 }
@@ -1751,28 +1749,28 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type)
 	int bank_off, sb_id;
 
 	/* mcam_idx should be less than (2 * bank depth) */
-	if (mcam_idx >= npc_priv.bank_depth * 2) {
+	if (mcam_idx >= npc_priv->bank_depth * 2) {
 		dev_err(rvu->dev, "%s: bad params\n",
 			__func__);
 		return -EINVAL;
 	}
 
 	/* find mcam offset per bank */
-	bank_off = mcam_idx & (npc_priv.bank_depth - 1);
+	bank_off = mcam_idx & (npc_priv->bank_depth - 1);
 
 	/* Find subbank id */
-	sb_id = bank_off / npc_priv.subbank_depth;
+	sb_id = bank_off / npc_priv->subbank_depth;
 
 	/* Check if subbank id is more than maximum
 	 * number of subbanks available
 	 */
-	if (sb_id >= npc_priv.num_subbanks) {
+	if (sb_id >= npc_priv->num_subbanks) {
 		dev_err(rvu->dev, "%s: invalid subbank %d\n",
 			__func__, sb_id);
 		return -EINVAL;
 	}
 
-	sb = &npc_priv.sb[sb_id];
+	sb = &npc_priv->sb[sb_id];
 
 	*key_type = sb->key_type;
 
@@ -1788,7 +1786,7 @@ static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
 	 * subsection depth - 1
 	 */
 	if (sb->key_type == NPC_MCAM_KEY_X4 &&
-	    sub_off >= npc_priv.subbank_depth) {
+	    sub_off >= npc_priv->subbank_depth) {
 		dev_err(rvu->dev,
 			"%s: Failed to get mcam idx (x4) sb->idx=%u sub_off=%u",
 			__func__, sb->idx, sub_off);
@@ -1799,7 +1797,7 @@ static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
 	 * 2 * subsection depth - 1
 	 */
 	if (sb->key_type == NPC_MCAM_KEY_X2 &&
-	    sub_off >= npc_priv.subbank_depth * 2) {
+	    sub_off >= npc_priv->subbank_depth * 2) {
 		dev_err(rvu->dev,
 			"%s: Failed to get mcam idx (x2) sb->idx=%u sub_off=%u",
 			__func__, sb->idx, sub_off);
@@ -1807,12 +1805,12 @@ static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
 	}
 
 	/* Find subbank offset from respective subbank (w.r.t bank) */
-	off = sub_off & (npc_priv.subbank_depth - 1);
+	off = sub_off & (npc_priv->subbank_depth - 1);
 
 	/* if subsection idx is in bank1, add bank depth,
 	 * which is part of sb->b1b
 	 */
-	bot = sub_off >= npc_priv.subbank_depth ? sb->b1b : sb->b0b;
+	bot = sub_off >= npc_priv->subbank_depth ? sb->b1b : sb->b0b;
 
 	*mcam_idx = bot + off;
 	return 0;
@@ -1825,37 +1823,37 @@ int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
 	int bank_off, sb_id;
 
 	/* mcam_idx should be less than (2 * bank depth) */
-	if (mcam_idx >= npc_priv.bank_depth * 2) {
+	if (mcam_idx >= npc_priv->bank_depth * 2) {
 		dev_err(rvu->dev, "%s: Invalid mcam idx %u\n",
 			__func__, mcam_idx);
 		return -EINVAL;
 	}
 
 	/* find mcam offset per bank */
-	bank_off = mcam_idx & (npc_priv.bank_depth - 1);
+	bank_off = mcam_idx & (npc_priv->bank_depth - 1);
 
 	/* Find subbank id */
-	sb_id = bank_off / npc_priv.subbank_depth;
+	sb_id = bank_off / npc_priv->subbank_depth;
 
 	/* Check if subbank id is more than maximum
 	 * number of subbanks available
 	 */
-	if (sb_id >= npc_priv.num_subbanks) {
+	if (sb_id >= npc_priv->num_subbanks) {
 		dev_err(rvu->dev, "%s: invalid subbank %d\n",
 			__func__, sb_id);
 		return -EINVAL;
 	}
 
-	*sb = &npc_priv.sb[sb_id];
+	*sb = &npc_priv->sb[sb_id];
 
 	/* Subbank offset per bank */
-	*sb_off = bank_off % npc_priv.subbank_depth;
+	*sb_off = bank_off % npc_priv->subbank_depth;
 
 	/* Index in a subbank should add subbank depth
 	 * if it is in bank1
 	 */
-	if (mcam_idx >= npc_priv.bank_depth)
-		*sb_off += npc_priv.subbank_depth;
+	if (mcam_idx >= npc_priv->bank_depth)
+		*sb_off += npc_priv->subbank_depth;
 
 	return 0;
 }
@@ -1871,9 +1869,9 @@ static int __npc_subbank_contig_alloc(struct rvu *rvu,
 	int k, offset, delta = 0;
 	int cnt = 0, sbd;
 
-	sbd = npc_priv.subbank_depth;
+	sbd = npc_priv->subbank_depth;
 
-	if (sidx >= npc_priv.bank_depth)
+	if (sidx >= npc_priv->bank_depth)
 		delta = sbd;
 
 	switch (prio) {
@@ -1940,8 +1938,8 @@ static int __npc_subbank_non_contig_alloc(struct rvu *rvu,
 	int cnt = 0, delta;
 	int k, sbd;
 
-	sbd = npc_priv.subbank_depth;
-	delta = sidx >= npc_priv.bank_depth ? sbd : 0;
+	sbd = npc_priv->subbank_depth;
+	delta = sidx >= npc_priv->bank_depth ? sbd : 0;
 
 	switch (prio) {
 		/* Find an area of size 'count' from sidx to eidx */
@@ -2002,7 +2000,7 @@ static void __npc_subbank_sboff_2_off(struct rvu *rvu, struct npc_subbank *sb,
 {
 	int sbd;
 
-	sbd = npc_priv.subbank_depth;
+	sbd = npc_priv->subbank_depth;
 
 	*off = sb_off & (sbd - 1);
 	*bmap = (sb_off >= sbd) ? sb->b1map : sb->b0map;
@@ -2051,20 +2049,20 @@ static int __npc_subbank_mark_free(struct rvu *rvu, struct npc_subbank *sb)
 	sb->flags = NPC_SUBBANK_FLAG_FREE;
 	sb->key_type = 0;
 
-	bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
-	bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
+	bitmap_clear(sb->b0map, 0, npc_priv->subbank_depth);
+	bitmap_clear(sb->b1map, 0, npc_priv->subbank_depth);
 
-	if (!xa_erase(&npc_priv.xa_sb_used, sb->arr_idx)) {
+	if (!xa_erase(&npc_priv->xa_sb_used, sb->arr_idx)) {
 		dev_err(rvu->dev,
 			"%s: Error to delete from xa_sb_used array\n",
 			__func__);
 		return -EFAULT;
 	}
 
-	rc = xa_insert(&npc_priv.xa_sb_free, sb->arr_idx,
+	rc = xa_insert(&npc_priv->xa_sb_free, sb->arr_idx,
 		       xa_mk_value(sb->idx), GFP_KERNEL);
 	if (rc) {
-		rc = xa_insert(&npc_priv.xa_sb_used, sb->arr_idx,
+		rc = xa_insert(&npc_priv->xa_sb_used, sb->arr_idx,
 			       xa_mk_value(sb->idx), GFP_KERNEL);
 		if (rc)
 			dev_err(rvu->dev,
@@ -2093,21 +2091,21 @@ static int __npc_subbank_mark_used(struct rvu *rvu, struct npc_subbank *sb,
 	sb->flags = NPC_SUBBANK_FLAG_USED;
 	sb->key_type = key_type;
 	if (key_type == NPC_MCAM_KEY_X4)
-		sb->free_cnt = npc_priv.subbank_depth;
+		sb->free_cnt = npc_priv->subbank_depth;
 	else
-		sb->free_cnt = 2 * npc_priv.subbank_depth;
+		sb->free_cnt = 2 * npc_priv->subbank_depth;
 
-	bitmap_clear(sb->b0map, 0, npc_priv.subbank_depth);
-	bitmap_clear(sb->b1map, 0, npc_priv.subbank_depth);
+	bitmap_clear(sb->b0map, 0, npc_priv->subbank_depth);
+	bitmap_clear(sb->b1map, 0, npc_priv->subbank_depth);
 
-	if (!xa_erase(&npc_priv.xa_sb_free, sb->arr_idx)) {
+	if (!xa_erase(&npc_priv->xa_sb_free, sb->arr_idx)) {
 		dev_err(rvu->dev,
 			"%s: Error to delete from xa_sb_free array\n",
 			__func__);
 		return -EFAULT;
 	}
 
-	rc = xa_insert(&npc_priv.xa_sb_used, sb->arr_idx,
+	rc = xa_insert(&npc_priv->xa_sb_used, sb->arr_idx,
 		       xa_mk_value(sb->idx), GFP_KERNEL);
 	if (rc)
 		dev_err(rvu->dev,
@@ -2131,10 +2129,10 @@ static bool __npc_subbank_free(struct rvu *rvu, struct npc_subbank *sb,
 
 	/* Check whether we can mark whole subbank as free */
 	if (sb->key_type == NPC_MCAM_KEY_X4) {
-		if (sb->free_cnt < npc_priv.subbank_depth)
+		if (sb->free_cnt < npc_priv->subbank_depth)
 			goto done;
 	} else {
-		if (sb->free_cnt < 2 * npc_priv.subbank_depth)
+		if (sb->free_cnt < 2 * npc_priv->subbank_depth)
 			goto done;
 	}
 
@@ -2213,7 +2211,7 @@ static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
 
 	/* x4 indexes are from 0 to bank size as it combines two x2 banks */
 	if (key_type == NPC_MCAM_KEY_X4 &&
-	    (ref >= npc_priv.bank_depth || limit >= npc_priv.bank_depth)) {
+	    (ref >= npc_priv->bank_depth || limit >= npc_priv->bank_depth)) {
 		dev_err(rvu->dev,
 			"%s: Wrong ref_enty(%d) or limit(%d) for x4\n",
 			__func__, ref, limit);
@@ -2223,8 +2221,8 @@ static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
 	/* This function is called either bank0 or bank1 portion of a subbank.
 	 * so ref and limit should be on same bank.
 	 */
-	diffbank = !!((ref & npc_priv.bank_depth) ^
-		      (limit & npc_priv.bank_depth));
+	diffbank = !!((ref & npc_priv->bank_depth) ^
+		      (limit & npc_priv->bank_depth));
 	if (diffbank) {
 		dev_err(rvu->dev,
 			"%s: request ref and limit should be from same bank\n",
@@ -2248,7 +2246,7 @@ static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
 	 * or equal to mcam entries available in the subbank if contig.
 	 */
 	if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
-		if (contig && count > npc_priv.subbank_depth) {
+		if (contig && count > npc_priv->subbank_depth) {
 			dev_err(rvu->dev, "%s: Less number of entries\n",
 				__func__);
 			return -ENOSPC;
@@ -2271,10 +2269,10 @@ static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
 	}
 
 process:
-	/* if ref or limit >= npc_priv.bank_depth, index are in bank1.
+	/* if ref or limit >= npc_priv->bank_depth, index are in bank1.
 	 * else bank0.
 	 */
-	if (ref >= npc_priv.bank_depth) {
+	if (ref >= npc_priv->bank_depth) {
 		bmap = sb->b1map;
 		t = sb->b1t;
 		b = sb->b1b;
@@ -2285,8 +2283,8 @@ static int __npc_subbank_alloc(struct rvu *rvu, struct npc_subbank *sb,
 	}
 
 	/* Calculate free slots */
-	bw = bitmap_weight(bmap, npc_priv.subbank_depth);
-	bfree = npc_priv.subbank_depth - bw;
+	bw = bitmap_weight(bmap, npc_priv->subbank_depth);
+	bfree = npc_priv->subbank_depth - bw;
 
 	if (!bfree) {
 		dev_dbg(rvu->dev, "%s: subbank is full\n", __func__);
@@ -2415,7 +2413,7 @@ npc_del_from_pf_maps(struct rvu *rvu, u16 mcam_idx)
 	int pcifunc, idx;
 	void *map;
 
-	map = xa_erase(&npc_priv.xa_idx2pf_map, mcam_idx);
+	map = xa_erase(&npc_priv->xa_idx2pf_map, mcam_idx);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: failed to erase mcam_idx(%u) from xa_idx2pf map\n",
@@ -2424,7 +2422,7 @@ npc_del_from_pf_maps(struct rvu *rvu, u16 mcam_idx)
 	}
 
 	pcifunc = xa_to_value(map);
-	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
+	map = xa_load(&npc_priv->xa_pf_map, pcifunc);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: failed to find entry for (%u) from xa_pf_map, mcam=%u\n",
@@ -2434,7 +2432,7 @@ npc_del_from_pf_maps(struct rvu *rvu, u16 mcam_idx)
 
 	idx = xa_to_value(map);
 
-	map = xa_erase(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
+	map = xa_erase(&npc_priv->xa_pf2idx_map[idx], mcam_idx);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: failed to erase mcam_idx(%u) from xa_pf2idx_map map\n",
@@ -2454,18 +2452,18 @@ npc_add_to_pf_maps(struct rvu *rvu, u16 mcam_idx, int pcifunc)
 		"%s: add2maps mcam_idx(%u) to xa_idx2pf map pcifunc=%#x\n",
 		__func__, mcam_idx, pcifunc);
 
-	rc = xa_insert(&npc_priv.xa_idx2pf_map, mcam_idx,
+	rc = xa_insert(&npc_priv->xa_idx2pf_map, mcam_idx,
 		       xa_mk_value(pcifunc), GFP_KERNEL);
 
 	if (rc) {
-		map = xa_load(&npc_priv.xa_idx2pf_map, mcam_idx);
+		map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
 		dev_err(rvu->dev,
 			"%s: failed to insert mcam_idx(%u) to xa_idx2pf map, existing value=%lu\n",
 			__func__, mcam_idx, xa_to_value(map));
 		return -EFAULT;
 	}
 
-	map = xa_load(&npc_priv.xa_pf_map, pcifunc);
+	map = xa_load(&npc_priv->xa_pf_map, pcifunc);
 	if (!map) {
 		dev_err(rvu->dev,
 			"%s: failed to find pf map entry for pcifunc=%#x, mcam=%u\n",
@@ -2475,12 +2473,12 @@ npc_add_to_pf_maps(struct rvu *rvu, u16 mcam_idx, int pcifunc)
 
 	idx = xa_to_value(map);
 
-	rc = xa_insert(&npc_priv.xa_pf2idx_map[idx], mcam_idx,
+	rc = xa_insert(&npc_priv->xa_pf2idx_map[idx], mcam_idx,
 		       xa_mk_value(pcifunc), GFP_KERNEL);
 
 	if (rc) {
-		map = xa_load(&npc_priv.xa_pf2idx_map[idx], mcam_idx);
-		xa_erase(&npc_priv.xa_idx2pf_map, mcam_idx);
+		map = xa_load(&npc_priv->xa_pf2idx_map[idx], mcam_idx);
+		xa_erase(&npc_priv->xa_idx2pf_map, mcam_idx);
 		dev_err(rvu->dev,
 			"%s: failed to insert mcam_idx(%u) to xa_pf2idx_map map, earlier value=%lu idx=%u\n",
 			__func__, mcam_idx, xa_to_value(map), idx);
@@ -2510,9 +2508,9 @@ npc_subbank_suits(struct npc_subbank *sb, int key_type)
 	return false;
 }
 
-#define SB_ALIGN_UP(val)   (((val) + npc_priv.subbank_depth) & \
-			    ~((npc_priv.subbank_depth) - 1))
-#define SB_ALIGN_DOWN(val) ALIGN_DOWN((val), npc_priv.subbank_depth)
+#define SB_ALIGN_UP(val)   (((val) + npc_priv->subbank_depth) & \
+			    ~((npc_priv->subbank_depth) - 1))
+#define SB_ALIGN_DOWN(val) ALIGN_DOWN((val), npc_priv->subbank_depth)
 
 static void npc_subbank_iter_down(struct rvu *rvu,
 				  int ref, int limit,
@@ -2538,7 +2536,7 @@ static void npc_subbank_iter_down(struct rvu *rvu,
 	}
 
 	*cur_ref = *cur_limit - 1;
-	align = *cur_ref - npc_priv.subbank_depth + 1;
+	align = *cur_ref - npc_priv->subbank_depth + 1;
 	if (align <= limit) {
 		*stop = true;
 		*cur_limit = limit;
@@ -2578,7 +2576,7 @@ static void npc_subbank_iter_up(struct rvu *rvu,
 	}
 
 	*cur_ref = *cur_limit + 1;
-	align = *cur_ref + npc_priv.subbank_depth - 1;
+	align = *cur_ref + npc_priv->subbank_depth - 1;
 
 	if (align >= limit) {
 		*stop = true;
@@ -2606,17 +2604,17 @@ npc_subbank_iter(struct rvu *rvu, int key_type,
 
 	/* limit and ref should < bank_depth for x4 */
 	if (key_type == NPC_MCAM_KEY_X4) {
-		if (*cur_ref >= npc_priv.bank_depth)
+		if (*cur_ref >= npc_priv->bank_depth)
 			return -EINVAL;
 
-		if (*cur_limit >= npc_priv.bank_depth)
+		if (*cur_limit >= npc_priv->bank_depth)
 			return -EINVAL;
 	}
 	/* limit and ref should < 2 * bank_depth, for x2 */
-	if (*cur_ref >= 2 * npc_priv.bank_depth)
+	if (*cur_ref >= 2 * npc_priv->bank_depth)
 		return -EINVAL;
 
-	if (*cur_limit >= 2 * npc_priv.bank_depth)
+	if (*cur_limit >= 2 * npc_priv->bank_depth)
 		return -EINVAL;
 
 	return 0;
@@ -2651,7 +2649,7 @@ static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
 			vidx = npc_idx2vidx(midx);
 		}
 
-		if (midx >= npc_priv.bank_depth * npc_priv.num_banks) {
+		if (midx >= npc_priv->bank_depth * npc_priv->num_banks) {
 			dev_err(rvu->dev,
 				"%s: Invalid mcam_idx=%u cannot be deleted\n",
 				__func__, mcam_idx[i]);
@@ -2846,7 +2844,7 @@ static int npc_subbank_free_cnt(struct rvu *rvu, struct npc_subbank *sb,
 {
 	int cnt, spd;
 
-	spd = npc_priv.subbank_depth;
+	spd = npc_priv->subbank_depth;
 	mutex_lock(&sb->lock);
 
 	if (sb->flags & NPC_SUBBANK_FLAG_FREE)
@@ -3005,7 +3003,7 @@ static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool contig,
 	max_alloc = !contig;
 
 	/* Check used subbanks for free slots */
-	xa_for_each(&npc_priv.xa_sb_used, index, val) {
+	xa_for_each(&npc_priv->xa_sb_used, index, val) {
 		idx = xa_to_value(val);
 
 		/* Minimize allocation from restricted subbanks
@@ -3014,7 +3012,7 @@ static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool contig,
 		if (npc_subbank_restrict_usage(rvu, idx))
 			continue;
 
-		sb = &npc_priv.sb[idx];
+		sb = &npc_priv->sb[idx];
 
 		/* Skip if not suitable subbank */
 		if (!npc_subbank_suits(sb, key_type))
@@ -3071,9 +3069,9 @@ static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool contig,
 	}
 
 	/* Allocate in free subbanks */
-	xa_for_each(&npc_priv.xa_sb_free, index, val) {
+	xa_for_each(&npc_priv->xa_sb_free, index, val) {
 		idx = xa_to_value(val);
-		sb = &npc_priv.sb[idx];
+		sb = &npc_priv->sb[idx];
 
 		/* Minimize allocation from restricted subbanks
 		 * in noref allocations.
@@ -3129,7 +3127,7 @@ static int npc_subbank_noref_alloc(struct rvu *rvu, int key_type, bool contig,
 	for (i = 0; restrict_valid &&
 	     (i < ARRAY_SIZE(npc_subbank_restricted_idxs)); i++) {
 		idx = npc_subbank_restricted_idxs[i];
-		sb = &npc_priv.sb[idx];
+		sb = &npc_priv->sb[idx];
 
 		/* Skip if not suitable subbank */
 		if (!npc_subbank_suits(sb, key_type))
@@ -3209,7 +3207,7 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 	bool ref_valid;
 	u16 vidx;
 
-	bd = npc_priv.bank_depth;
+	bd = npc_priv->bank_depth;
 
 	/* Special case: ref == 0 && limit= 0 && prio == HIGH && count == 1
 	 * Here user wants to allocate 0th entry
@@ -3227,7 +3225,7 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 	ref_valid = !!(limit || ref);
 	defrag_candidate = !ref_valid && !contig && virt;
 	if (!ref_valid) {
-		if (contig && count > npc_priv.subbank_depth)
+		if (contig && count > npc_priv->subbank_depth)
 			goto try_noref_multi_subbank;
 
 		rc = npc_subbank_noref_alloc(rvu, key_type, contig,
@@ -3272,7 +3270,7 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 		return -EINVAL;
 	}
 
-	if (contig && count > npc_priv.subbank_depth)
+	if (contig && count > npc_priv->subbank_depth)
 		goto try_ref_multi_subbank;
 
 	rc = npc_subbank_ref_alloc(rvu, key_type, ref, limit,
@@ -3334,8 +3332,8 @@ void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
 	*x4_free = 0;
 	*sb_free = 0;
 
-	for (i = 0; i < npc_priv.num_subbanks; i++) {
-		sb = &npc_priv.sb[i];
+	for (i = 0; i < npc_priv->num_subbanks; i++) {
+		sb = &npc_priv->sb[i];
 		mutex_lock(&sb->lock);
 
 		/* Count number of free subbanks */
@@ -3433,11 +3431,11 @@ static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
 {
 	mutex_init(&sb->lock);
 
-	sb->b0b = idx * npc_priv.subbank_depth;
-	sb->b0t = sb->b0b + npc_priv.subbank_depth - 1;
+	sb->b0b = idx * npc_priv->subbank_depth;
+	sb->b0t = sb->b0b + npc_priv->subbank_depth - 1;
 
-	sb->b1b = npc_priv.bank_depth + idx * npc_priv.subbank_depth;
-	sb->b1t = sb->b1b + npc_priv.subbank_depth - 1;
+	sb->b1b = npc_priv->bank_depth + idx * npc_priv->subbank_depth;
+	sb->b1t = sb->b1b + npc_priv->subbank_depth - 1;
 
 	sb->flags = NPC_SUBBANK_FLAG_FREE;
 	sb->idx = idx;
@@ -3449,7 +3447,7 @@ static void npc_subbank_init(struct rvu *rvu, struct npc_subbank *sb, int idx)
 	/* Keep first and last subbank at end of free array; so that
 	 * it will be used at last
 	 */
-	xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
+	xa_store(&npc_priv->xa_sb_free, sb->arr_idx,
 		 xa_mk_value(sb->idx), GFP_KERNEL);
 }
 
@@ -3474,7 +3472,7 @@ static int npc_pcifunc_map_create(struct rvu *rvu)
 
 		pcifunc = pf << 9;
 
-		xa_store(&npc_priv.xa_pf_map, (unsigned long)pcifunc,
+		xa_store(&npc_priv->xa_pf_map, (unsigned long)pcifunc,
 			 xa_mk_value(cnt), GFP_KERNEL);
 
 		cnt++;
@@ -3483,7 +3481,7 @@ static int npc_pcifunc_map_create(struct rvu *rvu)
 		for (vf = 0; vf < numvfs; vf++) {
 			pcifunc = (pf << 9) | (vf + 1);
 
-			xa_store(&npc_priv.xa_pf_map, (unsigned long)pcifunc,
+			xa_store(&npc_priv->xa_pf_map, (unsigned long)pcifunc,
 				 xa_mk_value(cnt), GFP_KERNEL);
 			cnt++;
 		}
@@ -3569,7 +3567,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
 	int rc, sb_off, i, err;
 	bool deleted;
 
-	sb = &npc_priv.sb[f->idx];
+	sb = &npc_priv->sb[f->idx];
 
 	alloc_cnt1 = 0;
 	alloc_cnt2 = 0;
@@ -3639,9 +3637,9 @@ static int npc_defrag_add_2_show_list(struct rvu *rvu, u16 old_midx,
 	node->vidx = vidx;
 	INIT_LIST_HEAD(&node->list);
 
-	mutex_lock(&npc_priv.lock);
-	list_add_tail(&node->list, &npc_priv.defrag_lh);
-	mutex_unlock(&npc_priv.lock);
+	mutex_lock(&npc_priv->lock);
+	list_add_tail(&node->list, &npc_priv->defrag_lh);
+	mutex_unlock(&npc_priv->lock);
 
 	return 0;
 }
@@ -3745,7 +3743,7 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 		}
 
 		/* save pcifunc */
-		map = xa_load(&npc_priv.xa_idx2pf_map, old_midx);
+		map = xa_load(&npc_priv->xa_idx2pf_map, old_midx);
 		pcifunc = xa_to_value(map);
 
 		/* delete from pf maps */
@@ -3904,29 +3902,29 @@ static void npc_defrag_list_clear(void)
 {
 	struct npc_defrag_show_node *node, *next;
 
-	mutex_lock(&npc_priv.lock);
-	list_for_each_entry_safe(node, next, &npc_priv.defrag_lh, list) {
+	mutex_lock(&npc_priv->lock);
+	list_for_each_entry_safe(node, next, &npc_priv->defrag_lh, list) {
 		list_del_init(&node->list);
 		kfree(node);
 	}
 
-	mutex_unlock(&npc_priv.lock);
+	mutex_unlock(&npc_priv->lock);
 }
 
 static void npc_lock_all_subbank(void)
 {
 	int i;
 
-	for (i = 0; i < npc_priv.num_subbanks; i++)
-		mutex_lock(&npc_priv.sb[i].lock);
+	for (i = 0; i < npc_priv->num_subbanks; i++)
+		mutex_lock(&npc_priv->sb[i].lock);
 }
 
 static void npc_unlock_all_subbank(void)
 {
 	int i;
 
-	for (i = npc_priv.num_subbanks - 1; i >= 0; i--)
-		mutex_unlock(&npc_priv.sb[i].lock);
+	for (i = npc_priv->num_subbanks - 1; i >= 0; i--)
+		mutex_unlock(&npc_priv->sb[i].lock);
 }
 
 int npc_cn20k_search_order_set(struct rvu *rvu,
@@ -3944,9 +3942,9 @@ int npc_cn20k_search_order_set(struct rvu *rvu,
 		USED = 1,
 	};
 
-	if (cnt != npc_priv.num_subbanks) {
+	if (cnt != npc_priv->num_subbanks) {
 		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
-			cnt, npc_priv.num_subbanks);
+			cnt, npc_priv->num_subbanks);
 		return -EINVAL;
 	}
 
@@ -3954,18 +3952,18 @@ int npc_cn20k_search_order_set(struct rvu *rvu,
 	npc_lock_all_subbank();
 
 	for (sb_idx = 0; sb_idx < cnt; sb_idx++) {
-		sb = &npc_priv.sb[sb_idx];
+		sb = &npc_priv->sb[sb_idx];
 		save[sb->idx] = sb->arr_idx;
 	}
 
 	for (prio = 0; prio < cnt; prio++) {
 		sb_idx = narr[prio];
-		sb = &npc_priv.sb[sb_idx];
+		sb = &npc_priv->sb[sb_idx];
 
 		if (sb->flags & NPC_SUBBANK_FLAG_USED)
-			xa = &npc_priv.xa_sb_used;
+			xa = &npc_priv->xa_sb_used;
 		else
-			xa = &npc_priv.xa_sb_free;
+			xa = &npc_priv->xa_sb_free;
 
 		rc = xa_err(xa_store(xa, prio,
 				     xa_mk_value(sb_idx), GFP_KERNEL));
@@ -3989,10 +3987,10 @@ int npc_cn20k_search_order_set(struct rvu *rvu,
 
 	for (prio = 0; prio < cnt; prio++) {
 		if (rsrc[FREE][prio] == -1)
-			xa_erase(&npc_priv.xa_sb_free, prio);
+			xa_erase(&npc_priv->xa_sb_free, prio);
 
 		if (rsrc[USED][prio] == -1)
-			xa_erase(&npc_priv.xa_sb_used, prio);
+			xa_erase(&npc_priv->xa_sb_used, prio);
 	}
 
 	for (int i = 0; i < cnt; i++)
@@ -4008,20 +4006,20 @@ int npc_cn20k_search_order_set(struct rvu *rvu,
 fail:
 	for (prio = 0; prio < cnt; prio++) {
 		if (rsrc[FREE][prio] == 1)
-			xa_erase(&npc_priv.xa_sb_free, prio);
+			xa_erase(&npc_priv->xa_sb_free, prio);
 
 		if (rsrc[USED][prio] == 1)
-			xa_erase(&npc_priv.xa_sb_used, prio);
+			xa_erase(&npc_priv->xa_sb_used, prio);
 	}
 
 	for (sb_idx = 0; sb_idx < cnt; sb_idx++) {
-		sb = &npc_priv.sb[sb_idx];
+		sb = &npc_priv->sb[sb_idx];
 		sb->arr_idx = save[sb_idx];
 
 		if (sb->flags & NPC_SUBBANK_FLAG_USED)
-			xa = &npc_priv.xa_sb_used;
+			xa = &npc_priv->xa_sb_used;
 		else
-			xa = &npc_priv.xa_sb_free;
+			xa = &npc_priv->xa_sb_free;
 
 		/* Since the entry already exists, xa_store() replaces
 		 * the value without a kmalloc(), making failure highly unlikely.
@@ -4041,7 +4039,7 @@ int npc_cn20k_search_order_set(struct rvu *rvu,
 const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz)
 {
 	*restricted_order = restrict_valid;
-	*sz = npc_priv.num_subbanks;
+	*sz = npc_priv->num_subbanks;
 	return subbank_srch_order;
 }
 
@@ -4065,7 +4063,7 @@ int npc_cn20k_defrag(struct rvu *rvu)
 	INIT_LIST_HEAD(&x4lh);
 	INIT_LIST_HEAD(&x2lh);
 
-	node = kcalloc(npc_priv.num_subbanks, sizeof(*node), GFP_KERNEL);
+	node = kcalloc(npc_priv->num_subbanks, sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 
@@ -4074,13 +4072,13 @@ int npc_cn20k_defrag(struct rvu *rvu)
 	npc_lock_all_subbank();
 
 	/* Fill in node with subbank properties */
-	for (i = 0; i < npc_priv.num_subbanks; i++) {
-		sb = &npc_priv.sb[i];
+	for (i = 0; i < npc_priv->num_subbanks; i++) {
+		sb = &npc_priv->sb[i];
 
 		node[i].idx = i;
 		node[i].key_type = sb->key_type;
 		node[i].free_cnt = sb->free_cnt;
-		node[i].vidx = kcalloc(npc_priv.subbank_depth * 2,
+		node[i].vidx = kcalloc(npc_priv->subbank_depth * 2,
 				       sizeof(*node[i].vidx),
 				       GFP_KERNEL);
 		if (!node[i].vidx) {
@@ -4110,8 +4108,8 @@ int npc_cn20k_defrag(struct rvu *rvu)
 	}
 
 	/* Filling vidx[] array with all vidx in that subbank */
-	xa_for_each_start(&npc_priv.xa_vidx2idx_map, index, map,
-			  npc_priv.bank_depth * 2) {
+	xa_for_each_start(&npc_priv->xa_vidx2idx_map, index, map,
+			  npc_priv->bank_depth * 2) {
 		midx = xa_to_value(map);
 		rc =  npc_mcam_idx_2_subbank_idx(rvu, midx,
 						 &sb, &sb_off);
@@ -4128,14 +4126,14 @@ int npc_cn20k_defrag(struct rvu *rvu)
 	}
 
 	/* Mark all subbank which has ref allocation */
-	for (i = 0; i < npc_priv.num_subbanks; i++) {
+	for (i = 0; i < npc_priv->num_subbanks; i++) {
 		tnode = &node[i];
 
 		if (!tnode->valid)
 			continue;
 
 		tot = (tnode->key_type == NPC_MCAM_KEY_X2) ?
-			npc_priv.subbank_depth * 2 : npc_priv.subbank_depth;
+			npc_priv->subbank_depth * 2 : npc_priv->subbank_depth;
 
 		if (node[i].vidx_cnt != tot - tnode->free_cnt)
 			tnode->refs = true;
@@ -4152,7 +4150,7 @@ int npc_cn20k_defrag(struct rvu *rvu)
 free_vidx:
 	npc_unlock_all_subbank();
 	mutex_unlock(&mcam->lock);
-	for (i = 0; i < npc_priv.num_subbanks; i++)
+	for (i = 0; i < npc_priv->num_subbanks; i++)
 		kfree(node[i].vidx);
 	kfree(node);
 	return rc;
@@ -4180,7 +4178,7 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 		*ptr[i] = USHRT_MAX;
 	}
 
-	if (!npc_priv.init_done)
+	if (!npc_priv)
 		return 0;
 
 	if (is_lbk_vf(rvu, pcifunc)) {
@@ -4188,7 +4186,7 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 			return -EINVAL;
 
 		idx = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
-		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		val = xa_load(&npc_priv->xa_pf2dfl_rmap, idx);
 		if (!val) {
 			pr_debug("%s: Failed to find %s index for pcifunc=%#x\n",
 				 __func__,
@@ -4207,7 +4205,7 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 			return -EINVAL;
 
 		idx = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
-		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		val = xa_load(&npc_priv->xa_pf2dfl_rmap, idx);
 		if (!val) {
 			pr_debug("%s: Failed to find %s index for pcifunc=%#x\n",
 				 __func__,
@@ -4227,7 +4225,7 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 			continue;
 
 		idx = NPC_DFT_RULE_ID_MK(pcifunc, i);
-		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		val = xa_load(&npc_priv->xa_pf2dfl_rmap, idx);
 		if (!val) {
 			pr_debug("%s: Failed to find %s index for pcifunc=%#x\n",
 				 __func__,
@@ -4251,8 +4249,8 @@ int rvu_mbox_handler_npc_get_pfl_info(struct rvu *rvu, struct msg_req *req,
 		return -EOPNOTSUPP;
 	}
 
-	rsp->kw_type = npc_priv.kw;
-	rsp->x4_slots = npc_priv.bank_depth;
+	rsp->kw_type = npc_priv->kw;
+	rsp->x4_slots = npc_priv->bank_depth;
 	return 0;
 }
 
@@ -4342,7 +4340,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 	int blkaddr, rc, i;
 	void *map;
 
-	if (!npc_priv.init_done)
+	if (!npc_priv)
 		return;
 
 	if (!npc_is_cgx_or_lbk(rvu, pcifunc)) {
@@ -4360,7 +4358,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 	/* LBK */
 	if (is_lbk_vf(rvu, pcifunc)) {
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
-		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		map = xa_erase(&npc_priv->xa_pf2dfl_rmap, index);
 		if (!map)
 			dev_dbg(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
@@ -4374,7 +4372,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 	/* VF */
 	if (is_vf(pcifunc)) {
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
-		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		map = xa_erase(&npc_priv->xa_pf2dfl_rmap, index);
 		if (!map)
 			dev_dbg(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
@@ -4388,7 +4386,7 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
 	/* PF */
 	for (i = NPC_DFT_RULE_START_ID; i < NPC_DFT_RULE_MAX_ID; i++)  {
 		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
-		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		map = xa_erase(&npc_priv->xa_pf2dfl_rmap, index);
 		if (!map)
 			dev_dbg(rvu->dev,
 				"%s: Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
@@ -4448,7 +4446,7 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	struct msg_rsp free_rsp;
 	u16 b, m, p, u;
 
-	if (!npc_priv.init_done)
+	if (!npc_priv)
 		return 0;
 
 	if (!npc_is_cgx_or_lbk(rvu, pcifunc)) {
@@ -4471,7 +4469,7 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	}
 
 	/* Set ref index as lowest priority index */
-	eidx = 2 * npc_priv.bank_depth - 1;
+	eidx = 2 * npc_priv->bank_depth - 1;
 
 	/* Install only UCAST for VF */
 	cnt = is_vf(pcifunc) ? 1 : ARRAY_SIZE(mcam_idx);
@@ -4500,9 +4498,9 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
 
-	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
+	if (npc_priv->kw == NPC_MCAM_KEY_X4) {
 		req.kw_type = NPC_MCAM_KEY_X4;
-		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
+		req.ref_entry = eidx & (npc_priv->bank_depth - 1);
 	} else {
 		req.kw_type = NPC_MCAM_KEY_X2;
 		req.ref_entry = eidx;
@@ -4543,9 +4541,9 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	req.hdr.pcifunc = pcifunc;
 	req.ref_prio = NPC_MCAM_LOWER_PRIO;
 
-	if (npc_priv.kw == NPC_MCAM_KEY_X4) {
+	if (npc_priv->kw == NPC_MCAM_KEY_X4) {
 		req.kw_type = NPC_MCAM_KEY_X4;
-		req.ref_entry = eidx & (npc_priv.bank_depth - 1);
+		req.ref_entry = eidx & (npc_priv->bank_depth - 1);
 	} else {
 		req.kw_type = NPC_MCAM_KEY_X2;
 		req.ref_entry = eidx;
@@ -4569,7 +4567,7 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	/* LBK */
 	if (is_lbk_vf(rvu, pcifunc)) {
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
-		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+		ret = xa_insert(&npc_priv->xa_pf2dfl_rmap, index,
 				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
 		if (ret) {
 			dev_err(rvu->dev,
@@ -4586,7 +4584,7 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	/* VF */
 	if (is_vf(pcifunc)) {
 		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
-		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+		ret = xa_insert(&npc_priv->xa_pf2dfl_rmap, index,
 				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
 		if (ret) {
 			dev_err(rvu->dev,
@@ -4604,7 +4602,7 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 	for (i = NPC_DFT_RULE_START_ID, k = 0; i < NPC_DFT_RULE_MAX_ID &&
 	     k < cnt; i++, k++) {
 		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
-		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+		ret = xa_insert(&npc_priv->xa_pf2dfl_rmap, index,
 				xa_mk_value(mcam_idx[k]), GFP_KERNEL);
 		if (ret) {
 			dev_err(rvu->dev,
@@ -4613,7 +4611,7 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
 				pcifunc);
 			for (int p = NPC_DFT_RULE_START_ID; p < i; p++) {
 				index = NPC_DFT_RULE_ID_MK(pcifunc, p);
-				xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+				xa_erase(&npc_priv->xa_pf2dfl_rmap, index);
 			}
 			goto err;
 		}
@@ -4687,71 +4685,79 @@ static int npc_priv_init(struct rvu *rvu)
 		return -EINVAL;
 	}
 
-	npc_priv.num_subbanks = num_subbanks;
-	npc_priv.bank_depth = bank_depth;
-	npc_priv.subbank_depth = subbank_depth;
+	npc_priv = kcalloc(1, sizeof(*npc_priv), GFP_KERNEL);
+	if (!npc_priv)
+		return -ENOMEM;
+
+	npc_priv->num_banks = num_banks;
+	npc_priv->num_subbanks = num_subbanks;
+	npc_priv->bank_depth = bank_depth;
+	npc_priv->subbank_depth = subbank_depth;
 
 	/* Get kex configured key size */
 	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(0));
-	npc_priv.kw = FIELD_GET(GENMASK_ULL(34, 32), cfg);
+	npc_priv->kw = FIELD_GET(GENMASK_ULL(34, 32), cfg);
 
 	dev_info(rvu->dev,
 		 "banks=%u depth=%u, subbanks=%u depth=%u, key type=%s\n",
 		 num_banks, bank_depth, num_subbanks, subbank_depth,
-		 npc_kw_name[npc_priv.kw]);
+		 npc_kw_name[npc_priv->kw]);
 
-	npc_priv.sb = kcalloc(num_subbanks, sizeof(struct npc_subbank),
-			      GFP_KERNEL);
-	if (!npc_priv.sb)
-		return -ENOMEM;
+	npc_priv->sb = kcalloc(num_subbanks, sizeof(struct npc_subbank),
+			       GFP_KERNEL);
+	if (!npc_priv->sb)
+		goto fail1;
 
-	xa_init_flags(&npc_priv.xa_sb_used, XA_FLAGS_ALLOC);
-	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
-	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
-	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
-	xa_init_flags(&npc_priv.xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
-	xa_init_flags(&npc_priv.xa_idx2vidx_map, XA_FLAGS_ALLOC);
-	xa_init_flags(&npc_priv.xa_vidx2idx_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv->xa_sb_used, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv->xa_sb_free, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv->xa_idx2pf_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv->xa_pf_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv->xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv->xa_idx2vidx_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv->xa_vidx2idx_map, XA_FLAGS_ALLOC);
 
 	if (npc_create_srch_order(num_subbanks))
-		goto fail1;
+		goto fail2;
 
 	npc_populate_restricted_idxs(num_subbanks);
 
 	/* Initialize subbanks */
-	for (i = 0, sb = npc_priv.sb; i < num_subbanks; i++, sb++)
+	for (i = 0, sb = npc_priv->sb; i < num_subbanks; i++, sb++)
 		npc_subbank_init(rvu, sb, i);
 
 	/* Get number of pcifuncs in the system */
-	npc_priv.pf_cnt = npc_pcifunc_map_create(rvu);
-	npc_priv.xa_pf2idx_map = kcalloc(npc_priv.pf_cnt,
-					 sizeof(struct xarray),
-					 GFP_KERNEL);
-	if (!npc_priv.xa_pf2idx_map)
-		goto fail2;
+	npc_priv->pf_cnt = npc_pcifunc_map_create(rvu);
+	npc_priv->xa_pf2idx_map = kcalloc(npc_priv->pf_cnt,
+					  sizeof(struct xarray),
+					  GFP_KERNEL);
+	if (!npc_priv->xa_pf2idx_map)
+		goto fail3;
 
-	for (i = 0; i < npc_priv.pf_cnt; i++)
-		xa_init_flags(&npc_priv.xa_pf2idx_map[i], XA_FLAGS_ALLOC);
+	for (i = 0; i < npc_priv->pf_cnt; i++)
+		xa_init_flags(&npc_priv->xa_pf2idx_map[i], XA_FLAGS_ALLOC);
 
-	INIT_LIST_HEAD(&npc_priv.defrag_lh);
-	mutex_init(&npc_priv.lock);
+	INIT_LIST_HEAD(&npc_priv->defrag_lh);
+	mutex_init(&npc_priv->lock);
 
 	return 0;
 
-fail2:
+fail3:
 	kfree(subbank_srch_order);
 	subbank_srch_order = NULL;
 
+fail2:
+	xa_destroy(&npc_priv->xa_sb_used);
+	xa_destroy(&npc_priv->xa_sb_free);
+	xa_destroy(&npc_priv->xa_idx2pf_map);
+	xa_destroy(&npc_priv->xa_pf_map);
+	xa_destroy(&npc_priv->xa_pf2dfl_rmap);
+	xa_destroy(&npc_priv->xa_idx2vidx_map);
+	xa_destroy(&npc_priv->xa_vidx2idx_map);
+	kfree(npc_priv->sb);
+	npc_priv->sb = NULL;
 fail1:
-	xa_destroy(&npc_priv.xa_sb_used);
-	xa_destroy(&npc_priv.xa_sb_free);
-	xa_destroy(&npc_priv.xa_idx2pf_map);
-	xa_destroy(&npc_priv.xa_pf_map);
-	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
-	xa_destroy(&npc_priv.xa_idx2vidx_map);
-	xa_destroy(&npc_priv.xa_vidx2idx_map);
-	kfree(npc_priv.sb);
-	npc_priv.sb = NULL;
+	kfree(npc_priv);
+	npc_priv = NULL;
 	return -ENOMEM;
 }
 
@@ -4759,25 +4765,31 @@ void npc_cn20k_deinit(struct rvu *rvu)
 {
 	int i;
 
-	xa_destroy(&npc_priv.xa_sb_used);
-	xa_destroy(&npc_priv.xa_sb_free);
-	xa_destroy(&npc_priv.xa_idx2pf_map);
-	xa_destroy(&npc_priv.xa_pf_map);
-	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
-	xa_destroy(&npc_priv.xa_idx2vidx_map);
-	xa_destroy(&npc_priv.xa_vidx2idx_map);
+	if (!npc_priv)
+		return;
 
-	for (i = 0; i < npc_priv.pf_cnt; i++)
-		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
+	xa_destroy(&npc_priv->xa_sb_used);
+	xa_destroy(&npc_priv->xa_sb_free);
+	xa_destroy(&npc_priv->xa_idx2pf_map);
+	xa_destroy(&npc_priv->xa_pf_map);
+	xa_destroy(&npc_priv->xa_pf2dfl_rmap);
+	xa_destroy(&npc_priv->xa_idx2vidx_map);
+	xa_destroy(&npc_priv->xa_vidx2idx_map);
 
-	kfree(npc_priv.xa_pf2idx_map);
+	for (i = 0; i < npc_priv->pf_cnt; i++)
+		xa_destroy(&npc_priv->xa_pf2idx_map[i]);
+
+	kfree(npc_priv->xa_pf2idx_map);
 	/* No need to destroy mutex lock as it is
 	 * part of subbank structure
 	 */
-	kfree(npc_priv.sb);
+	kfree(npc_priv->sb);
 	kfree(subbank_srch_order);
-	bitmap_clear(npc_priv.en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
+	bitmap_clear(npc_priv->en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
 		     MAX_SUBBANK_DEPTH);
+	npc_defrag_list_clear();
+	kfree(npc_priv);
+	npc_priv = NULL;
 }
 
 static int npc_setup_mcam_section(struct rvu *rvu, int key_type)
@@ -4790,7 +4802,7 @@ static int npc_setup_mcam_section(struct rvu *rvu, int key_type)
 		return -ENODEV;
 	}
 
-	for (sec = 0; sec < npc_priv.num_subbanks; sec++)
+	for (sec = 0; sec < npc_priv->num_subbanks; sec++)
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_MCAM_SECTIONX_CFG_EXT(sec), key_type);
 
@@ -4812,10 +4824,12 @@ int npc_cn20k_init(struct rvu *rvu)
 	if (err) {
 		dev_err(rvu->dev, "%s: mcam section configuration failure\n",
 			__func__);
-		return err;
+		goto fail;
 	}
 
-	npc_priv.init_done = true;
-
 	return 0;
+
+fail:
+	npc_cn20k_deinit(rvu);
+	return err;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 8bf857317e49..b759aa022a48 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -195,7 +195,7 @@ struct npc_defrag_show_node {
  */
 struct npc_priv_t {
 	int bank_depth;
-	const int num_banks;
+	int num_banks;
 	int num_subbanks;
 	int subbank_depth;
 	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *
@@ -214,7 +214,6 @@ struct npc_priv_t {
 	struct list_head defrag_lh;
 	struct mutex lock; /* protect defrag nodes */
 	int pf_cnt;
-	bool init_done;
 };
 
 struct npc_kpm_action0 {
-- 
2.43.0


