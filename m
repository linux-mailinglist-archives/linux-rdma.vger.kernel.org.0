Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5797CE2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfHUO1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:27:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:27:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENVZI086699;
        Wed, 21 Aug 2019 14:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=S3lUxAsrxPKwchcuWoTnXr3efNBKEyaxmQJaoh3kIC8=;
 b=ObcJ2U0DgvsqydMrRupGskXwew7XhVIEdLknhzZFqqjiusnOo5ap8O7SW2QIvAMF+XA4
 hYYeNVncENkAEyEKAFg9bRknz2BZdJjoCF8Cs7JGokbGXF0JifQ1p8IeMHygtL08iHb9
 ULG4tClsz4+bqWLWnoqzW2DW1/exklrX8X4iMbi+WioLxTMfsMYCbiGkti8pJYyrsaKi
 F3GHuHMbBFh4Th9viGflz8i2sMsp80PPq3pL438DqFG59rjp/K5WhzuRctr4yZDgXSnf
 sbAuuCmHE4r/X0FMeoXMPjVUiLRdrVJ8Emi0So41P+xsG+bNEM5L5TUvFWm5ptPDDuqM zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uea7qwygd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMZm8115207;
        Wed, 21 Aug 2019 14:27:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ug26a3fjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:03 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LER2Pa019910;
        Wed, 21 Aug 2019 14:27:02 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:27:02 -0700
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
Subject: [PATCH v1 rdma-core 01/12] verbs: Introduce new inline helpers
Date:   Wed, 21 Aug 2019 17:26:28 +0300
Message-Id: <20190821142639.5807-2-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142639.5807-1-yuval.shaia@oracle.com>
References: <20190821142639.5807-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
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
index 1e01b5db..eb9df3a4 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -3270,6 +3270,21 @@ static inline int ibv_read_counters(struct ibv_counters *counters,
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

