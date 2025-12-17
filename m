Return-Path: <linux-rdma+bounces-15046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BDDCC6FF7
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 11:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE0B3076E06
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5CC33BBC0;
	Wed, 17 Dec 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oT+diOBJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DF33B971
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965735; cv=none; b=PbThzefoWHtzgu4CU47sgkYW7M0amvdYrf2vHWvvDTl0G0yh6lD0GDzEVnsxPGQbqR9kCpNQVAmNMy9brxlnIYAv2tfut4b7KSmUYvosLF76u7+XSrKA+gZ+yXTJd9nBEk+phnJTtFpfQSDeSJeH5chSCNsxinJZDEgQy4EdAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965735; c=relaxed/simple;
	bh=fdzu72r8nQ/kLADu+08alFywaDPDrcxmHTshYZBHDcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYJJ8tuSltNMFlupiof46OV8XEtI9LRvpo9tB/3yKEOIF2p6JF3e5wB9lIG4qYikohpWOeye7YCFji5HbiXa4A6GFhAxpt3lWK5xCkgiod5A6ZRgtUSH9cn7FI336e8/WTzAgZRqBgxuKOUM7uCqzmCT15ADiGFlGSBuFDaC3bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oT+diOBJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH6Nb2T2068652;
	Wed, 17 Dec 2025 10:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=lBiXjFq7jI96Ic4DejIezxxQE7Zh/
	njVD7QDk7sF4Ic=; b=oT+diOBJQTP/hNae1Kp60FiptUwVRgkFZqNidQJiSew9R
	zSCxJt1kZmrAMRzOxpUUMGk+OggwYLtYQ/h/b/yk8inPs388sW+TXiaF0TqwarI+
	CsAsV6bpNVxxv7PZ56dqd4TS3oL9vKJAM5whUajN8v41kzxWEQT1OOz4/qmWlzGN
	bRZS8h/HxxUvTWY8ssimz9t+LN1DWv2BpNWZeTYY/BwszGObufKsuV7MQO3xWgQh
	6PDJdTKYmHeCwWi7SGJvXckik9szfjILXTgxDfi2Gx4lbzMOrRaeP53ZgSveoXBF
	D4WBU2jCyNvjB6caBH+GG+a+kujeLLb5O6KUn82CA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prnjjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 10:02:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH9PBLx025872;
	Wed, 17 Dec 2025 10:02:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkbkrhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 10:02:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BHA21Y3039698;
	Wed, 17 Dec 2025 10:02:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xkbkrf4-1;
	Wed, 17 Dec 2025 10:02:01 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: leon@kernel.org, jgg@ziepe.ca, kalesh-anakkur.purayil@broadcom.com,
        selvin.xavier@broadcom.com, linux-rdma@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] RDMA/bnxt_re: Fix incorrect BAR check in bnxt_qplib_map_creq_db()
Date: Wed, 17 Dec 2025 02:01:41 -0800
Message-ID: <20251217100158.752504-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4MCBTYWx0ZWRfX5uzU0ZFTXVUP
 8G8qfnQfz1172FvrxUGIcdICkY/+Y9Ak+5tXMncpTWIuFC6W9JFx45jxoGaVgYECabnZi/OpKbG
 HJDvQk4SMyBmu8+cHcU3OY+jE6DYXiKVLRPj730Th5kYtH6h0KxnfwN5RpV6ZEaXnA29ZECKVuy
 c9ToSjKUVuft8vViXb9HqU8u49YhtXnGGE1qVPcheFbzwxHQw11uZ6WndIDHjl5a2Y/3ix4DeJh
 BwmG0kUfLNsYlA4h/2Mhigg+pB6yHoaCFoeCUKvqiRWdfkbwc1cPnHd4WwrYct34RU3h5a4+wbT
 NHrnl6mSOFnjGPPw4WlWzPpyZa6d/nn6JcczQ027HkjcC1iM2mnBI6U3duaHZFL+5W+jzZwPS5q
 bZJHNHvV/k7vQpytZLFJyVb7b6at1A==
X-Proofpoint-GUID: fS9cn5Lfj5Gpc_-WI43oo69GThy923bH
X-Proofpoint-ORIG-GUID: fS9cn5Lfj5Gpc_-WI43oo69GThy923bH
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=69427f9b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=7eklbggE4qzE31kMUBkA:9

RCFW_COMM_CONS_PCI_BAR_REGION is defined as BAR 2, so checking
!creq_db->reg.bar_id is incorrect and always false.

pci_resource_start() returns the BAR base address, and a value of 0
indicates that the BAR is unassigned. Update the condition to test
bar_base == 0 instead.

This ensures the driver detects and logs an error for an unassigned
RCFW communication BAR.

Fixes: cee0c7bba486 ("RDMA/bnxt_re: Refactor command queue management code")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 295a9610f3e6..4dad0cfcfa98 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -1112,7 +1112,7 @@ static int bnxt_qplib_map_creq_db(struct bnxt_qplib_rcfw *rcfw, u32 reg_offt)
 	creq_db->dbinfo.flags = 0;
 	creq_db->reg.bar_id = RCFW_COMM_CONS_PCI_BAR_REGION;
 	creq_db->reg.bar_base = pci_resource_start(pdev, creq_db->reg.bar_id);
-	if (!creq_db->reg.bar_id)
+	if (!creq_db->reg.bar_base)
 		dev_err(&pdev->dev,
 			"QPLIB: CREQ BAR region %d resc start is 0!",
 			creq_db->reg.bar_id);
-- 
2.50.1


