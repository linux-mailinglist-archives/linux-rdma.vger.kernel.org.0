Return-Path: <linux-rdma+bounces-2500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69878C686D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 16:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8941F21D97
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211E13F447;
	Wed, 15 May 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="INEPCQmx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA913F43D;
	Wed, 15 May 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782787; cv=none; b=X0DZWsHnzDnICUSfW03QNWnl7gB2UFnNm+tzHR4TuGYe6CtEoogDTYXHu8Q+EjFKovpm/IAZEKtZXCmSkp8lqgqDH53GiWzjLZ4c6FnN/UnjMqmK1V6AUNeWhP0ZfkwLGIvJPBhGmHl04mcTbyMJcI1zpw1m6O1WCVaHsiehvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782787; c=relaxed/simple;
	bh=e+p8RDk6UwCW/o9hvuO0idARqRopXax2P77SzHlLk1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=II4DrTic6Z/EYda95fl52PbPhinqkYHfZ/dmXDB2je5I0KPIEkAOmh2YHt5wsv5P/zOnbs7vrZePVzdhsSBJ3y5YmQhbRFhbwmRP4fZekYUxQjmI3xW8fuZtz4HCEh2OoHDQ7UJWwm3GKzxzV6ygT6304stST3NgwyAxYDbxiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=INEPCQmx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F7nnaT008005;
	Wed, 15 May 2024 12:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=uCYHK17hrJDOfXBR96uhZxWSEWnjI89SyGP2oY566u4=;
 b=INEPCQmxH/ndA0QPvint7zqkUM0BXXaa/DAo/6BOkmwm/B47MYt+xft2oqKQeiNxHxUe
 XSDtnfreq8R2lJpYMFAVwX34WAl1rnR21JZT+16Wem4QHqteSHuTBkejE65EzK5HcmeA
 Vhd23WTnUe1voEEZSGrC7uoyllBqi890u271pR6ZPUfeQzcv4L/Vi/vbWdZpQvbLpgXH
 j2JAisKK0CaQsVXsjlVsn7CGVpxt315KZ95jO6QB5F07+eG5X9wdyNZ7cPT8tJF8WNVj
 h2gdFQPpQo6jwXefKtXzcx6zcbCtSVz8A5Xzd18xlumLRcWnef6gkn0JOwU3Wy7iVM2g cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3txc2xxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:53:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FC60pr038324;
	Wed, 15 May 2024 12:53:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pxgugg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:53:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FCmlrX038458;
	Wed, 15 May 2024 12:53:47 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24pxgud9-1;
	Wed, 15 May 2024 12:53:47 +0000
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
Subject: [PATCH v2 0/6] rds: rdma: Add ability to force GFP_NOIO
Date: Wed, 15 May 2024 14:53:36 +0200
Message-Id: <20240515125342.1069999-1-haakon.bugge@oracle.com>
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
 definitions=2024-05-15_06,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150090
X-Proofpoint-GUID: 0CdHtR4Rw4q5f5UdYabwerpWAtTHmgJV
X-Proofpoint-ORIG-GUID: 0CdHtR4Rw4q5f5UdYabwerpWAtTHmgJV

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
 kernel/workqueue.c                            | 21 +++++++
 net/rds/af_rds.c                              | 59 ++++++++++++++++++-
 7 files changed, 141 insertions(+), 12 deletions(-)

--
2.45.0


