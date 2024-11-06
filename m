Return-Path: <linux-rdma+bounces-5783-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2869BE0EE
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06622848BA
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7D1DA63C;
	Wed,  6 Nov 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vq3/ZVxg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284631D5151;
	Wed,  6 Nov 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881603; cv=none; b=fS/XyN4IVomIpQ1+1DRFjVQtDGh42SjtqfYsZa3s0c+tv65sv8wzi/3jYUc+n2EneA1mycImECrNcUUnJTVUcsl7McAgzvF78OhLHRAQAJPiL42k28z41DITcedRsV5AxgcpN/BiES4ljIPQ5rCo7B7v2Up1WPOGc1Gn27Uprks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881603; c=relaxed/simple;
	bh=iUcT/gwGrRVy7MprbFBNOk3U6166YlFFOKSZnEBXUx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRJQUUkEywnM3uAnIxjYOOU1pGr0/sdijIY5QTnIomGYM9japRMUZ1BbKmvJ2qorzMsPXHSOOqFGcbCGtMiQFiwV/W2flOGzkexumhpEBz+PLdLfRN1ed+AcLl05pm5IP04oBtE3mHtUqsStJg2FZ9da6Qu5N0SSGyxrtHx0zQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vq3/ZVxg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68BISL023384;
	Wed, 6 Nov 2024 08:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=e52w3lhZtfHAPxbejgCls0YBeKYdmjEqpuUeEO/e9
	Ng=; b=Vq3/ZVxg0iiGSXTQdZFL/84BtJzolkQLzzFKlHvZCGTnyrRkmBXyMnGJg
	xqMtcx8FDWH7MOGd/W0LkGkKspC5t15LuY4HEfigXhq5W4/jJ38duq+5pAdd7JQ1
	ZCdv4H3Xs8oSXULhJ6KvdqHF2EcEaT0f0sjoiqI3AB8Ej8aOXVq7YH5u+2+PMG8O
	Y3A7JAuc0yo0D6p38+j1db/XcnJibBO14Mrzlh0jMshE80qgUj8drPUiGyVMMckn
	hznRA+yLUxqKSF8/H5WvXmeXb+SPX108bQDTlOcVtZ9WLyN4oK7jMvgYj9xNIOh2
	JFWmQASulNEWbZGZYxSDoHOskjZpQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r4q0825j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:26:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A68QW5A019713;
	Wed, 6 Nov 2024 08:26:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r4q0825g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:26:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A645qEs031854;
	Wed, 6 Nov 2024 08:26:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmnsgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 08:26:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A68QQaH56099128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 08:26:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9F320040;
	Wed,  6 Nov 2024 08:26:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E2A720043;
	Wed,  6 Nov 2024 08:26:24 +0000 (GMT)
Received: from MacBookPro.fritz.box.com (unknown [9.171.50.17])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 08:26:24 +0000 (GMT)
From: Wenjia Zhang <wenjia@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>,
        Dust Li <dust.li@linux.alibaba.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH net v2] net/smc: Fix lookup of netdev by using ib_device_get_netdev()
Date: Wed,  6 Nov 2024 09:26:12 +0100
Message-ID: <20241106082612.57803-1-wenjia@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vVliH-_85x80HYY8j6ru-P5L6NRwzY_w
X-Proofpoint-ORIG-GUID: FvfFRUqBOtmALvW4bUO29lKSWp4I1oQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxlogscore=936 mlxscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060065

The SMC-R variant of the SMC protocol used direct call to function
ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device
driver to run SMC-R, it failed to find a device, because in mlx5_ib the
internal net device management for retrieving net devices was replaced
by a common interface ib_device_get_netdev() in commit 8d159eb2117b
("RDMA/mlx5: Use IB set_netdev and get_netdev functions").

Since such direct accesses to the internal net device management is not
recommended at all, update the SMC-R code to use proper API
ib_device_get_netdev().

Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
Reported-by: Aswin K <aswin@linux.ibm.com>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 net/smc/smc_ib.c   | 8 ++------
 net/smc/smc_pnet.c | 4 +---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9297dc20bfe2..9c563cdbea90 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
 	struct ib_device *ibdev = smcibdev->ibdev;
 	struct net_device *ndev;
 
-	if (!ibdev->ops.get_netdev)
-		return;
-	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
+	ndev = ib_device_get_netdev(ibdev, port + 1);
 	if (ndev) {
 		smcibdev->ndev_ifidx[port] = ndev->ifindex;
 		dev_put(ndev);
@@ -921,9 +919,7 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
 		port_cnt = smcibdev->ibdev->phys_port_cnt;
 		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
 			libdev = smcibdev->ibdev;
-			if (!libdev->ops.get_netdev)
-				continue;
-			lndev = libdev->ops.get_netdev(libdev, i + 1);
+			lndev = ib_device_get_netdev(libdev, i + 1);
 			dev_put(lndev);
 			if (lndev != ndev)
 				continue;
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index a04aa0e882f8..716808f374a8 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1054,9 +1054,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
 		for (i = 1; i <= SMC_MAX_PORTS; i++) {
 			if (!rdma_is_port_valid(ibdev->ibdev, i))
 				continue;
-			if (!ibdev->ibdev->ops.get_netdev)
-				continue;
-			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
+			ndev = ib_device_get_netdev(ibdev->ibdev, i);
 			if (!ndev)
 				continue;
 			dev_put(ndev);
-- 
2.43.0


