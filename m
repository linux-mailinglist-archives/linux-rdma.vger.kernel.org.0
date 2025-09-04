Return-Path: <linux-rdma+bounces-13081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0EB43AC6
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFBB3A4D31
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD12FCC1F;
	Thu,  4 Sep 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j/jidoTP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492702D5412;
	Thu,  4 Sep 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986840; cv=none; b=CfTkqn/tz4VSUUBxDSRTBkR7J9HqW00dl+RVw4hfGcVBsQTjBH+oEEVtxfhJ7XTNblX0+n5osXMZDtlAqXUniOVRgA9ZEDEAr8Q0PP5ehTveymEPqIypvam43Z4KbarREk5ZXeNuf7YtFlrTeOXhOdC/TqRw1Yhl51SI1lCOCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986840; c=relaxed/simple;
	bh=Uqj1mwVVRPf6dJUVHDMHYF68rIygHhhFT9n30gWW/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPkDQFnJ5Y5VOeXvdiLVQfygRSNW8SaLG5nkiS0uPfXSxJ6GNwg1O6rinagxGxTpz7K66jvFWmEw9EkUWPfWQrtneAvqznh8Q5tuLIi/dMqZkP6LAQX8YF/s6MRD/HwHmO2dX4TV4Ap15kcJe3Wl3JMwkkbcjhLwck963Vgg3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j/jidoTP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849nrvS011850;
	Thu, 4 Sep 2025 11:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=zJPm6nhvLd9SCgGt
	e3OOsBo0X4yKutvdmXTTDmGybsA=; b=j/jidoTPA4hLcIRzzmpCTmr/kaiM+xs3
	VH5IQiL83636OqBfPeJyeAUz3ss8WEeQX6VXAn4SlJ0AQicTQFq4o0kRv36FRIYx
	yHC0OFZpQFlndLvVEr2R9/ydh4t4wjIZoArDCwZ0t1wm1Jzi45Htf44FNvC3cjKk
	H4kVmi192fA7mNdbDHnSK33d0LYIIb+ODK3TY67Do8xmrNw+SaSqN8BRvWqOsLTB
	QNj2uIQ+xGimIEc0g6cTGDhkZ/oeBH+EsKiPnnnMn3KGfi4Fm6bN8Y/JfykiGWBI
	fPZKm6IYfIdXJYHwZF84bX2aEm8V2AePtIayUV1i5GISWiVl4hik4w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48y8fq87j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 11:53:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584Axexe015766;
	Thu, 4 Sep 2025 11:53:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01qrb9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 11:53:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 584BrnvM007701;
	Thu, 4 Sep 2025 11:53:49 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48v01qrb7y-1;
	Thu, 04 Sep 2025 11:53:48 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] rds: ib: Remove unused extern definition
Date: Thu,  4 Sep 2025 13:53:43 +0200
Message-ID: <20250904115345.3940851-1-haakon.bugge@oracle.com>
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
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040117
X-Proofpoint-GUID: FKuVAkVWUcajVvFAG1xNf9egSD3RhvN4
X-Authority-Analysis: v=2.4 cv=eoPfzppX c=1 sm=1 tr=0 ts=68b97dce cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=vqxsdnOqdfS0dGDShygA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FKuVAkVWUcajVvFAG1xNf9egSD3RhvN4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDA5NyBTYWx0ZWRfX2FzGZSOexjtv
 QtufhH/RcXYH89FLqcDilzTdDqMEMY8bD81oO5ZetpQvP0eoPt/eaQaCCCNsR90lrGLs4GXPFTC
 mNv3+aOZk1+D5C/T6QKy4MnhcmxN5R8Y/N32p3qBvvsJ942xYyYpmF8SnvsXyAu/m69aq/rSqwN
 X/xxmrgYTt++m3Bfi9Oh0mybTWX8xN1NSnVrs0LTPre43uDJ8PpXKzCLGXbkEWSyM83ET5zCRvx
 a6oxZxZX+mhapTaOTYlViPBxZhExkMMiGPljsc1rIh/3T1kW5igMmY8is1Y/cOkGFCcdQEa5uQp
 Qo5klO+r3I2jn1O8lNPwZ6ozYVkcrCgqg9vCFHhh6alLBE/Kq8ReP7UM/RS+F6lEeQyAITe1a9J
 Dw6hbvQX

In the old days, RDS used FMR (Fast Memory Registration) to register
IB MRs to be used by RDMA. A newer and better verbs based
registration/de-registration method called FRWR (Fast Registration
Work Request) was added to RDS by commit 1659185fb4d0 ("RDS: IB:
Support Fastreg MR (FRMR) memory registration mode") in 2016.

Detection and enablement of FRWR was done in commit 2cb2912d6563
("RDS: IB: add Fastreg MR (FRMR) detection support"). But said commit
added an extern bool prefer_frmr, which was not used by said commit -
nor used by later commits. Hence, remove it.

Fixes: 2cb2912d6563 ("RDS: IB: add Fastreg MR (FRMR) detection support")
Cc: stable@vger.kernel.org
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

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


