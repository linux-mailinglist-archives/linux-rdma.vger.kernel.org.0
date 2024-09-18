Return-Path: <linux-rdma+bounces-4982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD397B96D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 10:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601421F24038
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74E1741FD;
	Wed, 18 Sep 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lH/May/h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9F14D6E6;
	Wed, 18 Sep 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648571; cv=none; b=Hespwo7uJ4i1JrPcXbTz3c1qOgQlHq9CWxJ4aFdKTGmgTrivhoHXtMkDzc0RJ3ZZGaGFOaiEDpITKc98/DO7NC5czjdzx4EbwLDpCeIY1USp5UVmkCIl2PBf3Qv1pQJmCr+Vv1xOG/nHDXXSI41dZ4COf+vRwAauREpVT22JG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648571; c=relaxed/simple;
	bh=dfSnH0Yclqt/UhS8gXqBY0B33tPXDhXZ/PpPQRDjFjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eEon27dvodQX579Y8jIfNLqR0Uc1vNFZtgrLHHe4hGFd1I8o3pYfDRFRllhl0gJp3fKq6sFo5ydGsre+6dgIi39AhTQP6qaOL64cdAyDxAbWhZYnc/EddPVASw/iD15GC/hZuswmv4zkIY6P0/OIkiUYjYqg7pC9cmaEqrV1u6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lH/May/h; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7tfcD012633;
	Wed, 18 Sep 2024 08:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=txkwLOI4wL6wdg
	kEojth4TMSyAyDul66S+5Qvppat+4=; b=lH/May/hTkNANBJa/jX/smac6dbQue
	BsUTDvRFfKUJ/asY5N355r1TKEZgMxseABTNvKJ19MZHs1uO2RGXa/r1Txj13SHj
	32sCYkEXytM3hyQcCl1Mj5dVCt/yQipSOtasQeGgT2qhd5vq9Q13GQBdgp+MOvmS
	G3e83DBXOOFKRbyCsemZuFRGoA3CtOyPyZz45E6lEPEyaOKLyWPrwTMyDfcW47D/
	vKlNEBSzqEftCKKdJp9I4mS6TOkf1+OAKEofG+1qav1zBXLe3ftKBiTxzBG1UToC
	YjPAKjRenO+ffHV8ZP8cNU//zPTg2zbBoBqkMmhPRwCAi5IoZzZgEVLA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdrdhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 08:35:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48I8W3xF011242;
	Wed, 18 Sep 2024 08:35:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb7ysy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 08:35:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48I8Zu45022467;
	Wed, 18 Sep 2024 08:35:56 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyb7ystx-1;
	Wed, 18 Sep 2024 08:35:56 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Subject: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Date: Wed, 18 Sep 2024 10:35:50 +0200
Message-ID: <20240918083552.77531-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_06,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=513 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180053
X-Proofpoint-GUID: muVxEvSj4GGiDQq0Str0D8K6DEwSQLes
X-Proofpoint-ORIG-GUID: muVxEvSj4GGiDQq0Str0D8K6DEwSQLes

The Dynamic Interrupt Moderation mechanism can only be used by ULPs
using ib_alloc_cq() and family. We extend DIM to also cover legacy
ULPs using ib_create_cq(). The last commit takes advantage of this end
uses DIM in RDS.

Håkon Bugge (2):
  RDMA/core: Enable legacy ULPs to use RDMA DIM
  rds: ib: Add Dynamic Interrupt Moderation to CQs

 drivers/infiniband/core/cq.c    |  7 +++++--
 drivers/infiniband/core/cq.h    | 16 ++++++++++++++++
 drivers/infiniband/core/verbs.c |  6 ++++++
 net/rds/ib_cm.c                 | 10 ++++++++++
 4 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/core/cq.h

--
2.43.5


