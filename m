Return-Path: <linux-rdma+bounces-13290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E7B53C9E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 21:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA21884D71
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A636C097;
	Thu, 11 Sep 2025 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B10Vy88f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A363570D4;
	Thu, 11 Sep 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620129; cv=none; b=VyCmOyNy7yN8JUXtavjG8jIBrDQwNrAT7jcXQ5wzpp9wrKxZI+bpSDUci4sEzwthUQwFnvx3ATsPVydI6EXZCM2XFJS9BXn1MDL75m/8Ai1B1LFQv4mGv68RExvtvpM47KVEkuqFlWP72x+qO1RgGSOo6Y044ZhUcfIabqk2FOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620129; c=relaxed/simple;
	bh=L7YFqfGxafURyMOe7IsMYX14+3Ei65V0UEeRNVuigm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJoPgYtSj7HnI3AUPOL8wS0XKMB9TrXTzyA5EN2XLxceHAbyGotSUThVHhfK0PQRvgmKVtsJ9nTJ77zvzjZIxI/i6e6big5FLKYMt0KAqu2JkGrvfr9HPmcZiQQZYubQy14X5M6PjOPhKYrHc1h/W+tp/H18eXyQnUkK1A6oYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B10Vy88f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFLLRr018068;
	Thu, 11 Sep 2025 19:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YxL1wIW4dzQ+KFoD4
	pHY8FOGH0nh69kyosNwqmnO7Cs=; b=B10Vy88fVuuhshOzL3nvHezpFrK1ypGQZ
	zArBlaFlDLTSlhqz4sxnYc5g8ytqfPiWpapjICc0Yd7PBzp/cfMie4iFSsjxMCI1
	OoT9P+MAogJIQyPHv/mYyUneGdHozNJZ1oTR3DNLMnke3T/CujxuC1bIN9kokzaI
	fLLxDi9gQNNanJnFwmi3hop+vahQQeuREI9R7IYZtedxemOzEl3B5aEBNOZx1UT6
	p8VmXvHsOjUu8dcf92OZ3MS5t+U5OATlYKqPlxU4NnA4mXM8X1YjN4DHXl7kZfSY
	8I+gQAVe2zjzdjgICf4ccMUNFrM+6c9PMivBjyY/Qh2Sz31jyB/tw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct65kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BJaPK8021283;
	Thu, 11 Sep 2025 19:48:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct65kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH6FQ4007944;
	Thu, 11 Sep 2025 19:48:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pyg95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BJmS0e62456146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:48:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A48A20049;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D902920040;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id ADC79E12D7; Thu, 11 Sep 2025 21:48:27 +0200 (CEST)
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
Subject: [PATCH net-next v2 04/14] dibs: Register smc as dibs_client
Date: Thu, 11 Sep 2025 21:48:17 +0200
Message-ID: <20250911194827.844125-5-wintera@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX700qZVkvDihN
 lonambs0Q2ctIY8RaiRMscZyR18nVuetkRK8NHOuEyBG5YSQk0m5FofLvf1BdjdqsQzKlURi964
 hgvXO1lQDTuFiyu8scs35tbNYDa1qwCihrqZBzLKm5YJ1qXC2KAn64x6QXvCvHveVJoMSiHUzZT
 aqonENF1OFp4WfL4d6u3TPidBUuooXXu8PFdEa+LqNi48HzaxFZ0t0e7nuJqhbWAjkEo7oHJli1
 B54C4zSFZh0zKrW+TbzM4bPEh74vZhBnpdFjBBhUUrAKfe9rkjmQr8Z2sXHRZfr0K+IkyAs1izv
 grVZVlcggCVEnLYle46gyiWthhSeoiKRMjXVLerN2DumOX0Vdcwnh1Idpbb0vbPhE3HPzXGCI8N
 wZP+GBCl
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c32791 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=ToqWdGCbH8b2siDz3c8A:9
X-Proofpoint-GUID: DU1gKV8FIieY-yygIFSq_tcSftNzJ2cd
X-Proofpoint-ORIG-GUID: kjSh1tp0QGBoIC31KnzoyyE1UGu43DPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

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
 drivers/dibs/dibs_main.c          | 35 +++++++++++++++++++++++++++++++
 include/linux/dibs.h              | 23 ++++++++++++++++++++
 net/smc/Kconfig                   |  2 +-
 net/smc/smc_ism.c                 |  6 ++++++
 6 files changed, 67 insertions(+), 1 deletion(-)

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
diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 68e189932fcf..a5d2be9c3246 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
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
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 3f4175aaa732..7bedeaf52c1b 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -33,10 +33,33 @@
  * clients.
  */
 
+/* DIBS client
+ * -----------
+ */
 #define MAX_DIBS_CLIENTS	8
 
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


