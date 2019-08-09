Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC687707
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406127AbfHIKQm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 06:16:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfHIKQm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 06:16:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79ADXhQ062581;
        Fri, 9 Aug 2019 10:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=SXvs2DZuZMKGjo1bM1lqmXKa5nVW3ZemlDFW438SK4M=;
 b=AvMAXWQd6kKO4uCKwjA6zkuVjNR4Vs7npe/iJFgiDbxt/H3eajIW0Oo/kuQmkAChRjdo
 /icnUrnOHu3NN+wYwK5N3ELrjLyh5dyhnPsaMEQ4o80c4OTCHuY3pVITS4vaEh6ts137
 PjL7+IyunFpmKnHxxArRRECLqKw5BJIAne34YUA52PGR6ZnCnlQACn+aHX+njiDoehmN
 8W3eg7Zxffbalvw0CPFO/PF1f3SLStNfz+NEFNOZi/KipOoJ04Q48/kE5pZIV1ZScBq3
 2Aa3wQnqPHmIxbGlf/3lfoEVJIvyLPntVU4GRBm0Sjhsh9hbdwbwuF5/62Xy7ex2PXC5 gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=SXvs2DZuZMKGjo1bM1lqmXKa5nVW3ZemlDFW438SK4M=;
 b=XbGAE/sQjZCgx1BOYDR24H7ErGxxn2pkPvqnOzHoAzoR+W6sJnsGHfTpsJxtkKA+xD/v
 CZH/9m80r0/Teqyq3FkE3aer4Zgp15rfWu/racnEBSTqVpSLlCEct89/OcD3xcwpJFV4
 BEbNf/UyLusaflcZNPnmbKcEFZ7nwJC5maQ42dWH+hihbPlFunhQAJ95kmFtxLeJAwY5
 bT0DPUByBSdAA9xal4ju8G44rkhCbphmdalJb2Ln2iJ7mYfVVQQuxPtkLXR5oiMXr83W
 rEm/3fFRsIqgVdMejBz2krp43W87zBmWKEhAQFm/iKJQQGhr9i94rV1xuZLg0VPXNy8L 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u8hgp6myq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 10:16:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79ADDnJ144080;
        Fri, 9 Aug 2019 10:16:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2u8pj8xjct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 10:16:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x79AGQRh006838;
        Fri, 9 Aug 2019 10:16:26 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 03:16:26 -0700
Date:   Fri, 9 Aug 2019 13:16:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/siw: Fix a memory leak in siw_init_cpulist()
Message-ID: <20190809101619.GB17867@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090106
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error handling code doesn't free siw_cpu_info.tx_valid_cpus[0].  The
first iteration through the loop is a no-op so this is sort of an off by
one bug.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index d0f140daf659..95ace3967391 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -160,9 +160,9 @@ static int siw_init_cpulist(void)
 
 out_err:
 	siw_cpu_info.num_nodes = 0;
-	while (i) {
+	while (--i >= 0) {
 		kfree(siw_cpu_info.tx_valid_cpus[i]);
-		siw_cpu_info.tx_valid_cpus[i--] = NULL;
+		siw_cpu_info.tx_valid_cpus[i] = NULL;
 	}
 	kfree(siw_cpu_info.tx_valid_cpus);
 	siw_cpu_info.tx_valid_cpus = NULL;
-- 
2.20.1

