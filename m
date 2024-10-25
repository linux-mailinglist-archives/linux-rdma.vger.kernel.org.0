Return-Path: <linux-rdma+bounces-5516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E169AFAE5
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB21E280C6F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41BB1B3923;
	Fri, 25 Oct 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s42weJCq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493E18DF7F;
	Fri, 25 Oct 2024 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841052; cv=none; b=ExWGmoE7MbHL3+XEl50rxVz1+rDLczFf85TP65MBNfxIjJDnXPBxa0KHRXm2N5PkbP+js+lUFFfKZXuv9ybRQcKU7BlSglnPIOMcUZuJrj4y4HGA0nxNm8Sr6ggbUNnyjO28gBhVCkw4XAUbOucteoDXRi/iijAf1UmlzTJXTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841052; c=relaxed/simple;
	bh=rGdMudwJl1RcLtNxkMzfUbwAfbCOQ17rU0daHqxFbjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0hLXY/c/CH1F6xxw9U9QnPgpVgkRH/LvCJyHES0dUUTEIVsP2dkfuRHBvbMBmjynculD8QAc1gsj79tqp+QlzlFc/X8yB27pH8OYPSUyp8243IkAW48fOrGCjb0Twq7PO2xU3QMF5xQIYFmfFYtkHw+bFm132PBIjEljofk+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s42weJCq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P5tQ5Z003086;
	Fri, 25 Oct 2024 07:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CTSkejew1mbESZ6z5fD+xQoUgFiZoV/aiJrEWj5Jq
	cU=; b=s42weJCqX7voseEVEBcNQma0iFA/BLUax86nztNm5EO/1XqIKLQdbfPcf
	7reJBDLnJ2UFrSpZhWsBMpOlux+cy9p0s/Vsxq7Hu5Wtv7yqtSY8YVW4K+xGOer9
	h2Vt0EcRfNCzxuqa3VOU/8/3w9arWh/wrc/SQ84NxL/U6wuH7pFbb/7Vr54gMKZd
	7tMmdGTEUENQuvzNa1W9IuFPxeWrWwU0Niqt69A5uNnXfQbvxSBArSB6i8rcB9dn
	MwQK9BLY0MDvZKob8aCdnsR/KjX4u57mjevTPCzcNTkdqHQvicSsQz0FgrAYW3kr
	ivSF2bsvhSc5v/+sJ0XF1HfAWh/iw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g5kxgayv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:24:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49P7O4js019811;
	Fri, 25 Oct 2024 07:24:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g5kxgayr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:24:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P6PAYT001777;
	Fri, 25 Oct 2024 07:24:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9mh7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:24:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49P7O03k41746900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 07:24:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 175D120043;
	Fri, 25 Oct 2024 07:24:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A03D20040;
	Fri, 25 Oct 2024 07:23:59 +0000 (GMT)
Received: from MacBook-Pro-von-Wenjia.fritz.box.com (unknown [9.171.42.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2024 07:23:58 +0000 (GMT)
From: Wenjia Zhang <wenjia@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: [PATCH net] net/smc: Fix lookup of netdev by using ib_device_get_netdev()
Date: Fri, 25 Oct 2024 09:23:55 +0200
Message-ID: <20241025072356.56093-1-wenjia@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZjED-xRAXRX2C8HLC7WV5QbRbA2h2JcS
X-Proofpoint-GUID: epVEHzlf6S_W2um1v5Ad1WMu_av3QNGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250054

Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
alternative to get_netdev") introduced an API ib_device_get_netdev.
The SMC-R variant of the SMC protocol continued to use the old API
ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
ib_device_ops.get_netdev didn't work any more at least by using a mlx5
device driver. Thus, using ib_device_set_netdev() now became mandatory.

Replace ib_device_ops.get_netdev() with ib_device_get_netdev().

Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
Reported-by: Aswin K <aswin@linux.ibm.com>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
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
index 1dd362326c0a..8566937c8903 100644
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


