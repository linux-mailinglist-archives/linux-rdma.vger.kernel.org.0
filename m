Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9832FB86
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfE3MZU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 08:25:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfE3MZT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 08:25:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UCIdZJ057641;
        Thu, 30 May 2019 12:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=B2sNgYEhpnEp5W1pNTDkHmHu4dojUrg9oDu/rMfZL40=;
 b=IuWUO9P95cgdfh/46OdBln0ha6t954AKj1SNSjm8CpbtRlDh4uPhUu9Imt6349UAnEJv
 qK0YNs/+ryWcuPXSiQLbD/BvSAeRffrjT6lU+SMYzu6S+t9GjRxGTGrY8ykkL4abZQr2
 C4cZF2hzDB8YLEMYFFAtS9c/2v6nBhS4+0gR0IaIAXfBsH3hgeJ1CVaSNFN5pyjvcmpc
 HdZb9nwNyvOY5bkKocmTBnOIo/AhX8dHu6D1bW+xXPC7rZw0swnePKpzWSJTUneRrur7
 KkD3+yMvetuWOzHOF07FDRqDksyWu02Zmb6D6+QcXbYQQpAKpHPjzn9Y8EWmsMD90J9I FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbqfjt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 12:24:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UCOPrG150961;
        Thu, 30 May 2019 12:24:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sqh749cp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 12:24:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4UCOkxp018969;
        Thu, 30 May 2019 12:24:46 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.32.156)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 05:24:45 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     dledford@redhat.com, jgg@mellanox.com,
        shamir.rabinovitch@oracle.com
Subject: [PATCH for-next v3 0/4] ib_pd should not have ib_uobject
Date:   Thu, 30 May 2019 15:24:05 +0300
Message-Id: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=989 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set complete the cleanup done in the driver/verbs/uverbs
where the dependency of the code in the ib_x uobject pointer was
removed.

The uobject pointer is removed from the ib_pd as last step 
before I can start adding the pd sharing code.

The rdma/netlink code now don't have dependency in the ib_pd
uobject pointer and can report multiple context id that point
to same ib_pd. 

Using iproute2 I can test the modified rdma/netlink:
[root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core] 
dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core] 
dev mlx4_0 pdn 2 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
dev mlx4_0 pdn 3 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
dev mlx4_0 pdn 4 local_dma_lkey 0x8000 users 0 comm [ib_srp] 
dev mlx4_0 pdn 5 local_dma_lkey 0x8000 users 0 comm [ib_srpt] 
dev mlx4_0 pdn 6 local_dma_lkey 0x0 users 2 ctxn 0 pid 7693 comm ib_send_bw 
dev mlx4_0 pdn 7 local_dma_lkey 0x0 users 2 ctxn 1 pid 7694 comm ib_send_bw

Changelog:

v1->v2
* 1 patch from v1 applied (Jason)
* Fix uobj_get_obj_read macro (Jason)
* Do not allocate memory when fixing uobj_get_obj_read (Jason)
* Fix uobj_get_obj_read macro (Jason)
* rdma/netlink can now work as before (Leon)

v2->v3:
* rdma/netlink nest multiple context ids of same ib_pd (Leon)

Shamir Rabinovitch (4):
  RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
  RDMA/uverbs: uobj_put_obj_read macro should be removed
  RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
  IB/{core,hw}: ib_pd should not have ib_uobject pointer

 drivers/infiniband/core/nldev.c            | 129 +++++++++++-
 drivers/infiniband/core/uverbs_cmd.c       | 218 +++++++++++++--------
 drivers/infiniband/core/verbs.c            |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   1 -
 drivers/infiniband/hw/mlx5/main.c          |   1 -
 drivers/infiniband/hw/mthca/mthca_qp.c     |   3 +-
 include/rdma/ib_verbs.h                    |   1 -
 include/rdma/uverbs_std_types.h            |  11 +-
 include/uapi/rdma/rdma_netlink.h           |   3 +
 9 files changed, 273 insertions(+), 95 deletions(-)

-- 
2.20.1

