Return-Path: <linux-rdma+bounces-13121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12326B45B22
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919961C8145E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B0371EAE;
	Fri,  5 Sep 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eYGn3sdE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627E374266;
	Fri,  5 Sep 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084086; cv=none; b=Gfi/+LOaI64+yLzTF83iGEmjY4zDUK0rJOAqu8Bnb87SU26tQ+b/jJuJl2RXfSkdlKrADQrKTAtX7aKRPyEgmbBh6hBcT+upTpxDtG7OcWrwyL6FtfrfslcxNGOi8zZAj3b1Z1RYoiXLN1sez/5SEajlriVXGdHmqk0EA2nX2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084086; c=relaxed/simple;
	bh=//5LKvuMS1Tj5yyuELe9SsMD+jiLG3M30BoJXUJDPv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIIPxgge3Q84xMU7vR5K4tfHJm7vp4gpiGrKUSbaTDemUJv5US2c6fMhw+3TIy+GDG4rVoLF/j71/9036WNSuehN1wki9X8726FXj6eDHvs/jNL4cHhWVDRmPsFf6BzWcMQxedM7kuZiG7bKQspZSfUsIQoElE5O7v6U3xkGmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eYGn3sdE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5858P0Zb017834;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O/mmUSkPzZSNxYho4
	c3x/XEs9uNbKZIkzoHVRwGcvLU=; b=eYGn3sdELrUencRGWBlBCgBF+qokav2Eb
	A765v8D+Zj46sRtQ8iAf5cB64TS3iG8EtZcwEcV+0rxjwTT8V/Y/T2hd1phkNRvO
	fesiCoiLjif5cLyFOQcyCqjhrNB+PidgEAhFngl/hndrWhrbZ1Sf/UhW4p8xoSHo
	ZT2MglNI3AAsdXt2Mz2bPYXum7gEWtlUd6zOT8In1igg4LoTNZdljkX1uunCdh0S
	xl+4+5quX3HtoBwc92+d/IDRQ7YGgBw1gJ8IyTc9wWRoU20wZN0L7ue3uxNUon7y
	KeARBamvGABfYktunL8BUkIZ+WrgNj8cukMs9OfNsQ8jXr3mpfrwQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuag6me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EgCQg026179;
	Fri, 5 Sep 2025 14:54:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuag6m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585Bltsg019927;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmuj6vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSvJ24838772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5753B20043;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4333720040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 1DA1AE1133; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 02/14] net/smc: Decouple sf and attached send_buf in smc_loopback
Date: Fri,  5 Sep 2025 16:54:15 +0200
Message-ID: <20250905145428.1962105-3-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905145428.1962105-1-wintera@linux.ibm.com>
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SHOvgdRxq7Ote6NJq9MWS8iYdNHe1Bzp
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68baf9a9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=YPWO3w2s4X-KU5j4784A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX1DsYp7Urr0h1
 S5O5bcnkpG2XB7BiMCL9igyt6iqLxfpcWEXjSpUCuFzoi5Gp/juXHkEhQhHb5ZPk9UNPE1p0t9K
 yr6uOoGFlKBg6wKUERISpkNCqQK43bySx8F693kMUTJkTkNBtUhKuwOyrsnqT2G0LcKN7SKs/ZI
 JcbY+d3CSuBfC6ybyTvy1enFhE0WpCPq9WGAtob7uy6dAzRczLd8WTup6MPP1c5Y6PlTI+VlHZ2
 P/tsQfC728MZ3NZBfe8wiGQYH+vOMV1nvFZIiK1bO5XZ78QDZpypnN/wGhVsfMCLSsbzuRbHpJD
 PM5M71TovXwNgwtk6bAUx59tkWBfMJeVqWXTeZT3rz3LLwn1IwvMVSgDE+Vhs/EiOFK0BxP/YDN
 C37l/hhU
X-Proofpoint-ORIG-GUID: uASvJLv7sowDqIbnN6qTntFZfRBrRCdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Before this patch there was the following assumption in
smc_loopback.c>smc_lo_move_data():
sf (signalling flag) == 0 : data is already in an attached target dmb
sf == 1 : data is not yet in the target dmb

This is true for the 2 callers in smc client
smcd_cdc_msg_send() : sf=1
smcd_tx_rdma_writes() : sf=0
but should not be a general assumption.

Add a bool to struct smc_buf_desc to indicate whether an SMC-D sndbuf_desc
is an attached buffer. Don't call move_data() for attached send_buffers,
because it is not necessary.

Move the data in smc_lo_move_data() if len != 0 and signal when requested.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/smc_core.h     | 5 +++++
 net/smc/smc_ism.c      | 1 +
 net/smc/smc_loopback.c | 9 +++------
 net/smc/smc_tx.c       | 3 +++
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 48a1b1dcb576..a5a78cbff341 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -13,6 +13,7 @@
 #define _SMC_CORE_H
 
 #include <linux/atomic.h>
+#include <linux/types.h>
 #include <linux/smc.h>
 #include <linux/pci.h>
 #include <rdma/ib_verbs.h>
@@ -221,6 +222,10 @@ struct smc_buf_desc {
 					/* virtually contiguous */
 		};
 		struct { /* SMC-D */
+			/* SMC-D tx buffer */
+			bool		is_attached;
+					/* no need for explicit writes */
+			 /* SMC-D rx buffer: */
 			unsigned short	sba_idx;
 					/* SBA index number */
 			u64		token;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index fca01b95b65a..503a9f93b392 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -274,6 +274,7 @@ int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
 		dmb_desc->cpu_addr = dmb.cpu_addr;
 		dmb_desc->dma_addr = dmb.dma_addr;
 		dmb_desc->len = dmb.dmb_len;
+		dmb_desc->is_attached = true;
 	}
 	return rc;
 }
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 0eb00bbefd17..1853c26fbbbb 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -224,12 +224,6 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	struct smc_lo_dev *ldev = smcd->priv;
 	struct smc_connection *conn;
 
-	if (!sf)
-		/* since sndbuf is merged with peer DMB, there is
-		 * no need to copy data from sndbuf to peer DMB.
-		 */
-		return 0;
-
 	read_lock_bh(&ldev->dmb_ht_lock);
 	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
 		if (tmp_node->token == dmb_tok) {
@@ -244,6 +238,9 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
 	read_unlock_bh(&ldev->dmb_ht_lock);
 
+	if (!sf)
+		return 0;
+
 	conn = smcd->conn[rmb_node->sba_idx];
 	if (!conn || conn->killed)
 		return -EPIPE;
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 214ac3cbcf9a..3144b4b1fe29 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -426,6 +426,9 @@ static int smcd_tx_rdma_writes(struct smc_connection *conn, size_t len,
 	int srcchunk, dstchunk;
 	int rc;
 
+	if (conn->sndbuf_desc->is_attached)
+		return 0;
+
 	for (dstchunk = 0; dstchunk < 2; dstchunk++) {
 		for (srcchunk = 0; srcchunk < 2; srcchunk++) {
 			void *data = conn->sndbuf_desc->cpu_addr + src_off;
-- 
2.48.1


