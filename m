Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F6E97CED
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfHUO21 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:28:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40316 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO20 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:28:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENWg5071650;
        Wed, 21 Aug 2019 14:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=zeIwOOYMFuER6KRd6GjmJZzxbjuNdCjwT+BIpcXym0M=;
 b=DAaa4bwn2H2dkcbPwbxHqFRAQAVDzcfpZdIBnkaRiUuyKZU8BxoWitvJzMHBqHwjdCO8
 X49HqfBfN0N9Md3zadd/in1t+4jcDdPpt2opEL1zeDeVuebqUBy81EAvIvlHFTqHqWP9
 5Ld3BWOrbPvuR15XqSMFHMe9vCPJtIMLkKdQ+pJ4DmRlPH8xywo8BBZOWsuMITt+amj8
 T/gZxfCZ62/gE5H23Gok1magjLmWZ9rSfJYqgoxYZhdYrzxE0ogYm3kZZS2bBaZzlcZi
 REXgCJnOZAaA55QyWEZm6HizzUMcXCJrLEwm556tI4Oll4kUdzN0b40CC5sOMIE2dcKU rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ue90tp51d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:28:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENRi7194614;
        Wed, 21 Aug 2019 14:28:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ugj7qgkkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:28:06 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LES4WW014422;
        Wed, 21 Aug 2019 14:28:04 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:28:03 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH v1 rdma-core 11/12] rxe: Implementation of import MR callback
Date:   Wed, 21 Aug 2019 17:26:38 +0300
Message-Id: <20190821142639.5807-12-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142639.5807-1-yuval.shaia@oracle.com>
References: <20190821142639.5807-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The import MR verb take care of importing the generic part of the MR
object and then triggers provider's specific callback to take care of
provider's specific attributes.
Add implementation of rxe related MR attributes.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 providers/rxe/rxe.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3ea4ff08..c1cdde07 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -112,6 +112,32 @@ static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
 	return pd;
 }
 
+static struct ibv_mr *rxe_import_mr(struct ibv_context *context, uint32_t fd,
+				    uint32_t handle)
+{
+	struct ibv_import_mr cmd = {
+		.handle = handle,
+		.type = UVERBS_OBJECT_MR,
+		.fd = fd,
+	};
+	struct ib_uverbs_import_fr_fd_resp resp = {};
+	struct verbs_mr *vmr;
+	int ret;
+
+	vmr = calloc(1, sizeof(*vmr));
+	if (!vmr)
+		return NULL;
+
+	ret = ibv_cmd_import_mr(context, vmr, &cmd, sizeof(cmd), &resp,
+				sizeof(resp));
+	if (ret) {
+		free(vmr);
+		return NULL;
+	}
+
+	return &vmr->ibv_mr;
+}
+
 static struct ibv_pd *rxe_import_pd(struct ibv_context *context, uint32_t fd,
 				    uint32_t handle)
 {
@@ -862,6 +888,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.query_port = rxe_query_port,
 	.alloc_pd = rxe_alloc_pd,
 	.dealloc_pd = rxe_dealloc_pd,
+	.import_mr = rxe_import_mr,
 	.import_pd = rxe_import_pd,
 	.reg_mr = rxe_reg_mr,
 	.dereg_mr = rxe_dereg_mr,
-- 
2.20.1

