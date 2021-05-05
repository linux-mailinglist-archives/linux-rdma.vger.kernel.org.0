Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D6373BC0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 May 2021 14:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEEMzP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 May 2021 08:55:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37984 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhEEMzO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 May 2021 08:55:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145CYZod159255;
        Wed, 5 May 2021 12:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=t+5lqmtjv+sPKKe3bPXE2yQsUbsn6vWPDtvWeUP/R14=;
 b=JHPd77mC+0Z2WyNxCt2tfPCtFiM09pi3FNoTolnX0ukUDJdORV3DPZ1IaU9vMqeKAgmp
 Lprh2PJzp6FZ2jVSsDReDOMqqCTV/Nd9nTk4vEnZb5pcO3heVH9cP6oQ11m7ms98WdGV
 hHSC6+fEMZM+dGihGkUm7avz0pahIe5LRG7Aop9ENCVd1DPnMOnpigm8wVBOyq/mvPM/
 aOdZoU8K18I6N4EejrqYY9bAxGuR1djpRKbEmCJjHyHTzrnXbjJbeJN5OvwoO/Xrxdl4
 8lDbfhQIwDi8q2psKkCMpSTkpz1OQNCLy6tWr2FQQknJ+KZcK7+sIcag55Mq1cdCwgrR BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38bebc1nyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 12:54:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145CZRdd022240;
        Wed, 5 May 2021 12:54:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38bewqq0rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 May 2021 12:54:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 145CsB9F019139;
        Wed, 5 May 2021 12:54:11 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 May 2021 05:54:11 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Date:   Wed,  5 May 2021 14:54:01 +0200
Message-Id: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050091
X-Proofpoint-ORIG-GUID: IGDXU14FJDTikPxLXdF2aIFyyJ3Ztt3g
X-Proofpoint-GUID: IGDXU14FJDTikPxLXdF2aIFyyJ3Ztt3g
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050091
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are three conditions that must be fulfilled in order to consider
a partition match. Those are:

      1. Both P_Keys must valid
      2. At least one must be a full member
      3. The partitions (lower 15 bits) must match

In system employing both limited and full membership ports, we see
these false warning messages:

RDMA CMA: got different BTH P_Key (0x2a00) and primary path P_Key (0xaa00)
RDMA CMA: in the future this may cause the request to be dropped

even though the partition is the same.

See IBTA 10.9.1.2 Special P_Keys and 10.9.3 Partition Key Matching for
a reference.

Fixes: 84424a7fc793 ("IB/cma: Print warning on different inner and header P_Keys")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc2..f5bcf7d 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1368,6 +1368,24 @@ static int cma_save_net_info(struct sockaddr *src_addr,
 	return cma_save_ip_info(src_addr, dst_addr, ib_event, service_id);
 }
 
+/*
+ * If at least one of the pkeys is a full member, none of them are
+ * invalid, and the partitions (lower 15 bits) are equal, we have a
+ * match.
+ *
+ * See IBTA 10.9.1.2 Special P_Keys and 10.9.3 Partition Key Matching
+ */
+
+static bool partition_match(u16 pkey_a, u16 pkey_b)
+{
+	const u16 fmb = 0x8000; /* Full Member Bit */
+	const bool valid_pkeys = (pkey_a & ~fmb) && (pkey_b & ~fmb);
+	const bool one_full = (pkey_a | pkey_b) & fmb;
+	const bool same_partition = (pkey_a | fmb) == (pkey_b | fmb);
+
+	return valid_pkeys && one_full && same_partition;
+}
+
 static int cma_save_req_info(const struct ib_cm_event *ib_event,
 			     struct cma_req_info *req)
 {
@@ -1385,7 +1403,7 @@ static int cma_save_req_info(const struct ib_cm_event *ib_event,
 		req->has_gid	= true;
 		req->service_id = req_param->primary_path->service_id;
 		req->pkey	= be16_to_cpu(req_param->primary_path->pkey);
-		if (req->pkey != req_param->bth_pkey)
+		if (!partition_match(req->pkey, req_param->bth_pkey))
 			pr_warn_ratelimited("RDMA CMA: got different BTH P_Key (0x%x) and primary path P_Key (0x%x)\n"
 					    "RDMA CMA: in the future this may cause the request to be dropped\n",
 					    req_param->bth_pkey, req->pkey);
@@ -1396,7 +1414,7 @@ static int cma_save_req_info(const struct ib_cm_event *ib_event,
 		req->has_gid	= false;
 		req->service_id	= sidr_param->service_id;
 		req->pkey	= sidr_param->pkey;
-		if (req->pkey != sidr_param->bth_pkey)
+		if (!partition_match(req->pkey, sidr_param->bth_pkey))
 			pr_warn_ratelimited("RDMA CMA: got different BTH P_Key (0x%x) and SIDR request payload P_Key (0x%x)\n"
 					    "RDMA CMA: in the future this may cause the request to be dropped\n",
 					    sidr_param->bth_pkey, req->pkey);
-- 
1.8.3.1

