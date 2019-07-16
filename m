Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44026AE6F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbfGPSUF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:20:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42792 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSUE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:20:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIhSp124103;
        Tue, 16 Jul 2019 18:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Rv8g9P5rlL/ZE9P99MaVSSy6TYMpHixsSOvddaNgHm4=;
 b=gJKPZTP3YnU+4EB9Vi8CCloj/DbKhP9Dfk96VxNO0C9Iogo71UCpziW3Cb7xtux79LFv
 /gG5DCg23No+8U+/syRXnk6gNOSIsxviaXb8obls7z0onKKHMlIQEB5pAxguImFvOYkB
 1UmUoSP+6Hh3udBPQz4ld5rg+WTqCfxYmRWBYP+KDZ9FBEktDIx2MJZUQOiI7wo1Tz/j
 yCS2vfGXVBZ9651Dlsfk6+MBqvxk5yFe4QNMQlwZ3xebo7nDPJudXZ9ybZVBHp/l45sh
 9xjxWiFCseFbue8xUTTDef/ZNOfVfRVkGEiUr8vas0Jxd8/7M15PzmI59b0DGV+88lKg uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqx5c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHrKj125046;
        Tue, 16 Jul 2019 18:19:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tq6mn1qar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:40 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GIJdes024666;
        Tue, 16 Jul 2019 18:19:39 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:19:38 +0000
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
Subject: [PATCH rdma-core 07/12] man: Add description to ibv_import_mr function
Date:   Tue, 16 Jul 2019 21:18:35 +0300
Message-Id: <20190716181840.4579-8-yuval.shaia@oracle.com>
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
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160224
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
 libibverbs/man/ibv_reg_mr.3 | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
index 631e5fe8..f1f2c27a 100644
--- a/libibverbs/man/ibv_reg_mr.3
+++ b/libibverbs/man/ibv_reg_mr.3
@@ -3,7 +3,7 @@
 .\"
 .TH IBV_REG_MR 3 2006-10-31 libibverbs "Libibverbs Programmer's Manual"
 .SH "NAME"
-ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
+ibv_reg_mr, ibv_import_mr, ibv_dereg_mr \- register, import or deregister a memory region (MR)
 .SH "SYNOPSIS"
 .nf
 .B #include <infiniband/verbs.h>
@@ -11,6 +11,9 @@ ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
 .BI "struct ibv_mr *ibv_reg_mr(struct ibv_pd " "*pd" ", void " "*addr" ,
 .BI "                          size_t " "length" ", int " "access" );
 .sp
+.BI "struct ibv_mr *ibv_import_mr(struct ibv_context " "*context" ",
+.BI "                             uint32_t" " fd" ", uint32_t" " handle" );
+.sp
 .BI "int ibv_dereg_mr(struct ibv_mr " "*mr" );
 .fi
 .SH "DESCRIPTION"
@@ -52,6 +55,14 @@ Local read access is always enabled for the MR.
 .PP
 To create an implicit ODP MR, IBV_ACCESS_ON_DEMAND should be set, addr should be 0 and length should be SIZE_MAX.
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
@@ -68,9 +79,18 @@ is used by remote processes to perform Atomic and RDMA operations.  The remote p
 .B rkey
 as the rkey field of struct ibv_send_wr passed to the ibv_post_send function.
 .PP
+.B ibv_import_mr()
+returns a pointer to the imported MR, or NULL if the request fails.
+.PP
 .B ibv_dereg_mr()
 returns 0 on success, or the value of errno on failure (which indicates the failure reason).
 .SH "NOTES"
+.B ibv_import_mr()
+once MR is imported the process which created it stays on hold until all
+reference to it are deallocated (MR can be imported more than once). The
+results of importing a MR from the same process that creates it are
+unexpected.
+.PP
 .B ibv_dereg_mr()
 fails if any memory window is still bound to this MR.
 .SH "SEE ALSO"
-- 
2.20.1

