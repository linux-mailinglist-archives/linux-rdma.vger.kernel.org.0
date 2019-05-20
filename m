Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C908622D75
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfETH4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 03:56:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETH4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 03:56:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7mk99160720;
        Mon, 20 May 2019 07:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=O0DojGGqkell4vNLuHKhGAHWyqyX52AgxUZoqywcGOQ=;
 b=Ux1GikrRPMnlIK2VsK3MTBDmYvujhmza0fsL1/25cZdVz3unLTedmURa1jwC13b/SyUD
 e+CvK+zyZvOn5QNe6pTeOXP5prABJfwhFadIp3sx/ksZDAnaslTkK8ufs4FGQGrSY+E9
 zwGKmmjVH2utrVQwSjWlZXle/m1nRu+n6SOupWPmdLvQOvU7dpH3n3P4QOdCrYDtleDk
 5uwUUDTbufwF8u1qDae80DEucVV5DrEWFZ/fquFOjFdGLn4KAZMvSezFePgDB91CW7TI
 tR3DyOTtaW63Q2dTpnFI9Uzub+uJVvHo8DgmUNWvHgfA8wIHYSktCGrvxeAxE5I8n+Iu LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2sjapq52wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:56:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7rbWP083818;
        Mon, 20 May 2019 07:54:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2sjwqr3spp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:54:01 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4K7s0pQ027973;
        Mon, 20 May 2019 07:54:00 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.35.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 07:54:00 +0000
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     shamir.rabinovitch@oracle.com
Subject: [PATCH for-next v2 0/4] ib_pd should not have ib_uobject 
Date:   Mon, 20 May 2019 10:53:17 +0300
Message-Id: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200057
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=969 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200057
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
[root@qemu-fc29 iproute2]# ./rdma/rdma res show pd 
dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core] 
dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core] 
dev mlx4_0 pdn 2 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
dev mlx4_0 pdn 3 local_dma_lkey 0x8000 users 5 comm [ib_ipoib] 
dev mlx4_0 pdn 4 local_dma_lkey 0x8000 users 0 comm [ib_srp] 
dev mlx4_0 pdn 5 local_dma_lkey 0x8000 users 0 comm [ib_srpt] 
dev mlx4_0 pdn 14 local_dma_lkey 0x0 users 2 ctxn 8 pid 11786 comm ib_write_bw 
dev mlx4_0 pdn 15 local_dma_lkey 0x0 users 2 ctxn 9 pid 11787 comm ib_write_bw

Changelog:

v1->v2
* 1 patch from v1 applied (Jason)
* Fix uobj_get_obj_read macro (Jason)
* Do not allocate memory when fixing uobj_get_obj_read (Jason)
* Fix uobj_get_obj_read macro (Jason)
* rdma/netlink can now work as before (Leon)

Shamir Rabinovitch (4):
  RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
  RDMA/uverbs: uobj_put_obj_read macro should be removed
  RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
  IB/{core,hw}: ib_pd should not have ib_uobject pointer

 drivers/infiniband/core/nldev.c            |  93 ++++++++-
 drivers/infiniband/core/uverbs_cmd.c       | 218 +++++++++++++--------
 drivers/infiniband/core/verbs.c            |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   1 -
 drivers/infiniband/hw/mlx5/main.c          |   1 -
 drivers/infiniband/hw/mthca/mthca_qp.c     |   3 +-
 include/rdma/ib_verbs.h                    |   1 -
 include/rdma/uverbs_std_types.h            |  11 +-
 8 files changed, 234 insertions(+), 95 deletions(-)

-- 
2.20.1

