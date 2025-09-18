Return-Path: <linux-rdma+bounces-13489-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05917B84473
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A672B1C00859
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAA305065;
	Thu, 18 Sep 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnsyUv/K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F03302CB6;
	Thu, 18 Sep 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193537; cv=none; b=dY8yNXv3tRn7cTJ7fApLwhEXbuDWTAQfgktQNaGhwQy+dSZpZ7kGYoinzV6B1BvXVbZU7R+yxrP7Y+C/+KJi0eVN5ne/WMur2UmuBr/i5pU7flb0oP8NqYBMist2dj7096Za9jA8D72mEi60mznZvSyxmu5yvLh5kM6QNTtaFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193537; c=relaxed/simple;
	bh=//5LKvuMS1Tj5yyuELe9SsMD+jiLG3M30BoJXUJDPv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKy5UUqiR81/s/8c+O8GbSKdrLtguelQAq8HzZFSz8weXcNli6gNMXJY323WVH1MElX91SUEgOUJgVyUX/U1sdhPsbS6kYYp0w10JasuxZvzS0i191WA5uGNLznz12IV/58W7fxw8usdh9Qw8+5HlehvGb/JQmRofFZTlG6ZoDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnsyUv/K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4lHUW000348;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O/mmUSkPzZSNxYho4
	c3x/XEs9uNbKZIkzoHVRwGcvLU=; b=QnsyUv/KBte8jVymNJPgWsoR1VZNqYwn1
	UMRL8KN2P2Opyt5Bn0RLKdxM90xERcQuKl82LcmwMLSp1PWlUVKzgfLZo+xW8Srt
	YhXQ9DrYiLFTqaxaAUeBSmIu5r4Hx399ppoCehQlb9U9LwmX3dlHBB/+w0oBDaaA
	84eYn5HJnYHtmuhy84oaR65+chf1am2fE5OwpoK/5IKiRQn4TNkFrGH5ymHAProG
	qY71LfjqXYOB0iNiL7rJVttN3n94eev0jR0A7tX2a/nk45TShdw0WIOmsaYjGmPE
	gNcbHhzs/pYnBGLG6hH+rHigjtjaBdvV8BrCsAXIKdLfmC3QWHu8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hsrhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB56qu021482;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hsrhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9hBaH022347;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpx9xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51q951511626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0F7320043;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC59B20040;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A78C8E14CA; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Konstantin Shkolnyy <kshk@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shannon Nelson <sln@onemain.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH net-next v3 02/14] net/smc: Decouple sf and attached send_buf in smc_loopback
Date: Thu, 18 Sep 2025 13:04:48 +0200
Message-ID: <20250918110500.1731261-3-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250918110500.1731261-1-wintera@linux.ibm.com>
References: <20250918110500.1731261-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5J06ajRWuFKelPs7jN9kot8ujWVYD2mp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1mzBwNjFzjMP
 1j35q1Ho3F8OFzau0TyZYaRm8BbJFCKSJt6GF4UIIMsWlG6Sd1QonDNqLhfegxtXcnfWefxQLxC
 6X+z3Ga1/bOtOPGflFpBHvTKabfFeFKEFURGHoGMS/a5Hdp6ZHfHap4fd+ljIJ1GyceLQ5nT/yf
 ex3n2xtuNll9oG61ScTMymBAyIeytWI25f9qpaRJfdW9ekZTpJFYcyatkEIKMYON6R/YVe/0IfS
 hchWZLscluQ28NvtgFBhk9jvr4bLWc26oBve/sMOgawI93eQXBIl4dgfnx+l5poahEM+GXM7IL9
 XLrka0OZimh4GCzvwj/nLDlaQdxd1eAaXe+oD86XfjnQXnRbnVQtC9s8b7DRXUKRngbbr+X11Zk
 K3w6jBHU
X-Proofpoint-GUID: vYSjyWJChFR26p4WepLH497o5LeW5z5L
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cbe763 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=YPWO3w2s4X-KU5j4784A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

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


