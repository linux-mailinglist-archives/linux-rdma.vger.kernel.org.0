Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA03564B5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZIgq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 04:36:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZIgq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jun 2019 04:36:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XTfx191208;
        Wed, 26 Jun 2019 08:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=zXZxoZJEBRHT4nLZ37RcRkpsG9jZ39gMUZIcpfZXOdU=;
 b=R/RBZiNMEqyqqIPFYqMXIqhpfwAGIvwbz3zusC/6nh8+2LjawskvYLsajb1J/TbYpv95
 erti2hodBRf/DeuXd1l3yaoFAWRM+HW2A8zo0UIhHaHPqjS7ARJmUbttdtTXHO9eJ150
 dYOf8PfpMkCoZY7kBuERRN8TTvwqur8N9ePECTCOVIzRN1tHBOyIJOeCiJx1fv3VKnW8
 +R55ZJLHN8Ho7HASnOsj1v/nZRZ44plWJ95DQxg17HHTYFsoGiWHM1DPgIDrTqnmbGES
 rUJGYo8XdTk73XTQT/UROWoUDM916Ni8ZGg0wdJLn0QvpaU+aRXUpGoDCgYPhe0CDhaD Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqgt0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 08:36:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8ZWSc160238;
        Wed, 26 Jun 2019 08:36:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acck2dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 08:36:43 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q8afpO003620;
        Wed, 26 Jun 2019 08:36:42 GMT
Received: from srabinov-laptop.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:36:31 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
        yuval.shaia@oracle.com, shamir.rabinovitch@oracle.com
Subject: [RFC rdma-core] verbs: add ibv_export_to_fd man page
Date:   Wed, 26 Jun 2019 11:36:14 +0300
Message-Id: <20190626083614.23688-1-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260104
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the ibv_export_to_fd man page.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 libibverbs/man/ibv_export_to_fd.3.md | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 libibverbs/man/ibv_export_to_fd.3.md

diff --git a/libibverbs/man/ibv_export_to_fd.3.md b/libibverbs/man/ibv_export_to_fd.3.md
new file mode 100644
index 00000000..8e3f0fb2
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
+**ibv_export_to_fd**() export ib hw object (pd, mr,...) from context to another context represented by the file descriptor fd. The destination context (file descriptor) can
+then  be shared with other processes via unix socket SCM_RIGHTS. Once shared, the destination process can import the exported objects from the shared file descriptor to
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
+**ibv_context_to_fd**() returs the file descriptor of the given context.
+
+**ibv_pd_to_handle**(), **ibv_mr_to_handle**() returns the ib hw object handle from the given object.
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
+*handle* the handle the the exported object in the export context as returned from *ibv_export_to_fd*().
+
+**ibv_context_to_fd**()
+
+*context* context obtained from **ibv_open_device**() verb.
+
+**ibv_pd_to_handle**(), **ibv_mr_to_handle**()
+
+*pd*, *mr* obtained from **ibv_alloc_pd**(), **ibv_reg_mr**() verbs.
+
+# RETURN VALUE
+
+**ibv_export_to_fd**() returns 0 on success, or the value of errno on failure (which indicates the failure reason).
+
+**ibv_import_pd**(), **ibv_import_mr**() - returns a pointer to the imported ib hw object, or NULL if the request fails. 
+
+**ibv_context_to_fd**() returs the file descriptor of the given context.
+
+**ibv_pd_to_handle**(), **ibv_mr_to_handle**() returns the ib hw object handle from the given object
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

