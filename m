Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53C33B4341
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhFYMdh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 08:33:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22446 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231476AbhFYMdg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 08:33:36 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCQWhL007331;
        Fri, 25 Jun 2021 12:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6v4pFhTYJRL4EDBYY8yo5sCBTh7UAE0wjrvTVYA1U1A=;
 b=Vqp72E0HgYMOWLdemd4yQDuSaBscWfFaRNUVxIiTz14Ss3Amcqst4kFfI/blTM4QIdPz
 UZZsyJNHRcjXYUgzI4cfpKjBxWGsCQXbB7gcXUizXt1IIYmPEtAJQkbHvYC9HPeCz6Bg
 xHNb7q9SpxxzrULFgVQAb4Zmu9DTrls1YhHAwZ8TCtrnseVUUEwdh3yv2pDnjIHSfrlN
 kq/ZM2n42v17R/9P22yZtz9Q1pZONsjZ2hMHxMmujJ7WACyim24hRaDEH+6f7KEZS3Q/
 iE4VzQYJEdLNhrHy0ClOoJbpq0U69jC/K4WeZ1qPxdd8M2rsNLBJFub1PBzU7P5CibvK 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24a98tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:31:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PCBOvY108626;
        Fri, 25 Jun 2021 12:31:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 39d23y0ye0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:31:09 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15PCV8eG031937;
        Fri, 25 Jun 2021 12:31:08 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 05:31:08 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-rc v2] RDMA/core/sa_query: Remove unused argument
Date:   Fri, 25 Jun 2021 14:30:57 +0200
Message-Id: <1624624257-3677-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250070
X-Proofpoint-GUID: nETTPgkzWmvPBOlfkUWp0q568wHNkq0T
X-Proofpoint-ORIG-GUID: nETTPgkzWmvPBOlfkUWp0q568wHNkq0T
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes:4c33bd1926cc ("IB/SA: Add support to query OPA path records")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

	v1 -> v2:
	   * Fixed missing semicolon, as:
	     Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/infiniband/core/sa_query.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8f1705c..fec2be5 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1444,8 +1444,7 @@ enum opa_pr_supported {
  */
 static int opa_pr_query_possible(struct ib_sa_client *client,
 				 struct ib_sa_device *sa_dev,
-				 struct ib_device *device, u32 port_num,
-				 struct sa_path_rec *rec)
+				 struct ib_device *device, u32 port_num)
 {
 	struct ib_port_attr port_attr;
 
@@ -1567,8 +1566,7 @@ int ib_sa_path_rec_get(struct ib_sa_client *client,
 
 	query->sa_query.port     = port;
 	if (rec->rec_type == SA_PATH_REC_TYPE_OPA) {
-		status = opa_pr_query_possible(client, sa_dev, device, port_num,
-					       rec);
+		status = opa_pr_query_possible(client, sa_dev, device, port_num);
 		if (status == PR_NOT_SUPPORTED) {
 			ret = -EINVAL;
 			goto err1;
-- 
1.8.3.1

