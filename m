Return-Path: <linux-rdma+bounces-18960-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPF1FaAsz2k3tgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18960-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:57:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1739083F
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A48730255EB
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331C34E779;
	Fri,  3 Apr 2026 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="au7AKk6V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DE33F58D;
	Fri,  3 Apr 2026 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184965; cv=none; b=p9lRV9QHvOGYHQ8ZfRAsriZLlT2zkxXeRYdpuHD+uPxU28fdiLDARogx4/B14/9WpkoQX8YxbVf5D/gDS//w6yNMLATeAf7IzEUleMNUHwyIww4hUcyZw6Z+ypBpzeax5uIwxqEYjVBHysMxCNjksPgVFjCj4goKCLd8Zmz9rPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184965; c=relaxed/simple;
	bh=SpyB1UDLp63tDR4MOkpKv9bYJcE46cCUffH+8u2goM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0sYfduDpGaDYK8K9lnLXR8TP3i+0ESYBOG2xpXMiWl5PE0dlVQOrWLG6qFkUeADOKTeVWZBcHsftBrxRJQjIKGRffDyJov+ejIyRe9/7AdREN2vLKX+x6n8ZSkfBGT6nsbWlADugoLhcO4z9k3g+g+Oj8MPDxRgrtO/rIsI7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=au7AKk6V; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632MB8WP909193;
	Thu, 2 Apr 2026 19:55:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	IdExKWDhnDlEKK2oitIydQWQ0yUyVBrGnKAhHa2qLM=; b=au7AKk6VOO3QRpIlu
	lJ/SnMRodx3AyKppl87Fzx6sLArESY0wZusK7ik0ovOveLP8J1iEL3nSGGre28T2
	UKRuMkxRKoX9jkKtKzzAX0rvEKMgbv1l0D54/A4f7FD+waL/FC7Fv8JYDEH2RUmq
	tEUKEq230jM5N+I6PauxtBJUwn26v9bZpYCyVTIYOBsZ65dhSeghQ8/O0Zr4r95v
	xpTR2LFlJyK/BIMjXOXk3cqyTWYWkPpqj7Wh8NiWT1o12t7RbE9xJdkTHIMuwuRM
	lSScQ5ugLJEGxj5rlKErvyGyyHhKSewtjlv05LrznEhlZGTfwPo6CHVHxq54hb0u
	bfPmw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4da11crmts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 19:55:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 2 Apr 2026 19:55:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 2 Apr 2026 19:55:52 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A05FC3F7051;
	Thu,  2 Apr 2026 19:55:46 -0700 (PDT)
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
Subject: [PATCH v10 net-next 1/6] octeontx2-af: npc: cn20k: debugfs enhancements
Date: Fri, 3 Apr 2026 08:25:28 +0530
Message-ID: <20260403025533.6250-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403025533.6250-1-rkannoth@marvell.com>
References: <20260403025533.6250-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KeffcAYD c=1 sm=1 tr=0 ts=69cf2c39 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=Ci00bJMBAOu-zhm_1uQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAyNCBTYWx0ZWRfX3NSE7FVi7o0N
 wk0zuhQ3HZG7nOH/dbnSOLuz0yzS41AfI16/pq/sjrBWXE7IDPRC0HPCPPtOwPUqIQ+pXcZsDjC
 nEAoOIp868PU5Sc54fP+ckE1j8bH70Vq0OkTPiK9t4FTC3BpAbogWOB87RfOg8cusg4VekC8/pS
 QWxuXPDdcgP8LZfQw8YDdG7xIXnnNkuorIMuukloR1MNelMLMtpx6WMgdVuD1WTYnNO0etA5WI3
 6TjzN3l4RP8kW9E0PbO50dJpXIy9lPZsXyH4B2U+mf8TMjtUn8szsqWs2uVTGLPA04SlAd51zQv
 tUyn7ARgYQVp+F8sQSnvYD7TnqlrpStDgCNoXzKqvN7zij5T767z+Q+g1tbtTGS6Ex0SeWjcYO+
 6Ezsq8ad/hS10n+d+5kKlwObi8smbVLsN4QTfcboi5WCMhhZgygjP4AD31biCmdBqjNxiWFXEy6
 Ip1DQd+WThK/6Y3nR2w==
X-Proofpoint-GUID: 3Ycb3nYoYTK17pWI3jAeQUeMHx_DVWIj
X-Proofpoint-ORIG-GUID: 3Ycb3nYoYTK17pWI3jAeQUeMHx_DVWIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01
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
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18960-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EFB1739083F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Improve MCAM visibility and field debugging for CN20K NPC.

- Extend "mcam_layout" to show enabled (+) or disabled state per entry
  so status can be verified without parsing the full "mcam_entry" dump.
- Add "dstats" debugfs entry: reports recently hit MCAM indices with
  packet counts; stats are cleared on read so each read shows deltas.
- Add "mismatch" debugfs entry: lists MCAM entries that are enabled
  but not explicitly allocated, helping diagnose allocation/field issues.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 126 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  16 ++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   7 +
 3 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 3debf2fae1a4..e8f85ed5ead7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -13,6 +13,7 @@
 #include "struct.h"
 #include "rvu.h"
 #include "debugfs.h"
+#include "cn20k/reg.h"
 #include "cn20k/npc.h"
 
 static int npc_mcam_layout_show(struct seq_file *s, void *unused)
@@ -58,7 +59,8 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 						 "v:%u", vidx0);
 				}
 
-				seq_printf(s, "\t%u(%#x) %s\n", idx0, pf1,
+				seq_printf(s, "\t%u(%#x)%c %s\n", idx0, pf1,
+					   test_bit(idx0, npc_priv->en_map) ? '+' : ' ',
 					   map ? buf0 : " ");
 			}
 			goto next;
@@ -101,9 +103,13 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 						 vidx1);
 				}
 
-				seq_printf(s, "%05u(%#x) %s\t\t%05u(%#x) %s\n",
-					   idx1, pf2, v1 ? buf1 : "       ",
-					   idx0, pf1, v0 ? buf0 : "       ");
+				seq_printf(s, "%05u(%#x)%c %s\t\t%05u(%#x)%c %s\n",
+					   idx1, pf2,
+					   test_bit(idx1, npc_priv->en_map) ? '+' : ' ',
+					   v1 ? buf1 : "       ",
+					   idx0, pf1,
+					   test_bit(idx0, npc_priv->en_map) ? '+' : ' ',
+					   v0 ? buf0 : "       ");
 
 				continue;
 			}
@@ -120,8 +126,9 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 						 vidx0);
 				}
 
-				seq_printf(s, "\t\t   \t\t%05u(%#x) %s\n", idx0,
-					   pf1, map ? buf0 : " ");
+				seq_printf(s, "\t\t   \t\t%05u(%#x)%c %s\n", idx0, pf1,
+					   test_bit(idx0, npc_priv->en_map) ? '+' : ' ',
+					   map ? buf0 : " ");
 				continue;
 			}
 
@@ -134,7 +141,8 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 				snprintf(buf1, sizeof(buf1), "v:%05u", vidx1);
 			}
 
-			seq_printf(s, "%05u(%#x) %s\n", idx1, pf1,
+			seq_printf(s, "%05u(%#x)%c %s\n", idx1, pf1,
+				   test_bit(idx1, npc_priv->en_map) ? '+' : ' ',
 				   map ? buf1 : " ");
 		}
 next:
@@ -145,6 +153,100 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(npc_mcam_layout);
 
+static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
+static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	int blkaddr, pf, mcam_idx;
+	u64 stats, delta;
+	struct rvu *rvu;
+	u8 key_type;
+	void *map;
+
+	npc_priv = npc_priv_get();
+	rvu = s->private;
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return 0;
+
+	seq_puts(s, "idx\tpfunc\tstats\n");
+	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
+		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
+			mcam_idx = bank * npc_priv->bank_depth + idx;
+
+			npc_mcam_idx_2_key_type(rvu, mcam_idx, &key_type);
+			if (key_type == NPC_MCAM_KEY_X4 && bank != 0)
+				continue;
+
+			if (!test_bit(mcam_idx, npc_priv->en_map))
+				continue;
+
+			stats = rvu_read64(rvu, blkaddr,
+					   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(idx, bank));
+			if (!stats)
+				continue;
+			if (stats == dstats[bank][idx])
+				continue;
+
+			if (stats < dstats[bank][idx])
+				dstats[bank][idx] = 0;
+
+			pf = 0xFFFF;
+			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
+			if (map)
+				pf = xa_to_value(map);
+
+			if (stats > dstats[bank][idx])
+				delta = stats - dstats[bank][idx];
+			else
+				delta = stats;
+
+			seq_printf(s, "%u\t%#04x\t%llu\n",
+				   mcam_idx, pf, delta);
+			dstats[bank][idx] = stats;
+		}
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_mcam_dstats);
+
+static int npc_mcam_mismatch_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	struct npc_subbank *sb;
+	int mcam_idx, sb_off;
+	struct rvu *rvu;
+	void *map;
+	int rc;
+
+	npc_priv = npc_priv_get();
+	rvu = s->private;
+
+	seq_puts(s, "index\tsb idx\tkw type\n");
+	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
+		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
+			mcam_idx = bank * npc_priv->bank_depth + idx;
+
+			if (!test_bit(mcam_idx, npc_priv->en_map))
+				continue;
+
+			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
+			if (map)
+				continue;
+
+			rc = npc_mcam_idx_2_subbank_idx(rvu, mcam_idx,
+							&sb, &sb_off);
+			if (rc)
+				continue;
+
+			seq_printf(s, "%u\t%d\t%u\n", mcam_idx, sb->idx,
+				   sb->key_type);
+		}
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_mcam_mismatch);
+
 static int npc_mcam_default_show(struct seq_file *s, void *unused)
 {
 	struct npc_priv_t *npc_priv;
@@ -257,6 +359,16 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
 	if (!npc_dentry)
 		return -EFAULT;
 
+	npc_dentry = debugfs_create_file("dstats", 0444, rvu->rvu_dbg.npc, rvu,
+					 &npc_mcam_dstats_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("mismatch", 0444, rvu->rvu_dbg.npc, rvu,
+					 &npc_mcam_mismatch_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
 	npc_dentry = debugfs_create_file("mcam_default", 0444, rvu->rvu_dbg.npc,
 					 rvu, &npc_mcam_default_fops);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7291fdb89b03..e854b85ced9e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -808,6 +808,9 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	u64 cfg, hw_prio;
 	u8 kw_type;
 
+	enable ? set_bit(index, npc_priv.en_map) :
+		clear_bit(index, npc_priv.en_map);
+
 	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		cfg = rvu_read64(rvu, blkaddr,
@@ -1016,14 +1019,12 @@ static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 
 static void
 npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
-			    int bank, u8 kw_type, bool enable, u8 hw_prio)
+			    int bank, u8 kw_type, u8 hw_prio)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u64 bank_cfg;
 
 	bank_cfg = (u64)hw_prio << 24;
-	if (enable)
-		bank_cfg |= 0x1;
 
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		rvu_write64(rvu, blkaddr,
@@ -1119,7 +1120,8 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	/* TODO: */
 	/* PF installing VF rule */
 	npc_cn20k_set_mcam_bank_cfg(rvu, blkaddr, mcam_idx, bank,
-				    kw_type, enable, hw_prio);
+				    kw_type, hw_prio);
+	npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable);
 }
 
 void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
@@ -1735,9 +1737,9 @@ static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
 	return 0;
 }
 
-static int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
-				      struct npc_subbank **sb,
-				      int *sb_off)
+int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
+			       struct npc_subbank **sb,
+			       int *sb_off)
 {
 	int bank_off, sb_id;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 815d0b257a7e..004a556c7b90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -170,6 +170,7 @@ struct npc_defrag_show_node {
  * @num_banks:		Number of banks.
  * @num_subbanks:	Number of subbanks.
  * @subbank_depth:	Depth of subbank.
+ * @en_map:		Enable/disable status.
  * @kw:			Kex configured key type.
  * @sb:			Subbank array.
  * @xa_sb_used:		Array of used subbanks.
@@ -193,6 +194,9 @@ struct npc_priv_t {
 	const int num_banks;
 	int num_subbanks;
 	int subbank_depth;
+	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *
+		       MAX_NUM_SUB_BANKS *
+		       MAX_SUBBANK_DEPTH);
 	u8 kw;
 	struct npc_subbank *sb;
 	struct xarray xa_sb_used;
@@ -336,5 +340,8 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
 u16 npc_cn20k_vidx2idx(u16 index);
 u16 npc_cn20k_idx2vidx(u16 idx);
 int npc_cn20k_defrag(struct rvu *rvu);
+int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
+			       struct npc_subbank **sb,
+			       int *sb_off);
 
 #endif /* NPC_CN20K_H */
-- 
2.43.0


