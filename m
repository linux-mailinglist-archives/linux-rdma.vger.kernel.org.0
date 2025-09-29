Return-Path: <linux-rdma+bounces-13725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE65BA8890
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B472189CBC8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB4283C87;
	Mon, 29 Sep 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XXLXaBd/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05A280024;
	Mon, 29 Sep 2025 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137073; cv=none; b=ZDqCpPlJn6EllHbWAuaFry9H2Unia8/3n/32ckQN8RXb6CIMuq83vOutnUtfd6UNhIUiSWMFELWwU4jDPWMdbkBx4feWsVJxomTKdzVLrsWWYdr9hBDotpahR4PIyiLX6Vc8z8RAtmgPFKd+3dyUZ+vRx80vCs5C4JMbOzH966E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137073; c=relaxed/simple;
	bh=6yd3Q4qnaUSpReAq/bQiaYgW+uV6sVr9q2dA3+L3ylE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lgv1GOWlU9wUMzFX842cuW6Kz3PvAHqlc9sWI0H3NSoHHPWtcrnuj4JP33RVd/F+YEBHF6maTZrQeOWd2Kj8idf6F9EXYtxavT2cg10MOhB/BBH71x2xIO6CfD9KfBmqRvvEfTea2eEViS4cd8Q9uqqKCiCtcZPgKa+1Aq8iyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XXLXaBd/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T8xcch028804;
	Mon, 29 Sep 2025 09:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Z89O+xYIw6zUDIdSMfKGNTSD4Z8jm
	E0GHuzwKb9Y+XQ=; b=XXLXaBd/kgqC/XGsg6vZK0pADJmmhADm7Yh2WrilJuEMF
	LXOisE+qCapQ2Ozh3uzIWTmVLnh8DWuadSQMyIwp2ftW0g3DCPWbPYS9ERw9kD48
	WW3jJW941CMsthNZEytoS9EUSrFMv3LMhfhzleXKTn18mObjOUI3mvLTG64dhjKt
	Jv8/fjREdEZJKcJpBJFRxOsripx9mIeynNVr9EsOxUOSMqHuKtD5yaa1Rl0bGLVR
	zJzO3w8RU+NA8Qn0hLZ2RZYUfvnmqapH82pIUHAP8Y8HL9ZymHAsW206q8t2yj0r
	aP5I+cTF+lOgvXFJDIGSOQkcpOLx+a2/NVmW21ByA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49fq3700va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 09:11:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58T93fEI027542;
	Mon, 29 Sep 2025 09:11:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c65msv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 09:11:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58T997rC030630;
	Mon, 29 Sep 2025 09:11:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49e6c65msf-1;
	Mon, 29 Sep 2025 09:11:04 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/cxgb4: fix typo in write_pbl() debug message
Date: Mon, 29 Sep 2025 02:10:56 -0700
Message-ID: <20250929091102.50384-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4NyBTYWx0ZWRfX+vK+Pu02Trzc
 p6jWPk36Am3qXIrFHp4hIL+/roRzFCsq5qTBa5gP0rCgSsufWluNLLERjR7xVTzUcQXFNl4gYJa
 uiS+s6waj0RFwrshe0q/JzIaP9wQPOIBJmI0pkwVoxznK7B06qR2fDhhKCA24DTjwWTDpe1XCcD
 IGiB8VPs0ZTzEE1V8t3M4dK7Osc4vF4fVYfi4M4q1IpKwPpNPMoYyOPRCaUKk6pSkG9Owk54J3l
 ygBituJH7gfbeEp7uWYLFaZMZo8rC2dMrx9h85ZT6+tTEyLrXe9J5dfW7FqIBJS9+ZGnJ6x4TPe
 EdIbwHSbGNuLxQXomEVu9iwYePYwEgEHwhi06VLeQxvS/1aAelg2IUbtBuILjKJ/bmhbYGiGoU1
 O1XTZeImdodM0M37vhS8ougAm1uAkg==
X-Proofpoint-GUID: wMCFuNZuc-cs_Qrya_Jm9H4anA8ga-no
X-Proofpoint-ORIG-GUID: wMCFuNZuc-cs_Qrya_Jm9H4anA8ga-no
X-Authority-Analysis: v=2.4 cv=PfnyRyhd c=1 sm=1 tr=0 ts=68da4d29 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=GRIWPSkVTmBqgj7X1LUA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22

Correct the debug log format string from "pdb_addr" -> "pbl_addr"
to match the actual variable name.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/infiniband/hw/cxgb4/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index dcdfe250bdbe..adeed7447e7b 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -348,7 +348,7 @@ static int write_pbl(struct c4iw_rdev *rdev, __be64 *pbl,
 {
 	int err;
 
-	pr_debug("*pdb_addr 0x%x, pbl_base 0x%x, pbl_size %d\n",
+	pr_debug("*pbl_addr 0x%x, pbl_base 0x%x, pbl_size %d\n",
 		 pbl_addr, rdev->lldi.vr->pbl.start,
 		 pbl_size);
 
-- 
2.50.1


