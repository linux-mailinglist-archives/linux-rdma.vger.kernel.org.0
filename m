Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFD39C1C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfFHJ2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 05:28:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55822 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfFHJ2F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 05:28:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x589It1I042194;
        Sat, 8 Jun 2019 09:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=n2Cp/zOnPUelZ6ZAzbyuETxr/exUIQ0SWwRmO0m758Y=;
 b=pntCmACThBpgO0mK6Xf6hVyUhX/0c3KOqyLxzQCgrEmHO4ZzGCJvYLEwsy0/f7hkltMa
 qaDVA6P0LPYiy5xDRIURKgTGx7V3YjyVQvHgq9R0scnpb42LADxjJp1HRPqQwfHVluvG
 y7b76lHOcTRE2G3F/Ff4ZmTaKnVLY3iLfIedRuavhyslCF5/waZ9jd9/ToaBEKEU+YJG
 M5pmIp08PZOskHFwZKRPanUbdGXoWxWscwfaL1k38Ima6p+a+5O4ilhsKxnTvxEPVfBp
 jAXMGwOSEe1RB/tmzmhkJXMtAzQrcQXGUJFCry+ywmyaVtH6wahwcGcuJFLfhvnlanqU Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2t02he8vsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 09:27:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x589RIZV176582;
        Sat, 8 Jun 2019 09:27:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t04hx3qut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 09:27:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x589RT86031442;
        Sat, 8 Jun 2019 09:27:29 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 02:27:29 -0700
Date:   Sat, 8 Jun 2019 12:27:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/hns: Fix an error code in hns_roce_set_user_sq_size()
Message-ID: <20190608092714.GE28890@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=755
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906080071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=801 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906080071
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function is supposed to return negative kernel error codes but here
it returns CMD_RST_PRC_EBUSY (2).  The error code eventually gets passed
to IS_ERR() and since it's not an error pointer it leads to an Oops in
hns_roce_v1_rsv_lp_qp()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static analysis.  Not tested.

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ac017c24b200..018ff302ab9e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1098,7 +1098,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	if (ret == CMD_RST_PRC_SUCCESS)
 		return 0;
 	if (ret == CMD_RST_PRC_EBUSY)
-		return ret;
+		return -EBUSY;
 
 	ret = __hns_roce_cmq_send(hr_dev, desc, num);
 	if (ret) {
@@ -1106,7 +1106,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 		if (retval == CMD_RST_PRC_SUCCESS)
 			return 0;
 		else if (retval == CMD_RST_PRC_EBUSY)
-			return retval;
+			return -EBUSY;
 	}
 
 	return ret;
-- 
2.20.1

