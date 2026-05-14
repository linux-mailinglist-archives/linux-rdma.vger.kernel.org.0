Return-Path: <linux-rdma+bounces-20658-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GsmJXZsBWo+WwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20658-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:32:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9053E596
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8215630AFA76
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A603C3C0E;
	Thu, 14 May 2026 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GGWRX2cD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE63B8950;
	Thu, 14 May 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740030; cv=none; b=FJU3NZ4gyWK2u+3IMBq6VBJxso7ELSQbjb6xLVoZ8vhC7ZUrKZXK/ZmntRaC5JshxeMqc/Umeup4ZKul96olNtJxt2BZR3iBAfbP0ActEbQSPJS5ULskRYw1Y6l5lfcvcAAewkYqs5YBJzTKVBweLdVKXBVJoye0HuexUeOE5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740030; c=relaxed/simple;
	bh=V03pdNHi0tOIj6Sk6FMkECq8VjnhZEmkBSyRRXuvLyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZKSRd3BJDASQ3uDJouzWSmJSzCgYjB0lIr6oe0XioSTn0pOZKL++9TI9gpgXs4mc3aPcYd2JpT0cdaRfzrLpBDduql/iv5ypLuY59L2r1MJvP4yRldhbNzMPteTYhJQsyZ6AHlIuCzFJcE/pEaFxJa9hkmqBURyF+eMKdDMVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GGWRX2cD; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E21t2v2549028;
	Wed, 13 May 2026 23:26:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	p6zkDs1VhynAYMdq2VObGaJzL3EVh8GZHWc/HJcqoQ=; b=GGWRX2cDCjLUwW/os
	0v3ikAWQPpEd4o5hilqoAoK2iF4I0+luRPbusS2hIaCkY+icAEtGvk+EXy2hAKu0
	b9hkpngLIq79bcFWSS/ehDZ4wYW/rNKlKnQqkhimikWB8prHQNWOKTMzftRUDGRn
	8PZL8SEeQXGyBVGbM8qQrBPlkRfZfE2Q3T6M7km38xe/FQ+yPnpzO1M1ihxMgSsE
	rGQgmNvUrA1qWtom3NuIaY9Ypp/bv6iIAhDWUWtBZ+wr6y6Fao6CcBZiDWSVr5N5
	luN8iDvN1SgYUQ5yAdM2BP0AjXf0dPMFviW8oDFV2USZ6hUj+IYwcoGPSRCTzP5o
	OZi7A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e45ybe4as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 23:26:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 23:26:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 23:26:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D253F5B693F;
	Wed, 13 May 2026 23:26:39 -0700 (PDT)
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
Subject: [PATCH v14 net-next 6/9] octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle
Date: Thu, 14 May 2026 11:55:34 +0530
Message-ID: <20260514062537.3813802-7-rkannoth@marvell.com>
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
X-Proofpoint-GUID: s3oeGETDgNgCehupR9q-bT6V_HIjUd-y
X-Proofpoint-ORIG-GUID: s3oeGETDgNgCehupR9q-bT6V_HIjUd-y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2MCBTYWx0ZWRfXzcISG3AUncXG
 8kCw6iwmqlG7ZAIfcBinbBb2U/n+Sem5trZ1zplM5giUl5eAq1WzCoT3CkoiQftW/JxsqF7cZaX
 QT81aVvFUvwdY7dCnvEEdw6d8s9Cdf5/E3BMZOzwnw3DMLILLKU0ZWRWcnb5lC7NglQtxZUFRli
 Uu2h6D578jr/sAaW9DufrL2ancyN5wjdGR9rrBwdyFwo1OqKiofDa7IedZdonprNy9s8/baVO1N
 u1CBazaNq/zFiPFvRbfjsUuxrAk0AP39rrbAouVUGaQWy4cjlUFVCH2COUsG46DLm3tRVjfL2s4
 9G+SO+8w6z8nmUoD+L5qQWOrfSSH0wXHhTnxtJEdnKCsGx6oEtklXc1ma6BoXDU/Y4LQo+WdVKI
 A8yclZ1ng/JEGU0pB9jZgvZWUfskBXqOSO2FbGQT5rWVHJmUkOTRwPQ/5x2Tx1h0D+Lp1OYBW6k
 hdMWq28/X2AxlAq74Gw==
X-Authority-Analysis: v=2.4 cv=ZtTd7d7G c=1 sm=1 tr=0 ts=6a056b28 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=D4RoFv6TgYvzmL5duKYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 34B9053E596
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20658-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add NIX_LF_DONT_FREE_DFT_IDXS so the PF can send NIX LF free during hw
reinit or teardown without the AF freeing CN20K default NPC rule indexes
while the driver still owns that state (otx2_init_hw_resources and
otx2_free_hw_resources).

On CN20K, allocate default NPC rules from NIX LF alloc before
nix_interface_init, roll back with npc_cn20k_dft_rules_free on failure,
and free from NIX LF free when the new flag is not set. Tighten
rvu_mbox_handler_nix_lf_alloc error handling: use a single rc, propagate
qmem_alloc and other errors, and set -ENOMEM only when kcalloc fails
(remove the blanket -ENOMEM at the free_mem path).

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 69 ++++++++++++-------
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 20 ++++--
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  6 +-
 4 files changed, 61 insertions(+), 35 deletions(-)

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
index f977734ae712..7df256a9e01c 100644
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
index 3c814d157ab9..ec5b2d648246 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1285,11 +1285,18 @@ void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
 	struct nix_mce_list *mce_list;
 	int index, blkaddr, mce_idx;
 	struct rvu_pfvf *pfvf;
+	u16 ptr[4];
 
 	/* multicast pkt replication is not enabled for AF's VFs & SDP links */
 	if (is_lbk_vf(rvu, pcifunc) || is_sdp_pfvf(rvu, pcifunc))
 		return;
 
+	/* In cn20k, only CGX mapped devices have default MCAST entry */
+	if (is_cn20k(rvu->pdev) &&
+	    npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &ptr[0], &ptr[1],
+					&ptr[2], &ptr[3]))
+		return;
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return;
@@ -1329,9 +1336,12 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int index, blkaddr;
+	u16 ptr[4];
 
 	/* only CGX or LBK interfaces have default entries */
-	if (is_cn20k(rvu->pdev) && !npc_is_cgx_or_lbk(rvu, pcifunc))
+	if (is_cn20k(rvu->pdev) &&
+	    npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &ptr[0], &ptr[1],
+					&ptr[2], &ptr[3]))
 		return;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
@@ -4085,12 +4095,10 @@ void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
 
 	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
 					     nixlf, NIXLF_UCAST_ENTRY);
-	if (ucast_idx < 0) {
-		dev_err(rvu->dev,
-			"%s: Error to get ucast entry for pcifunc=%#x\n",
-			__func__, pcifunc);
+
+	/* In cn20k, default rules are freed before detach rsrc */
+	if (ucast_idx < 0)
 		return;
-	}
 
 	npc_enable_mcam_entry(rvu, mcam, blkaddr, ucast_idx, false);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..81b088f5a016 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1053,7 +1053,6 @@ irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 	/* Clear the IRQ */
 	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
 
-
 	mbox_data = otx2_read64(pf, RVU_PF_PFAF_MBOX0);
 
 	if (mbox_data & MBOX_UP_MSG) {
@@ -1729,7 +1728,7 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	mutex_lock(&mbox->lock);
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
-		free_req->flags = NIX_LF_DISABLE_FLOWS;
+		free_req->flags = NIX_LF_DISABLE_FLOWS | NIX_LF_DONT_FREE_DFT_IDXS;
 		if (otx2_sync_mbox_msg(mbox))
 			dev_err(pf->dev, "%s failed to free nixlf\n", __func__);
 	}
@@ -1803,7 +1802,7 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	/* Reset NIX LF */
 	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
 	if (free_req) {
-		free_req->flags = NIX_LF_DISABLE_FLOWS;
+		free_req->flags = NIX_LF_DISABLE_FLOWS | NIX_LF_DONT_FREE_DFT_IDXS;
 		if (!(pf->flags & OTX2_FLAG_PF_SHUTDOWN))
 			free_req->flags |= NIX_LF_DONT_FREE_TX_VTAG;
 		if (otx2_sync_mbox_msg(mbox))
@@ -1926,7 +1925,6 @@ int otx2_alloc_queue_mem(struct otx2_nic *pf)
 	struct otx2_qset *qset = &pf->qset;
 	struct otx2_cq_poll *cq_poll;
 
-
 	/* RQ and SQs are mapped to different CQs,
 	 * so find out max CQ IRQs (i.e CINTs) needed.
 	 */
-- 
2.43.0


