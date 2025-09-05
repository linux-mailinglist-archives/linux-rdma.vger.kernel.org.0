Return-Path: <linux-rdma+bounces-13110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA1B45479
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 12:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E91A08467
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3132D595B;
	Fri,  5 Sep 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fhcTe84v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A482BE02D;
	Fri,  5 Sep 2025 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067731; cv=none; b=SCGa1JjT+Y4uAuVZK3dsAcm1IUMyLiuUtpWmdkODp58ZCBvL48AaloKIEjDZ903sf1Kn2wvC/lyu4BX0wRvvpIZ6cOqeDu+XVx5C09p2SUMaBaMSJ5OX1z9aiuMSX1y+B9xX5arhq6CMYpJ1EHTcyk+1dUNKFyFncYDoTte2a74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067731; c=relaxed/simple;
	bh=9Qap+eGs7ZQYwgm1QJ8AAh/l4wMnkb7/hdNbQnyD2LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8sW5dJSXMncEwkp5NfOUFjcZNjP9PwUuwOcODQQdiQqRXgauiNXQsc8KZb0lDEDlUF6NuuImLL48kLpjC8T4UV3GdG0NIG4BCYiJEPPsjoRH3MJKyy6snP/59YdVD8ZiOa4mtWSjgz1MmPa+MNBgINsdQXgbfWnhVshl8DthBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fhcTe84v; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AFhjU001934;
	Fri, 5 Sep 2025 10:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=UthwyRnhGLwJ6SHA
	FNKvY9tkC4zGqchzQLCene09JYE=; b=fhcTe84vcdCtp7IbDAj5J6umuB8zBzaG
	P8EN5wecsdGzKsoWumk+nIrjTTd1dkwIsRsEnSkzf6a6EZjB8bQJPrB0rsqHD6Nr
	jRfvBfnx7WcEORJ2KERt7JLmO8k/cbRxOxiai+gdFkxBHJOt4lC3I/t+N28GsOcp
	gY8H2XeZD4Pm3gLLLgUfbYMYHqEHbos0LBYZbhSET7uCQkNEmOTOtboRIgtNlI/z
	NG+tdxPucMHL5QVh29/mB9380Yl/i/Ol2oagrL1NVj2PLTf9K1Ldh8BnfT24cFIq
	pANsFrBFF60Ds/YDFoGesAx7IBKVrB1hz5n+6oglBG9UhMBKNBu/lw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ywxdr077-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 10:22:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Jbf6034471;
	Fri, 5 Sep 2025 10:22:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01s038v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 10:22:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585AM2VU011858;
	Fri, 5 Sep 2025 10:22:02 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48v01s036y-1;
	Fri, 05 Sep 2025 10:22:02 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] rds: ib: Remove unused extern definition
Date: Fri,  5 Sep 2025 12:19:57 +0200
Message-ID: <20250905101958.4028647-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509050100
X-Proofpoint-GUID: BMqJQNtE3aoNiSX-BXnqEAEX98lKcFiY
X-Proofpoint-ORIG-GUID: BMqJQNtE3aoNiSX-BXnqEAEX98lKcFiY
X-Authority-Analysis: v=2.4 cv=S7nZwJsP c=1 sm=1 tr=0 ts=68bab9cc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=vqxsdnOqdfS0dGDShygA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwMCBTYWx0ZWRfX//8KCIUpvCEi
 QFYiuDDSoUJsOEnA8UsILsvv/6ur2lffIkRy5qYNPNJkyBwYSazRRo8H7a7OKa7NyfL4gJ0VFni
 uM8BgUIA6IReItNjGof1siIt5161vvomV1VwbsKZfIVKqa6LSxmZP8CJBSRac0ieV+HRqdgRGN7
 XjbdwXqJ33BB0Z0yYt/EocER9Ks3HfRBxqiVnQPeDJac+zo6ePpYTIHXZAp4lrkbB/Pv1QeUrLw
 BssTK7kSivEahtlWRs+yS0sgYBC3ndJ96CHFWsHzhPFRThKMlXwC510zX1GeqJA5F+9vuaRHYm3
 ZuJ/rWj71OgbrIlqaGkmVh7y9LAz8+lpDl/Gas/GvrZQr7mWotUPbcqY0XKIcg7CVNL3Itc01QX
 vCa68r28

In the old days, RDS used FMR (Fast Memory Registration) to register
IB MRs to be used by RDMA. A newer and better verbs based
registration/de-registration method called FRWR (Fast Registration
Work Request) was added to RDS by commit 1659185fb4d0 ("RDS: IB:
Support Fastreg MR (FRMR) memory registration mode") in 2016.

Detection and enablement of FRWR was done in commit 2cb2912d6563
("RDS: IB: add Fastreg MR (FRMR) detection support"). But said commit
added an extern bool prefer_frmr, which was not used by said commit -
nor used by later commits. Hence, remove it.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

---

v3 -> v4:
      * Added Allison's r-b
      * Removed indentation for this section

v2 -> v3:
      * As per Jakub's request, removed Cc: and Fixes: tags
      * Subject to net-next (instead of net)

v1 -> v2:
      * Added commit message
      * Added Cc: stable@vger.kernel.org
---
 net/rds/ib_mr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/rds/ib_mr.h b/net/rds/ib_mr.h
index ea5e9aee4959e..5884de8c6f45b 100644
--- a/net/rds/ib_mr.h
+++ b/net/rds/ib_mr.h
@@ -108,7 +108,6 @@ struct rds_ib_mr_pool {
 };
 
 extern struct workqueue_struct *rds_ib_mr_wq;
-extern bool prefer_frmr;
 
 struct rds_ib_mr_pool *rds_ib_create_mr_pool(struct rds_ib_device *rds_dev,
 					     int npages);
-- 
2.43.5


