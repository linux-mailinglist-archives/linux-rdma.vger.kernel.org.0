Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09852380B92
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 16:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhENOTj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 10:19:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37918 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhENOTj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 May 2021 10:19:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EEEhq4072385;
        Fri, 14 May 2021 14:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zNC7OQCGpB44JeelSJRSvUVJPjA+rAX5PB4VLakxdFI=;
 b=t7Q7cC9wDUoKjvMRBiuViSqOmsHa5GcEEgT+l3YiMXVUiKopsoXSnrm1GlqjJeNbMB25
 JXu1zW7cnkpTEEghg4NRIU4vRKpYTHHsVK1hxUlOCeyebZk5MjQTDrlDEXBGONxkESQV
 PTKBKRRQoT7pBTN8sYzsHVfMCiJ2HhhHSLcfxrjJc1lYhk8tNRyEixu1ZVbspKfEVlbs
 PTd7BV1Y389wP418laZsSw9d+6GlR6B81QHyWdJ67byXc1AQTVciczNztzcUfCLG3iHk
 GUU8qjp05rkiy1S6N/fqGYDRWWgDYBADQqpjRQq2fKzKBT+ZE0/RsuiQn5wjILfE8moR 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38gpnxvf29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 14:18:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EEG0CP094099;
        Fri, 14 May 2021 14:18:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38gppq4y3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 14:18:20 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EEIKL0097842;
        Fri, 14 May 2021 14:18:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38gppq4y3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 14:18:19 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14EEIIBu029349;
        Fri, 14 May 2021 14:18:18 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 14:18:18 +0000
Date:   Fri, 14 May 2021 17:18:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Avihai Horon <avihaih@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: fix a NULL vs IS_ERR() bug
Message-ID: <YJ6Got+U7lz+3n9a@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: pAOQGFclzYTUCpQ23dtiy4nkhhrDKqYn
X-Proofpoint-ORIG-GUID: pAOQGFclzYTUCpQ23dtiy4nkhhrDKqYn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140115
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The uapi_get_object() function returns error pointers, it never returns
NULL.

Fixes: 149d3845f4a5 ("RDMA/uverbs: Add a method to introspect handles in a context")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/uverbs_std_types_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 9ec6971056fa..818704c676c0 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -117,8 +117,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_INFO_HANDLES)(
 		return ret;
 
 	uapi_object = uapi_get_object(attrs->ufile->device->uapi, object_id);
-	if (!uapi_object)
-		return -EINVAL;
+	if (IS_ERR(uapi_object))
+		return PTR_ERR(uapi_object);
 
 	handles = gather_objects_handle(attrs->ufile, uapi_object, attrs,
 					out_len, &total);
-- 
2.30.2

