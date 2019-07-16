Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D476AE2F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfGPSMx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:12:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPSMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:12:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9KBB108093;
        Tue, 16 Jul 2019 18:12:33 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tq6qtp8fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:12:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICWiM148410;
        Tue, 16 Jul 2019 18:12:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tq5bcjejm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:12:31 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GICPF5023758;
        Tue, 16 Jul 2019 18:12:26 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:12:25 +0000
From:   Shamir Rabinovitch <srabinov7@gmail.com>
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
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH 00/25] Shared PD and MR
Date:   Tue, 16 Jul 2019 21:11:35 +0300
Message-Id: <20190716181200.4239-1-srabinov7@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=861
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160223
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1034
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160222
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following patch-set introduce the shared object feature.

A shared object feature allows one process to create HW objects (currently
PD and MR) so that a second process can import.

Patch-set is logically splits to 4 parts as the following:
- patches 1 to 8 and 18 are preparation steps.
- patches 9 to 14 are the implementation of import PD
- patches 15 to 17 are the implementation of the verb
- patches 19 to 14 are the implementation of import MR

Shamir Rabinovitch (17):
  RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
  RDMA/uverbs: Delete the macro uobj_put_obj_read
  RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
  IB/{core,hw}: ib_pd should not have ib_uobject pointer
  IB/core: ib_uobject need HW object reference count
  IB/uverbs: Helper function to initialize ufile member of
    uverbs_attr_bundle
  IB/uverbs: Add context import lock/unlock helper
  IB/uverbs: ufile must be freed only when not used anymore
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
 drivers/infiniband/core/rdma_core.c           |  52 +-
 drivers/infiniband/core/uverbs.h              |  24 +
 drivers/infiniband/core/uverbs_cmd.c          | 505 +++++++++++++++---
 drivers/infiniband/core/uverbs_main.c         |   5 +
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
 17 files changed, 740 insertions(+), 113 deletions(-)

-- 
2.20.1

