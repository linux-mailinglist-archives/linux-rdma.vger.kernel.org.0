Return-Path: <linux-rdma+bounces-12608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D647B1C900
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7E218C4ABE
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93929B8E1;
	Wed,  6 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3gdGk5u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2C29AB1A;
	Wed,  6 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494903; cv=none; b=UqpAUt4DE7RvbMH0xJr+hlYmN0LicrAwR4wX9yjSW32D4NnikUD93pfzNNvixBr4KVFF4aOji9R8nr0z9wWT9lOjjwquDfdY+l82GpwdKhHzxl73SeRZpPgCKqJ+bLk0m98A75G8jH6pj0q4+qnulXsix33709ASXEE0nj7eChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494903; c=relaxed/simple;
	bh=MhKZpiEMkhMe+8G9ZYn2CZ/sRLsIuEsALS1T2Ke395w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npeVm4xpG99/Y0zjzUhIDgedqSPmBItRi1+puKajYkAjmRNfI0yG079tXwqDmz/taPorwDffcIXUVFx0kjJ4B8ccnWhTKnRjLY7RgWt5bOhP47YxgZiWYLnwjnhTunPyaMeGNRHhmlo4WK6Vn75HazCi1oupdQerCGCbsB1hV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3gdGk5u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57682WFk020940;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dXVOk2NwJH5c47OGV
	5Mvihe6kkp3b03MIHMex+rYl0A=; b=H3gdGk5u8tL572UYUenzR+uVbexkk9ZD5
	dHfcSyb6Y7vR4dTeM6Qh7VYOTbKJS3d8xhNxM5CG9UxAEgydV/WanllpYMZTXIca
	i9X406Ca+6RmVYGqRd1Gljjszh2GeXB08CngSTLhCbjRS5IYbyyjYLCKv/Bttp0V
	SqcOQqXPHC6W+I0FP3YNaoHcsAZtXB/+IXBHsi19n8AlNq+vGL6SrI2x/rVbbXg9
	LVJwlKC8ANfyvsl2hXnsj4IPsC0ThZM/uS1jpmv08FF2xnU6lK790BQC8opRWgsW
	jzjkJ9QC5IkQuyUkZu6hCf+F3iMtODz7/fwQtxHpAwoxKXS9+ylYQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6350ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FfRuc025823;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6350u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576ChDlS008004;
	Wed, 6 Aug 2025 15:41:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwmv8s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNh048169426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 183F62004B;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED74720040;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A28ADE1296; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 07/17] net/dibs: Register smc as dibs_client
Date: Wed,  6 Aug 2025 17:41:12 +0200
Message-ID: <20250806154122.3413330-8-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=U0vM5sLUQvpGRQ2cxP0A:9
X-Proofpoint-GUID: q3flNQXZxzFjA4O68hrTZyQv9DOvedwe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX19qqhB77qZCf
 in/eQy0q39XyqwopxGJnhM+FKF3VJ4n29eT/HvyXl0If84I4klxVgRNVO/Y0szlF+WnFC6cBHxC
 5fb6f3dlCSie1fA57ZjvdusbwF+U3kWChfv+67WYTkMLtcE+4OYMkrUOR4JnDvNRzgILcaG0rn1
 p/uLEBEf+CbnQPLRIJgoKB2q2UAT1U12TGfkMAQMJCZvM2GATQsTJRn5Ux/KBYIHW/Ree5xgNiD
 6u5B2gKtdfMF4xndaYPRyA5CuY9LaFzQLR1eB1WhJWDV8wLZ4nlJ/6IuHoghC/fjdy6+ttzZaBi
 fCgcGClUmuIiXap5T+scPhnNBJplutb5MUuOOFwCboX+BdHP2YKNfcGW06i5knHNcMtJswaOyCz
 uAnVtRu8H5BT25aT2mrHv8BlLEuozgLNDNhE9y6M69KZGz5D7NjQImLrTaGJbFIe5RNPPK2N
X-Proofpoint-ORIG-GUID: SGI6LVtBeOlxON4frvEKFjvEN6_5EvWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=638
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060096

Formally register smc as dibs client. Functionality will be moved by
follow-on patches from ism_client to dibs_client until eventually
ism_client can be removed.
As DIBS is only a shim layer without any dependencies, we can depend SMC
on DIBS without adding indirect dependencies. A follow-on patch will
remove dependency of SMC on ISM.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
---
 include/linux/dibs.h | 24 +++++++++++++++++++++++-
 net/dibs/dibs_main.c | 35 +++++++++++++++++++++++++++++++++++
 net/smc/Kconfig      |  2 +-
 net/smc/smc_ism.c    |  6 ++++++
 4 files changed, 65 insertions(+), 2 deletions(-)

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
index 348242fd05dd..d91e461f2f06 100644
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


