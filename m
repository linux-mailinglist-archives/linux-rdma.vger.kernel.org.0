Return-Path: <linux-rdma+bounces-2584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E03E8CC29B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912AD1C22C7B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02795146D52;
	Wed, 22 May 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AIJkqmGf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226A145FF7;
	Wed, 22 May 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386133; cv=none; b=RmegbWrDYIHgye0GLE8iSU+s1Qj4mPoPI+Esa8QJpeIHyJlzOyDe+viuknP3f19YXAQU8tFbWdf8gEsQ1ZPKiVVWvY3cT7Aau2gElFjvJfXCOniJ5MsHiH1UDKgqLc/wj12PrWa59SagrArOiYvz6ybj89pLG9RyIv5QWLoukDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386133; c=relaxed/simple;
	bh=Bgk0V0Er5w/wzbCJE6+tSMRiF1xx3R6+JUR/WBMVwHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osYLvFwFpGTuQ1jNtWeUo4Q/gU4P/PnfzE5xLRHjosCHN7JdhIfCNHihWIhtHdY3KNEmolpxFSV+EYy3aCcfa6iNnlE7nOCgTapubflxY/nmpYBXfZRzXf3WgiYbkly0HUO0FTbH1cK/UMwvI5kHNY+XPG5R7s/idAf/6JalyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AIJkqmGf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqrDW006158;
	Wed, 22 May 2024 13:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=twT+K8oVeAk+YnC4JNSJ2r2sxYlropxrZyjmkmI6lpw=;
 b=AIJkqmGf2Ylllww7xC7J6Gl6tfiKiFXzMW7QR2DRKtLnvweAPGOgyuHkQLXniTdP6PtN
 ks/ESVZ/wI3N+iCKanDIsTVOJQdJGJOFjgtX3ZwJch0D1C+QD8y9qgdcG2fY/waidtdJ
 OogwjzpVZite4NeetV+wdpc4XFUhTxMP/2wdHnfS/pc+7ziv8o+LJsrzXRTMmnNUc1Wr
 aRowxW+9P+qvss5Q5/HzFUcTenYcBgvRVjRQuxoNmc/NQXusAX7N6pwBgUV+C22iHneT
 NUyDRQ74uSh92ut1GG94HIDL8o4z3p245VKWBle5217cmNEXmMAHdvpn869GShpQq9BV kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d7qqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MDKcE1019530;
	Wed, 22 May 2024 13:54:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98t2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:54:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm2t016070;
	Wed, 22 May 2024 13:54:58 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-4;
	Wed, 22 May 2024 13:54:58 +0000
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
Subject: [PATCH v3 2/6] ml: renaming metadata directory
Date: Wed, 22 May 2024 15:54:35 +0200
Message-Id: <20240522135444.1685642-4-haakon.bugge@oracle.com>
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
X-Proofpoint-GUID: whrBJ2XC8JF8m5632jgPqIxXy34XKVui
X-Proofpoint-ORIG-GUID: whrBJ2XC8JF8m5632jgPqIxXy34XKVui

From: Luci Bot <fajita@oracle.com>

Adjusting the metadata directory name to match the legacy mainline system

Signed-off-by: Luci Bot <fajita@oracle.com>
Reviewed-by: Mark Nicholson <mark.j.nicholson@oracle.com>
---
 {uek-rpm => ml-rpm}/ol8/Module.kabi_aarch64         |   0
 {uek-rpm => ml-rpm}/ol8/Module.kabi_aarch64debug    |   0
 {uek-rpm => ml-rpm}/ol8/Module.kabi_x86_64          |   0
 {uek-rpm => ml-rpm}/ol8/Module.kabi_x86_64debug     |   0
 {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_aarch64       |   0
 {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_aarch64debug  |   0
 {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_x86_64        |   0
 {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_x86_64debug   |   0
 {uek-rpm => ml-rpm}/ol8/check-kabi                  |   0
 {uek-rpm => ml-rpm}/ol8/config-aarch64              |   0
 {uek-rpm => ml-rpm}/ol8/config-aarch64-container    |   0
 {uek-rpm => ml-rpm}/ol8/config-aarch64-debug        |   0
 {uek-rpm => ml-rpm}/ol8/config-aarch64-emb3         |   0
 {uek-rpm => ml-rpm}/ol8/config-aarch64-emb3-debug   |   0
 {uek-rpm => ml-rpm}/ol8/config-x86_64               |   0
 {uek-rpm => ml-rpm}/ol8/config-x86_64-container     |   0
 {uek-rpm => ml-rpm}/ol8/config-x86_64-debug         |   0
 {uek-rpm => ml-rpm}/ol8/core-emb3-aarch64.list      |   0
 {uek-rpm => ml-rpm}/ol8/filter-aarch64.sh           |   0
 {uek-rpm => ml-rpm}/ol8/filter-modules.sh           |   0
 {uek-rpm => ml-rpm}/ol8/filter-x86_64.sh            |   0
 {uek-rpm => ml-rpm}/ol8/find-provides               |   0
 {uek-rpm => ml-rpm}/ol8/generate_bls_conf.sh        |   0
 {uek-rpm => ml-rpm}/ol8/kabi_lockedlist_aarch64     |   0
 .../ol8/kabi_lockedlist_aarch64debug                |   0
 {uek-rpm => ml-rpm}/ol8/kabi_lockedlist_x86_64      |   0
 {uek-rpm => ml-rpm}/ol8/kabi_lockedlist_x86_64debug |   0
 {uek-rpm => ml-rpm}/ol8/kabitool                    |   0
 {uek-rpm => ml-rpm}/ol8/kernel-uek.spec             |   0
 {uek-rpm => ml-rpm}/ol8/mod-denylist.sh             |   0
 {uek-rpm => ml-rpm}/ol8/mod-extra.list              |   0
 {uek-rpm => ml-rpm}/ol8/mod-sign.sh                 |   0
 {uek-rpm => ml-rpm}/ol8/modules-core-aarch64.list   |   0
 {uek-rpm => ml-rpm}/ol8/modules-core-x86_64.list    |   0
 {uek-rpm => ml-rpm}/ol8/perf                        |   0
 {uek-rpm => ml-rpm}/ol8/secureboot.cer              | Bin
 {uek-rpm => ml-rpm}/ol8/secureboot_aarch64.cer      | Bin
 {uek-rpm => ml-rpm}/ol8/securebootca.cer            | Bin
 {uek-rpm => ml-rpm}/ol8/turbostat                   |   0
 {uek-rpm => ml-rpm}/ol8/update-el-aarch64           |   0
 {uek-rpm => ml-rpm}/ol8/update-el-x86               |   0
 {uek-rpm => ml-rpm}/ol8/x509.genkey                 |   0
 {uek-rpm => ml-rpm}/ol8/x86_energy_perf_policy      |   0
 {uek-rpm => ml-rpm}/ol9/Module.kabi_aarch64         |   0
 {uek-rpm => ml-rpm}/ol9/Module.kabi_aarch64debug    |   0
 {uek-rpm => ml-rpm}/ol9/Module.kabi_x86_64          |   0
 {uek-rpm => ml-rpm}/ol9/Module.kabi_x86_64debug     |   0
 {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_aarch64       |   0
 {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_aarch64debug  |   0
 {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_x86_64        |   0
 {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_x86_64debug   |   0
 {uek-rpm => ml-rpm}/ol9/check-kabi                  |   0
 {uek-rpm => ml-rpm}/ol9/config-aarch64              |   0
 {uek-rpm => ml-rpm}/ol9/config-aarch64-container    |   0
 {uek-rpm => ml-rpm}/ol9/config-aarch64-debug        |   0
 {uek-rpm => ml-rpm}/ol9/config-x86_64               |   0
 {uek-rpm => ml-rpm}/ol9/config-x86_64-container     |   0
 {uek-rpm => ml-rpm}/ol9/config-x86_64-debug         |   0
 {uek-rpm => ml-rpm}/ol9/filter-aarch64.sh           |   0
 {uek-rpm => ml-rpm}/ol9/filter-modules.sh           |   0
 {uek-rpm => ml-rpm}/ol9/filter-x86_64.sh            |   0
 {uek-rpm => ml-rpm}/ol9/find-provides               |   0
 {uek-rpm => ml-rpm}/ol9/generate_bls_conf.sh        |   0
 {uek-rpm => ml-rpm}/ol9/kabi_lockedlist_aarch64     |   0
 .../ol9/kabi_lockedlist_aarch64debug                |   0
 {uek-rpm => ml-rpm}/ol9/kabi_lockedlist_x86_64      |   0
 {uek-rpm => ml-rpm}/ol9/kabi_lockedlist_x86_64debug |   0
 {uek-rpm => ml-rpm}/ol9/kabitool                    |   0
 {uek-rpm => ml-rpm}/ol9/kernel-uek.spec             |   0
 {uek-rpm => ml-rpm}/ol9/mod-denylist.sh             |   0
 {uek-rpm => ml-rpm}/ol9/mod-extra.list              |   0
 {uek-rpm => ml-rpm}/ol9/mod-sign.sh                 |   0
 {uek-rpm => ml-rpm}/ol9/modules-core-aarch64.list   |   0
 {uek-rpm => ml-rpm}/ol9/modules-core-x86_64.list    |   0
 {uek-rpm => ml-rpm}/ol9/perf                        |   0
 {uek-rpm => ml-rpm}/ol9/secureboot.cer              | Bin
 {uek-rpm => ml-rpm}/ol9/secureboot_aarch64.cer      | Bin
 {uek-rpm => ml-rpm}/ol9/securebootca.cer            | Bin
 {uek-rpm => ml-rpm}/ol9/turbostat                   |   0
 {uek-rpm => ml-rpm}/ol9/update-el-aarch64           |   0
 {uek-rpm => ml-rpm}/ol9/update-el-x86               |   0
 {uek-rpm => ml-rpm}/ol9/x509.genkey                 |   0
 {uek-rpm => ml-rpm}/ol9/x86_energy_perf_policy      |   0
 {uek-rpm => ml-rpm}/tools/kabi                      |   0
 uek-rpm/.Orabug_list                                |   5 -----
 85 files changed, 5 deletions(-)
 rename {uek-rpm => ml-rpm}/ol8/Module.kabi_aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/Module.kabi_aarch64debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/Module.kabi_x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/Module.kabi_x86_64debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_aarch64debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/Symtypes.kabi_x86_64debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/check-kabi (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-aarch64-container (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-aarch64-debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-aarch64-emb3 (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-aarch64-emb3-debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-x86_64-container (100%)
 rename {uek-rpm => ml-rpm}/ol8/config-x86_64-debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/core-emb3-aarch64.list (100%)
 rename {uek-rpm => ml-rpm}/ol8/filter-aarch64.sh (100%)
 rename {uek-rpm => ml-rpm}/ol8/filter-modules.sh (100%)
 rename {uek-rpm => ml-rpm}/ol8/filter-x86_64.sh (100%)
 rename {uek-rpm => ml-rpm}/ol8/find-provides (100%)
 rename {uek-rpm => ml-rpm}/ol8/generate_bls_conf.sh (100%)
 rename {uek-rpm => ml-rpm}/ol8/kabi_lockedlist_aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/kabi_lockedlist_aarch64debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/kabi_lockedlist_x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/kabi_lockedlist_x86_64debug (100%)
 rename {uek-rpm => ml-rpm}/ol8/kabitool (100%)
 rename {uek-rpm => ml-rpm}/ol8/kernel-uek.spec (100%)
 rename {uek-rpm => ml-rpm}/ol8/mod-denylist.sh (100%)
 rename {uek-rpm => ml-rpm}/ol8/mod-extra.list (100%)
 rename {uek-rpm => ml-rpm}/ol8/mod-sign.sh (100%)
 rename {uek-rpm => ml-rpm}/ol8/modules-core-aarch64.list (100%)
 rename {uek-rpm => ml-rpm}/ol8/modules-core-x86_64.list (100%)
 rename {uek-rpm => ml-rpm}/ol8/perf (100%)
 rename {uek-rpm => ml-rpm}/ol8/secureboot.cer (100%)
 rename {uek-rpm => ml-rpm}/ol8/secureboot_aarch64.cer (100%)
 rename {uek-rpm => ml-rpm}/ol8/securebootca.cer (100%)
 rename {uek-rpm => ml-rpm}/ol8/turbostat (100%)
 rename {uek-rpm => ml-rpm}/ol8/update-el-aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol8/update-el-x86 (100%)
 rename {uek-rpm => ml-rpm}/ol8/x509.genkey (100%)
 rename {uek-rpm => ml-rpm}/ol8/x86_energy_perf_policy (100%)
 rename {uek-rpm => ml-rpm}/ol9/Module.kabi_aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/Module.kabi_aarch64debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/Module.kabi_x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/Module.kabi_x86_64debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_aarch64debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/Symtypes.kabi_x86_64debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/check-kabi (100%)
 rename {uek-rpm => ml-rpm}/ol9/config-aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/config-aarch64-container (100%)
 rename {uek-rpm => ml-rpm}/ol9/config-aarch64-debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/config-x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/config-x86_64-container (100%)
 rename {uek-rpm => ml-rpm}/ol9/config-x86_64-debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/filter-aarch64.sh (100%)
 rename {uek-rpm => ml-rpm}/ol9/filter-modules.sh (100%)
 rename {uek-rpm => ml-rpm}/ol9/filter-x86_64.sh (100%)
 rename {uek-rpm => ml-rpm}/ol9/find-provides (100%)
 rename {uek-rpm => ml-rpm}/ol9/generate_bls_conf.sh (100%)
 rename {uek-rpm => ml-rpm}/ol9/kabi_lockedlist_aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/kabi_lockedlist_aarch64debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/kabi_lockedlist_x86_64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/kabi_lockedlist_x86_64debug (100%)
 rename {uek-rpm => ml-rpm}/ol9/kabitool (100%)
 rename {uek-rpm => ml-rpm}/ol9/kernel-uek.spec (100%)
 rename {uek-rpm => ml-rpm}/ol9/mod-denylist.sh (100%)
 rename {uek-rpm => ml-rpm}/ol9/mod-extra.list (100%)
 rename {uek-rpm => ml-rpm}/ol9/mod-sign.sh (100%)
 rename {uek-rpm => ml-rpm}/ol9/modules-core-aarch64.list (100%)
 rename {uek-rpm => ml-rpm}/ol9/modules-core-x86_64.list (100%)
 rename {uek-rpm => ml-rpm}/ol9/perf (100%)
 rename {uek-rpm => ml-rpm}/ol9/secureboot.cer (100%)
 rename {uek-rpm => ml-rpm}/ol9/secureboot_aarch64.cer (100%)
 rename {uek-rpm => ml-rpm}/ol9/securebootca.cer (100%)
 rename {uek-rpm => ml-rpm}/ol9/turbostat (100%)
 rename {uek-rpm => ml-rpm}/ol9/update-el-aarch64 (100%)
 rename {uek-rpm => ml-rpm}/ol9/update-el-x86 (100%)
 rename {uek-rpm => ml-rpm}/ol9/x509.genkey (100%)
 rename {uek-rpm => ml-rpm}/ol9/x86_energy_perf_policy (100%)
 rename {uek-rpm => ml-rpm}/tools/kabi (100%)
 delete mode 100644 uek-rpm/.Orabug_list

diff --git a/uek-rpm/ol8/Module.kabi_aarch64 b/ml-rpm/ol8/Module.kabi_aarch64
similarity index 100%
rename from uek-rpm/ol8/Module.kabi_aarch64
rename to ml-rpm/ol8/Module.kabi_aarch64
diff --git a/uek-rpm/ol8/Module.kabi_aarch64debug b/ml-rpm/ol8/Module.kabi_aarch64debug
similarity index 100%
rename from uek-rpm/ol8/Module.kabi_aarch64debug
rename to ml-rpm/ol8/Module.kabi_aarch64debug
diff --git a/uek-rpm/ol8/Module.kabi_x86_64 b/ml-rpm/ol8/Module.kabi_x86_64
similarity index 100%
rename from uek-rpm/ol8/Module.kabi_x86_64
rename to ml-rpm/ol8/Module.kabi_x86_64
diff --git a/uek-rpm/ol8/Module.kabi_x86_64debug b/ml-rpm/ol8/Module.kabi_x86_64debug
similarity index 100%
rename from uek-rpm/ol8/Module.kabi_x86_64debug
rename to ml-rpm/ol8/Module.kabi_x86_64debug
diff --git a/uek-rpm/ol8/Symtypes.kabi_aarch64 b/ml-rpm/ol8/Symtypes.kabi_aarch64
similarity index 100%
rename from uek-rpm/ol8/Symtypes.kabi_aarch64
rename to ml-rpm/ol8/Symtypes.kabi_aarch64
diff --git a/uek-rpm/ol8/Symtypes.kabi_aarch64debug b/ml-rpm/ol8/Symtypes.kabi_aarch64debug
similarity index 100%
rename from uek-rpm/ol8/Symtypes.kabi_aarch64debug
rename to ml-rpm/ol8/Symtypes.kabi_aarch64debug
diff --git a/uek-rpm/ol8/Symtypes.kabi_x86_64 b/ml-rpm/ol8/Symtypes.kabi_x86_64
similarity index 100%
rename from uek-rpm/ol8/Symtypes.kabi_x86_64
rename to ml-rpm/ol8/Symtypes.kabi_x86_64
diff --git a/uek-rpm/ol8/Symtypes.kabi_x86_64debug b/ml-rpm/ol8/Symtypes.kabi_x86_64debug
similarity index 100%
rename from uek-rpm/ol8/Symtypes.kabi_x86_64debug
rename to ml-rpm/ol8/Symtypes.kabi_x86_64debug
diff --git a/uek-rpm/ol8/check-kabi b/ml-rpm/ol8/check-kabi
similarity index 100%
rename from uek-rpm/ol8/check-kabi
rename to ml-rpm/ol8/check-kabi
diff --git a/uek-rpm/ol8/config-aarch64 b/ml-rpm/ol8/config-aarch64
similarity index 100%
rename from uek-rpm/ol8/config-aarch64
rename to ml-rpm/ol8/config-aarch64
diff --git a/uek-rpm/ol8/config-aarch64-container b/ml-rpm/ol8/config-aarch64-container
similarity index 100%
rename from uek-rpm/ol8/config-aarch64-container
rename to ml-rpm/ol8/config-aarch64-container
diff --git a/uek-rpm/ol8/config-aarch64-debug b/ml-rpm/ol8/config-aarch64-debug
similarity index 100%
rename from uek-rpm/ol8/config-aarch64-debug
rename to ml-rpm/ol8/config-aarch64-debug
diff --git a/uek-rpm/ol8/config-aarch64-emb3 b/ml-rpm/ol8/config-aarch64-emb3
similarity index 100%
rename from uek-rpm/ol8/config-aarch64-emb3
rename to ml-rpm/ol8/config-aarch64-emb3
diff --git a/uek-rpm/ol8/config-aarch64-emb3-debug b/ml-rpm/ol8/config-aarch64-emb3-debug
similarity index 100%
rename from uek-rpm/ol8/config-aarch64-emb3-debug
rename to ml-rpm/ol8/config-aarch64-emb3-debug
diff --git a/uek-rpm/ol8/config-x86_64 b/ml-rpm/ol8/config-x86_64
similarity index 100%
rename from uek-rpm/ol8/config-x86_64
rename to ml-rpm/ol8/config-x86_64
diff --git a/uek-rpm/ol8/config-x86_64-container b/ml-rpm/ol8/config-x86_64-container
similarity index 100%
rename from uek-rpm/ol8/config-x86_64-container
rename to ml-rpm/ol8/config-x86_64-container
diff --git a/uek-rpm/ol8/config-x86_64-debug b/ml-rpm/ol8/config-x86_64-debug
similarity index 100%
rename from uek-rpm/ol8/config-x86_64-debug
rename to ml-rpm/ol8/config-x86_64-debug
diff --git a/uek-rpm/ol8/core-emb3-aarch64.list b/ml-rpm/ol8/core-emb3-aarch64.list
similarity index 100%
rename from uek-rpm/ol8/core-emb3-aarch64.list
rename to ml-rpm/ol8/core-emb3-aarch64.list
diff --git a/uek-rpm/ol8/filter-aarch64.sh b/ml-rpm/ol8/filter-aarch64.sh
similarity index 100%
rename from uek-rpm/ol8/filter-aarch64.sh
rename to ml-rpm/ol8/filter-aarch64.sh
diff --git a/uek-rpm/ol8/filter-modules.sh b/ml-rpm/ol8/filter-modules.sh
similarity index 100%
rename from uek-rpm/ol8/filter-modules.sh
rename to ml-rpm/ol8/filter-modules.sh
diff --git a/uek-rpm/ol8/filter-x86_64.sh b/ml-rpm/ol8/filter-x86_64.sh
similarity index 100%
rename from uek-rpm/ol8/filter-x86_64.sh
rename to ml-rpm/ol8/filter-x86_64.sh
diff --git a/uek-rpm/ol8/find-provides b/ml-rpm/ol8/find-provides
similarity index 100%
rename from uek-rpm/ol8/find-provides
rename to ml-rpm/ol8/find-provides
diff --git a/uek-rpm/ol8/generate_bls_conf.sh b/ml-rpm/ol8/generate_bls_conf.sh
similarity index 100%
rename from uek-rpm/ol8/generate_bls_conf.sh
rename to ml-rpm/ol8/generate_bls_conf.sh
diff --git a/uek-rpm/ol8/kabi_lockedlist_aarch64 b/ml-rpm/ol8/kabi_lockedlist_aarch64
similarity index 100%
rename from uek-rpm/ol8/kabi_lockedlist_aarch64
rename to ml-rpm/ol8/kabi_lockedlist_aarch64
diff --git a/uek-rpm/ol8/kabi_lockedlist_aarch64debug b/ml-rpm/ol8/kabi_lockedlist_aarch64debug
similarity index 100%
rename from uek-rpm/ol8/kabi_lockedlist_aarch64debug
rename to ml-rpm/ol8/kabi_lockedlist_aarch64debug
diff --git a/uek-rpm/ol8/kabi_lockedlist_x86_64 b/ml-rpm/ol8/kabi_lockedlist_x86_64
similarity index 100%
rename from uek-rpm/ol8/kabi_lockedlist_x86_64
rename to ml-rpm/ol8/kabi_lockedlist_x86_64
diff --git a/uek-rpm/ol8/kabi_lockedlist_x86_64debug b/ml-rpm/ol8/kabi_lockedlist_x86_64debug
similarity index 100%
rename from uek-rpm/ol8/kabi_lockedlist_x86_64debug
rename to ml-rpm/ol8/kabi_lockedlist_x86_64debug
diff --git a/uek-rpm/ol8/kabitool b/ml-rpm/ol8/kabitool
similarity index 100%
rename from uek-rpm/ol8/kabitool
rename to ml-rpm/ol8/kabitool
diff --git a/uek-rpm/ol8/kernel-uek.spec b/ml-rpm/ol8/kernel-uek.spec
similarity index 100%
rename from uek-rpm/ol8/kernel-uek.spec
rename to ml-rpm/ol8/kernel-uek.spec
diff --git a/uek-rpm/ol8/mod-denylist.sh b/ml-rpm/ol8/mod-denylist.sh
similarity index 100%
rename from uek-rpm/ol8/mod-denylist.sh
rename to ml-rpm/ol8/mod-denylist.sh
diff --git a/uek-rpm/ol8/mod-extra.list b/ml-rpm/ol8/mod-extra.list
similarity index 100%
rename from uek-rpm/ol8/mod-extra.list
rename to ml-rpm/ol8/mod-extra.list
diff --git a/uek-rpm/ol8/mod-sign.sh b/ml-rpm/ol8/mod-sign.sh
similarity index 100%
rename from uek-rpm/ol8/mod-sign.sh
rename to ml-rpm/ol8/mod-sign.sh
diff --git a/uek-rpm/ol8/modules-core-aarch64.list b/ml-rpm/ol8/modules-core-aarch64.list
similarity index 100%
rename from uek-rpm/ol8/modules-core-aarch64.list
rename to ml-rpm/ol8/modules-core-aarch64.list
diff --git a/uek-rpm/ol8/modules-core-x86_64.list b/ml-rpm/ol8/modules-core-x86_64.list
similarity index 100%
rename from uek-rpm/ol8/modules-core-x86_64.list
rename to ml-rpm/ol8/modules-core-x86_64.list
diff --git a/uek-rpm/ol8/perf b/ml-rpm/ol8/perf
similarity index 100%
rename from uek-rpm/ol8/perf
rename to ml-rpm/ol8/perf
diff --git a/uek-rpm/ol8/secureboot.cer b/ml-rpm/ol8/secureboot.cer
similarity index 100%
rename from uek-rpm/ol8/secureboot.cer
rename to ml-rpm/ol8/secureboot.cer
diff --git a/uek-rpm/ol8/secureboot_aarch64.cer b/ml-rpm/ol8/secureboot_aarch64.cer
similarity index 100%
rename from uek-rpm/ol8/secureboot_aarch64.cer
rename to ml-rpm/ol8/secureboot_aarch64.cer
diff --git a/uek-rpm/ol8/securebootca.cer b/ml-rpm/ol8/securebootca.cer
similarity index 100%
rename from uek-rpm/ol8/securebootca.cer
rename to ml-rpm/ol8/securebootca.cer
diff --git a/uek-rpm/ol8/turbostat b/ml-rpm/ol8/turbostat
similarity index 100%
rename from uek-rpm/ol8/turbostat
rename to ml-rpm/ol8/turbostat
diff --git a/uek-rpm/ol8/update-el-aarch64 b/ml-rpm/ol8/update-el-aarch64
similarity index 100%
rename from uek-rpm/ol8/update-el-aarch64
rename to ml-rpm/ol8/update-el-aarch64
diff --git a/uek-rpm/ol8/update-el-x86 b/ml-rpm/ol8/update-el-x86
similarity index 100%
rename from uek-rpm/ol8/update-el-x86
rename to ml-rpm/ol8/update-el-x86
diff --git a/uek-rpm/ol8/x509.genkey b/ml-rpm/ol8/x509.genkey
similarity index 100%
rename from uek-rpm/ol8/x509.genkey
rename to ml-rpm/ol8/x509.genkey
diff --git a/uek-rpm/ol8/x86_energy_perf_policy b/ml-rpm/ol8/x86_energy_perf_policy
similarity index 100%
rename from uek-rpm/ol8/x86_energy_perf_policy
rename to ml-rpm/ol8/x86_energy_perf_policy
diff --git a/uek-rpm/ol9/Module.kabi_aarch64 b/ml-rpm/ol9/Module.kabi_aarch64
similarity index 100%
rename from uek-rpm/ol9/Module.kabi_aarch64
rename to ml-rpm/ol9/Module.kabi_aarch64
diff --git a/uek-rpm/ol9/Module.kabi_aarch64debug b/ml-rpm/ol9/Module.kabi_aarch64debug
similarity index 100%
rename from uek-rpm/ol9/Module.kabi_aarch64debug
rename to ml-rpm/ol9/Module.kabi_aarch64debug
diff --git a/uek-rpm/ol9/Module.kabi_x86_64 b/ml-rpm/ol9/Module.kabi_x86_64
similarity index 100%
rename from uek-rpm/ol9/Module.kabi_x86_64
rename to ml-rpm/ol9/Module.kabi_x86_64
diff --git a/uek-rpm/ol9/Module.kabi_x86_64debug b/ml-rpm/ol9/Module.kabi_x86_64debug
similarity index 100%
rename from uek-rpm/ol9/Module.kabi_x86_64debug
rename to ml-rpm/ol9/Module.kabi_x86_64debug
diff --git a/uek-rpm/ol9/Symtypes.kabi_aarch64 b/ml-rpm/ol9/Symtypes.kabi_aarch64
similarity index 100%
rename from uek-rpm/ol9/Symtypes.kabi_aarch64
rename to ml-rpm/ol9/Symtypes.kabi_aarch64
diff --git a/uek-rpm/ol9/Symtypes.kabi_aarch64debug b/ml-rpm/ol9/Symtypes.kabi_aarch64debug
similarity index 100%
rename from uek-rpm/ol9/Symtypes.kabi_aarch64debug
rename to ml-rpm/ol9/Symtypes.kabi_aarch64debug
diff --git a/uek-rpm/ol9/Symtypes.kabi_x86_64 b/ml-rpm/ol9/Symtypes.kabi_x86_64
similarity index 100%
rename from uek-rpm/ol9/Symtypes.kabi_x86_64
rename to ml-rpm/ol9/Symtypes.kabi_x86_64
diff --git a/uek-rpm/ol9/Symtypes.kabi_x86_64debug b/ml-rpm/ol9/Symtypes.kabi_x86_64debug
similarity index 100%
rename from uek-rpm/ol9/Symtypes.kabi_x86_64debug
rename to ml-rpm/ol9/Symtypes.kabi_x86_64debug
diff --git a/uek-rpm/ol9/check-kabi b/ml-rpm/ol9/check-kabi
similarity index 100%
rename from uek-rpm/ol9/check-kabi
rename to ml-rpm/ol9/check-kabi
diff --git a/uek-rpm/ol9/config-aarch64 b/ml-rpm/ol9/config-aarch64
similarity index 100%
rename from uek-rpm/ol9/config-aarch64
rename to ml-rpm/ol9/config-aarch64
diff --git a/uek-rpm/ol9/config-aarch64-container b/ml-rpm/ol9/config-aarch64-container
similarity index 100%
rename from uek-rpm/ol9/config-aarch64-container
rename to ml-rpm/ol9/config-aarch64-container
diff --git a/uek-rpm/ol9/config-aarch64-debug b/ml-rpm/ol9/config-aarch64-debug
similarity index 100%
rename from uek-rpm/ol9/config-aarch64-debug
rename to ml-rpm/ol9/config-aarch64-debug
diff --git a/uek-rpm/ol9/config-x86_64 b/ml-rpm/ol9/config-x86_64
similarity index 100%
rename from uek-rpm/ol9/config-x86_64
rename to ml-rpm/ol9/config-x86_64
diff --git a/uek-rpm/ol9/config-x86_64-container b/ml-rpm/ol9/config-x86_64-container
similarity index 100%
rename from uek-rpm/ol9/config-x86_64-container
rename to ml-rpm/ol9/config-x86_64-container
diff --git a/uek-rpm/ol9/config-x86_64-debug b/ml-rpm/ol9/config-x86_64-debug
similarity index 100%
rename from uek-rpm/ol9/config-x86_64-debug
rename to ml-rpm/ol9/config-x86_64-debug
diff --git a/uek-rpm/ol9/filter-aarch64.sh b/ml-rpm/ol9/filter-aarch64.sh
similarity index 100%
rename from uek-rpm/ol9/filter-aarch64.sh
rename to ml-rpm/ol9/filter-aarch64.sh
diff --git a/uek-rpm/ol9/filter-modules.sh b/ml-rpm/ol9/filter-modules.sh
similarity index 100%
rename from uek-rpm/ol9/filter-modules.sh
rename to ml-rpm/ol9/filter-modules.sh
diff --git a/uek-rpm/ol9/filter-x86_64.sh b/ml-rpm/ol9/filter-x86_64.sh
similarity index 100%
rename from uek-rpm/ol9/filter-x86_64.sh
rename to ml-rpm/ol9/filter-x86_64.sh
diff --git a/uek-rpm/ol9/find-provides b/ml-rpm/ol9/find-provides
similarity index 100%
rename from uek-rpm/ol9/find-provides
rename to ml-rpm/ol9/find-provides
diff --git a/uek-rpm/ol9/generate_bls_conf.sh b/ml-rpm/ol9/generate_bls_conf.sh
similarity index 100%
rename from uek-rpm/ol9/generate_bls_conf.sh
rename to ml-rpm/ol9/generate_bls_conf.sh
diff --git a/uek-rpm/ol9/kabi_lockedlist_aarch64 b/ml-rpm/ol9/kabi_lockedlist_aarch64
similarity index 100%
rename from uek-rpm/ol9/kabi_lockedlist_aarch64
rename to ml-rpm/ol9/kabi_lockedlist_aarch64
diff --git a/uek-rpm/ol9/kabi_lockedlist_aarch64debug b/ml-rpm/ol9/kabi_lockedlist_aarch64debug
similarity index 100%
rename from uek-rpm/ol9/kabi_lockedlist_aarch64debug
rename to ml-rpm/ol9/kabi_lockedlist_aarch64debug
diff --git a/uek-rpm/ol9/kabi_lockedlist_x86_64 b/ml-rpm/ol9/kabi_lockedlist_x86_64
similarity index 100%
rename from uek-rpm/ol9/kabi_lockedlist_x86_64
rename to ml-rpm/ol9/kabi_lockedlist_x86_64
diff --git a/uek-rpm/ol9/kabi_lockedlist_x86_64debug b/ml-rpm/ol9/kabi_lockedlist_x86_64debug
similarity index 100%
rename from uek-rpm/ol9/kabi_lockedlist_x86_64debug
rename to ml-rpm/ol9/kabi_lockedlist_x86_64debug
diff --git a/uek-rpm/ol9/kabitool b/ml-rpm/ol9/kabitool
similarity index 100%
rename from uek-rpm/ol9/kabitool
rename to ml-rpm/ol9/kabitool
diff --git a/uek-rpm/ol9/kernel-uek.spec b/ml-rpm/ol9/kernel-uek.spec
similarity index 100%
rename from uek-rpm/ol9/kernel-uek.spec
rename to ml-rpm/ol9/kernel-uek.spec
diff --git a/uek-rpm/ol9/mod-denylist.sh b/ml-rpm/ol9/mod-denylist.sh
similarity index 100%
rename from uek-rpm/ol9/mod-denylist.sh
rename to ml-rpm/ol9/mod-denylist.sh
diff --git a/uek-rpm/ol9/mod-extra.list b/ml-rpm/ol9/mod-extra.list
similarity index 100%
rename from uek-rpm/ol9/mod-extra.list
rename to ml-rpm/ol9/mod-extra.list
diff --git a/uek-rpm/ol9/mod-sign.sh b/ml-rpm/ol9/mod-sign.sh
similarity index 100%
rename from uek-rpm/ol9/mod-sign.sh
rename to ml-rpm/ol9/mod-sign.sh
diff --git a/uek-rpm/ol9/modules-core-aarch64.list b/ml-rpm/ol9/modules-core-aarch64.list
similarity index 100%
rename from uek-rpm/ol9/modules-core-aarch64.list
rename to ml-rpm/ol9/modules-core-aarch64.list
diff --git a/uek-rpm/ol9/modules-core-x86_64.list b/ml-rpm/ol9/modules-core-x86_64.list
similarity index 100%
rename from uek-rpm/ol9/modules-core-x86_64.list
rename to ml-rpm/ol9/modules-core-x86_64.list
diff --git a/uek-rpm/ol9/perf b/ml-rpm/ol9/perf
similarity index 100%
rename from uek-rpm/ol9/perf
rename to ml-rpm/ol9/perf
diff --git a/uek-rpm/ol9/secureboot.cer b/ml-rpm/ol9/secureboot.cer
similarity index 100%
rename from uek-rpm/ol9/secureboot.cer
rename to ml-rpm/ol9/secureboot.cer
diff --git a/uek-rpm/ol9/secureboot_aarch64.cer b/ml-rpm/ol9/secureboot_aarch64.cer
similarity index 100%
rename from uek-rpm/ol9/secureboot_aarch64.cer
rename to ml-rpm/ol9/secureboot_aarch64.cer
diff --git a/uek-rpm/ol9/securebootca.cer b/ml-rpm/ol9/securebootca.cer
similarity index 100%
rename from uek-rpm/ol9/securebootca.cer
rename to ml-rpm/ol9/securebootca.cer
diff --git a/uek-rpm/ol9/turbostat b/ml-rpm/ol9/turbostat
similarity index 100%
rename from uek-rpm/ol9/turbostat
rename to ml-rpm/ol9/turbostat
diff --git a/uek-rpm/ol9/update-el-aarch64 b/ml-rpm/ol9/update-el-aarch64
similarity index 100%
rename from uek-rpm/ol9/update-el-aarch64
rename to ml-rpm/ol9/update-el-aarch64
diff --git a/uek-rpm/ol9/update-el-x86 b/ml-rpm/ol9/update-el-x86
similarity index 100%
rename from uek-rpm/ol9/update-el-x86
rename to ml-rpm/ol9/update-el-x86
diff --git a/uek-rpm/ol9/x509.genkey b/ml-rpm/ol9/x509.genkey
similarity index 100%
rename from uek-rpm/ol9/x509.genkey
rename to ml-rpm/ol9/x509.genkey
diff --git a/uek-rpm/ol9/x86_energy_perf_policy b/ml-rpm/ol9/x86_energy_perf_policy
similarity index 100%
rename from uek-rpm/ol9/x86_energy_perf_policy
rename to ml-rpm/ol9/x86_energy_perf_policy
diff --git a/uek-rpm/tools/kabi b/ml-rpm/tools/kabi
similarity index 100%
rename from uek-rpm/tools/kabi
rename to ml-rpm/tools/kabi
diff --git a/uek-rpm/.Orabug_list b/uek-rpm/.Orabug_list
deleted file mode 100644
index 7becf1b0a9be7..0000000000000
--- a/uek-rpm/.Orabug_list
+++ /dev/null
@@ -1,5 +0,0 @@
-31961009 # [UEK-NEXT] kexec allows kernel whose signature is in the dbx to be booted
-34116060 # LUCI Maintainer: Disable OpenSSL 3.0 warnings for v5.18
-35455153 # [UEK-NEXT] Manage Original OL Signing Keys
-35641429 # Add uek_kabi.h to LUCI and update check-kabi scripts
-36459425 # Build fix for 6.9 LUCI
-- 
2.31.1


