Return-Path: <linux-rdma+bounces-2583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D298CC296
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B107A284792
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9514F13D608;
	Wed, 22 May 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FQgWxBe3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988C145B2D;
	Wed, 22 May 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386132; cv=none; b=TfY2BfbfptQ9WSQNeXnyJJtJAjpfE5ePUwzJJg6P4+rta27zwgu1Hkl3ahslXkY+1Ajgl8rOAhSdfvQ5SpEJcFel4U7rxwqiBnu/wv7DyCYM5Sh4vLeNsm98KOZe295rn5DHzLdD14pXRgsRLuYlx3ASQnGYQY//11yQubVQmh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386132; c=relaxed/simple;
	bh=MrpVZ5Axr/2UuHEVUcVkN9rxOh8kZ1Lj/4sURUpwvng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHNFmhXcCStluovEnpL7BfBit3GzEj3kqPsXhdzVXp7JSwHTIor7GDI8PQt+NpWaARsKhjKCH18WW5QYp+i0wLt4FIVSfKJEPbTO/ZH2bImWL5IauD2+xq8l6mpyWA/FC1aT7Nr/Pi8R1qvGurqwRMqByAIxJ8eySg6ZcOnskzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FQgWxBe3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqdEn013781;
	Wed, 22 May 2024 13:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=8VCdZ6YctjlbVSUNltcvc7m7IvdjWI1xHbgEF6LAwoQ=;
 b=FQgWxBe3ZCeM+DSN2aiTa6DKoBi4zij+gXjbAUQa+0BLIjDrDENe4bux9l6yz9mEfaAd
 7MwmhNNegLHXr7WzRPhJlL0/1k1wQ3g7XY4/mjOKezlKPtJlDbNDqlO1j343C0CQBAtR
 2g+aXfbAjfQ2ZVVdXUHdpQhCOtAfqIwxuRLXAvJo05ldI+rVc9ZZOPcaIgb53Ffe9B8a
 RK5T/UFuAs/cVdqhm3GgqeUMf2UpBFqgk/i+mwIPCAZ36MUoPrn2P8QBS/RRtyaz+XcJ
 eKzDyj/PWXaAS9Vr23sBGD+5irmExXO46eNFiIhcqo4UsTs2SFlZvJQNfagOV9BUGikA lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdyt68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCFwa8019529;
	Wed, 22 May 2024 13:55:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98taa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:12 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm37016070;
	Wed, 22 May 2024 13:55:12 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-8;
	Wed, 22 May 2024 13:55:11 +0000
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
Subject: [PATCH v3 4/6] ml: Remove revocation list
Date: Wed, 22 May 2024 15:54:39 +0200
Message-Id: <20240522135444.1685642-8-haakon.bugge@oracle.com>
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
X-Proofpoint-ORIG-GUID: 47pxZdCNrk_mPFS3VihkLX4jWnE2Ed6D
X-Proofpoint-GUID: 47pxZdCNrk_mPFS3VihkLX4jWnE2Ed6D

From: Luci Bot <fajita@oracle.com>

Remove revocation list

Signed-off-by: Luci Bot <fajita@oracle.com>
Reviewed-by: Mark Nicholson <mark.j.nicholson@oracle.com>
---
 ml-rpm/ol8/config-aarch64            | 2 --
 ml-rpm/ol8/config-aarch64-container  | 2 --
 ml-rpm/ol8/config-aarch64-debug      | 2 --
 ml-rpm/ol8/config-aarch64-emb3       | 2 --
 ml-rpm/ol8/config-aarch64-emb3-debug | 2 --
 ml-rpm/ol8/config-x86_64             | 2 --
 ml-rpm/ol8/config-x86_64-debug       | 2 --
 ml-rpm/ol9/config-aarch64            | 2 --
 ml-rpm/ol9/config-aarch64-container  | 2 --
 ml-rpm/ol9/config-aarch64-debug      | 2 --
 ml-rpm/ol9/config-x86_64             | 2 --
 ml-rpm/ol9/config-x86_64-debug       | 2 --
 12 files changed, 24 deletions(-)

diff --git a/ml-rpm/ol8/config-aarch64 b/ml-rpm/ol8/config-aarch64
index a4df0eba125b6..37d717c5a8d33 100644
--- a/ml-rpm/ol8/config-aarch64
+++ b/ml-rpm/ol8/config-aarch64
@@ -2981,8 +2981,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_SWIOTLB_DYNAMIC=y
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_DMA_NUMA_CMA=y
diff --git a/ml-rpm/ol8/config-aarch64-container b/ml-rpm/ol8/config-aarch64-container
index d793781f15e3d..0fe9d3ff00c24 100644
--- a/ml-rpm/ol8/config-aarch64-container
+++ b/ml-rpm/ol8/config-aarch64-container
@@ -804,8 +804,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CORDIC=y
 CONFIG_SWIOTLB_DYNAMIC=y
 CONFIG_DMA_RESTRICTED_POOL=y
diff --git a/ml-rpm/ol8/config-aarch64-debug b/ml-rpm/ol8/config-aarch64-debug
index c32292309a83b..c53800d995e55 100644
--- a/ml-rpm/ol8/config-aarch64-debug
+++ b/ml-rpm/ol8/config-aarch64-debug
@@ -2982,8 +2982,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_SWIOTLB_DYNAMIC=y
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_DMA_NUMA_CMA=y
diff --git a/ml-rpm/ol8/config-aarch64-emb3 b/ml-rpm/ol8/config-aarch64-emb3
index 1cf1cc181a2a5..f3242c8fd1526 100644
--- a/ml-rpm/ol8/config-aarch64-emb3
+++ b/ml-rpm/ol8/config-aarch64-emb3
@@ -2295,8 +2295,6 @@ CONFIG_SYSTEM_TRUSTED_KEYS="certs/ol_signing_keys.pem"
 CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CORDIC=m
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_DMA_CMA=y
diff --git a/ml-rpm/ol8/config-aarch64-emb3-debug b/ml-rpm/ol8/config-aarch64-emb3-debug
index 39835c5ea13a6..b67b24f5f4128 100644
--- a/ml-rpm/ol8/config-aarch64-emb3-debug
+++ b/ml-rpm/ol8/config-aarch64-emb3-debug
@@ -2295,8 +2295,6 @@ CONFIG_SYSTEM_TRUSTED_KEYS="certs/ol_signing_keys.pem"
 CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CORDIC=m
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_DMA_CMA=y
diff --git a/ml-rpm/ol8/config-x86_64 b/ml-rpm/ol8/config-x86_64
index 6fcf000a07e99..3b64dd1e4d726 100644
--- a/ml-rpm/ol8/config-x86_64
+++ b/ml-rpm/ol8/config-x86_64
@@ -2844,8 +2844,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
 CONFIG_SWIOTLB_DYNAMIC=y
diff --git a/ml-rpm/ol8/config-x86_64-debug b/ml-rpm/ol8/config-x86_64-debug
index 6f416ab81a59f..c7e44a1771a2e 100644
--- a/ml-rpm/ol8/config-x86_64-debug
+++ b/ml-rpm/ol8/config-x86_64-debug
@@ -2864,8 +2864,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
 CONFIG_RANDOM32_SELFTEST=y
diff --git a/ml-rpm/ol9/config-aarch64 b/ml-rpm/ol9/config-aarch64
index 3b5feccf3fac6..52016234394da 100644
--- a/ml-rpm/ol9/config-aarch64
+++ b/ml-rpm/ol9/config-aarch64
@@ -2984,8 +2984,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_SWIOTLB_DYNAMIC=y
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_DMA_NUMA_CMA=y
diff --git a/ml-rpm/ol9/config-aarch64-container b/ml-rpm/ol9/config-aarch64-container
index 3a32908836299..10aab8ae56a80 100644
--- a/ml-rpm/ol9/config-aarch64-container
+++ b/ml-rpm/ol9/config-aarch64-container
@@ -818,8 +818,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CORDIC=y
 CONFIG_SWIOTLB_DYNAMIC=y
 CONFIG_DMA_RESTRICTED_POOL=y
diff --git a/ml-rpm/ol9/config-aarch64-debug b/ml-rpm/ol9/config-aarch64-debug
index a263556e04956..6efe07685e993 100644
--- a/ml-rpm/ol9/config-aarch64-debug
+++ b/ml-rpm/ol9/config-aarch64-debug
@@ -2985,8 +2985,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_SWIOTLB_DYNAMIC=y
 CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_DMA_NUMA_CMA=y
diff --git a/ml-rpm/ol9/config-x86_64 b/ml-rpm/ol9/config-x86_64
index fefc2541cb166..dc72342bc78ce 100644
--- a/ml-rpm/ol9/config-x86_64
+++ b/ml-rpm/ol9/config-x86_64
@@ -2836,8 +2836,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
 CONFIG_SWIOTLB_DYNAMIC=y
diff --git a/ml-rpm/ol9/config-x86_64-debug b/ml-rpm/ol9/config-x86_64-debug
index 358b2ab724b04..fb67da8c1c03e 100644
--- a/ml-rpm/ol9/config-x86_64-debug
+++ b/ml-rpm/ol9/config-x86_64-debug
@@ -2856,8 +2856,6 @@ CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
 CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=8192
 CONFIG_SECONDARY_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
-CONFIG_SYSTEM_REVOCATION_LIST=y
-CONFIG_SYSTEM_REVOCATION_KEYS="certs/ol_revocation_keys.pem"
 CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
 CONFIG_RANDOM32_SELFTEST=y
-- 
2.31.1


