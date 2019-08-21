Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2886697CE4
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfHUO1e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:27:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO1d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:27:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENU8H086661;
        Wed, 21 Aug 2019 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Y40LB/n87O1OkNVgQyWvm7j7emodK3xi8FMFMog1i/4=;
 b=hRYplcd9uF3QvyxDL4ZLUrEjmrVtDVmOwmYHfqM1DRnDQeqqc9lhyFTz94Vqm9bIVSIQ
 M0gvPH37+G2ZoYQzD5TnygJfWIbVHXv0vsQtyr/chW6l8XkRp62CyvO7Hl060J+YZ5/M
 qZ0mYriO58dA691k1FAbS9Dw6efGA2mhx2TA/hpskVgvXYBgzmcrGibeLaQQnCCYyDyr
 TxauNLjbAMI3lVeirgf+OSTDngVFmm3aIfh1I1sc3RC4UbAd/ufSHRtPY6OxqHLU+U+L
 8uYdAzv9QkWGsgOhFWioC53rZd57AB4wLTwSDcuqBflZKdUBb5x15dOjpJDpKN89gVjy PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uea7qwyhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMYdS115109;
        Wed, 21 Aug 2019 14:27:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ug26a3fnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LER8aG019932;
        Wed, 21 Aug 2019 14:27:08 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:27:08 -0700
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
Subject: [PATCH v1 rdma-core 02/12] man: Add description to ibv_import_pd function
Date:   Wed, 21 Aug 2019 17:26:29 +0300
Message-Id: <20190821142639.5807-3-yuval.shaia@oracle.com>
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

New ibv_import_pd is introduce to allow process to import a PD craeted
by another process.
Add description of the API to ibv_alloc_pd man page.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 libibverbs/man/ibv_alloc_pd.3 | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/libibverbs/man/ibv_alloc_pd.3 b/libibverbs/man/ibv_alloc_pd.3
index cc475f4a..aed72ff4 100644
--- a/libibverbs/man/ibv_alloc_pd.3
+++ b/libibverbs/man/ibv_alloc_pd.3
@@ -3,13 +3,16 @@
 .\"
 .TH IBV_ALLOC_PD 3 2006-10-31 libibverbs "Libibverbs Programmer's Manual"
 .SH "NAME"
-ibv_alloc_pd, ibv_dealloc_pd \- allocate or deallocate a protection domain (PDs)
+ibv_alloc_pd, ibv_import_pd, ibv_dealloc_pd \- allocate, import or deallocate a protection domain (PDs)
 .SH "SYNOPSIS"
 .nf
 .B #include <infiniband/verbs.h>
 .sp
 .BI "struct ibv_pd *ibv_alloc_pd(struct ibv_context " "*context" );
 .sp
+.BI "struct ibv_pd *ibv_import_pd(struct ibv_context " "*context" ",
+.BI "                             uint32_t" " fd" ", uint32_t" " handle" );
+.sp
 .BI "int ibv_dealloc_pd(struct ibv_pd " "*pd" );
 .fi
 .SH "DESCRIPTION"
@@ -17,6 +20,14 @@ ibv_alloc_pd, ibv_dealloc_pd \- allocate or deallocate a protection domain (PDs)
 allocates a PD for the RDMA device context 
 .I context\fR.
 .PP
+.B ibv_import_pd()
+imports PD identified by
+.I handle\fR
+from context identified by file descriptor
+.I fd\fR
+to context
+.I context\fR.
+.PP
 .B ibv_dealloc_pd()
 deallocates the PD
 .I pd\fR.
@@ -24,9 +35,18 @@ deallocates the PD
 .B ibv_alloc_pd()
 returns a pointer to the allocated PD, or NULL if the request fails.
 .PP
+.B ibv_import_pd()
+returns a pointer to the imported PD, or NULL if the request fails.
+.PP
 .B ibv_dealloc_pd()
 returns 0 on success, or the value of errno on failure (which indicates the failure reason).
 .SH "NOTES"
+.B ibv_import_pd()
+once PD is imported the process which created it stays on hold until all
+reference to it are deallocated (PD can be imported more than once). The
+results of importing a PD from the same process that creates it are
+unexpected.
+.PP
 .B ibv_dealloc_pd()
 may fail if any other resource is still associated with the PD being
 freed.
-- 
2.20.1

