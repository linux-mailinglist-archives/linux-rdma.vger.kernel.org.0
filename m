Return-Path: <linux-rdma+bounces-13119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E99B45B17
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520781BC60E9
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687637C0E4;
	Fri,  5 Sep 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K0Y/8SqW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8537426A;
	Fri,  5 Sep 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084086; cv=none; b=M9E4BRlSRHTtD+BVzEQ+q3aNaAdJ6xotcxgJdUxOjSDcx57zdPVAukzf5/3PSpBuovBz0EMeuEjzUiBJIwVKzcfHXBs9XD1l7VAF57LNSQdFXuW5NFSWXcTtUGAJRDpZ7tOvVxSIa6N3vKF6jBH1jnamwVFZYmFhjaRrD9EDi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084086; c=relaxed/simple;
	bh=my8n0VdtD6tyNiTnWCJ0CNPczTLx4CJRbjLGICDOhww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2Pmhf0OssH2BbL81zDEv+enW+WReq8O+WAXULo+MramgNyyseNCm7c2yxa7CF4Z+MT81IIGZbvhLZ6RcnufNa/6USlGG3ngw+cqRFn23SjcftIJyFn3MOBTBOX/2Cxop540CSJ09a+gALQEVilJMyozQc3Ba15p5mDxWakXxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K0Y/8SqW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585CxSDG005481;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XGinc7QtK05TLMEec
	tvTR+us6jj6cPq6NUC6PBDN/00=; b=K0Y/8SqWgpGTwzkyCYyvhTGW6R+80Yis4
	WkBjfGOvhdPyjYOIjZdA4j6CE9iE/HC+ifYP6+voS+izQdxR81cx676Lif0MZbV7
	Ni364XQ4HR1Npq5iF/zlqJznDAUTJMUlU4DILhpAEtUrKlRYDOd6uQG6/RFjbISV
	8FjbYHmLxTAXmE3/Ec6WG7mOkjlofw0H4MFBmRUId91NC2uQ9+v+oyKDBmTJPcol
	5X40DCoWewttj7P1mhZ1861xU5pXTiHdmCd17ymteQBRmnpvOKASiVF955HB3oo/
	xQLI/VdEjx7bLcg9sxKv2Iou4bvD/HSAHpt9AAnZXnzZeutTLdmnA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg88wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EngrN028470;
	Fri, 5 Sep 2025 14:54:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg88wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585D0He3019442;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n9tv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsScH56689144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E17D20043;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5915E20040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 23C5FE115D; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
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
Subject: [PATCH net-next 04/14] net/dibs: Register smc as dibs_client
Date: Fri,  5 Sep 2025 16:54:17 +0200
Message-ID: <20250905145428.1962105-5-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68baf9a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=ToqWdGCbH8b2siDz3c8A:9
X-Proofpoint-ORIG-GUID: pta4jJzoYdXgfzi6t8EsRIciSbVu6vHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX2IE68SkTDoJG
 6G++oXL9dQXlKlP2Qa0/yDDXHKgHu9sWZZQUt13rHBY7hP/ODUr5eLf+dPyZ9BXVCs344q8LvbU
 GBFeMIiMYvViplQRjN3Ptlj3PwMTGUo8MDAbhHMs8VuKVjsAQi0PWlGEB10IRJCzW1ohmcWOJsE
 44gJBu5cKOMQ0ckH6bqXEozHt7XzfYr/UlIvEkK7CDLZAwvE8swt/svZJnji1egkoF1S0sYNO+B
 93TzHlxLwchw3WqAeA97twBG3ZRB6k9vxSflV16duWwc2pCuCa4jBr80cZBHP9Sw3g7ZGmMIKoq
 e3/+88xAZ+daZnoLRWL1koT3VAUtjr9tcSqONCVgpvzMqZyk20LyPMyM2t4ljTDf9pIky7eeTYW
 Hf8tdJdU
X-Proofpoint-GUID: A4MKpF2E3LZV8OEAdj_PQeAMtRgDbEYg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Formally register smc as dibs client. Functionality will be moved by
follow-on patches from ism_client to dibs_client until eventually
ism_client can be removed.
As DIBS is only a shim layer without any dependencies, we can depend SMC
on DIBS without adding indirect dependencies. A follow-on patch will
remove dependency of SMC on ISM.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |  1 +
 arch/s390/configs/defconfig       |  1 +
 include/linux/dibs.h              | 24 ++++++++++++++++++++-
 net/dibs/dibs_main.c              | 35 +++++++++++++++++++++++++++++++
 net/smc/Kconfig                   |  2 +-
 net/smc/smc_ism.c                 |  6 ++++++
 6 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 5e616bc988ac..7bc54f053a3b 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -120,6 +120,7 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
+CONFIG_DIBS=y
 CONFIG_SMC_DIAG=m
 CONFIG_SMC_LO=y
 CONFIG_INET=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 094599cdaf4d..4bf6f3311f7d 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -111,6 +111,7 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
+CONFIG_DIBS=y
 CONFIG_SMC_DIAG=m
 CONFIG_SMC_LO=y
 CONFIG_INET=y
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 3f4175aaa732..5c432699becb 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -33,10 +33,32 @@
  * clients.
  */
 
+/* DIBS client
+ * -----------
+ */
 #define MAX_DIBS_CLIENTS	8
-
 struct dibs_client {
+	/* client name for logging and debugging purposes */
 	const char *name;
+	/* client index - provided and used by dibs layer */
+	u8 id;
 };
 
+/* Functions to be called by dibs clients:
+ */
+/**
+ * dibs_register_client() - register a client with dibs layer
+ * @client: this client
+ *
+ * Return: zero on success.
+ */
+int dibs_register_client(struct dibs_client *client);
+/**
+ * dibs_unregister_client() - unregister a client with dibs layer
+ * @client: this client
+ *
+ * Return: zero on success.
+ */
+int dibs_unregister_client(struct dibs_client *client);
+
 #endif	/* _DIBS_H */
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index 68e189932fcf..a5d2be9c3246 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -20,6 +20,41 @@ MODULE_LICENSE("GPL");
 /* use an array rather a list for fast mapping: */
 static struct dibs_client *clients[MAX_DIBS_CLIENTS];
 static u8 max_client;
+static DEFINE_MUTEX(clients_lock);
+
+int dibs_register_client(struct dibs_client *client)
+{
+	int i, rc = -ENOSPC;
+
+	mutex_lock(&clients_lock);
+	for (i = 0; i < MAX_DIBS_CLIENTS; ++i) {
+		if (!clients[i]) {
+			clients[i] = client;
+			client->id = i;
+			if (i == max_client)
+				max_client++;
+			rc = 0;
+			break;
+		}
+	}
+	mutex_unlock(&clients_lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dibs_register_client);
+
+int dibs_unregister_client(struct dibs_client *client)
+{
+	int rc = 0;
+
+	mutex_lock(&clients_lock);
+	clients[client->id] = NULL;
+	if (client->id + 1 == max_client)
+		max_client--;
+	mutex_unlock(&clients_lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dibs_unregister_client);
 
 static int __init dibs_init(void)
 {
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index ba5e6a2dd2fd..40dd60c1d23f 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SMC
 	tristate "SMC socket protocol family"
-	depends on INET && INFINIBAND
+	depends on INET && INFINIBAND && DIBS
 	depends on m || ISM != m
 	help
 	  SMC-R provides a "sockets over RDMA" solution making use of
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 503a9f93b392..a7a965e3c0ce 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -18,6 +18,7 @@
 #include "smc_pnet.h"
 #include "smc_netlink.h"
 #include "linux/ism.h"
+#include "linux/dibs.h"
 
 struct smcd_dev_list smcd_dev_list = {
 	.list = LIST_HEAD_INIT(smcd_dev_list.list),
@@ -42,6 +43,9 @@ static struct ism_client smc_ism_client = {
 	.handle_irq = smcd_handle_irq,
 };
 #endif
+static struct dibs_client smc_dibs_client = {
+	.name = "SMC-D",
+};
 
 static void smc_ism_create_system_eid(void)
 {
@@ -623,11 +627,13 @@ int smc_ism_init(void)
 #if IS_ENABLED(CONFIG_ISM)
 	rc = ism_register_client(&smc_ism_client);
 #endif
+	rc = dibs_register_client(&smc_dibs_client);
 	return rc;
 }
 
 void smc_ism_exit(void)
 {
+	dibs_unregister_client(&smc_dibs_client);
 #if IS_ENABLED(CONFIG_ISM)
 	ism_unregister_client(&smc_ism_client);
 #endif
-- 
2.48.1


