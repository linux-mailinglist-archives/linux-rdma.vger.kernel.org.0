Return-Path: <linux-rdma+bounces-13116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57535B45B0A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28C2A45C4F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E467F3728B4;
	Fri,  5 Sep 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fSAF1QlB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5D371E82;
	Fri,  5 Sep 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084083; cv=none; b=XN1+l2qTbEFVgrjNsOGxNdmoDNkKc8DDZ7pyJb61Qx10srkUmWBZG7K9Na4aPVpCbFUEUfzq+DCjUmBuB+91O4yDFwO3CTqa/pSJxy2wG8co+nUkk1HljapyzNxBhMLr7/zSGZxxQaD8hIO2bajsO22+yp9q0LB1rCA4iQSwkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084083; c=relaxed/simple;
	bh=GDNiEccEkIWKQiqQAJhaP4i0wLdF2VaQH8TO6PsVBPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNOKp3tG+WV9nlY46y0NifczxitBjE3XFBt8f7xaETTY3diE2L81n0Eq1crJK0xioVxUZPh6KlrhrxQ8+J5Cil2t5nuwJMG5txQ8gvPD+Xx3BmcUEkMapVLF+bChVP1nNjZU59J8ApSEoUK6/B8RNU71xi3WnDZgBIyB+h+f+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fSAF1QlB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5858EcPX020452;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ia57Oo0jKsdRs+T7J
	U7JuofsTCJJd1kAM65roESwd40=; b=fSAF1QlBOljwSz02YmlQrceVcL2Fr7tBH
	86JEX/fzUXVGewPeXhnBS28B67A4z4gOTaOFhG6Apy4CgSPUVrT6Mb6RmATc8+A6
	PhznUvsCw6DV9+3/33yFTjEjrg1Oakp6AAMdsolMrqL+r4YMs6SDbHgFVCNiCM3N
	gWsZ2mi2EnipFErEbBHWIjs2uwmInWatdnNeeOxAB9KhojntTpRqmLqi2XniZQ98
	uHX4na8p+PozPpLVsgkhMi+Z1WPd7uHuD9GRUVv44t9A2dMCDSvn6FyxcyUe38bM
	hKg8WWpN49f4OZ4fSG0eT1GKj10pHavlCfZY3GKPpZ8YLGjvLs+bw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswds988-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EjU4W028751;
	Fri, 5 Sep 2025 14:54:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswds982-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585B6pLh019924;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmuj6ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSND52953470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F8A02004D;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CA0820043;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 1AA4DE1132; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
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
Subject: [PATCH net-next 01/14] net/smc: Remove error handling of unregister_dmb()
Date: Fri,  5 Sep 2025 16:54:14 +0200
Message-ID: <20250905145428.1962105-2-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68baf9aa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=E2BrbLywADzKi2prdkwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX6FIVTqk6Z9r5
 zL3fiEf5m9ZMvQ6Ic7W8T5HZ1D/kxFbSRcJ1B/vQG8PTg3rw2tPRAVEe6Osqjw2oEYLPjFwk2W3
 QNYIeieIcykQMWSFvH7jKO7ZwW3oDm16fw8bu4A/Tb6b5dXFO3zGJb/9TWu6xbmW20UuACqNZEP
 295HH+4buWkSQEgqQ2oEYSR4AcOaUetUJlNS92GKBjCcP5wqmGzA303ld8VT+B/ZIsRy5zJB5Go
 KzD0DV60OxDR/NdGjZU3zXYhmKrsWxVH6TEAhdqp68nsWpzt5HTUr6fX40J0k5vIad3QIHnF0wG
 jxKio3w0pTp/F/Y0uJW8QhT20v+1f1XZ/JBV4P7jBYskh/TKYY1Mwnzk+c1iA3UNT2Y9MQ4VZ8b
 rk0S5EQK
X-Proofpoint-GUID: GP0JUCyULcL6Le-Du7ByS21zMl5OP7P7
X-Proofpoint-ORIG-GUID: Mm0CRJtbAGL9f-lamX5iI8IZFCK-zwEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

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
index a58ffb7a0610..fca01b95b65a 100644
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


