Return-Path: <linux-rdma+bounces-2576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C68CC27D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919E51C22761
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2513EFE3;
	Wed, 22 May 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J7ekvkrr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFA1E877;
	Wed, 22 May 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386107; cv=none; b=AEeJU0pUBxMXtW2eL/noJVQM/Y9aePEoow/8rTdRAVzvZzfAC+DDI0jbb9yTI1f4RRK9WSSYQkGeueXlUTe74gzwcpkRPOjTlH/Z4+J8jPG5SaWpsG34yiFqMB7uwCLfvK96I5J4WjI/3p3xE6sf4PnkvrvzrvLRcjvFQG9jvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386107; c=relaxed/simple;
	bh=v8eakKEM4ULYeCnXIKHdujVrFtH6Rw+0Imx+uzve/lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WSoLFe6EqGkq0RDp5S64UtJ8Lp9aS+5MDfleiPysniGem1FoalwD3Iv7MkQftIMo3ffnsqlQMiWqiHJSFQpuS9j9X/RLeIs8HD2e957tF2BMoxYekF5Es7IHzOopepDD6WAqRZH/MPxm+oksRNM+cJyNhDsCVuT1QtDc6z7wDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J7ekvkrr; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqUbR022592;
	Wed, 22 May 2024 13:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=oq/kG3egLEXzbNt6YtpgNyeWtInFVjpBmdZ6xA2j9Gc=;
 b=J7ekvkrrWQvkGwObUAgHfnR1xJ1LQAD0y49qS5rzChTchDl0KKJy9vEWhBW2Xf5PJsvX
 Y2Pm9GJ7EYVkNWes0puVgF+7UVVyDHQqRmkeZbXExYssUcfF2Il5b3ACzsfjphy5u/6g
 GmuM+Sezac+Gb327n3BDBCPJqW4je/z6qmzx5ggeHFL/SNg/BtmI1CAvGmjHa3vZHJSD
 3dIGIZhHR49UwmRIhOW/UpAwjO2GtQDEIHF3nNA8hpBt2X+zDjmKd4WscbnK2kJr/WGz
 XBKzSMR010fGAomfL5HqcWTLUYFikLKuW3+wQNFzEVEDfnexe68jwltxxCY49O+Imw5d eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv7svq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:54:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MDlmWS019631;
	Wed, 22 May 2024 13:54:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98sw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:54:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm2k016070;
	Wed, 22 May 2024 13:54:48 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-1;
	Wed, 22 May 2024 13:54:48 +0000
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
Subject: [PATCH v3 0/6] rds: rdma: Add ability to force GFP_NOIO
Date: Wed, 22 May 2024 15:54:32 +0200
Message-Id: <20240522135444.1685642-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_07,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220093
X-Proofpoint-GUID: Mlw-2_TRVwFnFbnUOaa_HnEMcZYlzC65
X-Proofpoint-ORIG-GUID: Mlw-2_TRVwFnFbnUOaa_HnEMcZYlzC65

This series enables RDS and the RDMA stack to be used as a block I/O
device. This to support a filesystem on top of a raw block device
which uses RDS and the RDMA stack as the network transport layer.

Under intense memory pressure, we get memory reclaims. Assume the
filesystem reclaims memory, goes to the raw block device, which calls
into RDS, which calls the RDMA stack. Now, if regular GFP_KERNEL
allocations in RDS or the RDMA stack require reclaims to be fulfilled,
we end up in a circular dependency.

We break this circular dependency by:

1. Force all allocations in RDS and the relevant RDMA stack to use
   GFP_NOIO, by means of a parenthetic use of
   memalloc_noio_{save,restore} on all relevant entry points.

2. Make sure work-queues inherits current->flags
   wrt. PF_MEMALLOC*, such that work executed on the
   work-queue inherits the same flag(s).


Håkon Bugge (6):
  workqueue: Inherit per-process allocation flags
  rds: Brute force GFP_NOIO
  RDMA/cma: Brute force GFP_NOIO
  RDMA/cm: Brute force GFP_NOIO
  RDMA/mlx5: Brute force GFP_NOIO
  net/mlx5: Brute force GFP_NOIO

 drivers/infiniband/core/cm.c                  | 15 ++++-
 drivers/infiniband/core/cma.c                 | 20 ++++++-
 drivers/infiniband/hw/mlx5/main.c             | 22 +++++--
 .../net/ethernet/mellanox/mlx5/core/main.c    | 14 ++++-
 include/linux/workqueue.h                     |  9 +++
 kernel/workqueue.c                            | 60 +++++++++++++++++++
 net/rds/af_rds.c                              | 59 +++++++++++++++++-
 7 files changed, 187 insertions(+), 12 deletions(-)

--
2.31.1


