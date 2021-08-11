Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378353E90FD
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhHKM2y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 08:28:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5126 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231721AbhHKM1m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 08:27:42 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BCQa49028635;
        Wed, 11 Aug 2021 12:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=S//UJb2BAflVWKg64/+XomkAmAV29LtsUxuQPldZtd4=;
 b=k3EcOtbTnDCp/t1AtXTiUQHA7ZwWO9SeT70x6oSpj1wKBn9h2q4jXqWRQeuwyDYkJVFE
 tpFpttaJ5/HfEsHwBJgTCiS91a4L6wNtOj8tCZoEU+ev6dZsEGHcQpAcnqDh/OAOzc+n
 /wmQ/22lrTkkN5gFr8dxV8RLAh6VLnJoinhOaSM6hvTRGQGcABiPkymByfhH5KyqlW/X
 v6GJntefdRFm0myi0BqXpOm8XwNMOW1U55+L2kHopeMLfubZhIIXCj+Nd7hEQxWjJBem
 OEcjYLME6H1mVWB0HskTmIx0mD+XWMvOv9sWKUfUpc5BRCDsJxGT0mNDfREvObJhZSNe Kg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=S//UJb2BAflVWKg64/+XomkAmAV29LtsUxuQPldZtd4=;
 b=rs3csblgTCnMFEQV1gok5plxIYDG3phDZ6andKT59mUQ+blcmAC5t6FzU5wOoj69ZFvi
 KYURyN6EAtuVnrDPMz1cgqhVs00tSBwu85eedjHfjkW3UA4aebZKPSNWcmYCzqGHgKaj
 CiKMdkg6sA8QVgNoA78nmabktNpmz2Agq+LyqSjQCb4HxHL0II8FQsvTL7ojDrcF092l
 r7ERv0Q6UB/CMRbV+skAHQbQgDN/JFtpxiu90ZfSgVx8HUNIWSveq8JuVi06szOLUsg8
 WlIP3DRsOSDgCC03EAxRq6FTPV1CVwlAA4CBxr/TvKlIjlXruq56pBU9Ydy3AAXCK7Rz AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44ahnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 12:27:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BCQFGj001398;
        Wed, 11 Aug 2021 12:27:14 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by userp3020.oracle.com with ESMTP id 3aa3xv0s52-1;
        Wed, 11 Aug 2021 12:27:14 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH for-next] RDMA/core/sa_query: Remove unused function
Date:   Wed, 11 Aug 2021 14:27:11 +0200
Message-Id: <1628684831-26981-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110084
X-Proofpoint-ORIG-GUID: OBOx6C_EL44qT5Rpy1axSa2h3St--oP2
X-Proofpoint-GUID: OBOx6C_EL44qT5Rpy1axSa2h3St--oP2
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_sa_service_rec_query() was introduced in kernel v2.6.13 by commit
cbae32c56314 ("[PATCH] IB: Add Service Record support to SA client")
in 2005. It was not used then and have never been used since.

Removing it.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/sa_query.c | 101 -------------------------------------
 include/rdma/ib_sa.h               |  10 ----
 2 files changed, 111 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index b61576f..7c31b91 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1656,107 +1656,6 @@ static void ib_sa_service_rec_release(struct ib_sa_query *sa_query)
 	kfree(container_of(sa_query, struct ib_sa_service_query, sa_query));
 }
 
-/**
- * ib_sa_service_rec_query - Start Service Record operation
- * @client:SA client
- * @device:device to send request on
- * @port_num: port number to send request on
- * @method:SA method - should be get, set, or delete
- * @rec:Service Record to send in request
- * @comp_mask:component mask to send in request
- * @timeout_ms:time to wait for response
- * @gfp_mask:GFP mask to use for internal allocations
- * @callback:function called when request completes, times out or is
- * canceled
- * @context:opaque user context passed to callback
- * @sa_query:request context, used to cancel request
- *
- * Send a Service Record set/get/delete to the SA to register,
- * unregister or query a service record.
- * The callback function will be called when the request completes (or
- * fails); status is 0 for a successful response, -EINTR if the query
- * is canceled, -ETIMEDOUT is the query timed out, or -EIO if an error
- * occurred sending the query.  The resp parameter of the callback is
- * only valid if status is 0.
- *
- * If the return value of ib_sa_service_rec_query() is negative, it is an
- * error code.  Otherwise it is a request ID that can be used to cancel
- * the query.
- */
-int ib_sa_service_rec_query(struct ib_sa_client *client,
-			    struct ib_device *device, u32 port_num, u8 method,
-			    struct ib_sa_service_rec *rec,
-			    ib_sa_comp_mask comp_mask,
-			    unsigned long timeout_ms, gfp_t gfp_mask,
-			    void (*callback)(int status,
-					     struct ib_sa_service_rec *resp,
-					     void *context),
-			    void *context,
-			    struct ib_sa_query **sa_query)
-{
-	struct ib_sa_service_query *query;
-	struct ib_sa_device *sa_dev = ib_get_client_data(device, &sa_client);
-	struct ib_sa_port   *port;
-	struct ib_mad_agent *agent;
-	struct ib_sa_mad *mad;
-	int ret;
-
-	if (!sa_dev)
-		return -ENODEV;
-
-	port  = &sa_dev->port[port_num - sa_dev->start_port];
-	agent = port->agent;
-
-	if (method != IB_MGMT_METHOD_GET &&
-	    method != IB_MGMT_METHOD_SET &&
-	    method != IB_SA_METHOD_DELETE)
-		return -EINVAL;
-
-	query = kzalloc(sizeof(*query), gfp_mask);
-	if (!query)
-		return -ENOMEM;
-
-	query->sa_query.port     = port;
-	ret = alloc_mad(&query->sa_query, gfp_mask);
-	if (ret)
-		goto err1;
-
-	ib_sa_client_get(client);
-	query->sa_query.client = client;
-	query->callback        = callback;
-	query->context         = context;
-
-	mad = query->sa_query.mad_buf->mad;
-	init_mad(&query->sa_query, agent);
-
-	query->sa_query.callback = callback ? ib_sa_service_rec_callback : NULL;
-	query->sa_query.release  = ib_sa_service_rec_release;
-	mad->mad_hdr.method	 = method;
-	mad->mad_hdr.attr_id	 = cpu_to_be16(IB_SA_ATTR_SERVICE_REC);
-	mad->sa_hdr.comp_mask	 = comp_mask;
-
-	ib_pack(service_rec_table, ARRAY_SIZE(service_rec_table),
-		rec, mad->data);
-
-	*sa_query = &query->sa_query;
-
-	ret = send_mad(&query->sa_query, timeout_ms, gfp_mask);
-	if (ret < 0)
-		goto err2;
-
-	return ret;
-
-err2:
-	*sa_query = NULL;
-	ib_sa_client_put(query->sa_query.client);
-	free_mad(&query->sa_query);
-
-err1:
-	kfree(query);
-	return ret;
-}
-EXPORT_SYMBOL(ib_sa_service_rec_query);
-
 static void ib_sa_mcmember_rec_callback(struct ib_sa_query *sa_query,
 					int status,
 					struct ib_sa_mad *mad)
diff --git a/include/rdma/ib_sa.h b/include/rdma/ib_sa.h
index ba3c808..b09f1f1 100644
--- a/include/rdma/ib_sa.h
+++ b/include/rdma/ib_sa.h
@@ -430,16 +430,6 @@ int ib_sa_path_rec_get(struct ib_sa_client *client, struct ib_device *device,
 					void *context),
 		       void *context, struct ib_sa_query **query);
 
-int ib_sa_service_rec_query(struct ib_sa_client *client,
-			    struct ib_device *device, u32 port_num, u8 method,
-			    struct ib_sa_service_rec *rec,
-			    ib_sa_comp_mask comp_mask, unsigned long timeout_ms,
-			    gfp_t gfp_mask,
-			    void (*callback)(int status,
-					     struct ib_sa_service_rec *resp,
-					     void *context),
-			    void *context, struct ib_sa_query **sa_query);
-
 struct ib_sa_multicast {
 	struct ib_sa_mcmember_rec rec;
 	ib_sa_comp_mask		comp_mask;
-- 
1.8.3.1

