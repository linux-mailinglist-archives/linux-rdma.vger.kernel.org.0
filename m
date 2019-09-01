Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DFA4ABB
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2019 18:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfIAQxx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Sep 2019 12:53:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfIAQxx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Sep 2019 12:53:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81Gn0wg178754;
        Sun, 1 Sep 2019 16:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=5iZCgpzek+1XaMZLMl+1kbbVjymb7/H2pYuZ4wVTy/k=;
 b=fo89dR9pE4mNbBK2aBMBKlsw/cN2HW/aSDq/FMT/J4Vpibgv5F7CW/a+CJVmWJ8VtFcO
 D8Tdcd6NEcYtrimL6Ii5Dzw7VHOfVUIZtivj8s4xeiJJaBK9iXWlh+gjvywLE/2MdCOi
 0bZ6CHe5icHk2huR6MboXNyml2AfqZey5+daFfewzXRt00UQWeU2ENP7xf3lgnCGpiXh
 r3rBBdzta+UoPTSfweald8fT5QPfqv0F4zUwMsGtdQBavnpYIvdgMcz5yZ9KHM/z8Snm
 aPlum8QBpfEYTRrNfqHv+4PLkH4h4ycjZ1dia71TjwZzg10bKo1n4KpzGGMeAkkvw9QE +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2urhst00bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 16:53:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81Gn1ZN171609;
        Sun, 1 Sep 2019 16:51:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2uqey7paum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 16:51:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x81GpKmQ007022;
        Sun, 1 Sep 2019 16:51:20 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Sep 2019 09:51:20 -0700
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
Subject: [PATCH v3 0/5] Take out ucontext from HW objects
Date:   Sun,  1 Sep 2019 19:51:03 +0300
Message-Id: <20190901165108.11518-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=775
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=835 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010192
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

v2 -> v3:
	* Reorder patches so build would not break

Thanks,
Yuval

Shamir Rabinovitch (4):
  RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
  RDMA/uverbs: Delete the macro uobj_put_obj_read
  RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
  IB/{core,hw}: ib_pd should not have ib_uobject pointer

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

