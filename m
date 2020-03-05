Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1569C17A87E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCEPEk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPEk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:40 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEC420801;
        Thu,  5 Mar 2020 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420679;
        bh=S47PAierAPdxDRkfVaG9e1PvtYvJyD0DLvKzhXfwYic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvRdsgK6PMIsIYBXLLkLEDJbz9qAIh31YpBnC8Mf+o+jeK7rdyXV+N4UoHJ0OaLA6
         ZTYYUjqHI2j3+yWF0TwBcBBXct+LpuP0Gs9KYaYoMKZoTp1HA3wI7YGX58krqr5aP8
         IMZ0dYtEi0+fCnzV/dVjvurYpZCNXG1JcmkgS2lM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 11/11] librdmacm: Document ECE API
Date:   Thu,  5 Mar 2020 17:03:56 +0200
Message-Id: <20200305150356.208843-12-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150356.208843-1-leon@kernel.org>
References: <20200305150356.208843-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Add manual pages for librdmacm part of ECE.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 librdmacm/man/CMakeLists.txt           |  2 +
 librdmacm/man/rdma_cm.7                | 14 +++++-
 librdmacm/man/rdma_get_remote_ece.3.md | 61 +++++++++++++++++++++++++
 librdmacm/man/rdma_set_local_ece.3.md  | 62 ++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 librdmacm/man/rdma_get_remote_ece.3.md
 create mode 100644 librdmacm/man/rdma_set_local_ece.3.md

diff --git a/librdmacm/man/CMakeLists.txt b/librdmacm/man/CMakeLists.txt
index 2d1efbff..6159c3e3 100644
--- a/librdmacm/man/CMakeLists.txt
+++ b/librdmacm/man/CMakeLists.txt
@@ -29,6 +29,7 @@ rdma_man_pages(
   rdma_get_local_addr.3
   rdma_get_peer_addr.3
   rdma_get_recv_comp.3
+  rdma_get_remote_ece.3.md
   rdma_get_request.3
   rdma_get_send_comp.3
   rdma_get_src_port.3
@@ -56,6 +57,7 @@ rdma_man_pages(
   rdma_resolve_addr.3
   rdma_resolve_route.3
   rdma_server.1
+  rdma_set_local_ece.3.md
   rdma_set_option.3
   rdma_xclient.1
   rdma_xserver.1
diff --git a/librdmacm/man/rdma_cm.7 b/librdmacm/man/rdma_cm.7
index 8e5ad99e..122c96f0 100644
--- a/librdmacm/man/rdma_cm.7
+++ b/librdmacm/man/rdma_cm.7
@@ -26,6 +26,10 @@ parameter in specific calls.  If an event channel is provided, an rdma_cm identi
 will report its event data (results of connecting, for example), on that channel.
 If a channel is not provided, then all rdma_cm operations for the selected
 rdma_cm identifier will block until they complete.
+.P
+The RDMA CM gives an option to different libibverbs providers to advertise and
+use various specific to that provider QP configuration options. This functionality
+is called ECE (enhanced connection establishment).
 .SH "RDMA VERBS"
 The rdma_cm supports the full range of verbs available through the libibverbs
 library and interfaces.  However, it also provides wrapper functions for some
@@ -111,6 +115,8 @@ destroy the QP
 release the rdma_cm_id
 .IP rdma_destroy_event_channel
 release the event channel
+.IP rdma_set_local_ece
+set desired ECE options
 .P
 An almost identical process is used to setup unreliable datagram (UD)
 communication between nodes.  No actual connection is formed between QPs
@@ -157,6 +163,10 @@ release the connected rdma_cm_id
 release the listening rdma_cm_id
 .IP rdma_destroy_event_channel
 release the event channel
+.IP rdma_get_remote_ece
+get ECe options sent by the client
+.IP rdma_set_local_ece
+set desired ECE options
 .SH "RETURN CODES"
 .IP "=  0"
 success
@@ -198,6 +208,7 @@ rdma_get_dst_port(3),
 rdma_get_local_addr(3),
 rdma_get_peer_addr(3),
 rdma_get_recv_comp(3),
+rdma_get_remote_ece(3),
 rdma_get_request(3),
 rdma_get_send_comp(3),
 rdma_get_src_port(3),
@@ -221,7 +232,8 @@ rdma_reg_write(3),
 rdma_reject(3),
 rdma_resolve_addr(3),
 rdma_resolve_route(3),
-rdma_set_option(3)
+rdma_get_remote_ece(3),
+rdma_set_option(3),
 mckey(1),
 rdma_client(1),
 rdma_server(1),
diff --git a/librdmacm/man/rdma_get_remote_ece.3.md b/librdmacm/man/rdma_get_remote_ece.3.md
new file mode 100644
index 00000000..1db1f8ee
--- /dev/null
+++ b/librdmacm/man/rdma_get_remote_ece.3.md
@@ -0,0 +1,61 @@
+---
+date: 2020-02-02
+footer: librdmacm
+header: "Librdmacm Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: RDMA_GET_REMOTE_ECE
+---
+
+# NAME
+
+rdma_get_remote_ece - Get remote ECE paraemters as received from the peer.
+
+# SYNOPSIS
+
+```c
+#include <rdma/rdma_cma.h>
+
+int rdma_get_remote_ece(struct rdma_cm_id *id, struct ibv_ece *ece);
+```
+# DESCRIPTION
+
+**rdma_get_remote_ece()** get ECE parameters as were received from the communication peer.
+
+This function is suppose to be used by the users of external QPs. The call needs
+to be performed before replying to the peer and needed to allow for the passive
+side to know ECE options of other side.
+
+Being used by external QP and RDMA_CM doesn't manage that QP, the peer needs
+to call to libibverbs API by itself.
+
+Usual flow for the passive side will be:
+
+ * ibv_create_qp() <- create data QP.
+ * ece = rdma_get_remote_ece() <- get ECE options from remote peer
+ * ibv_set_ece(ece) <- set local ECE options with data received from the peer.
+ * ibv_modify_qp() <- enable data QP.
+ * rdma_set_local_ece(ece) <- set desired ECE options after respective
+				libibverbs provider masked unsupported options.
+ * rdma_accept()/rdma_establish()/rdma_reject_ece()
+
+# ARGUMENTS
+
+*id
+:    RDMA communication identifier.
+
+*ece
+:    ECE struct to be filled.
+
+# RETURN VALUE
+
+**rdma_get_remote_ece()** returns 0 on success, or -1 on error.  If an error occurs, errno will be set to indicate the failure reason.
+
+# SEE ALSO
+
+**rdma_cm**(7), rdma_set_local_ece(3)
+
+# AUTHOR
+
+Leon Romanovsky <leonro@mellanox.com>
diff --git a/librdmacm/man/rdma_set_local_ece.3.md b/librdmacm/man/rdma_set_local_ece.3.md
new file mode 100644
index 00000000..253e60df
--- /dev/null
+++ b/librdmacm/man/rdma_set_local_ece.3.md
@@ -0,0 +1,62 @@
+---
+date: 2020-02-02
+footer: librdmacm
+header: "Librdmacm Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: RDMA_SET_LOCAL_ECE
+---
+
+# NAME
+
+rdma_set_local_ece - Set local ECE paraemters to be used for REQ/REP communication.
+
+# SYNOPSIS
+
+```c
+#include <rdma/rdma_cma.h>
+
+int rdma_set_local_ece(struct rdma_cm_id *id, struct ibv_ece *ece);
+```
+# DESCRIPTION
+
+**rdma_set_local_ece()** set local ECE parameters.
+
+This function is suppose to be used by the users of external QPs. The call needs
+to be performed before replying to the peer and needed to configure RDMA_CM with
+desired ECE options.
+
+Being used by external QP and RDMA_CM doesn't manage that QP, the peer needs
+to call to libibverbs API by itself.
+
+Usual flow for the passive side will be:
+
+ * ibv_create_qp() <- create data QP.
+ * ece = ibv_get_ece() <- get ECE from libibvers provider.
+ * rdma_set_local_ece(ece) <- set desired ECE options.
+ * rdma_connect() <- send connection request
+ * ece = rdma_get_remote_ece() <- get ECE options from remote peer
+ * ibv_set_ece(ece) <- set local ECE options with data received from the peer.
+ * ibv_modify_qp() <- enable data QP.
+ * rdma_accept()/rdma_establish()/rdma_reject_ece()
+
+# ARGUMENTS
+
+*id*
+:    RDMA communication identifier.
+
+*ece
+:    ECE parameters.
+
+# RETURN VALUE
+
+**rdma_set_local_ece()** returns 0 on success, or -1 on error.  If an error occurs, errno will be set to indicate the failure reason.
+
+# SEE ALSO
+
+**rdma_cm**(7), rdma_get_remote_ece(3)
+
+# AUTHOR
+
+Leon Romanovsky <leonro@mellanox.com>
--
2.24.1

