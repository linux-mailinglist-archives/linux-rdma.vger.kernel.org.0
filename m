Return-Path: <linux-rdma+bounces-12601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C3B1C8EB
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F2C18A5EBD
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0E2918DB;
	Wed,  6 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="svzhkw8d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C142951D0;
	Wed,  6 Aug 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494899; cv=none; b=d1IJzaMlLDZn4nWQxUKa6vSHK0XahifB+OiAAtXNTE0MwNv5ft//Gss0PgYAesTZDxRaG/5s7zapyTdGALpr8Vzga2QCe3dRLjdMh900zBhtUxiwcoFVmtTJOsjXBdiTbN7tyrWUIOLdpVUgYb3V7387g93JT5bQKDTdom2R9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494899; c=relaxed/simple;
	bh=2iwdPMF5IYmSN5s/EolFOqaYRSt7GTc8QZGHyko4yJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7aY4gywI9C5kOex1LPB9JfOYyhjDFPdqiK9MDSeLX8qP/Y3kaAnRf2YS5v2IXkyVXdpeN5UgidJSPOMo9PMLKzhZBJ9eRyAKyRaTx6ekgcznIYH8sLaOMWNCoWQ9Aij8d2vyi6v+RiNg2ryAuTQpQ41vJkMgNXWIYyZbOrKgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svzhkw8d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766tDjg019393;
	Wed, 6 Aug 2025 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CP7PE/9mGLM4vK9Du
	dbNkSY+479u0ZfAuP6ulhYK/eg=; b=svzhkw8dDLVfqWk1a6pCoBWbxjt7kcCws
	ei3ES+ub7u19gaF+liLcgk1kOdn+Vy0qduN2dFKd/3QoikF5oQKZCfMjOfklfgc7
	zWXVb5Vhx1YjoSjanmQ68B609FInYondEenZ898XFptywQgmtPkudPdFENSTlvbp
	w0yHebWlaQgbyWlP01PF7g1Tym8Y5x+NUFIkA3BRgB5JD7bSyif1EXma1vm0OB8A
	13LMFEQlLl/dVpMQN8YzGtxMtPWip7OCoiDaixYoUxFQxFbBWV0huhRZzCcSDjjm
	Zk612puBodOdCLNRaXMsbN6eCCw65A4UTQzI51ETUx3L1PmLrpYDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26ttcmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FdZpn030975;
	Wed, 6 Aug 2025 15:41:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26ttcmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CYMFY020606;
	Wed, 6 Aug 2025 15:41:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwmv8vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfMo85374246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA7D22005A;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2E9C2004F;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 966A6E1277; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 03/17] net/smc: Remove error handling of unregister_dmb()
Date: Wed,  6 Aug 2025 17:41:08 +0200
Message-ID: <20250806154122.3413330-4-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: RTMCDwKdgUI5oAcYbMl87oyOfWR5b_aw
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=E2BrbLywADzKi2prdkwA:9
X-Proofpoint-GUID: ccEnzzJH5G9xfwPL0XxE_Vxlh6kyaQ7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX43UBSqrCUJGR
 dtNuT6wKEb2hWk5nkPdRt2hLf4UNKMuzHSOVIyV/aydIwXfgLFlNbDkLYZEtKD5yQkuSz9r6Ers
 qys3tbTGIPWFdB8fI5ksCQJgCH33MRZafFYB7skAi5VMPOLJ8nmyHKZnj05I29opp2vk0N4bW36
 AiTiM/u4y9rbo+WnEJ5qpK2FZKeliQ2vc/fXTeN8kSr44zdSo/vhyHP2IkcQI1uKh8lTfv2Lxp+
 A1FYNcaqtgyiRxjOEWmWwO+ONHuCbDaXnnriQLNyWayFiU2JpdjKL9BL6Mq7Ga0/YAMXJ1LDZV4
 5NbYhTb4y51a3MQiYd+WTiQU4wdzr/LIHNGquHN0d0KPJCG1zHoF2RsBtn2Hn8phef/2aDGJsBI
 A8lEHx+ktg0Xg4BGzcY6RFWuyfHAk54XqAMbl8ukZlkWaFG3bBap+GjDJv23N5naCza5lMG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=786
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060096

smcd_buf_free() calls smc_ism_unregister_dmb(lgr->smcd, buf_desc) and
then unconditionally frees buf_desc.

Remove the cleaning up of fields of buf_desc in
smc_ism_unregister_dmb(), because it is not helpful.

This removes the only usage of ISM_ERROR from the smc module. So move it
to drivers/s390/net/ism.h.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 drivers/s390/net/ism.h |  1 +
 include/net/smc.h      |  2 --
 net/smc/smc_ism.c      | 14 +++++---------
 net/smc/smc_ism.h      |  3 ++-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 047fa6101555..b5b03db52fce 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -10,6 +10,7 @@
 #include <asm/pci_insn.h>
 
 #define UTIL_STR_LEN	16
+#define ISM_ERROR	0xFFFF
 
 /*
  * Do not use the first word of the DMB bits to ensure 8 byte aligned access.
diff --git a/include/net/smc.h b/include/net/smc.h
index db84e4e35080..a9c023dd1380 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -44,8 +44,6 @@ struct smcd_dmb {
 
 #define ISM_RESERVED_VLANID	0x1FFF
 
-#define ISM_ERROR	0xFFFF
-
 struct smcd_dev;
 
 struct smcd_gid {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 84f98e18c7db..a94e1450d095 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -205,13 +205,13 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 	return rc;
 }
 
-int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
+void smc_ism_unregister_dmb(struct smcd_dev *smcd,
+			    struct smc_buf_desc *dmb_desc)
 {
 	struct smcd_dmb dmb;
-	int rc = 0;
 
 	if (!dmb_desc->dma_addr)
-		return rc;
+		return;
 
 	memset(&dmb, 0, sizeof(dmb));
 	dmb.dmb_tok = dmb_desc->token;
@@ -219,13 +219,9 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 	dmb.cpu_addr = dmb_desc->cpu_addr;
 	dmb.dma_addr = dmb_desc->dma_addr;
 	dmb.dmb_len = dmb_desc->len;
-	rc = smcd->ops->unregister_dmb(smcd, &dmb);
-	if (!rc || rc == ISM_ERROR) {
-		dmb_desc->cpu_addr = NULL;
-		dmb_desc->dma_addr = 0;
-	}
+	smcd->ops->unregister_dmb(smcd, &dmb);
 
-	return rc;
+	return;
 }
 
 int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 6763133dd8d0..765aa8fae6fa 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -47,7 +47,8 @@ int smc_ism_get_vlan(struct smcd_dev *dev, unsigned short vlan_id);
 int smc_ism_put_vlan(struct smcd_dev *dev, unsigned short vlan_id);
 int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 			 struct smc_buf_desc *dmb_desc);
-int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
+void smc_ism_unregister_dmb(struct smcd_dev *dev,
+			    struct smc_buf_desc *dmb_desc);
 bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd);
 int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
 		       struct smc_buf_desc *dmb_desc);
-- 
2.48.1


