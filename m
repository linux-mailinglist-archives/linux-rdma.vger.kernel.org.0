Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE776AE68
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfGPSTn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:19:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbfGPSTn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:19:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIhSk124103;
        Tue, 16 Jul 2019 18:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=J5kaTtssVeHtJq/qVVlB2lMVoH4UviO8jz7i2zsbdSg=;
 b=OFMhDxR+CT2KpubpKGcYIxnC4AG1ntAPKw0atwePreoRjzAos/Mno593/YwAGGsWLjfM
 Tl86/7qYNwWUQ4ENA6f9tvg6SrjAdzg5OWtqbM4astumOWPUYqtOllFvkMaDWFyTE2rv
 5DUMl9+S5m9pd+WIfIPXwakw1/KAK2GOnTCXOsrdouhdYPWc7Hkt3FbbrBfm3pz64bcR
 JOEmeuXuF7p2VkoN7Ok2i84AZp+JsK1wpHVCXDg6v3TQ7NFEFzIz7cokQ9meZ9zXyzPa
 r9i3kq+kd3rlvRucyeIgdO/hRI9kra7F5IGYCx+5Wud/OR9zWhrECFGGfEa01aWZC5hi Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tq7xqx598-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHpjM149741;
        Tue, 16 Jul 2019 18:19:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tsctwcg8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIJ4Er002694;
        Tue, 16 Jul 2019 18:19:04 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:19:03 +0000
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
Subject: [PATCH rdma-core 01/12] verbs: Introduce new inline helpers
Date:   Tue, 16 Jul 2019 21:18:29 +0300
Message-Id: <20190716181840.4579-2-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181840.4579-1-yuval.shaia@oracle.com>
References: <20190716181840.4579-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160224
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

For sharing object an application needs an access to object's hadnle
(such as PD handle).

Add helpers to do that.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 libibverbs/verbs.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 1b0aef03..ff593d93 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -3263,6 +3263,21 @@ static inline int ibv_read_counters(struct ibv_counters *counters,
 	return vctx->read_counters(counters, counters_value, ncounters, flags);
 }
 
+static inline uint32_t ibv_context_to_fd(struct ibv_context *context)
+{
+	return context->cmd_fd;
+}
+
+static inline uint32_t ibv_pd_to_handle(struct ibv_pd *pd)
+{
+	return pd->handle;
+}
+
+static inline uint32_t ibv_mr_to_handle(struct ibv_mr *mr)
+{
+	return mr->handle;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.20.1

