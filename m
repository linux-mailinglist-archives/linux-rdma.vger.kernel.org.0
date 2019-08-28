Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1432CA0A66
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1TXi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 15:23:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47920 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfH1TXh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 15:23:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SJKLKk172955;
        Wed, 28 Aug 2019 19:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=yoMQcH5vzRkEdsTmHaY4NeEA5xq2HWMCWNc8zSckcrU=;
 b=sNISs00C8NTrsZ6sjgtAyviAZNSj848XjZEJel+rD5h4V8YCrIujeSmw8cRS2IEFuoKm
 IhWNDQrBLSA9tDHIPfTtG0JwfGs7NeEipTunL5mS/YshcLya0JsQLI71SMOoA6J4ap9w
 nIiFfqKRea+UoL4PPyytHGqiU8DSJZyw3MfJ+KUDZ2+BsDrCTIUqKcjphjkLEFnzTHRG
 JlMo+Q8yIw6W5E3M5K5cauW49voSlqTPYZ0hfEXvssbjBNCd+AfvFq2XDbFHIMpYuulr
 2G2RAC3keI2h+QpAI+vyPQlvC6A9zG0PwBzbOiKB6Ks3t6KQw41H53EVkfYzMV6Osa3v 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2unyp9010k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 19:23:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SJIruf150889;
        Wed, 28 Aug 2019 19:23:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2untetrqt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 19:23:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SJN6BM007968;
        Wed, 28 Aug 2019 19:23:06 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 12:23:05 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, oulijun@huawei.com,
        xavier.huwei@huawei.com, leon@kernel.org, parav@mellanox.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        galpress@amazon.com, israelr@mellanox.com, monis@mellanox.com,
        maxg@mellanox.com, kamalheib1@gmail.com, yuval.shaia@oracle.com,
        denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, ereza@mellanox.com, will@kernel.org,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, srabinov7@gmail.com,
        santosh.shilimkar@oracle.com
Subject: [PATCH v2 0/5] Take out ucontext from HW objects
Date:   Wed, 28 Aug 2019 22:22:40 +0300
Message-Id: <20190828192245.11003-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=702 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280187
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch-set, originaly part of Shared PD & MR patch-set, intend to take
out the field ucontext from the HW objects ib_pd and ib_mr.

v0 -> v1:
        * Add the patch "RDMA/nldev: ib_pd can be pointed by multiple
	  ib_ucontext"

v1 -> v2:
	* Remove unneeded union in ib_mr

Shamir Rabinovitch (4):
  RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
  RDMA/uverbs: Delete the macro uobj_put_obj_read
  IB/{core,hw}: ib_pd should not have ib_uobject pointer
  RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext

Yuval Shaia (1):
  IB/core: ib_mr should not have ib_uobject pointer

 drivers/infiniband/core/nldev.c               | 127 +++++++++-
 drivers/infiniband/core/uverbs_cmd.c          | 219 +++++++++++-------
 drivers/infiniband/core/uverbs_std_types_mr.c |   1 -
 drivers/infiniband/core/verbs.c               |   4 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   1 -
 drivers/infiniband/hw/mlx5/main.c             |   1 -
 drivers/infiniband/hw/mthca/mthca_qp.c        |   3 +-
 include/rdma/ib_verbs.h                       |   6 +-
 include/rdma/uverbs_std_types.h               |  11 +-
 include/uapi/rdma/rdma_netlink.h              |   3 +
 10 files changed, 272 insertions(+), 104 deletions(-)

-- 
2.20.1

