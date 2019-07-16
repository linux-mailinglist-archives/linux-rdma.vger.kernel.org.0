Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C771C6AE72
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfGPSU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:20:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43132 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSU3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:20:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIItKV124205;
        Tue, 16 Jul 2019 18:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=9DgOOptHngtJ8ACOkVk6a/8IKI9LweFSWwgUj2GbItE=;
 b=fniWJhfgaa01RWrx/h7zmkuF9QA4huA7LbQASL+12QO87nI9wJbM7GpcWW0cUbHytpNX
 rGiAOdkuLJHazZA04DYzAcDhSTPvgqPZFWPaXtdwS5swcSeA4nxeI87WONmtxs7y99Kt
 IITKH+J31ZaGbNALpujxBmrL+qKPEWp9XSdJ1ddAbFqF3iMFCyjuTcb+lu2/uJV6rJ2x
 f6HKRRe3LD0YOIqYSOW+vvFfhJ6h0XHlSiIS5vSJoS/0AY3CdyitKfUyva8ICLIf5bQ9
 zxgGHBhQkPUN9/URElVS3dECcrgLWr0wucmxSwSlS6xrMg0CsBmrY71+clDYyPm8wiXB hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tq7xqx5e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:20:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHqKq158778;
        Tue, 16 Jul 2019 18:20:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tq5bcjhf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:20:05 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIK3ft003474;
        Tue, 16 Jul 2019 18:20:03 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:20:03 +0000
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
Subject: [PATCH rdma-core 11/12] rxe: Implementation of import MR callback
Date:   Tue, 16 Jul 2019 21:18:39 +0300
Message-Id: <20190716181840.4579-12-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181840.4579-1-yuval.shaia@oracle.com>
References: <20190716181840.4579-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160224
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
index 6a8194a4..aefaef5c 100644
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

