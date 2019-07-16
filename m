Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6ED6AE3F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfGPSNr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:13:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59562 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPSNr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:13:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9NfU002058;
        Tue, 16 Jul 2019 18:13:31 GMT
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78pp58w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICe1J114757;
        Tue, 16 Jul 2019 18:13:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tq6mn1mur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:30 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIDSMZ030503;
        Tue, 16 Jul 2019 18:13:28 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:13:28 +0000
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
Subject: [PATCH 10/25] IB/core: Install clone ib_pd in device ops
Date:   Tue, 16 Jul 2019 21:11:45 +0300
Message-Id: <20190716181200.4239-11-srabinov7@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181200.4239-1-srabinov7@gmail.com>
References: <20190716181200.4239-1-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160223
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1034
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160222
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yuval Shaia <yuval.shaia@oracle.com>

Install clone_ib_pd in the device ops.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/infiniband/core/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 7f4affe8a10d..d4996e0f2976 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2572,6 +2572,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, set_vf_guid);
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 	SET_DEVICE_OP(dev_ops, unmap_fmr);
+	SET_DEVICE_OP(dev_ops, clone_ib_pd);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
-- 
2.20.1

