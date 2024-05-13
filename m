Return-Path: <linux-rdma+bounces-2450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0558C4115
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088A61C22D5E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD25F1514CD;
	Mon, 13 May 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCPybtLw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352E15098E;
	Mon, 13 May 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604882; cv=none; b=W8Us78r5jaSCKu4zIG9S8f+8oQ+VrV6NAEEMcrGt7ueb8YIw6wn0LstQ4KMXhboKjNcUJKvE7vaukSwEeksPIaPC2xctzBdo7FtW5En0dr43XsCqUV5Xx18AtMglAqAlgTe68a6Wx3VhEGW8myilptx/j0mNe1/PcP8IgJFEq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604882; c=relaxed/simple;
	bh=TG35ABlfr/gUBh6hxqOCQKtGj8bXdt0sjJdHpeJbLag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zzy98WRfBugyDvjiPeX9mlERTnY5UrFKnwpAunyfzWcXw2KGyaf3BczuaMb881X5sQ4hEZB9Sdb29NzreYK27lvVEy/qJX9oaX+U8g1LaBj6wIOkFykf+IEebI/NNwq2jSMbKT+yYtKPZTg1iHqoU900HqeprnUaKJzykvPBmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DCPybtLw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DCOBrD027951;
	Mon, 13 May 2024 12:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=asPw8Na3vKhJc4WBcLxe3ZTCvPqcnYlUc+TTZ6Jwr4Y=;
 b=DCPybtLwZ+7MNGaetDYKkFPkopsSD6nGVYDq7QJdAgR8SBXNxrpI206O9fd+JxTMohcC
 +hWdw/gyDDxhv75ms4X6I5HhVpJpXUDqNPDqK8AxOKVHj6rxIVBCsIrWjUIimVuPyik7
 3UAamxljaqE4pu+4vjUsdy/gdeM9YhOe4Z/RamNJtJw5s2kMacv626RPtnuJCxfvMLTH
 ZZWisSG1Din7TAVTs+oELXqjCLo3lNL1qo/QtuboiRj/sYs+1JSAK9NdBmQnV5egppxn
 zfWhcU467LKBxKk5byNDdfJERZpMZk9bmuBzhRFBtoY1oO0DD8mIT2pMVdzzG+M+7x9w dQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3ce28vpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DBBFXk018131;
	Mon, 13 May 2024 12:54:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4c1348-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:12 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44DCq97u001819;
	Mon, 13 May 2024 12:54:12 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y1y4c12sj-1;
	Mon, 13 May 2024 12:54:11 +0000
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
Subject: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
Date: Mon, 13 May 2024 14:53:40 +0200
Message-Id: <20240513125346.764076-1-haakon.bugge@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130082
X-Proofpoint-GUID: j_l2RydB90BZJl-lij9T-2hpDFYUH-5w
X-Proofpoint-ORIG-GUID: j_l2RydB90BZJl-lij9T-2hpDFYUH-5w

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
   wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
   work-queue inherits the same flag(s).

Håkon Bugge (6):
  workqueue: Inherit NOIO and NOFS alloc flags
  rds: Brute force GFP_NOIO
  RDMA/cma: Brute force GFP_NOIO
  RDMA/cm: Brute force GFP_NOIO
  RDMA/mlx5: Brute force GFP_NOIO
  net/mlx5: Brute force GFP_NOIO

 drivers/infiniband/core/cm.c                  | 15 ++++-
 drivers/infiniband/core/cma.c                 | 20 ++++++-
 drivers/infiniband/hw/mlx5/main.c             | 22 +++++--
 .../net/ethernet/mellanox/mlx5/core/main.c    | 14 ++++-
 include/linux/workqueue.h                     |  2 +
 kernel/workqueue.c                            | 17 ++++++
 net/rds/af_rds.c                              | 60 ++++++++++++++++++-
 7 files changed, 138 insertions(+), 12 deletions(-)

--
2.39.3


