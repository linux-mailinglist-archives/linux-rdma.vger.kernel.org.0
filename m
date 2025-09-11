Return-Path: <linux-rdma+bounces-13288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C65B53C94
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 21:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DABE3BAFBC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 19:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42229369974;
	Thu, 11 Sep 2025 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jzVaSsBF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF934AAEE;
	Thu, 11 Sep 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620128; cv=none; b=YI38ZdQC9H0bC7ntIFbUQyaudeuBtlYwr5r/Ao0bd6DKKHSfYwSOYZ/LF8NzKbtMFtYm6OKtUHvhFTYhU6io5wV13E0YZ9XRRkU2qPoZFSr44guKEhaXHBp831EIfHFQdl4m+0h0KbKunPUWw8c9gsA7OS10IRqhk8zDCSvc3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620128; c=relaxed/simple;
	bh=//5LKvuMS1Tj5yyuELe9SsMD+jiLG3M30BoJXUJDPv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiH8wVDVDAUa8cD8oJxLMi+Mv2Iu4uh59gdQxB5xlJPtkx3OTx9MF7ilInlG9OiLBzpr7C2a+MLwaEQ1GsFhWx19ga+sPwsqySsIbXHQthchyYhChQ3LdUHYbfnfgDIWmjKBVsSSu71JM98uIQnruhHzuD3xoB/9MofSBJpnbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jzVaSsBF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIIBXa009648;
	Thu, 11 Sep 2025 19:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O/mmUSkPzZSNxYho4
	c3x/XEs9uNbKZIkzoHVRwGcvLU=; b=jzVaSsBFQSsZ+FVwD4FoyyjmdJ7p7o01E
	zXMIE8G0ATYCAWvm35A0ZeTP/6HD5bpmcQleSbkmFyQQyuI1V/aZC9L3vhDxb5zC
	wrYetbtxrl/Cjj+HR/Ty+NiqJi19uuUpinj4ntU63ZKm7Ktpj5p2eQDAglHLAFkz
	4FDIjjNyr7KcXhnW4ZB9dS1g0j8C8ytk0TRG63O2sFyOhVt39t3cq/SVGqsRShEQ
	PRFZnmFuTAHYfIugS2XHcZBCyjBRY94GbNP+Tw0r76733coaF5ncBRW7AOQHa70r
	n8FO3A6P3vv1jU7/enS8UxIz3n0FoTMBCLVL9PoOL136tXNpTs9XA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydbu9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BJii9d007794;
	Thu, 11 Sep 2025 19:48:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydbu92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH6DUC020469;
	Thu, 11 Sep 2025 19:48:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp17myu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BJmSLJ51118530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:48:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0349820043;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E082B20040;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A6F76E12C2; Thu, 11 Sep 2025 21:48:27 +0200 (CEST)
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
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net-next v2 02/14] net/smc: Decouple sf and attached send_buf in smc_loopback
Date: Thu, 11 Sep 2025 21:48:15 +0200
Message-ID: <20250911194827.844125-3-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911194827.844125-1-wintera@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cjqGc-dNE6K5_BREmDSZ-cp6jjyx3GHj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfXwycB2JRusY0U
 KkX8z8t2w+Sio5C0N3GJPbDDVFsF5f3NJs5H7HnO6lI5GvAGmTun3hHSZj/f+V7g7KxT8E7YdS3
 oDdhmT7ed19NfVDnWR90B896dyaVMV8OseRN+TegO9Jjq948S/Q3ahiyYW+x8XRUfvWn/+pQi30
 gqVA3OkRBzZSdqYw7IJp+idiZmO0lbwwbwAkDECtj3in+lDpXMLPeQ0zvBUauvD608hvLnM/7j0
 oLVsROJfbaIdojKieGhSjXV8UzcEhP6ZaJaf1wspiGowefqj3vva/bB9aOE23joV/9gGWtW64cR
 aEFUBWNDvmrCc5GBYag+ANvNXLsDpfrovUh1Kuq0rM1/K1AqcyNbCMnG40BNu/hFumXzy8Fm90g
 Jru4X6xT
X-Proofpoint-GUID: _0EMapXhkOnaCSPabcz1mpKgM0MQt05i
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c32792 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=YPWO3w2s4X-KU5j4784A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

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


