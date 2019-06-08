Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3D39C19
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfFHJZj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 05:25:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54090 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfFHJZj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 05:25:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x589IfDc042165;
        Sat, 8 Jun 2019 09:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=GrWzgX6glrKXbxS3u89SRRHdMSUZtk55ulssWr86Pz8=;
 b=NYTkOnk24TiyELr2a0OaiOKemvEb//iOQpsCpJVXK7e7ci8jtf47n1HFWnz9NGqKLsnZ
 JL65SImFqtHmrVCNtiJMripd6ZHReN0Z6RmLe8A/uCso8TP54gsPgDI3k2ZMb/LtuwDI
 kr40hiz94hCHZ7QvPlJtTO6OYextqpSPn9mJv0BZI5dibnPjxUcZ7kCOHqEqMRU3tFu8
 af41bAk6sJC0OL5oIMC+tKUEyP3c3rYp5NBCvuiAC79K3WG1TUmvb7ujQjqmao/M+Wwy
 QtEyyy00+1l4OrBuEHE9qs0YSP6vvfGjxRnaynIJR7NSRqmbZ3eekwrpVpw1kB7Kpxa4 ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2t02he8vq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 09:25:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x589OtYv172907;
        Sat, 8 Jun 2019 09:25:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t04hx3qdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 09:25:22 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x589PL7K000858;
        Sat, 8 Jun 2019 09:25:21 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 02:25:21 -0700
Date:   Sat, 8 Jun 2019 12:25:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/hns: prevent undefined behavior in
 hns_roce_set_user_sq_size()
Message-ID: <20190608092514.GC28890@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906080071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906080071
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The "ucmd->log_sq_bb_count" variable is a user controlled variable in
the 0-255 range.  If we shift more than then number of bits in an int
then it's undefined behavior (it shift wraps).  It turns out this
doesn't cause any real issues at runtime, but it's good to check anyway.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8db2817a249e..006b3e7f4ed5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -342,7 +342,8 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 	u32 max_cnt;
 
 	/* Sanity check SQ size before proceeding */
-	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
+	if (ucmd->log_sq_bb_count > 31 ||
+	    (u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
 	     ucmd->log_sq_stride > max_sq_stride ||
 	     ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
 		dev_err(hr_dev->dev, "check SQ size error!\n");
-- 
2.20.1

