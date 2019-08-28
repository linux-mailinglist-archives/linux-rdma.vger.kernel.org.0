Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CACE9FE39
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfH1JQM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 05:16:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60482 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfH1JQM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 05:16:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S9F5dG018899;
        Wed, 28 Aug 2019 09:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=HK9T9WfatVKw2JpyFWA5Ir3pDV8Kl2EU+MBpUCW29lU=;
 b=bIGPgJkrWRVBSlWQ9RdvDC11D7SLDoffM4FTaQQ/9Y4IWsuyk0OmMLBhm0GggNR5WvvY
 rey8g2SzbfNeFL7dfygfe+4X2FUVB7lzEyosqvwSxvhbikHp6klOXdxgLf2beyCj4i50
 8PIQaTMTgPI/FnK4IugK7e+rC3M1GAYhDPWnZhcjVPnSqaUYI5w/xri0Xu65YJM1rQTU
 w+udv1YlMRRxRsT3qETOqReUoFecV0Y+Z5QBZssOQObkascQhveKuqh1YxcKvzTlxxPf
 8mI8+iWX/6SeLad6siF+NvQ4EnJ8xyMTMugX1nuCgpuwWLwidarHaa/hGI+nMeGwYKMb Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2unpter041-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 09:15:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S9856h182397;
        Wed, 28 Aug 2019 09:15:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2un5rkty3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 09:15:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7S9FjwJ002541;
        Wed, 28 Aug 2019 09:15:45 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 02:15:45 -0700
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
Subject: [PATCH v1 0/5] Take out ucontext from HW objects
Date:   Wed, 28 Aug 2019 12:15:28 +0300
Message-Id: <20190828091533.3129-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=667
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=723 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280098
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch-set, originaly part of Shared PD & MR patch-set, intend to take
out the field ucontext from the HW objects ib_pd and ib_mr.

v0 -> v1:
	* Add the patch "RDMA/nldev: ib_pd can be pointed by multiple
	  ib_ucontext"

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
 include/rdma/ib_verbs.h                       |   2 -
 include/rdma/uverbs_std_types.h               |  11 +-
 include/uapi/rdma/rdma_netlink.h              |   3 +
 10 files changed, 271 insertions(+), 101 deletions(-)

-- 
2.20.1

