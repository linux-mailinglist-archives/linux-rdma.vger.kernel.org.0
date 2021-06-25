Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6D3B3F60
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 10:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFYIgI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 04:36:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55216 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhFYIgH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 04:36:07 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P8Hc83005283;
        Fri, 25 Jun 2021 08:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=S4WdFoB7MOW3VNVmxbrkKVGNCZQc3Hflrk0Z5obO8ho=;
 b=iXkCHzqUrTEwNRVwisOWXzPoGe48HKGnFM0ZI+foyfmo7+fmFfDP8wuwktQdFZDVJtRJ
 t3i/MB35BI+FgEYE1GzCzK4Gy8SMLEacdHYiSsii2xVwE2G4AjNWtsu0d+bwQP1SllsT
 P4pAKVD7EQCh0AMmtbhAtXAeBebB4BOZ3ZPeKzpUIhizxdMP/TCCMZW0//0WfzZ78CdE
 0Wvm0ZmX5ppCPu8O2cadGpIMT1XCZoYB7GWkppOVa7ChCnw53SU36X9/gpiUsv4WYs51
 6zOi0Jq6MbVaBBfcu9Q6RseupzbuZijA8l+cMOg8uGeB27i47bgDWYXfsz7p/cetygu8 XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24m0syg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 08:33:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15P8FmOn101801;
        Fri, 25 Jun 2021 08:33:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 39d2pxvf27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 08:33:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15P8XfLJ007528;
        Fri, 25 Jun 2021 08:33:41 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 01:33:41 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-rc] RDMA/core/sa_query: Remove unused argument
Date:   Fri, 25 Jun 2021 10:33:32 +0200
Message-Id: <1624610012-22291-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250048
X-Proofpoint-ORIG-GUID: zEFmmjmSfzq4MOzbi3sCutYJox3cS_MO
X-Proofpoint-GUID: zEFmmjmSfzq4MOzbi3sCutYJox3cS_MO
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes:4c33bd1926cc ("IB/SA: Add support to query OPA path records")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/sa_query.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8f1705c..e491fba 100644
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
+		status = opa_pr_query_possible(client, sa_dev, device, port_num)
 		if (status == PR_NOT_SUPPORTED) {
 			ret = -EINVAL;
 			goto err1;
-- 
1.8.3.1

