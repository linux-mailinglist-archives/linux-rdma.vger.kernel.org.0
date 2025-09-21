Return-Path: <linux-rdma+bounces-13527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04AB8D755
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 10:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02C27A2969
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52E41A8F;
	Sun, 21 Sep 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNRemo0r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A531F03D2;
	Sun, 21 Sep 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758442755; cv=none; b=skC8ZQLwx0eJcXUoXP8W6rPFTLjWao7WLG1oMy1BOyMMmrJVeXH2VXA3BMWxyz1F9aCEREVAqcVEM2ZdeUPka60usHvKcRp1BwD0CBHu0lOL0whmu0HHRHzbYUHv8pDwy0y99naupwSNg/CBu/PpTcJGvzobtkGNT1PGMuO+X5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758442755; c=relaxed/simple;
	bh=jHs4/gN2SeIRDXGb1k9CE0pyWKprUPFK1+h4YXCdgwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgDmLk1PGLb8a9j0I4HoMNntOFabsl0WFucXuD4fJ+SjIVcfUGlBdY1Noc/Rq15l8cuypocxngp2pz5fK1pVfyVLo3otV4C6uYRCCixckT9uuMpkUvNxum2S/tF1dUGhBW8vgrY8ARAONjXKeeCHS3YnMHCGuV2JgsWjMGFEmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fNRemo0r; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L6guAj026203;
	Sun, 21 Sep 2025 08:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Qz3FrvIXvdzdbWbVMwAPsQLYxGef+
	xBgNcMvfosS/O8=; b=fNRemo0r/EkichrNqwQo9tWxogu7xvLKpqmyaohs5VHNx
	QMr9DEj63E8hE/qE4PDokm+T/avNmPhfnQzverNVXnvlN+kG52s3GhjPQbx3q/O8
	8dYHomZozalzpWJOcDJdFmJT4t/cNjXRYEy8DJhel9fjIZQ1F61rWdTcEx/oYDXO
	q9enhQDufABoFevOKOd0EbmXMKg4RyPmFxsrKHEJpEC07rPr6dZtSn3vI9c3/ARj
	rkaiafanBCmDOIeqVQD9095ut+dwrUiUJbuhUvpU1SzWulJTrsLjx2mcri5GIpED
	tTkNZz21/3dxQdJ5lf1pq2DKoxU1oyWxyMLvSNj2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt0tst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 08:19:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58L2Viww002078;
	Sun, 21 Sep 2025 08:18:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq5rfey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 08:18:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58L8IucC028896;
	Sun, 21 Sep 2025 08:18:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 499jq5rfeu-1;
	Sun, 21 Sep 2025 08:18:56 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] RDMA/bnxt_re: Fix incorrect errno used in function comments
Date: Sun, 21 Sep 2025 01:18:48 -0700
Message-ID: <20250921081854.1059094-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509210084
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68cfb4f8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=a2Zrw6guy7SMuBTi8TcA:9
X-Proofpoint-ORIG-GUID: 0OJRmqpfQMGX_khBB3ZtZHibutQx3VFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX5TTouwdULgos
 aEH/1TTVPKEMcC7B9VQCFrdrWeG3iZT4kVKFvK0Qdx8qFGW1gePM+MKU4isr1boJe1Jnn+B/Y3K
 YdqD4Q+S4/b1TfCuY6U8AO9QLGEIkWwzPmdTH8A4G9FFRLGUYFNFVEQ+pQgQG+tllknHpFOHtpJ
 OEkgfXdMDaUxjVrsqr6vAhO2dbpeTGnYh2sxfyHn5HA5gC3xhKaI1CAgLROAfV/F4G4S3r3DO3B
 JoF7N9N/zERj/9wP5Rwkz7C0skJ4zYrdO+1Bp6z+1fq1LSf0titn8eKX0nOIr5pAEdx9UKl6GKO
 hkSfjsRiA3KHQ98CIx90kQr7WfkPbWBmPlMThlnz6GEHzZH3kfZWwjW1/Gl7y0gW5+wXa2N6PXC
 n7X5nm9d
X-Proofpoint-GUID: 0OJRmqpfQMGX_khBB3ZtZHibutQx3VFB

The function comments in qplib_rcfw.c mention -ETIMEOUT as a
possible return value. However, the correct errno is -ETIMEDOUT.

Update the comments to reflect the proper return value to avoid
confusion for developers and users referring to the code.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5e34395472c5..295a9610f3e6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -186,7 +186,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
  * wait for command completion. Maximum holding interval is 8 second.
  *
  * Returns:
- * -ETIMEOUT if command is not completed in specific time interval.
+ * -ETIMEDOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
 static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
@@ -382,7 +382,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
  * This function can not be called from non-sleepable context.
  *
  * Returns:
- * -ETIMEOUT if command is not completed in specific time interval.
+ * -ETIMEDOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
 static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
-- 
2.50.1


