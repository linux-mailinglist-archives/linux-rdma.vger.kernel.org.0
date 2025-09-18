Return-Path: <linux-rdma+bounces-13482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F47B84443
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF2A1BC7F88
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27466302168;
	Thu, 18 Sep 2025 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="npVWQ3Lo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D42FBE1E;
	Thu, 18 Sep 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193533; cv=none; b=gPpKJi/yI6snpz40yYi+RpLHvBQnyk1evRI1VyNq2a1KjFa36cVqz3o0vi8IKYWL/8TdsCZ0Y1jxoGVwuxZhNxi1tELhZmY5cNurNJCBiE6GhEX1RZvuf+B12FjajZCYGo9xCW+TMSjRsfjgiPobGDWDbPlZnI4EWNTZ7lwGZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193533; c=relaxed/simple;
	bh=L7YFqfGxafURyMOe7IsMYX14+3Ei65V0UEeRNVuigm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVckIqBC3ohF1tKltxszNRfmr/CxnWjplq/YpqNLjpIJ6naLUxfBzJAjUzqZnd0eyrimlxQjIDtC/4EKk42CCkETJOXXP6y0oicqfmCE11c9R9T+vPQiXsryD98adzRhRQjqPcAaFinClE/JcXLrQuyb7zdGJdZxbT3AUiTJb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=npVWQ3Lo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I51dhb023812;
	Thu, 18 Sep 2025 11:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YxL1wIW4dzQ+KFoD4
	pHY8FOGH0nh69kyosNwqmnO7Cs=; b=npVWQ3LoiUTZLFmDZUcpIF1dXwi59/gOZ
	WSPqhz6zV3CjyNolXrZv7jj4pvJ6lvg1O3kYgSyxSeFIcbCpNqJA4E37w/7YNct3
	lLENIZxQpRLbHzx12HDl0zF+W252tKZcAPagkMo+jzoQdgNO28dVZ4gkMQfNCrPE
	LkjYt8Oz+6fLw6xNcVqci5CHZAY6mOS2QviTZJ1bZjcnd6Hm23YkYQTlyAMWTHWG
	sUjF/r5xmx5sorzeejsjJZTuNA6xgclZJkGjJFkuzZcB/g0o8rNSJ3GIkno4CY6N
	HI4UOUbIlrvttx2lNKyAv09wh3h7Rej8gpNmALxbWV1Ob/g22FxTg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB4hOh029286;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7V7xe018620;
	Thu, 18 Sep 2025 11:05:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mp31w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51FN43057558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13E442004E;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E940E20040;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id AE9F7E14D8; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
Subject: [PATCH net-next v3 04/14] dibs: Register smc as dibs_client
Date: Thu, 18 Sep 2025 13:04:50 +0200
Message-ID: <20250918110500.1731261-5-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 9qfJ3rHlQrYR1V7MAzY0__folUKfY4Yq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX8sQxaWmU90xA
 pXAF09a4gjPrcoSJ/oXhUUuEL7wqj3+gk996wnWSkwdW8Xt8Em3uw8smSzzVxKfeR3UWCGxN0Ua
 9s5b9Z0nT9ti31uudta3UyI70PqsN4hrMjTa92Q4t+roNQYsua0IRAFqB1pm6j5qh6/JGLcuZN4
 8exBECYkiJbgmOTfuerxPSCr9kh/5N3hHlHepbP8Q5PIN31IIXJ7zbeu83hv8l4JF5qDAsss2Ji
 aPuusEdF5YtsWqfOg0tjDBFfIL16QfI0Foi2m9iWmAzm4JwvtrvFQ0pNJN+NoM1Msg5TXh01z1X
 paTB05MxIwKjFPl2JYiLbNaKLo6V3nCwI7M8Wq1yHaUCeSqECTwuW6GamckpKALDWCWTBZC1vzn
 s8p5jDlk
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cbe762 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=ToqWdGCbH8b2siDz3c8A:9
X-Proofpoint-GUID: 7D5NcWZPlvY1YfJD3YLB5ODObSAAXIDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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


