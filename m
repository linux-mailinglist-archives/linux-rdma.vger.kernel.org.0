Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5C97CE9
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfHUO2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:28:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52906 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO2E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:28:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENUQJ096321;
        Wed, 21 Aug 2019 14:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=IVYp/OPl0TJcNNeeOUs1XjNzreS8JQ42NvftZLO9wm8=;
 b=JOD8VAfVFyqqG05KCgSLrViYDKqGmITRZRyTJ397pmhvGUBIGw0GW+qXMFD0Nnn655BY
 CA99qmxvLpXwqJgop4KaUYEnbOMsPDAaOLc4XRnE+S23iPQ5j4CS4GZTlPldDG8H5FSq
 JYas3P9/KAkIsB9DQJe8+uFu0OsovxM0OV4TyLtkHLN2Ff3HeO0pV5eATTeLAugxeRSJ
 bXcd9NJ+RF4kVqLd9azfqLMw+9eeFBwI6s2oD6zc1jROQ1DUXMKaHBeqXEBMc4ZPw6dm
 bpJRm6vUmSdjJcCmYj72aSOIf3G19p+wEWAl2IJk9hxHM1gQqzj12BwvL+3yHPjbWjfL WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ue9hpnw4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMY86115124;
        Wed, 21 Aug 2019 14:27:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ug26a3g3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LERdYu020289;
        Wed, 21 Aug 2019 14:27:39 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:27:39 -0700
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
Subject: [PATCH v1 rdma-core 07/12] man: Add description to ibv_import_mr function
Date:   Wed, 21 Aug 2019 17:26:34 +0300
Message-Id: <20190821142639.5807-8-yuval.shaia@oracle.com>
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

New ibv_import_mr is introduce to allow process to import a MR craeted
by another process.
Add description of the API to ibv_reg_mr man page.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 libibverbs/man/ibv_reg_mr.3 | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
index be90a57b..85d5b9e1 100644
--- a/libibverbs/man/ibv_reg_mr.3
+++ b/libibverbs/man/ibv_reg_mr.3
@@ -3,7 +3,7 @@
 .\"
 .TH IBV_REG_MR 3 2006-10-31 libibverbs "Libibverbs Programmer's Manual"
 .SH "NAME"
-ibv_reg_mr, ibv_reg_mr_iova, ibv_dereg_mr \- register or deregister a memory region (MR)
+ibv_reg_mr, ibv_import_mr, ibv_reg_mr_iova, ibv_dereg_mr \- register or deregister a memory region (MR)
 .SH "SYNOPSIS"
 .nf
 .B #include <infiniband/verbs.h>
@@ -15,6 +15,9 @@ ibv_reg_mr, ibv_reg_mr_iova, ibv_dereg_mr \- register or deregister a memory reg
 .BI "                               size_t " "length" ", uint64_t " "hca_va" ,
 .BI "                               int " "access" );
 .sp
+.BI "struct ibv_mr *ibv_import_mr(struct ibv_context " "*context" ",
+.BI "                             uint32_t" " fd" ", uint32_t" " handle");
+.sp
 .BI "int ibv_dereg_mr(struct ibv_mr " "*mr" );
 .fi
 .SH "DESCRIPTION"
@@ -63,6 +66,14 @@ a lkey or rkey. The offset in the memory region is computed as 'addr +
 (iova - hca_va)'. Specifying 0 for hca_va has the same effect as
 IBV_ACCESS_ZERO_BASED.
 .PP
+.B ibv_import_mr()
+imports MR identified by
+.I handle\fR
+from context identified by file descriptor
+.I fd\fR
+to device context
+.I context\fR.
+.PP
 .B ibv_dereg_mr()
 deregisters the MR
 .I mr\fR.
@@ -79,9 +90,13 @@ is used by remote processes to perform Atomic and RDMA operations.  The remote p
 .B rkey
 as the rkey field of struct ibv_send_wr passed to the ibv_post_send function.
 .PP
+.B ibv_import_mr()
+returns a pointer to the imported MR, or NULL if the request fails.
+.PP
 .B ibv_dereg_mr()
 returns 0 on success, or the value of errno on failure (which indicates the failure reason).
 .SH "NOTES"
+.PP
 .B ibv_dereg_mr()
 fails if any memory window is still bound to this MR.
 .SH "SEE ALSO"
-- 
2.20.1

