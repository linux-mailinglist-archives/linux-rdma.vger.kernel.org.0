Return-Path: <linux-rdma+bounces-13486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79102B8445E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D0A1C004F3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57CA303A3B;
	Thu, 18 Sep 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DN9xuLxZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD2302CA2;
	Thu, 18 Sep 2025 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193536; cv=none; b=r2i8+8NZBE7PtBJY3XKb52+Y3xolB261jOR83x0doIpOckGqSrDJVyHShBwBLVoA2C+w0HyBRDPfXA0yP2IGxvNbKo0Rk/kxsDBQ6J6CZL+vhdegn45m7FnHNxYJWfRpwzo7+Yxg5KjUfsujHm3O+8r/qB7cRG+S8T4u3c4m90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193536; c=relaxed/simple;
	bh=xz88VKqDUnGtmGU4WQqpuEmmQUZLaWZxz0B93JsY42s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImD+rvZb5SVlvodE45DxRNtz7eR/lmqQ2b6VsPbsKlvdHxHWito8hzkBUGTxhi0ovjpXzuVVZF6B1Dy3BxYzAV/0ARnGwCFDN8NoscsS6AgcVA1b5uQ9I7aD+WSZO4zWWGxtSl47QV+rmo3WzsXH36sZpWIMQQc4HSD/NYpPEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DN9xuLxZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4NJWa028838;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qWgZEhwYpPlPjPS2q
	wWLiZvJiVl6lmU9u7STf7rzpGo=; b=DN9xuLxZAziOeuPaKwHhkqUEC6RTtQW8E
	K1UrQD/EWnxRt7NKwsiTXwJVP+9s7qoL42hpTgH+mF/pXhZZruJoPPTjjjpDeEvZ
	YK1XlXKx+hp3HgRfYctH7fbG3HR6JSgOSYCV/pzvST+RUwLbNnaOFub+KKOTKjyT
	ANnzJO58nId244JfKUzdqF6Ilwn53VTCdd9IBbsQ9Zrwk9UGJfOw8XunUcJW8YS9
	OdjxubhsI9CbKc2Ywz1xUyCYWsVEIbbCGOch+LFhwStS0fciWeaBJgmXtoPU85/1
	Gixfl7O/+vtmnhKEfJ8O+ce0jC9d7wOMj9mjwMUVnFmFeVgbojgVA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p9se0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IAo7Y0016254;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p9sds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9X1YB029514;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb16f4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51jG51577180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9C672005A;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D17B420043;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A3FF6E14B8; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
Subject: [PATCH net-next v3 01/14] net/smc: Remove error handling of unregister_dmb()
Date: Thu, 18 Sep 2025 13:04:47 +0200
Message-ID: <20250918110500.1731261-2-wintera@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1k9cZ66k25W5
 //vE8BxxW9VrGBm899EVsZPDnqWQoLPCYt985h1LPTjc1mD/mcSyvPdCsobpGS5xjggV42uC0p+
 TFpfoIz+m4lQ3G1xw+dF/x3Og+0ueeiAYQmxm39uY9r0q24hY3T3iqa4soZE9byZyTHX+bYQTv8
 uC1LYnnu8lGG7EIzH9OjBPfjGOQq6Fq0TqHUuLHBbym9a16qsk7s7nIrOjIv5D6+47tHfYcAbfD
 io6uhsTvbzo7ST90QtFPaPdKTLSrT0cKaKSOsFXluH5DplOReQsMtW/EXKiIuBb0mOrUaerp8Nb
 mMu/GPVWt4A4y5kwkUI5+dxsFPrmbtiC7uejFFdm9fNSqtr6VbojZvpIjHEFItI59aV1zlu/Wn5
 prYfAPpU
X-Proofpoint-ORIG-GUID: wCcpwYfxHPV0xvqIsW1d9KJPKYwOdljt
X-Proofpoint-GUID: 0jaSal2KjUJqw0JkhyWUTcND9aW5RG2A
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cbe763 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=E2BrbLywADzKi2prdkwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

smcd_buf_free() calls smc_ism_unregister_dmb(lgr->smcd, buf_desc) and
then unconditionally frees buf_desc.

Remove the cleaning up of fields of buf_desc in
smc_ism_unregister_dmb(), because it is not helpful.

This removes the only usage of ISM_ERROR from the smc module. So move it
to drivers/s390/net/ism.h.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
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


