Return-Path: <linux-rdma+bounces-12606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579BB1C8FC
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE11F18C48B9
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AEE29B797;
	Wed,  6 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RA0Eo2mo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B8298CD7;
	Wed,  6 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494903; cv=none; b=PzuT5xeKOhVu62DEShaeZ/9dpZU6mB9t0KDhrzKVnHYAUuPDuJTi8cOWT+tZH+WWFBs+E4M3RweCtGOHFSetQoyaHnZIaLaG5r3UYkMc8tGlqMnd/B8z01dR36Xqdci9Xe+agpaBEL46onk/xFnvru9nDpAOgZJKAjmv0DW7LsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494903; c=relaxed/simple;
	bh=oYFXm6tmLG37kTrSbKmAQwUsQMeXCUBvVWhpdhoRnCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjTmMIi7q/6tXLTNMv1/TGHLCCYfV9Oyn462O9KgsFPy8VvgwS8wLgQPtbWys4DD4etdDheW1DBMldtwAKArTWjy7qtcwuFleY4c/zFJ38YDZNWau03XSv4WeGvbEfGLhJH+KBKieyFOyDquDvteBkaFuuTJorpsb3hT0EdhvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RA0Eo2mo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5767lhVb028812;
	Wed, 6 Aug 2025 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+qoyqtzLlSUHaK0QZ
	WuaVM3DKxmVIZgfALp6hsa6gnU=; b=RA0Eo2moE19B6WVe9p0H7yTpm1bKeYMBC
	jIKmCc1kFAmcUqTNBaQ22zPiYeP0FHxExv+PZslcITf4PKoPNlSNKr50CAvLDs5q
	e+XMJVeBtrSO3kao28Qy75hUz8iE+hLM666HF8FgwLN3YvZLxHd0swgXzq8O19/c
	RSK/nKEknAz/bMlbXaOLW3wwQ5nXf8GsPUcl4NgoLMQ9X9tUUAU8QbqvIJ3fMzlg
	/qC98f2MnaWvur5l4ne+yv0FW57t7rA/H1P6mpuPxAVBqdEBHZ12QVLGhcbvdXqi
	Er04TJZQzoH2f0z8xBfubZaYYeU9CEDo5gJxqnKsHxOZpiVOkFRDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60w494-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FOs9O002084;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60w48w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CUC9i001627;
	Wed, 6 Aug 2025 15:41:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwqv8k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfMAP56557878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE9B320040;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C83A82004F;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 9959EE127E; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
Subject: [RFC net-next 04/17] net/smc: Decouple sf and attached send_buf in smc_loopback
Date: Wed,  6 Aug 2025 17:41:09 +0200
Message-ID: <20250806154122.3413330-5-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806154122.3413330-1-wintera@linux.ibm.com>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jyiTIRE4q0zsVp7G99KTf-y14YpYVk8m
X-Proofpoint-ORIG-GUID: Y9YAv8YJRO4kP32X7nvjy5LKqqaXFlT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX5pFydr3Z7p4N
 6/AV3AJ981+anwzrBmpcxUwYNH00Dzlr0hIrmIQgZmBMWqK38lEM8KpRQ+tyWKd2sW6SOMl+jSj
 +sBcOuw8fV+o7G96RBP8Llt94X6y85PspXYoYQtilno9jb5qTTmgIcEuXG/28Gk0qoPoTl6BU85
 7Ssan1fhqoEf6sfEaE8c5BRHN3GUf2fPhgThorSjtWlu/IVF5MBQxrsxIxY/jXzm7A7AyRPH8PH
 ZrSyTBGJrY2IvvMWmRHg2/CrfMXDbd+Ce4ZORxvYEoy8ZnXwZs2g0ig3c65+WoCCdZVGjrfHZrU
 qfNI8ybL83jLTWO0ftPQHZtxVxRhsATGSC60VIdzbhxtXthdfALAEIIxs6obKS6RmSgUTxh7jJD
 lqwJp5l0AKqxtD6stogmEqj4mTDamsKfXQmPBZJWkVDkI0qF/hQ9347iHWsn1fpqHVOjjPAA
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=YPWO3w2s4X-KU5j4784A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

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
---
 net/smc/smc_core.h     | 5 +++++
 net/smc/smc_ism.c      | 1 +
 net/smc/smc_loopback.c | 9 +++------
 net/smc/smc_tx.c       | 3 +++
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 48a1b1dcb576..fe5f48d14323 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -13,6 +13,7 @@
 #define _SMC_CORE_H
 
 #include <linux/atomic.h>
+#include <linux/types.h>
 #include <linux/smc.h>
 #include <linux/pci.h>
 #include <rdma/ib_verbs.h>
@@ -221,12 +222,16 @@ struct smc_buf_desc {
 					/* virtually contiguous */
 		};
 		struct { /* SMC-D */
+			 /* SMC-D rx buffer: */
 			unsigned short	sba_idx;
 					/* SBA index number */
 			u64		token;
 					/* DMB token number */
 			dma_addr_t	dma_addr;
 					/* DMA address */
+			/* SMC-D tx buffer */
+			bool		is_attached;
+					/* no need for explicit writes */
 		};
 	};
 };
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index a94e1450d095..7363f8be9f94 100644
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


