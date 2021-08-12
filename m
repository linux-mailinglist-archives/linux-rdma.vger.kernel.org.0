Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB33EA84E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhHLQN3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 12:13:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21190 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhHLQNH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Aug 2021 12:13:07 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CGC1RO003849;
        Thu, 12 Aug 2021 16:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=NUw2a6auC0L90dEpKCoF3i0Ba5bslxpZhP1+vV6FvY0=;
 b=KydXpE2y8bgBWsiz2qgprrvA1LT9KDMl2epOF1BrwFhz6xnfMnXzhfqnftoVwqy/Yjz+
 XTambm/DYiF1NPF4C1AKiE/UJWJFq9SItNGOt6LbYjvgJOFLFQFiW626QQ9J/8QnIwBS
 VGjHkm9MRF629kYxPcu9wO/q14kbCq5u0I7sze0jyqPiSFyqkn5AKUBIajoEiODac4w8
 qJxlRyV8s6JsofQfUxQxQop0o74lG1hXeyey7pjGaKKKSOOLHQ5LfBPb3ne/5NtsPMEo
 du3qDYFNbFZderKmiJZOGDC42p0pNR7FsJV1PS2H+f/f/bTMA3CgcsFtp/XYR0aYDRn4 tQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=NUw2a6auC0L90dEpKCoF3i0Ba5bslxpZhP1+vV6FvY0=;
 b=xOWFmUtilHXkBGevJYk3DlWdQrKX5wki16TtO8wTVfseUCg35rOp3VBMhofdiW0HuxqQ
 R085tT/fDA2SomM6efoLKmk6a3zIFmHXKQpwlty8yFIKk+arFKsHmRiW3oyKeZib98RW
 Wg22/wiQwCYqKpG4QpH7se3KVbzNGIDZh3uwLd6wD/t0dDM24D2HhZybQqzMROz6Ikv3
 /AiZbuLfH6vBjFxwBH9sDiXk5+QYE1YlJYQw8qN0TZe6ACeEEOmxeyG4I1clIf/ucurk
 ohQQw8dpBYPJdzy+q/rH7bCnZ8bxHnLuKTaMQcc7KaHKYjeyZteBbjToENBVuOxXInIS jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad2ajgrke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 16:12:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17CGAHl7170908;
        Thu, 12 Aug 2021 16:12:37 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by userp3030.oracle.com with ESMTP id 3abjw8vhjv-1;
        Thu, 12 Aug 2021 16:12:37 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH for-next v2] RDMA/core/sa_query: Retry SA queries
Date:   Thu, 12 Aug 2021 18:12:35 +0200
Message-Id: <1628784755-28316-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120105
X-Proofpoint-ORIG-GUID: 1HoNaFdNUZtsG4Ay3MhkqjIj4k4hipuQ
X-Proofpoint-GUID: 1HoNaFdNUZtsG4Ay3MhkqjIj4k4hipuQ
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A MAD packet is sent as an unreliable datagram (UD). SA requests are
sent as MAD packets. As such, SA requests or responses may be silently
dropped.

IB Core's MAD layer has a timeout and retry mechanism, which amongst
other, is used by RDMA CM. But it is not used by SA queries. The lack
of retries of SA queries leads to long specified timeout, and error
being returned in case of packet loss. The ULP or user-land process
has to perform the retry.

Fix this by taking advantage of the MAD layer's retry mechanism.

First, a check against a zero timeout is added in
rdma_resolve_route(). In send_mad(), we set the MAD layer timeout to
one tenth of the specified timeout and the number of retries to
10. The special case when timeout is less than 10 is handled.

With this fix:

 # ucmatose -c 1000 -S 1024 -C 1

runs stable on an Infiniband fabric. Without this fix, we see an
intermittent behavior and it errors out with:

cmatose: event: RDMA_CM_EVENT_ROUTE_ERROR, error: -110

(110 is ETIMEDOUT)

Fixes: f75b7a529494 ("[PATCH] IB: Add automatic retries to MAD layer")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c      | 3 +++
 drivers/infiniband/core/sa_query.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 515a7e9..c3f2fac 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3117,6 +3117,9 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 	struct rdma_id_private *id_priv;
 	int ret;
 
+	if (!timeout_ms)
+		return -EINVAL;
+
 	id_priv = container_of(id, struct rdma_id_private, id);
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED, RDMA_CM_ROUTE_QUERY))
 		return -EINVAL;
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index b61576f..5a56082 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1358,6 +1358,7 @@ static int send_mad(struct ib_sa_query *query, unsigned long timeout_ms,
 {
 	unsigned long flags;
 	int ret, id;
+	const int nmbr_sa_query_retries = 10;
 
 	xa_lock_irqsave(&queries, flags);
 	ret = __xa_alloc(&queries, &id, query, xa_limit_32b, gfp_mask);
@@ -1365,7 +1366,13 @@ static int send_mad(struct ib_sa_query *query, unsigned long timeout_ms,
 	if (ret < 0)
 		return ret;
 
-	query->mad_buf->timeout_ms  = timeout_ms;
+	query->mad_buf->timeout_ms  = timeout_ms / nmbr_sa_query_retries;
+	query->mad_buf->retries = nmbr_sa_query_retries;
+	if (!query->mad_buf->timeout_ms) {
+		/* Special case, very small timeout_ms */
+		query->mad_buf->timeout_ms = 1;
+		query->mad_buf->retries = timeout_ms;
+	}
 	query->mad_buf->context[0] = query;
 	query->id = id;
 
-- 
1.8.3.1

