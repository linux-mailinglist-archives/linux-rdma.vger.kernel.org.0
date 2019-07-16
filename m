Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABF56AE77
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfGPSVX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:21:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPSVX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:21:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIsob124168;
        Tue, 16 Jul 2019 18:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=90NJu+sdq1/LKb6cZZgTZbCffVv+E5VG8dbT7YPIqkM=;
 b=s4gbUIE0DGPYq5Iu5sBWcPCyB2e1NeXm/V7jzw42Moc4N5WdkE7E45WuFOE5iOcaArj0
 D+tRF6lyq+N5X2ZQ98JG+QW1adV75TtOtySIPxA1Wl3TGOWyHnoTICmyh7VTgMg8qHuC
 XdzjPd7v5Hb4wTDStBUsG9d0A1f0iVSJfDlgy8idrjYfyrre7a52MfP/pm/At7Db/UmH
 SvYADZKZNeGh00sjR8CeUOkwOjkiCR0hm9NKFMnYS7sB5YRwfHIJP9cqfD76qTitV6yE
 dnbyZ/wheXr+BfwQDfvYfJwJeRb9nrAwRs7QI4yJnw1RWzk0zvMw8lSKWAegtd0fUdQ4 bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xqx5jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:21:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHqGb038390;
        Tue, 16 Jul 2019 18:19:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4du2wg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:00 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIIww8002620;
        Tue, 16 Jul 2019 18:18:58 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:18:58 +0000
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
Subject: [PATCH rdma-core 00/12] Shared PD and MR
Date:   Tue, 16 Jul 2019 21:18:28 +0300
Message-Id: <20190716181840.4579-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160224
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following patch-set introduce the shared object feature.

A shared object feature allows one process to create HW objects (currently
PD and MR) so that a second process can import.

Patch-set is logically splits to two parts, one for PD and one for MR.
(patches 2 and 7 are the changes to man pages)

Shamir Rabinovitch (2):
  verbs: Introduce new inline helpers
  verbs: pinpong test using shared objects API

Yuval Shaia (10):
  man: Add description to ibv_import_pd function
  verbs: Introduce new verb to import PD object
  mlx4: Implementation of import PD callback
  mlx5: Implementation of import PD callback
  rxe: Implementation of import PD callback
  man: Add description to ibv_import_mr function
  verbs: Introduce new verb to import MR object
  mlx4: Implementation of import MR callback
  mlx5: Implementation of import MR callback
  rxe: Implementation of import MR callback

 kernel-headers/rdma/ib_user_verbs.h |   26 +
 libibverbs/cmd.c                    |   39 +
 libibverbs/driver.h                 |   12 +
 libibverbs/dummy_ops.c              |   18 +
 libibverbs/examples/CMakeLists.txt  |    3 +
 libibverbs/examples/shpd_pingpong.c | 1142 +++++++++++++++++++++++++++
 libibverbs/kern-abi.h               |    3 +-
 libibverbs/libibverbs.map.in        |    3 +
 libibverbs/man/ibv_alloc_pd.3       |   22 +-
 libibverbs/man/ibv_reg_mr.3         |   22 +-
 libibverbs/verbs.h                  |   55 ++
 providers/mlx4/mlx4-abi.h           |    2 +
 providers/mlx4/mlx4.c               |    2 +
 providers/mlx4/mlx4.h               |    4 +
 providers/mlx4/verbs.c              |   56 ++
 providers/mlx5/mlx5-abi.h           |    2 +
 providers/mlx5/mlx5.c               |    2 +
 providers/mlx5/mlx5.h               |    4 +
 providers/mlx5/verbs.c              |   54 ++
 providers/rxe/rxe-abi.h             |    2 +
 providers/rxe/rxe.c                 |   55 ++
 21 files changed, 1525 insertions(+), 3 deletions(-)
 create mode 100644 libibverbs/examples/shpd_pingpong.c

-- 
2.20.1

