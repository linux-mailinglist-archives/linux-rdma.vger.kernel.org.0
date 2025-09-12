Return-Path: <linux-rdma+bounces-13314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE5B55009
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 15:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954AA167EF6
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB883081B8;
	Fri, 12 Sep 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kcvZOLE3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5F3002DE;
	Fri, 12 Sep 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685068; cv=none; b=HaATVJyj7Fhs9o+oH31aURraDeQuMWyrHWg3W6yd3sLv6BanwcNSyL4z/WskftqSzoeEicqTq3bnbaRgHh7GJ4NJKKVF182U2tJj5m91/eTlOna3cP6Tfik7vycCEUicNh5AYi27ReGBeZNm4VfqJx0jsNcirrHzYYn9ZIS32qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685068; c=relaxed/simple;
	bh=2UKOvJk8sT4wD4CgxBKlGW2IV/aUfFIbJVKRo8iIYN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PFwfrDm9lucFCT0gZo7gX3GnVIVLvvTtpKGxkuPn2/wgbz6FnByFxW2TCLfXXWHWjSNry3G01uKzUnL9bGJuD6TjzLNbr/TX2J4CI6uP+V81FSx3dLekZGm5n7Fapvj9Pi9eva1ekt1mH+EOFUtT6v1s+pGt/FtK6ZFRvwlGiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kcvZOLE3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1ug6O022007;
	Fri, 12 Sep 2025 13:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=FjSQ5V25DxhSwBaA
	ZR7X4fXaIWfKI+kAQTy1IEtVj7A=; b=kcvZOLE34K4Le2UjSzafLHvlJKN32XXT
	5ntuMXf87wG4N2SEbxl+CjBEKhLlnQCKtWB6B2mETSQTcNKPv8yYX5pvei+x99+d
	zBzhIvN+yHJ6sBincrTWZE8S9shiCo/nwWTe6Ml+6ACAd7d0G2UeXt6CVr098WVY
	shLs1YwzuTTCyyq+BxEb0mVe4t8nFytq5eyx0Su92QQ4NKyQxtiJu9GzllNuJEjH
	NX70hnDjI3oh4ua0uk63L9dxY05zdYUn6cmhcVaxIbF4nvCesG2RyQOMWRGhCXq2
	DW6d5Xg7CClFcDyNb1v1lMH2u04FNHsIbJHt4V70crvyKXbl1qIgHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jh0a6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:50:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCYdrJ038766;
	Fri, 12 Sep 2025 13:50:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddwe5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:50:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CDosCk009920;
	Fri, 12 Sep 2025 13:50:54 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 490bddwe53-1;
	Fri, 12 Sep 2025 13:50:54 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: mbloch@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: fix typo in pci_irq.c comment
Date: Fri, 12 Sep 2025 06:50:44 -0700
Message-ID: <20250912135050.3921116-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
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
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120129
X-Proofpoint-ORIG-GUID: gRGxFeuuodI3g7xOcg63x8ZwWVzXQPTY
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c4253f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=nEMAJ4ySRUttQcq-aIwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: gRGxFeuuodI3g7xOcg63x8ZwWVzXQPTY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX+YMhEWPfmsP9
 fbzOs+5rzoaYk9lUxWpzPZ6mwtIbkzlQnBMTpPQye0dU7mJxO4V18Xi/zn2TTo81JtV/Z0ETxOM
 87hP2PXXHlnrz+Q1JdV/4l8VmT1W3F8pWF1x2x2ACOhmAkeRayMxvXzb0edOLhyF6j21cddWxi0
 QqthTk5w4wTYbg64x5tLYBeAgqm4M2q+yqoWPNDbSvlmO8mLJcwlm3n96QAdvwfa3+yTXyLXL7r
 IaCRjwG9Aimf40uL3Kfn0Yrd6TCe3/buBfYgwyUNivXyynSXBtdPvWz9CaHfrtoHmp/m1ddZZw4
 xwiSCRBoiaP47ia37mYBpKrDGczdPQIcD9kiQJ3jwIVfBqOtZKnOmBPJFRZjpZDlTJDXjAy8Duz
 Ny8UNEOXQ1hdWZLpszgbWqOfQNe7Pg==

Fix a typo in a comment in pci_irq.c:
 "ssigned" → "assigned"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 692ef9c2f729..e18a850c615c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -54,7 +54,7 @@ static int mlx5_core_func_to_vport(const struct mlx5_core_dev *dev,
 
 /**
  * mlx5_get_default_msix_vec_count - Get the default number of MSI-X vectors
- *                                   to be ssigned to each VF.
+ *                                   to be assigned to each VF.
  * @dev: PF to work on
  * @num_vfs: Number of enabled VFs
  */
-- 
2.50.1


