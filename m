Return-Path: <linux-rdma+bounces-2580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7878CC28C
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879481C2298A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893BD1422B7;
	Wed, 22 May 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GM+VLnvB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F31411C6;
	Wed, 22 May 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386127; cv=none; b=pjem8qoGWrvWQscvLOSgZKcq2tyFL87mtsAdT4XBnNtMqlIkGCK9LEdOvKErFcbjtrfBIEYGiFx6orQ7c0SBWJDlbkNbcq2IqgbqDSUr9/hUIdWEcTpA+jB3PGK9EG/hJ2TY8HSyIWnKT1rrOxqUJRJHoLzpoQh3PsezLiJKKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386127; c=relaxed/simple;
	bh=6N5fPUydPwCdo8b408ssTFRPGAydsftvTekE98oT2vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbgYjFV19HMJHbAZEGYcCTdmzAVeMSgjzbH8I2QfApxoJ4TPst+eUCyAFxg3LDU/FWHQRC/82ES4gGx1/GEgXA/KHM45GLNFsgfauNDE91MDVB89mR/Ra5UCZAMq1hdEU6lBHsncbG9QELNDQ67f+D+f/tj8Yo1xLpRDTnZjp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GM+VLnvB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqgxt023730;
	Wed, 22 May 2024 13:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=bOGnrc1BVsuP3kWUt6pR1W/GO+qodCsHYHjULVIOpCY=;
 b=GM+VLnvBoF+DreLPbvQvPs3WD6mYfUdneWVnal+YTzjuPC5DFQK2ANtH704JfC3ZupBV
 WwBnDWaYcx4yjhwxK+kUbkDZJX/wTCouO0OGNG4Q8B3YgIICIzPzL9atL9gebsMBmzDr
 sXZfH+dfT7YGAJo5G6BdAjDCvuV6Ly8CZN0CwPS4jQsx2Kqd6oWi1qSrqfE/0c8e4eHg
 sXLdlLQzE8R969GoctMMPueu2xKGS9tGjjrFfr6sMADtVdesqco09k5r6kyrBQ2OXL8i
 9+X9LFyPkaGdV0EgslfT+KJe5sUQRPAjtdu9a3pny8zxo5016yhb7z29VaaKZSjvu7fr sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jreqngd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCAsXk019535;
	Wed, 22 May 2024 13:55:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98t6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm31016070;
	Wed, 22 May 2024 13:55:05 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-6;
	Wed, 22 May 2024 13:55:04 +0000
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
Subject: [PATCH v3 3/6] ml: adjusting build metadata to reflect mainline
Date: Wed, 22 May 2024 15:54:37 +0200
Message-Id: <20240522135444.1685642-6-haakon.bugge@oracle.com>
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
X-Proofpoint-GUID: kFQ9ceil-5pmcpw8xWP754QdYsPnrR1Y
X-Proofpoint-ORIG-GUID: kFQ9ceil-5pmcpw8xWP754QdYsPnrR1Y

From: Luci Bot <fajita@oracle.com>

Updating defaults to reflect that this is a mainline build

Signed-off-by: Luci Bot <fajita@oracle.com>
Reviewed-by: Mark Nicholson <mark.j.nicholson@oracle.com>
---
 ml-rpm/ol8/{kernel-uek.spec => kernel-mainline.spec} | 2 +-
 ml-rpm/ol9/{kernel-uek.spec => kernel-mainline.spec} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename ml-rpm/ol8/{kernel-uek.spec => kernel-mainline.spec} (99%)
 rename ml-rpm/ol9/{kernel-uek.spec => kernel-mainline.spec} (99%)

diff --git a/ml-rpm/ol8/kernel-uek.spec b/ml-rpm/ol8/kernel-mainline.spec
similarity index 99%
rename from ml-rpm/ol8/kernel-uek.spec
rename to ml-rpm/ol8/kernel-mainline.spec
index e9a4e07f43fe7..ed47eb0706a87 100644
--- a/ml-rpm/ol8/kernel-uek.spec
+++ b/ml-rpm/ol8/kernel-mainline.spec
@@ -388,7 +388,7 @@ Summary: Oracle Unbreakable Enterprise Kernel Release 8
 %define kernel_prereq  coreutils, systemd >= 203-2, /usr/bin/kernel-install
 %define initrd_prereq  dracut >= 027
 
-%define variant %{?build_variant:%{build_variant}}%{!?build_variant:-luci}
+%define variant %{?build_variant:%{build_variant}}%{!?build_variant:-mainline}
 
 %define installonly_variant_name kernel%{?build_variant:%{build_variant}}%{!?build_variant:-luci}
 
diff --git a/ml-rpm/ol9/kernel-uek.spec b/ml-rpm/ol9/kernel-mainline.spec
similarity index 99%
rename from ml-rpm/ol9/kernel-uek.spec
rename to ml-rpm/ol9/kernel-mainline.spec
index 0b494c7cf567c..0eb7d20043ed0 100644
--- a/ml-rpm/ol9/kernel-uek.spec
+++ b/ml-rpm/ol9/kernel-mainline.spec
@@ -361,7 +361,7 @@ Summary: Oracle Unbreakable Enterprise Kernel Release 8
 %define kernel_prereq  coreutils, systemd >= 203-2, /usr/bin/kernel-install
 %define initrd_prereq  dracut >= 027
 
-%define variant %{?build_variant:%{build_variant}}%{!?build_variant:-luci}
+%define variant %{?build_variant:%{build_variant}}%{!?build_variant:-mainline}
 
 %define installonly_variant_name kernel%{?build_variant:%{build_variant}}%{!?build_variant:-luci}
 
-- 
2.31.1


