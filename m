Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44FF97CE3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfHUO10 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:27:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51752 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO10 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:27:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENXvb096446;
        Wed, 21 Aug 2019 14:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=1auPGg+/vG0RdyB63WsggCifsf1kXs0JscGVAUu3qiU=;
 b=PO+uh8CAYB/eivF20h+fHqQ+g8l0ibBh7pVFekLAjvMVNnzJezxbvv530w6iEmcjY4ST
 NQq5vLrSqmt7KdbfuC+LMmo67g3xhET7bmmCu2sBJcMi1xYJMmPhLwWJ+XQJ6ziEqb3G
 ctjPJ05+m5qtZzFr2TaEe91f8UD9Go1UEVwcPmozsprJIk9XPu9RzxeXbvIJx6U2F6yz
 ysptHOWtaVPGw3pK+Q5hYLUJ1pCLiMqyYHOuw3+3sgAfulNwrFQs71shB+ZZWMoke1qA
 c/DOyfKpxZx/4MUI5SoYzyo9EFU01oAxdW4rOOnPi/XejI3QGU7Rt80qrLt3SdsmafpU +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ue9hpnvx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:26:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMZ9O115247;
        Wed, 21 Aug 2019 14:26:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ug26a3fab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:26:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LEQuZT019763;
        Wed, 21 Aug 2019 14:26:56 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:26:56 -0700
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
Subject: [PATCH v1 rdma-core 00/12] Shared PD and MR
Date:   Wed, 21 Aug 2019 17:26:27 +0300
Message-Id: <20190821142639.5807-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following patch-set introduce the shared object feature.

A shared object feature allows one process to create HW objects (currently
PD and MR) so that a second process can import.

Patch-set is logically splits to two parts, one for PD and one for MR.
(patches 2 and 7 are the changes to man pages)

v0 -> v1:
	* Fix typo in comment
	* Rebase to latest upstream branch

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
 libibverbs/man/ibv_reg_mr.3         |   17 +-
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
 21 files changed, 1520 insertions(+), 3 deletions(-)
 create mode 100644 libibverbs/examples/shpd_pingpong.c

-- 
2.20.1

