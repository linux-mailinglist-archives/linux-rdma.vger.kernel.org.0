Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7388B2F871
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE3IVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 04:21:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35406 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3IVP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 04:21:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U8EGeA069541;
        Thu, 30 May 2019 08:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=8643zhCEUhvqcjL//AwIOlkRUp/gltx19+8VpMzH9aI=;
 b=ES3C0BebODgqfT6uiO1gItccTFcnFFnxctHHMHDN40JUl9sUVZD8izBYOLVhqb6/DyU9
 vklNLJ25759p2rFgEWrq6MLEd2GfR3i/HfRNx6a1YAVGhdlZpgKFtADqo34RpBa8pBQx
 10bqPcAzMT4SKzp/A0gS+BfyEAsg1fksfh03j5gatten1HCtkA289pxp5BGelkhciWeV
 qxk34iSv+j4dVIoAO0bfChC5vKhTtSt24KoA/ukgw3v6bkf2ymIw8arKKjaLcpcDpk12
 ixKNwiyn4JYUHFQftv+zDqbpguxbGyBzgWWmj8XAVlzuhwK2xSY0SFbXQLQGnOBdPJHq FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dptm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 08:20:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U8KPs7012948;
        Thu, 30 May 2019 08:20:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sqh746bww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 08:20:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U8KWYC018388;
        Thu, 30 May 2019 08:20:32 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 01:20:31 -0700
Date:   Thu, 30 May 2019 11:20:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: check for allocation failure in uapi_add_elm()
Message-ID: <20190530082024.GA11836@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300063
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the kzalloc() fails then we should return ERR_PTR(-ENOMEM).  In the
current code it's possible that the kzalloc() fails and the
radix_tree_insert() inserts the NULL pointer successfully and we return
the NULL "elm" pointer to the caller.  That results in a NULL pointer
dereference.

Fixes: 9ed3e5f44772 ("IB/uverbs: Build the specs into a radix tree at runtime")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/uverbs_uapi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 7a987acf0c0b..ccc4be0a6566 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -22,6 +22,8 @@ static void *uapi_add_elm(struct uverbs_api *uapi, u32 key, size_t alloc_size)
 		return ERR_PTR(-EOVERFLOW);
 
 	elm = kzalloc(alloc_size, GFP_KERNEL);
+	if (!elm)
+		return ERR_PTR(-ENOMEM);
 	rc = radix_tree_insert(&uapi->radix, key, elm);
 	if (rc) {
 		kfree(elm);
-- 
2.20.1

