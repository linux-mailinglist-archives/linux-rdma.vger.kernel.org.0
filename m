Return-Path: <linux-rdma+bounces-13617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE26B99852
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976D2174D55
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79C2E3B16;
	Wed, 24 Sep 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QzOCyjeF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EB2DECD3;
	Wed, 24 Sep 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711717; cv=none; b=fHzd8H/SUk/GFInSRtYqZY9bbZCfdnHtPTVsqdmb6rmwHeREZ+xgfAM0p5o2MizGPAz3+1ua4WRUL6T8dNBHcZ2Jtmuke3xezR2KUdCvBCLTYFpMBo94bB3elKno83QbHklIvfj+Nx796bY2kfPIq7JGu3i8heZLGfkTfeL7qOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711717; c=relaxed/simple;
	bh=cr4qWuS/qeNoGn2r3UvjRXrjCPoHcvjyAE2TZOBIwK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+CoXshz4OnCplC8MnckHvo9ZD9WHzZzX2CbV9NatCiE5dbc14GT7aqlDK2kWXH1PbFLkEi9qS6QqC6JN5EsgIq4jDBZw7N/sM9sbVZjOd1yfNfpsGLfe9I+A9YRGiAuxzArZXsZzFgvH2xO3xmPA69YTwZUJcBVFfetuliRlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QzOCyjeF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9MwjE007064;
	Wed, 24 Sep 2025 11:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=zCmu1PRApsVncooi0pNqkyzI+iNQK
	2CT/pGQIAlwKq8=; b=QzOCyjeFwZZTZ680JqataNNz16/V1YMzkHrjazpooAB8L
	hJ3OTitLWM3OyJiv+/0gH+tENckua8raBuwqop6RqWfGjyF6gngodWfEeSocI8R8
	qgwFuNigvnL+bY+wwz5Wvb9r4BrC1DupOB77Wb21dT2kOehuCj0fBBmnxnj1G7BN
	SbchOBKRFqgYHvktAIO3RXCgbajZkZvwMOjL3y7i9ae76lzAZbeJnds7g7CSXxTw
	n5GWmQaYKjo/mpzxxoq1I3qMT5Qpx87KA0nLpmcTmQQB/M9TU7R/2TNCujI7VWjW
	jtkgW25IYjw32XJcuuCUqgthXsthJFcr1CnOtmF/w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv17mk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 11:01:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9cQkh040890;
	Wed, 24 Sep 2025 11:01:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a950k9f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 11:01:38 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58OB1Yma003988;
	Wed, 24 Sep 2025 11:01:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49a950k9e2-1;
	Wed, 24 Sep 2025 11:01:33 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 rdma-next] RDMA/bnxt_re: improve clarity in ALLOC_PAGE handler
Date: Wed, 24 Sep 2025 04:01:27 -0700
Message-ID: <20250924110130.340195-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509240094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfX3CNqDwlp7wJy
 Hdc5IwqQu2LI4loqLXTdb7cwg+CE+befGQAu8NbVffOZZsRvM3Lp0jNeKmBwP5qFk0ZaE6LRIdG
 d0ulHUR2s0zNni50Z42XDqivT4B4d9eCKavwkNNOBPc/12Suc9OxszQfMMi7U6D9KeQKeDwwA9Q
 ufuOdpPJxH3zoKeGYgbkVrCB8hS+dFuhmvTx46xizMMO5VAt9DpN6akRpxDEK7Qo0feoBrrYrir
 ePd6oGpMPQL7so0ci54emfpcrns8/mPNeN/bgu/WanRpvm57Klyyts5BeljrNdSVa96fkEHht8R
 En4+TZTe381jDUG9aUx/5VumCTBThNYmqq0ulry0OubeEPyteR5IELsiUfqJrgTyYb2Mb+8iZU7
 uj7iAm5oQXO/iYYk8Vms0FyteNsI4A==
X-Proofpoint-GUID: Cf-pPq_lhvrXMoWW70YWGaW1pP06MkxJ
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d3cf94 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=Q-fNiiVtAAAA:8 a=UKki0cc_KDZAvk2E3YUA:9
 cc=ntf awl=host:12086
X-Proofpoint-ORIG-GUID: Cf-pPq_lhvrXMoWW70YWGaW1pP06MkxJ

Update uverbs_copy_to call to use sizeof(dpi) instead of sizeof(length)
when copying the device page index (DPI) back to user space. Both dpi
and length are declared as u32, so this change has no functional impact
but makes the code clearer.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
v1 ->  v2
added Reviewed-by: Kalesh AP
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 8236d82e9a67..4dab5ca7362b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4746,7 +4746,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 		return err;
 
 	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_DPI,
-			     &dpi, sizeof(length));
+			     &dpi, sizeof(dpi));
 	if (err)
 		return err;
 
-- 
2.50.1


