Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE8527E2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfFYJWA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 05:22:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53248 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfFYJV7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jun 2019 05:21:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5P999uR183423;
        Tue, 25 Jun 2019 09:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=v0L+wTyers6pyrU8myCWzzydsqQ6FjVlb/H+Wq3zgco=;
 b=Xme3roAr4BGuia9Jr7G4ywY+Yu9nxHCKAvvwSGb0LfpmJhm3M6o8nF4EZACrvxyPDBZ0
 Y2TOjnSn3gK2/dEhTDT/eBNOQOZjJmiRwM6pPIbBWR4WjKhr0SH+QEx2NifCkLai2+PM
 Eoq1yhfuQodBmj8m1Eh+gSXtlI9P3j0+o4FFc/s4D8ccCY39Nvp5uaZtiA3aR/qrkyUa
 CLyyLy1gbHD2hOvz3o1DVRTKxgiiaWwQrSTa/sAIRKX8gCO5RPDFK28FoiJfEYkOxEBA
 U5jGVQ4yTez7/r5PUdLLnS6601SseZA8Emp8qYzwJyGj3IiD4z+9ZIdXs4qDHKEw4UoM dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9pk2eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 09:21:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5P9KmfC171859;
        Tue, 25 Jun 2019 09:21:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t9p6u316v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 09:21:56 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5P9LteH025573;
        Tue, 25 Jun 2019 09:21:56 GMT
Received: from srabinov-laptop.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 02:21:37 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
        yuval.shaia@oracle.com, shamir.rabinovitch@oracle.com
Subject: [RFC rdma-core] verbs: add ibv_export_to_fd man page
Date:   Tue, 25 Jun 2019 12:21:13 +0300
Message-Id: <20190625092113.19099-1-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250074
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 libibverbs/man/ibv_export_to_fd.3 | 99 +++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 libibverbs/man/ibv_export_to_fd.3

diff --git a/libibverbs/man/ibv_export_to_fd.3 b/libibverbs/man/ibv_export_to_fd.3
new file mode 100644
index 00000000..e3e06bb0
--- /dev/null
+++ b/libibverbs/man/ibv_export_to_fd.3
@@ -0,0 +1,99 @@
+.\" -*- nroff -*-
+.\" Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md
+.\"
+.TH IBV_EXPORT_TO_FD 3 2019-06-20 libibverbs "Libibverbs Programmer's Manual"
+.SH "NAME"
+ibv_export_to_fd, ibv_import_x \- exports ib hw object (e.g. pd) from current context to the
+.B export context.
+ibv_import_x import the ib hw object from the
+.B export context
+to the current context (e.g. ibv_import_pd).
+.SH "SYNOPSIS"
+.nf
+.B #include <infiniband/verbs.h>
+.sp
+.BI "int ibv_export_to_fd(uint32_t " "fd" ,
+.BI "                     uint32_t " "*new_handle" ,
+.BI "                     struct ibv_context " "*context" ,
+.BI "                     enum uverbs_default_objects " "type" ,
+.BI "                     uint32_t " "handle");
+.sp
+.BI "struct ibv_pd *ibv_import_pd(struct ibv_context " "*context" ,
+.BI "                             uint32_t " "fd" ,
+.BI "                             uint32_t " "handle");
+.sp
+.BI "struct ibv_mr *ibv_import_mr(struct ibv_context " "*context" ,
+.BI "                             uint32_t " "fd" ,
+.BI "                             uint32_t " "handle");
+.sp
+.BI "uint32_t ibv_context_to_fd(struct ibv_context " "*context");
+.sp
+.BI "uint32_t ibv_pd_to_handle(struct ibv_pd " "*pd");
+.sp
+.BI "uint32_t ibv_mr_to_handle(struct ibv_mr " "*mr");
+.fi
+.SH "DESCRIPTION"
+.B ibv_export_to_fd()
+export ib hw object (pd, mr,...) from context to another context represented by the file descriptor fd. The destination context (file descriptor) can then be shared with other processes via unix socket SCM_RIGHTS. Once shared, the destination process can import the exported objects from the shared file descriptor to it's current context by using the equivalent ibv_import_x (e.g. ibv_import_pd) verb which return ib hw object. The destruction of the imported object is done by using the ib hw object destroy verb (e.g. ibv_dealloc_pd).
+.PP
+.B fd
+is the destination context's file descriptor.
+.PP
+.B new_handle
+is the handle of the new object.
+.PP
+.B context
+is the context to export the object from
+.PP
+.B type
+is the type of the object being exported (e.g. UVERBS_OBJECT_PD)
+.PP
+.B handle
+is the handle of the object being exported.
+.PP
+.nf
+To export object (e.g. pd), the below steps should be taken:
+
+1. Allocate new shared context (ibv_open_device)
+2. Get the new context file descriptor (ibv_context_to_fd)
+3. Get the ib hw object handle (e.g. ibv_pd_to_handle)
+4. Export the ib hw object to the file descriptor (ibv_export_to_fd)
+.fi
+.P
+.B ibv_import_pd(), ibv_import_mr()
+import pd/mr previously exported via
+.B export context
+.P
+.B context
+the context to import the ib hw object to
+.P
+.B fd
+is the source context's file descriptor.
+.P
+.B handle
+the handle the the exported object in the
+.B export context
+as returned from
+.B ibv_export_to_fd()
+.P
+.B ibv_context_to_fd()
+returs the file descriptor of the given context
+.P
+.B ibv_pd_to_handle(), ibv_mr_to_handle()
+returns the ib hw object handle from the given object
+.SH "RETURN VALUE"
+.B ibv_export_to_fd()
+\- returns 0 on success, or the value of errno on failure (which indicates the failure reason).
+.P
+.B ibv_import_pd(), ibv_import_mr()
+\- returns a pointer to the imported ib hw object, or NULL if the request fails.
+.SH "NOTES"
+The destination context for this verb can be
+.B ANY
+context including the source context.
+.SH "SEE ALSO"
+.BR ibv_dealloc_pd (3),
+.BR ibv_dereg_mr (3),
+.SH "AUTHORS"
+.TP
+Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
-- 
2.21.0

