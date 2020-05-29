Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA261E7A06
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE2KFQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 06:05:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2KFQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 06:05:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TA1rMF087676;
        Fri, 29 May 2020 10:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=0gJLq4YojQgaIIrHm1luPyKNZoJoIPK+46mPmjZtKgg=;
 b=j+cQfjbpt+xzDLxDpETFbG3oFhJIHfhNq6SpJxbj3QdLtrNTZPkCSbCaDfjO8HSGgk6U
 yE1ysnVJ98dbQsAC30H3CybTi8ofelMl+eS02i8ONbfbkhMajbBEgXU9gledNdpQHfq9
 YxJt8dSLvDbWLdVfPIT6yNitgi9Ef0KqcHdCb+oOs2ajiQynyntnP/L2Tq8b1eOA2FwP
 1LTKZRUCpquxMSwtDgBRXBHZSOdeHES1TkNNMhPtWTGMuqmkVfNimYAiV9DS1TxfEbY/
 WFVCBCWgbzqO8M0+wu0+w84MdpaPaRJYiq0O8x8YD49vrJIFQY2dP3+TX1rwEhHUqCIy lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 318xbk9m94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 10:05:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T9xNNT179592;
        Fri, 29 May 2020 10:03:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 317ddu7q9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 10:03:11 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04TA39V2008190;
        Fri, 29 May 2020 10:03:09 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 03:03:09 -0700
Date:   Fri, 29 May 2020 13:03:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        "Vishwanathapura, Niranjana" <niranjana.vishwanathapura@intel.com>,
        Andrzej Kacprowski <andrzej.kacprowski@intel.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] IB/hfi1: Fix an error code in hfi1_vnic_init()
Message-ID: <20200529100302.GC1304852@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005290079
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should preserve the error code from hfi1_netdev_rx_init() but
currently the function returns success instead.

Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface Controller (VNIC) HW support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/hfi1/vnic_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index b183c56b7b6a4..f89d0cb1c7204 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -512,7 +512,8 @@ static int hfi1_vnic_init(struct hfi1_vnic_vport_info *vinfo)
 			goto txreq_fail;
 	}
 
-	if (hfi1_netdev_rx_init(dd)) {
+	rc = hfi1_netdev_rx_init(dd);
+	if (rc) {
 		dd_dev_err(dd, "Unable to initialize netdev contexts\n");
 		goto alloc_fail;
 	}
-- 
2.26.2

