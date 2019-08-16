Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D890F900E3
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfHPLlj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 07:41:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHPLlj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Aug 2019 07:41:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GBdHFC109671;
        Fri, 16 Aug 2019 11:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=r8qWLddZAoSzpyOp5YvkQkPWLLMeYfRi5A/J7tky61E=;
 b=JafrYcQ6KvtOmpYnwuIoxFd472Hdr98eWLAdahLyCAuc7sdygNzzsWiZAvfE+0XPwqyh
 85diFhSwSLDhmSwNk/gD3U9fR3sNsYDFTdQ0Yk0iEJ6PyYA5AsbbbgrzmaWJsdm6yoMX
 ahZlOhCDylknxjJ6Ic+GPPfW5+NH3nWwsikMTOnppCQGcmHUFiBSWsRlNev4sEwaEhaT
 eWUo1Ieu1Jlwm9xOkp/uEFyUhcR7XLFyPfBzcVcPl9IOkG4HLqUNZvWhcvkUE5pOFJW6
 AxhgUo2gatcqcnc2JC0xy42oaA8XIuHfFlvNkH05ZeLSmW8AH8ZTWEXI+q7XKsV0z8Pm ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbu0235-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 11:41:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GBcYos001756;
        Fri, 16 Aug 2019 11:39:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2udgqg1qyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 11:39:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7GBdFeW006950;
        Fri, 16 Aug 2019 11:39:15 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 04:39:14 -0700
Date:   Fri, 16 Aug 2019 14:39:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/hns: Fix some white space check_mtu_validate()
Message-ID: <20190816113907.GA30799@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This line was indented a bit too far.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index b729f8ef90a2..f972127edbf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1080,7 +1080,7 @@ static int check_mtu_validate(struct hns_roce_dev *hr_dev,
 	int p;
 
 	p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
-	    active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
+	active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
 
 	if ((hr_dev->caps.max_mtu >= IB_MTU_2048 &&
 	    attr->path_mtu > hr_dev->caps.max_mtu) ||
-- 
2.20.1

