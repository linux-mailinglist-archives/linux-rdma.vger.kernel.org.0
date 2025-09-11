Return-Path: <linux-rdma+bounces-13282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555B3B53C85
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 21:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E09AC2643
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C827281D;
	Thu, 11 Sep 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s1W1JuM6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B626561D;
	Thu, 11 Sep 2025 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620124; cv=none; b=bOfJk7mU+z/GOvYGTRy0zlzBCaRRvODcP1LGScjHns7YlczDIvpz4UEo2Sx7qr4N/OgnO75kZ3WkQ7k9HgsWSaXbvCrgJnsT45dc8WYtCj6I73YwOKzt+DnhZpxLduKUsktK2Dp+gzBFk6BqFLg5W9WWh8nOFad2CEQIbQta2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620124; c=relaxed/simple;
	bh=xz88VKqDUnGtmGU4WQqpuEmmQUZLaWZxz0B93JsY42s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgo3EVTDpb0QeAe7GE4QjcD26zM40ebuEFss/3eJGzioFlqocbUCkDGequzYanAf43s4AF4/0ceAmc+JQBjCzkRBe21Hh7ccvzZQ4PCrUeXqfqf0PpI8Ilzoqi7CfoSJxTuX0f1cl4UN2spODoxSPaO5TIOB11mierSD8Mxfkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s1W1JuM6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFKHLM009911;
	Thu, 11 Sep 2025 19:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qWgZEhwYpPlPjPS2q
	wWLiZvJiVl6lmU9u7STf7rzpGo=; b=s1W1JuM6VA+ZxgcOoRD2/9mVS6U+0fOvl
	Clhhihr0o1mUhYKADGG4f4mxAPynMKhL6pIpbBHGpRQEDtaV5yzNHgKnYFG61z8A
	WZeHmYt2P9wQE2RAZytgo2NfFWmFofrtQY/SHgUCC7pi+dxCVXVEIOFUUQBosd1X
	ejwUa88oevCdCo/IEoL79nQ0t64Mx0OdeIBV7yiRK5h/Rd0FXCG7MtTVfGMBnCna
	Vd1b5rZsmIeUwXH5eLIyAbN1pwnM+tmQ2JE2Qnnv6tZ3cTEQV2wXs7Gl6qy1P749
	DzT0g+sFaFXsJINq6lExyGFXigcTCtr3qy9eVRv8cw20oE+LG1xIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx70bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BJmWnX027286;
	Thu, 11 Sep 2025 19:48:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx70bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BI6ZCb017218;
	Thu, 11 Sep 2025 19:48:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmqa4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BJmS8640698174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:48:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC3AF20043;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D810A20040;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A390FE12AA; Thu, 11 Sep 2025 21:48:27 +0200 (CEST)
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
Subject: [PATCH net-next v2 01/14] net/smc: Remove error handling of unregister_dmb()
Date: Thu, 11 Sep 2025 21:48:14 +0200
Message-ID: <20250911194827.844125-2-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: BOssWzWZaotR_CEJddtNyziy_Z39SRT2
X-Proofpoint-ORIG-GUID: 3elPxzmqpfnbUpHr5_kv2KdvncfHjW8u
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c32791 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=E2BrbLywADzKi2prdkwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX2o8j6i5JyVRT
 hPa2oXSlMmdux7omB9Eq6yZcSZ5+itlq1tOgQtf1xDPpiY5nmKUJfp2vh6YuagBCQddwrhihZRr
 TWW6g2joJhrDF/94P+d73d9/O2WGW9pxiJD+WW0ocIrSIFxKxDkYNcHSohvFOzeLOlzxDeSBt2g
 hZKLAH9t65+ewBz0Ob5r8u03lpJ82ypytQUbZBUITnggZ3Yn7dyNhijBJw8c5iFwgkJ2TYtU/Xv
 2k57+s5ErJDIw9RE4d/o6K0OTEULUnYd/31bSU26OY1AwXDazvPZ4Eul+9ByWb/tp69/e7X0zOs
 9/Wcafqic+FZWw2axlV6ydfn37N1zJtLsL/lQdD0AlezhYtgTgnybotfBr6kFb/rJfD+HINnV6e
 urYCp68G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

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


