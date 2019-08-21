Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4397C94
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfHUOWR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:22:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfHUOWQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:22:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEEMAM077937;
        Wed, 21 Aug 2019 14:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=XLC/hg3v7+kxf7Cw6O8axHdsVAK3rhV57+uPAmArkIg=;
 b=UnahgY12tabeG1r1QjTtlwK0B135gqx1od3MGM0IFUvj4oqznIX92e6zdNhdAIJJzj8F
 u8QVciBk/LxFZA3egbrstO3czQ8Iao7RwklNKpb5duCighkBgd+dC4DhBG6QF4zc1ASR
 uxikXCMftQQ7NXoxRFjmD66btdASeW5sPa3+2mC8GHEt/rdf8UPwaHrdsV6RPUYH9SzD
 OZ3rLRFwYzDrSpm9XhVAKgjg7TEF9mhBiqeAI01o/OW0kRosYNx87TjBXrUOJFpLcuTE
 2PzgserspmMZmWKS1hznT96jMd7JW1tr2avjYgj6nswW756XghM3mH3bG9jZN3LwOUh/ Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uea7qwxdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:21:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEIZB1182834;
        Wed, 21 Aug 2019 14:21:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ugj7qgd7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:21:44 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LELd7A014426;
        Wed, 21 Aug 2019 14:21:39 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:21:38 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Subject: [PATCH v1 00/24] Shared PD and MR
Date:   Wed, 21 Aug 2019 17:21:01 +0300
Message-Id: <20190821142125.5706-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210157
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following patch-set introduce the shared object feature.

A shared object feature allows one process to create HW objects (currently
PD and MR) so that a second process can import.

Patch-set is logically splits to 4 parts as the following:
- patches 1 to 7 and 18 are preparation steps.
- patches 8 to 14 are the implementation of import PD
- patches 15 to 17 are the implementation of the verb
- patches 19 to 24 are the implementation of import MR

v0 -> v1:
	* Delete the patch "IB/uverbs: ufile must be freed only when not
	  used anymore". The process can die, the ucontext remains until
	  last reference to it is closed.
	* Rebase to latest for-next branch

Shamir Rabinovitch (16):
  RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
  RDMA/uverbs: Delete the macro uobj_put_obj_read
  RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
  IB/{core,hw}: ib_pd should not have ib_uobject pointer
  IB/core: ib_uobject need HW object reference count
  IB/uverbs: Helper function to initialize ufile member of
    uverbs_attr_bundle
  IB/uverbs: Add context import lock/unlock helper
  IB/verbs: Prototype of HW object clone callback
  IB/mlx4: Add implementation of clone_pd callback
  IB/mlx5: Add implementation of clone_pd callback
  RDMA/rxe: Add implementation of clone_pd callback
  IB/uverbs: Add clone reference counting to ib_pd
  IB/uverbs: Add PD import verb
  IB/mlx4: Enable import from FD verb
  IB/mlx5: Enable import from FD verb
  RDMA/rxe: Enable import from FD verb

Yuval Shaia (8):
  IB/core: Install clone ib_pd in device ops
  IB/core: ib_mr should not have ib_uobject pointer
  IB/core: Install clone ib_mr in device ops
  IB/mlx4: Add implementation of clone_pd callback
  IB/mlx5: Add implementation of clone_pd callback
  RDMA/rxe: Add implementation of clone_pd callback
  IB/uverbs: Add clone reference counting to ib_mr
  IB/uverbs: Add MR import verb

 drivers/infiniband/core/device.c              |   2 +
 drivers/infiniband/core/nldev.c               | 127 ++++-
 drivers/infiniband/core/rdma_core.c           |  23 +-
 drivers/infiniband/core/uverbs.h              |   2 +
 drivers/infiniband/core/uverbs_cmd.c          | 489 +++++++++++++++---
 drivers/infiniband/core/uverbs_main.c         |   1 +
 drivers/infiniband/core/uverbs_std_types_mr.c |   1 -
 drivers/infiniband/core/verbs.c               |   4 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   1 -
 drivers/infiniband/hw/mlx4/main.c             |  18 +-
 drivers/infiniband/hw/mlx5/main.c             |  34 +-
 drivers/infiniband/hw/mthca/mthca_qp.c        |   3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
 include/rdma/ib_verbs.h                       |  43 +-
 include/rdma/uverbs_std_types.h               |  11 +-
 include/uapi/rdma/ib_user_verbs.h             |  15 +
 include/uapi/rdma/rdma_netlink.h              |   3 +
 17 files changed, 669 insertions(+), 113 deletions(-)

-- 
2.20.1

