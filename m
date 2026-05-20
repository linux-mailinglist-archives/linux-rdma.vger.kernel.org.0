Return-Path: <linux-rdma+bounces-21007-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEmINEEYDWoctQUAu9opvQ
	(envelope-from <linux-rdma+bounces-21007-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 04:11:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFE8586BA0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 04:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F604305E890
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 02:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814D530100D;
	Wed, 20 May 2026 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EyelC8JC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7A2DC76C;
	Wed, 20 May 2026 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243043; cv=none; b=tN1xKO97051FnZUWM9ZGxLI4r9tJOkJmp3gEFNxwtFFP+32tTk6uuHUp31wJwIu3/JAnRvihmToilGpbIJpDAQq6/Urk3ODs2UXwBycEsHtck8l69s9WN3T9zFPQij7MLTOm7h1e4fickYg+8gtSGRMADw4uhUoliaXAfQYrhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243043; c=relaxed/simple;
	bh=ZmDFqVrJJenDRLyf5M2qrdJTqf+pQpEoKvfEfy8xi/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbG+N3+WEg+TrAG6bfstuU/c752Ovv6NBJUD0dUbYRNvqQGe5ESry4YiNTmXqPEQLZSTN4UcarX0h7MY89PkVySVBmFmQhJ+qcYXNaBcLR1P7YxcnL5eaLA1rrOmNjpWbx/zU6Ah9Y8ERZEBvOJXHw3FufWpMd6OqNGgc7xJshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EyelC8JC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JFoFq83009289;
	Tue, 19 May 2026 19:10:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	WjwQL8FV8JWPJQaQHEBdE0FNyCOrn+uFSXoLQLOebE=; b=EyelC8JCo/ONtoDtS
	XPE5GxcB1mU91A/zqLJJw4P2ALRIhLht5Q9V8YJn7OxItCUJllofaSRL+o1okKU5
	iuRIa0AqoMi8TgGb/xP18HZ9/I1AdXYXfgo3YICtUFXTBt7R6hZF5eO2a70e1K5w
	vao5pPHX3medsyFDgDzd1bHjEmlI9gc9zdspECMIoEDc+3RINAh6ytNKOuBl0KI6
	LsPnpBzyyGy2xCNbSFyL0GX4YpBr+R+nZ9xkaYUpKwnl/T4d5jENKgzyFmB/02oX
	T/GrcrWf6qFuBkCMDJFdXkDCmmWwTTkSPJotnErMyXej0vhJf1kQik37cI5bnCxI
	cHSJQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8jywb7uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:10:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 May 2026 19:10:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 May 2026 19:10:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C43555B6946;
	Tue, 19 May 2026 19:10:00 -0700 (PDT)
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
Subject: [PATCH v15 net-next 1/9] octeontx2-af: npc: cn20k: debugfs enhancements
Date: Wed, 20 May 2026 07:39:31 +0530
Message-ID: <20260520020939.1457231-2-rkannoth@marvell.com>
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
X-Proofpoint-GUID: 7loHVYl7hyxYKhRyBzAfQc4UCWuSZ4xb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOCBTYWx0ZWRfX77KnZx3eLsqB
 6f5z+cnKQ377xMuIR7HoJCzKDMd20qs6ykYlE8tYfCrK2aPKZQIyIFwmVj7a/mmJoi0aGbDakta
 q6rajN03HhKf1fUq63K11zDIdWJRafkg2+iX7Tu1j+1HM2rg30ffV31mfzERm/qpi/RWdwefNVS
 KJJbbqQuZKKUng2v1DJQZlDZziwU9YjFd81laWOX04mkD1HdGf5XqbelrQwY7utdJg9gDimZIsF
 /L3w+h9smLKCguU+roYGoZi0aSah5r/v76Q5+g0ltl7F5OIMNfFVaoU/G/KDEYNBKZAh7gB4xYR
 lpiSU9sWFeEuDN3vqZrKY/fMqffSb/I0HFWjXsA7Sof0tv4ldSXBhp299GplyjgqmZFG2AQ8Rei
 gyAarK19l9ja31ja+eliQL85J/qyHWaNTGqY1nEvMYKGc00cuVUAgNB6WKvCF6k0kjNN0IZbaop
 QBEO4xBB5r8wjpm2AAQ==
X-Proofpoint-ORIG-GUID: 7loHVYl7hyxYKhRyBzAfQc4UCWuSZ4xb
X-Authority-Analysis: v=2.4 cv=QbNWeMbv c=1 sm=1 tr=0 ts=6a0d1801 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=MGki9FtnWEUF7_4ZUUMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21007-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4DFE8586BA0
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
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 158 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  37 +++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  11 ++
 3 files changed, 191 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 6f13296303cb..730ef97a57e6 100644
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
@@ -145,6 +153,136 @@ static int npc_mcam_layout_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(npc_mcam_layout);
 
+#define __OCTEONTX2_DEBUGFS_ATTRIBUTE_FOPS(__name)			\
+static const struct file_operations __name ## _fops = {			\
+	.owner = THIS_MODULE,						\
+	.open = __name ## _open,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(__name, __size)		\
+static int __name ## _open(struct inode *inode, struct file *file)		\
+{										\
+	return single_open_size(file, __name ## _show, inode->i_private,	\
+				__size);					\
+}										\
+__OCTEONTX2_DEBUGFS_ATTRIBUTE_FOPS(__name)
+
+static DEFINE_MUTEX(stats_lock);
+
+/* MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS represent
+ * hard limit on all silicon variants, preventing any possibility of
+ * out-of-bounds access.
+ */
+static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
+static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	int blkaddr, pf, mcam_idx;
+	u64 stats, delta;
+	struct rvu *rvu;
+	char buff[64];
+	u8 key_type;
+	void *map;
+
+	npc_priv = npc_priv_get();
+	rvu = s->private;
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return 0;
+
+	mutex_lock(&stats_lock);
+	seq_puts(s, "idx\tpfunc\tstats\n");
+	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
+		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
+			mcam_idx = bank * npc_priv->bank_depth + idx;
+
+			if (npc_mcam_idx_2_key_type(rvu, mcam_idx, &key_type))
+				continue;
+
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
+			delta = stats - dstats[bank][idx];
+
+			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
+				 mcam_idx, pf, delta);
+			seq_puts(s, buff);
+
+			dstats[bank][idx] = stats;
+		}
+	}
+
+	mutex_unlock(&stats_lock);
+	return 0;
+}
+
+/*  "%u\t%#04x\t%llu\n" needs less than 64 characters to print */
+#define TOTAL_SZ (MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH * 64)
+DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_dstats, TOTAL_SZ);
+
+static int npc_mcam_mismatch_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	struct npc_subbank *sb;
+	int mcam_idx, sb_off;
+	struct rvu *rvu;
+	char buff[64];
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
+			snprintf(buff, sizeof(buff), "%u\t%d\t%u\n",
+				 mcam_idx, sb->idx, sb->key_type);
+
+			seq_puts(s, buff);
+		}
+	}
+	return 0;
+}
+
+/* "%u\t%d\t%u\n" needs less than 64 characters to print. */
+DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_mismatch, TOTAL_SZ);
+
 static int npc_mcam_default_show(struct seq_file *s, void *unused)
 {
 	struct npc_priv_t *npc_priv;
@@ -259,6 +397,12 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
 	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
 			    npc_priv, &npc_vidx2idx_map_fops);
 
+	debugfs_create_file("dstats", 0444, rvu->rvu_dbg.npc, rvu,
+			    &npc_mcam_dstats_fops);
+
+	debugfs_create_file("mismatch", 0444, rvu->rvu_dbg.npc, rvu,
+			    &npc_mcam_mismatch_fops);
+
 	debugfs_create_file("idx2vidx", 0444, rvu->rvu_dbg.npc,
 			    npc_priv, &npc_idx2vidx_map_fops);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 6b3f453fd500..9fa9a589cf9c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -824,7 +824,7 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
 			    cfg);
-		return 0;
+		goto update_en_map;
 	}
 
 	/* For NPC_CN20K_MCAM_KEY_X4 keys, both the banks
@@ -842,6 +842,12 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 			    cfg);
 	}
 
+update_en_map:
+	if (enable)
+		set_bit(index, npc_priv.en_map);
+	else
+		clear_bit(index, npc_priv.en_map);
+
 	return 0;
 }
 
@@ -1789,9 +1795,9 @@ static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
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
 
@@ -4498,11 +4504,19 @@ static int npc_priv_init(struct rvu *rvu)
 		npc_const2 = rvu_read64(rvu, blkaddr, NPC_AF_CONST2);
 
 	num_banks = mcam->banks;
+	if (num_banks > MAX_NUM_BANKS) {
+		dev_err(rvu->dev,
+			"Number of banks(%u) is invalid\n", num_banks);
+		return -EINVAL;
+	}
+
 	bank_depth = mcam->banksize;
 
 	num_subbanks = FIELD_GET(GENMASK_ULL(39, 32), npc_const2);
-	if (!num_subbanks) {
-		dev_err(rvu->dev, "Number of subbanks is zero\n");
+	if (!num_subbanks || num_subbanks > MAX_NUM_SUB_BANKS) {
+		dev_err(rvu->dev,
+			"Number of subbanks is invalid %u\n",
+			num_subbanks);
 		return -EFAULT;
 	}
 
@@ -4513,10 +4527,15 @@ static int npc_priv_init(struct rvu *rvu)
 		return -EINVAL;
 	}
 
-	npc_priv.num_subbanks = num_subbanks;
-
 	subbank_depth =	bank_depth / num_subbanks;
+	if (subbank_depth > MAX_SUBBANK_DEPTH) {
+		dev_err(rvu->dev,
+			"Invalid subbank depth %u\n",
+			subbank_depth);
+		return -EINVAL;
+	}
 
+	npc_priv.num_subbanks = num_subbanks;
 	npc_priv.bank_depth = bank_depth;
 	npc_priv.subbank_depth = subbank_depth;
 
@@ -4605,6 +4624,8 @@ void npc_cn20k_deinit(struct rvu *rvu)
 	 */
 	kfree(npc_priv.sb);
 	kfree(subbank_srch_order);
+	bitmap_clear(npc_priv.en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
+		     MAX_SUBBANK_DEPTH);
 }
 
 static int npc_setup_mcam_section(struct rvu *rvu, int key_type)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 3d5eb952cc07..3e851950be64 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -10,6 +10,10 @@
 
 #define MKEX_CN20K_SIGN	0x19bbfdbd160
 
+/* MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS represent
+ * hard limit on all silicon variants, preventing any possibility of
+ * out-of-bounds access on matrix defined using these values.
+ */
 #define MAX_NUM_BANKS 2
 #define MAX_NUM_SUB_BANKS 32
 #define MAX_SUBBANK_DEPTH 256
@@ -170,6 +174,7 @@ struct npc_defrag_show_node {
  * @num_banks:		Number of banks.
  * @num_subbanks:	Number of subbanks.
  * @subbank_depth:	Depth of subbank.
+ * @en_map:		Enable/disable status.
  * @kw:			Kex configured key type.
  * @sb:			Subbank array.
  * @xa_sb_used:		Array of used subbanks.
@@ -193,6 +198,9 @@ struct npc_priv_t {
 	const int num_banks;
 	int num_subbanks;
 	int subbank_depth;
+	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *
+		       MAX_NUM_SUB_BANKS *
+		       MAX_SUBBANK_DEPTH);
 	u8 kw;
 	struct npc_subbank *sb;
 	struct xarray xa_sb_used;
@@ -336,5 +344,8 @@ u16 npc_cn20k_vidx2idx(u16 index);
 u16 npc_cn20k_idx2vidx(u16 idx);
 int npc_cn20k_defrag(struct rvu *rvu);
 bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc);
+int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
+			       struct npc_subbank **sb,
+			       int *sb_off);
 
 #endif /* NPC_CN20K_H */
-- 
2.43.0


