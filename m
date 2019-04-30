Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E341FB5F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfD3OZW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 10:25:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47094 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfD3OZV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 10:25:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UEOTiX053601;
        Tue, 30 Apr 2019 14:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=P8qIxx5y2+atTJF39SPyZ9UKLK0ArIcXYp8wErranJw=;
 b=pqcAFOQzPPhCLdBTqe99DJa+RJzSBMM1GdJ4V0cHCq0RQQcOiChFB56TIPseo/hjpQ5P
 4cfIfS9D/MKLg9e6WT0oA87dzX16G52xBhs1vfGFnhg+KNUFLQ5zkHxnF3/+gokRPJlQ
 quHyYU8HMpVnu7KBViO2qV1TLxEhVE/vrDsWVPJC1Y9ZE07N0Cct9ySTEk38j54bnUoL
 dnZF/P+xAwpzJHXbnX9VMsDulFAB7DlC/r7WzkcoBqhb/ZE1s4+iSF7Qa1NeFdsI4+jg
 nKZD71semrmkGko/DsWgIjf5T4D3EeREuIpzT2Xo/MRP3eqyxHu9nEF0rzYpuEgvrgf3 OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s5j5u1jm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:25:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UENZWq095091;
        Tue, 30 Apr 2019 14:25:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2s4yy9jutj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:25:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3UEP4Fd024780;
        Tue, 30 Apr 2019 14:25:04 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.1.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 07:25:04 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH for-next v1 1/4] RDMA/uverbs: initialize uverbs_attr_bundle ucontext in ib_uverbs_get_context
Date:   Tue, 30 Apr 2019 17:23:21 +0300
Message-Id: <20190430142333.31063-2-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300090
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300091
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_uverbs_get_context does not have uobject so it does not call the
rdma_lookup_get_uobject which is used to set up the uverbs_attr_bundle
ucontext. for ib_uverbs_get_context we need to set up this manually
before we send the uverbs_attr_bundle down to the driver layer.

this complete the change that was done in
("70f06b26f07e IB: ucontext should be set properly for all cmd & ioctl paths")

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 04d08135b374..76ac113d1da5 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -230,6 +230,8 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 		goto err_alloc;
 	}
 
+	attrs->context = ucontext;
+
 	ucontext->res.type = RDMA_RESTRACK_CTX;
 	ucontext->device = ib_dev;
 	ucontext->cg_obj = cg_obj;
-- 
2.20.1

