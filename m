Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5152B87C51
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfHIOJU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 10:09:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56640 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOJU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 10:09:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79E940B062843;
        Fri, 9 Aug 2019 14:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=bZflEZ52X9bX6B1ILrh7IAFuiqaNmTJv+kJCS3AfmeA=;
 b=ahJUuhOKvQTdsnFHuTiSXWoq5LfwbRx/qY/dYgH+hMpD118mOMCH5TbbPatKAq7zC2+z
 qtfa7Gu9bVf3ZeHCfi+Xka/Qqc15IytepryX7eec9hxdtorjhTWmGEir+Plx5yv9mRXl
 LCsmgra2qPNLqo9Q3ESK+OoQ9fnwOhXoWXChDmiYMx8zvQ8bkmJR4IB7fwv/KUNwwUoh
 8Re2qZTTSEcdIU1HS8mgccNHxLtpgO9KoW0LQan3OSxdXUFtJq08tQ43562VNqHqEX69
 DOJQT5CIazwjaDnZWhejXNoDDRmO7xZbpZ+RxELZswQI+qownF2jkVW0kS2PcitYDbcd Dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=bZflEZ52X9bX6B1ILrh7IAFuiqaNmTJv+kJCS3AfmeA=;
 b=LuMpZWrgevVKJdkBGQZosUBNO4bpoFBPnD1YvHkMlRtCz2x4UlPRGsjlXvum/DbqPZ7e
 35zmBLr+tlhg9/mkWRl4mJYHwAS72cJ+KuS8uEuSEMS4Y9CNr6xQ/D/QDu5554o2Oeqw
 O/52UDLnezijW173i2UR3UGyStW1vXUMRBQHZ3KY+VhGvvqOG4rnxQ4fghihZZlSOA83
 lvtnFEctUdHCHwSjgmY8s0hzhkjEXJOXLz3Q2GhcTst2pzPTpnvICiwY6NRt/2Dcsl4+
 NEsJh57o/5MB5woHPBgvGVNSOyzGy/DOhTxkU1mjXUuBTCcTANGHAIPzYcMkvXR2BGAD SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u8hgp7mm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 14:09:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79E8rDu136000;
        Fri, 9 Aug 2019 14:09:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u8pj952s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 14:09:13 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x79E9Bin003600;
        Fri, 9 Aug 2019 14:09:11 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 07:09:11 -0700
Date:   Fri, 9 Aug 2019 17:09:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] RDMA/siw: Fix a memory leak in siw_init_cpulist()
Message-ID: <20190809140904.GB3552@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF1431A46D.4DAAB987-ON00258451.003E917F-00258451.0040859B@notes.na.collabserv.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090144
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error handling code doesn't free siw_cpu_info.tx_valid_cpus[0].  The
first iteration through the loop is a no-op so this is sort of an off
by one bug.  Also Bernard pointed out that we can remove the NULL
assignment and simplify the code a bit.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
---
v2:  Remove the NULL assignment like Bernard Metzler pointed out.

 drivers/infiniband/sw/siw/siw_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index d0f140daf659..05a92f997f60 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -160,10 +160,8 @@ static int siw_init_cpulist(void)
 
 out_err:
 	siw_cpu_info.num_nodes = 0;
-	while (i) {
+	while (--i >= 0)
 		kfree(siw_cpu_info.tx_valid_cpus[i]);
-		siw_cpu_info.tx_valid_cpus[i--] = NULL;
-	}
 	kfree(siw_cpu_info.tx_valid_cpus);
 	siw_cpu_info.tx_valid_cpus = NULL;
 
-- 
2.20.1

