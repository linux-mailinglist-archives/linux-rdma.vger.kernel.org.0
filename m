Return-Path: <linux-rdma+bounces-13537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B542B8E4CD
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 22:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E883117C992
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA1F286404;
	Sun, 21 Sep 2025 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llzXZKZw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341127056F;
	Sun, 21 Sep 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758485400; cv=none; b=KA8uPtPZjY/M0Cavwh7vqKLpYNIBlSmvhXuv+5zoGKunIeNUJuS3J2a+zlnQcsYUHHqcKaeDQq9IKVptCR+8Pf2puFROfoqvKJju0zj2905TBNjPfDy1hYm1Qxjr+zw7+FiqBiLGED5TNJduKcWw9cLURusDGIWJAcLYIUfsou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758485400; c=relaxed/simple;
	bh=6CDJ7AhyuSIJd8lWUHCNYysECZVpuIAVFfCe0lXLHuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYGz8xBTNRWVbcY5Dx4oGO6jHlpxeyu3YDo+vrmZmZ4nxpm0yaMy738FBbvF9FTpQYSqLX2Gopt9ZLNyBhSIYGZ9l1yOJizq6QBKwP0wFhd1n39MnRTTQT/+ep5EGIpl4OhqMHvQ97GVrUgtFHCbROiTbGnQoz/zkEWOe/E8yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=llzXZKZw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LFcexo022357;
	Sun, 21 Sep 2025 20:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=k6CFKAF+82TrCz0nzR8+Lbuhmdt47
	tf2NSkt3ox7hbE=; b=llzXZKZwxSzLzFxRLeleQEWZ92ctAIMqGKjO4DtQNF3PV
	1GhIb7rC1FPuGXxEed1kt8hDph7AcsdXbdg0aw9AXSDySPDAsJeGZ8EL29Rf0PbQ
	IiFxxLKTR+WelebKpVA2YIQZk8rkqj++ehO8xRQ+dB9NF971LidSPANe6AbOGnLJ
	IpSbJ+MS/QJNKebPCy6pygEBgoW8asqBgbKhtlGwI3R2iqoMZJD/EyMVVSTRFDn9
	c1w7R6QhAmBtzwdEuESUBWzevKOZ9wTVLTctdh+ESEMahG8SlNR038O6zsZv2I5s
	yYoB20zdR6GXiEWz4MeXlTvYmFYJgSUQQkCZGJJqA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdh8xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 20:09:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58LK6TU0002048;
	Sun, 21 Sep 2025 20:09:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq63x52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 20:09:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58LK9p6C037039;
	Sun, 21 Sep 2025 20:09:51 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 499jq63x4s-1;
	Sun, 21 Sep 2025 20:09:51 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/bnxt_re: improve clarity in ALLOC_PAGE handler
Date: Sun, 21 Sep 2025 13:09:46 -0700
Message-ID: <20250921200948.1568850-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509210206
X-Proofpoint-GUID: RO5dcByEwHvj4P8UmW7HkcCgOpe5rugb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX5xB3uCRysueN
 lHanTAe7+ZIoPi/R4Vj1mLEmO9q4R8IyP4VR/n9b2LxIExp/FhY8TqDNh3ePGqcSgdn13bH6Y3v
 Wj1S6koNvjm7a4r+s2uWtOLRhXB7lAWIEc9DjwBOHy1SIBuSJNmK2GSwFDY9S8R1XzT+jj2PWll
 VE1DJwvXEeOo3pvFz5gSdE0BsZ6zC4wPu5/PpBcto7R28/WzQqXWG4dWToDR4PCagxtjLdl+xqS
 Jy/hd0Y+q3LPXH5+DHpx2Ye9xkD3Ufe7nuVRP4PGX82vxIWE/qGVMUTAWvi78UCc1dppEm7UIsY
 TYfttZvHF4lB/qnATho8A/jn118eBAYc92GRmaotxyPH5+B43iO2oLUdfrdA3ItAZDocBX3dPI4
 brsNPXpf
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d05b91 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=z5HJRSdbJYA6UED7pmwA:9
X-Proofpoint-ORIG-GUID: RO5dcByEwHvj4P8UmW7HkcCgOpe5rugb

Update uverbs_copy_to call to use sizeof(dpi) instead of sizeof(length)
when copying the device page index (DPI) back to user space. Both dpi
and length are declared as u32, so this change has no functional impact
but makes the code clearer.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 6bb4f6ac8476..09cd2622e363 100644
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


