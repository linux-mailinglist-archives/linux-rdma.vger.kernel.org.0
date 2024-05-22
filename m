Return-Path: <linux-rdma+bounces-2581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1EF8CC291
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C9AB22CD7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2AB145B3B;
	Wed, 22 May 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CbYRpL5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3B1448CD;
	Wed, 22 May 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386130; cv=none; b=tJw+Obc/f0xkjdxdAWhXLWPahxvuGx6xveZkS7Wnujkl3aup77SQN/otbG28oTDEV/MBN0OCmLdhdu/Sj2mYc5CtEQfHlkve/6RiZAIuZxnwEbBGd+Ejj4u8uWIKg20YbS1xUKv9jvLowfaktPVeKkwY5PqFTTdrbJe+g6VrKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386130; c=relaxed/simple;
	bh=/eLrnUv/ccO8hCexIgcoaF5RL3XvRmL0xNirt8amung=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ol5zZPKjf3+I0O1NwCks9cEO71hElUJkQTibvTWPMlDAqF4u2autijMJ8/PBrXS+0Z6I7JhKat9TndT0JVtcMLQweZBly+yXqUmykUpb84AAbOPQYaTo9jatdNwON+2cm4M0wBbyZquIKPs3y8CG4/jklmgHxGxXsVkzuBWvZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CbYRpL5y; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqrDU006158;
	Wed, 22 May 2024 13:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=pbtxMEpfCRIbFycrHWd/2ZSkuy58mLEqJ5dDgR/gKoM=;
 b=CbYRpL5y+nKEXK1yOZjHvafkW9Kq5lh/eUXva9Fk1Pj2m4heQlj3jcaOOcJVaX8CBrER
 ZpnssTftW/SH5FLbYCCaRtbA7F3Jlte/ER5FproHJagOgHmMUQknm2J4rwwqVTjMZWXU
 jfpKcqJbx1AMpii/o/5oYivrkmj2s7sXo6Rnmm3CrO9fbwbunMIejVb3SyDRF+d/LPE7
 Wu1mfCtOX2A04JGM6ZZ0YKhZqpTG/4rzgQYK71l6K+sxAwsZrGNCd9XqP4AdQjQQXf5f
 PdWN/YU1lEWxINMeT3VkSEwpxr0OajzL65ROxxvyhqZ7iBAM5lJnIU/Q/JjPqS2V6oYy 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d7qqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:54:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCJjar019632;
	Wed, 22 May 2024 13:54:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98sy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:54:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm2n016070;
	Wed, 22 May 2024 13:54:51 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-2;
	Wed, 22 May 2024 13:54:51 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v3 1/6] Orabug_list: Drop 36459425
Date: Wed, 22 May 2024 15:54:33 +0200
Message-Id: <20240522135444.1685642-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240522135444.1685642-1-haakon.bugge@oracle.com>
References: <20240522135444.1685642-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_07,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220093
X-Proofpoint-GUID: YPkwUK80X36BWKf91leWaqnaAkeuaLAx
X-Proofpoint-ORIG-GUID: YPkwUK80X36BWKf91leWaqnaAkeuaLAx

From: luci <vijayendra.suman@oracle.com>

Build fix for 6.9 LUCI

Signed-off-by: Luci Bot <fajita_us@oracle.com>
---
 uek-rpm/.Orabug_list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/uek-rpm/.Orabug_list b/uek-rpm/.Orabug_list
index c5b31288c668c..7becf1b0a9be7 100644
--- a/uek-rpm/.Orabug_list
+++ b/uek-rpm/.Orabug_list
@@ -2,3 +2,4 @@
 34116060 # LUCI Maintainer: Disable OpenSSL 3.0 warnings for v5.18
 35455153 # [UEK-NEXT] Manage Original OL Signing Keys
 35641429 # Add uek_kabi.h to LUCI and update check-kabi scripts
+36459425 # Build fix for 6.9 LUCI
-- 
2.31.1


