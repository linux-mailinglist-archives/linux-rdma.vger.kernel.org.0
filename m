Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34C456BCF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFZO0v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 10:26:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33920 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZO0u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jun 2019 10:26:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QEOAAG004990;
        Wed, 26 Jun 2019 14:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=j1vy9bdilbX7NDMwiEs4Dn4CeFfD6xbhUGsnymsBRW4=;
 b=xOb6eC8jkWHjt/NDB5LI0uNEVi1y5KBHpZfX0vXtCgj7LtMgzs9fcUn2435TekAuuVN/
 71wUKp7y9saT10nbDGhbM6ur62GFWrHXFXdbeTKzfxM5hbmP5UwQu4sETm9awHIPEXsy
 nxhLM38NBSvj/myPVaa5Ynu/Bhuou0Ta23+GCGhGyJz0Jrks+PitjvqTw1FO97k5YRbM
 r86cYumnarN+zMyH+nnnVQ0KEuLgi2imooOMm1ih3G+5xwRd59FO5hq10bCUsLyT1CyB
 u/IAT2LiLTJLyvDmZpl1Cf/0lri0DfgRoWIxp4Cs241EJZHPhZbd5BAjk0hEQPsICBpU 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9ptp50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 14:26:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QEPXnL178863;
        Wed, 26 Jun 2019 14:26:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t9accqqsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 14:26:47 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QEQkpl020598;
        Wed, 26 Jun 2019 14:26:46 GMT
Received: from srabinov-laptop.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 07:26:45 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
        santosh.shilimkar@oracle.com, yuval.shaia@oracle.com,
        shamir.rabinovitch@oracle.com
Subject: [RFC rdma-core v2] verbs: add object export & import man page
Date:   Wed, 26 Jun 2019 17:26:30 +0300
Message-Id: <20190626142630.8737-1-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260170
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the man page for object export & pd/mr import.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---

Changelog:

v1 -> v2: Review comments (Yuval)
v0 -> v1: Change to markdown format (Jason)

----
 libibverbs/man/ibv_export_to_fd.3.md | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 libibverbs/man/ibv_export_to_fd.3.md

diff --git a/libibverbs/man/ibv_export_to_fd.3.md b/libibverbs/man/ibv_export_to_fd.3.md
new file mode 100644
index 00000000..440210e8
--- /dev/null
+++ b/libibverbs/man/ibv_export_to_fd.3.md
@@ -0,0 +1,109 @@
+---
+date: 2018-06-26
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: ibv_export_to_fd
+tagline: Verbs
+---
+
+# NAME
+
+**ibv_export_to_fd**, **ibv_import_pd**, **ibv_import_mr** - export & import ib hw objects.
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+int ibv_export_to_fd(uint32_t fd,
+                     uint32_t *new_handle,
+                     struct ibv_context *context,
+                     enum uverbs_default_objects type,
+                     uint32_t handle);
+
+struct ibv_pd *ibv_import_pd(struct ibv_context *context,
+                             uint32_t fd,
+                             uint32_t handle);
+
+struct ibv_mr *ibv_import_mr(struct ibv_context *context,
+                             uint32_t fd,
+                             uint32_t handle);
+
+uint32_t ibv_context_to_fd(struct ibv_context *context);
+
+uint32_t ibv_pd_to_handle(struct ibv_pd *pd);
+
+uint32_t ibv_mr_to_handle(struct ibv_mr *mr);
+
+```
+
+# DESCRIPTION
+
+**ibv_export_to_fd**() exports ib hw object (pd, mr,...) from one context to another context represented by the file descriptor fd. The destination context (file descriptor) can
+then be shared with other processes by passing it via unix socket SCM_RIGHTS. Once shared, the destination process can import the exported objects from the shared file descriptor to
+it's current context by using the equivalent ibv_import_x (e.g. ibv_import_pd) verb which return ib hw object. The destruction of the imported object is done  by  using
+the ib hw object destroy verb (e.g. ibv_dealloc_pd).
+
+## To export object (e.g. pd), the below steps should be taken:
+
+1. Allocate new shared context (ibv_open_device).
+2. Get the new context file descriptor (ibv_context_to_fd).
+3. Get the ib hw object handle (e.g. ibv_pd_to_handle).
+4. Export the ib hw object to the file descriptor (ibv_export_to_fd).
+
+**ibv_import_pd**(), **ibv_import_mr**() import pd/mr previously exported via export context.
+
+**ibv_context_to_fd**() returns the file descriptor of a given context.
+
+**ibv_pd_to_handle**(), **ibv_mr_to_handle**() returns the ib hw object handle of a given object.
+
+# ARGUMENTS
+
+**ibv_export_to_fd**()
+
+*fd* is the destination context's file descriptor.
+
+*new_handle* is the handle of the new object.
+
+*context* is the context to export the object from.
+
+*type* is the type of the object being exported (e.g. UVERBS_OBJECT_PD).
+
+*handle* is the handle of the object being exported.
+
+**ibv_import_pd**(), **ibv_import_mr**()
+
+*context* the context to import the ib hw object to.
+
+*fd* is the source context's file descriptor.
+
+*handle* is the handle of the exported object in the export context as returned from *ibv_export_to_fd*().
+
+**ibv_context_to_fd**()
+
+*context* is the context obtained from **ibv_open_device**() verb.
+
+**ibv_pd_to_handle**(), **ibv_mr_to_handle**()
+
+*pd*, *mr* obtained from **ibv_alloc_pd**(), **ibv_reg_mr**() verbs.
+
+# RETURN VALUE
+
+**ibv_export_to_fd**() returns 0 on success, or the value of errno on failure (which indicates the failure reason).
+
+**ibv_import_pd**(), **ibv_import_mr**() returns a pointer to the imported ib hw object, or NULL if the request fails.
+
+**ibv_context_to_fd**() returns the file descriptor of the given context.
+
+**ibv_pd_to_handle**(), **ibv_mr_to_handle**() returns the ib hw object handle from the given object.
+
+# SEE ALSO
+
+**ibv_dealloc_pd**(3), **ibv_dereg_mr**(3)
+
+# AUTHORS
+
+Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
-- 
2.21.0

