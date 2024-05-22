Return-Path: <linux-rdma+bounces-2585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF098CC29F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CA1283072
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB71474D8;
	Wed, 22 May 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HP9ybbBS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802721474B7;
	Wed, 22 May 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386139; cv=none; b=cF1E4Bsv/U//zyFhHQK1ffSfOsMgyYyZaOV0MMoagOZ1wYrpPWYs0S4acvubJpMNkQLebsnVWKgybXyhoT2Idi02g5IrH8kf/3rAgf2TiemqZapeV8Kr/SXvyGRzF6tSCXdMLmqnFtFt+7Lo4JOAuSrQdo2wf8z2v6qVKGB93Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386139; c=relaxed/simple;
	bh=kK+OhbDo2JEyj7pc/ZTdnFaD3OwZTrp2X84sYD1+N90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQazxVspcQK3BW4HoaJr2r4ITXZKg5mZVpq47Q1OpJmamOakADl1zLAsJy+Tlpw2gaZXEAXEOCIZPrtF5KkyYR+5KEdP6rwViB9D0rMLKyaOVXUd6bTQlXIdDXGqYL2QEo4ZIW6kmgHTq7aL9PBRTpeWfxD4WKEcfdoLT5EeorQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HP9ybbBS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCrKJS006713;
	Wed, 22 May 2024 13:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=IObyseWmhRp79zg0ks96haG4gisXWog/WVAkWgKvqZ4=;
 b=HP9ybbBSqzogk8n+cAqj9qnJ7c7dnxdVgWvLfOz42l2gwb9fnM7w0aHV70y62UmDy+5n
 hA2pLsxynaCyvGT6Vaz/crUkHOwgIoNs6wxbx9nkV3swxEgzh/3Blfpu2Tlp844gDwYO
 mi5Uflwifu+BOkYIgTxDt2krCMYd88VJ7uP8q5Z0zM53KED710Yb5DWd1J/tv8HoyQUK
 qtok4jQpsDQsjFw8IBnHjFknD3G/MDInd16H/MbekNg/2eDX0QcgyL8Ta0XS9qVnvcwp
 oQGD5Oew+PscnyLlEYmzaodhFaXLVocFEnEhrTngoOuRgfAmz/iBGhl9Gy5ViO+ecW9e hQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d7qru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MD47EJ019531;
	Wed, 22 May 2024 13:55:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98ter-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm3D016070;
	Wed, 22 May 2024 13:55:19 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-10;
	Wed, 22 May 2024 13:55:19 +0000
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
Subject: [PATCH v3 5/6] ml: Add ol_signing_keys.pem in certs dir
Date: Wed, 22 May 2024 15:54:41 +0200
Message-Id: <20240522135444.1685642-10-haakon.bugge@oracle.com>
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
X-Proofpoint-GUID: 0x85Bf96kQPixahaWTzFnCc5zFp9Zd4E
X-Proofpoint-ORIG-GUID: 0x85Bf96kQPixahaWTzFnCc5zFp9Zd4E

From: Luci Bot <fajita@oracle.com>

ol_signing_keys.pem is copied in certs directory

Signed-off-by: Luci Bot <fajita@oracle.com>
Reviewed-by: Mark Nicholson <mark.j.nicholson@oracle.com>
---
 ml-rpm/ol8/kernel-mainline.spec | 11 +++++++++++
 ml-rpm/ol9/kernel-mainline.spec | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/ml-rpm/ol8/kernel-mainline.spec b/ml-rpm/ol8/kernel-mainline.spec
index ed47eb0706a87..8487d522984a3 100644
--- a/ml-rpm/ol8/kernel-mainline.spec
+++ b/ml-rpm/ol8/kernel-mainline.spec
@@ -483,6 +483,7 @@ BuildConflicts: rpm < 4.13.0.1-19
 Source0: linux-%{kversion}.tar.bz2
 
 %if %{signkernel}%{signmodules}
+Source9: ol_signing_keys.pem
 Source10: x509.genkey
 %endif
 
@@ -1110,6 +1111,11 @@ BuildContainerKernel() {
     perl -p -i -e "s/^EXTRAVERSION.*/EXTRAVERSION = ${ExtraVer}/" Makefile
 
     make %{?make_opts} mrproper
+
+%if %{signkernel}%{signmodules}
+    cp %{SOURCE10} %{SOURCE9} certs/.
+%endif
+
     cp configs/config-container .config
 
     make %{?make_opts} ARCH=$Arch %{?_kernel_cc} olddefconfig > /dev/null
@@ -1159,6 +1165,11 @@ BuildKernel() {
 
     make %{?make_opts} mrproper
 
+%if %{signkernel}%{signmodules}
+    cp %{SOURCE10} %{SOURCE9} certs/.
+%endif
+
+
 %if %{signkernel}%{signmodules}
     cp %{SOURCE10} certs/.
 %endif
diff --git a/ml-rpm/ol9/kernel-mainline.spec b/ml-rpm/ol9/kernel-mainline.spec
index 0eb7d20043ed0..6a84976f01632 100644
--- a/ml-rpm/ol9/kernel-mainline.spec
+++ b/ml-rpm/ol9/kernel-mainline.spec
@@ -458,6 +458,7 @@ BuildConflicts: rpm < 4.13.0.1-19
 Source0: linux-%{kversion}.tar.bz2
 
 %if %{signkernel}%{signmodules}
+Source9: ol_signing_keys.pem
 Source10: x509.genkey
 %endif
 
@@ -1072,6 +1073,11 @@ BuildContainerKernel() {
     perl -p -i -e "s/^EXTRAVERSION.*/EXTRAVERSION = ${ExtraVer}/" Makefile
 
     make %{?make_opts} mrproper
+
+%if %{signkernel}%{signmodules}
+    cp %{SOURCE10} %{SOURCE9} certs/.
+%endif
+
     cp configs/config-container .config
 
     make %{?make_opts} ARCH=$Arch %{?_kernel_cc} olddefconfig > /dev/null
@@ -1121,6 +1127,11 @@ BuildKernel() {
 
     make %{?make_opts} mrproper
 
+%if %{signkernel}%{signmodules}
+    cp %{SOURCE10} %{SOURCE9} certs/.
+%endif
+
+
 %if %{signkernel}%{signmodules}
     cp %{SOURCE10} certs/.
 %endif
-- 
2.31.1


