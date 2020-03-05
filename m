Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B12917A878
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCEPEV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgCEPEV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:21 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D2220848;
        Thu,  5 Mar 2020 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420660;
        bh=L6HLfIuqRxbMKf4NDJAZFpTqecV+EDSbtfNdYBdUqEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPbWfvQxyhqwHcJitpwVD0G5hUUhlafbbMBlSDQF29IIrM/CbP9wgBcKDyiF1fLS0
         FT0DZfcNct91I7pxNjNea4NsjXyxp61bWMx70Wm+TZoQPSOECMq13xHq4dctsL8JBp
         HFbzonMhwTn/4AJZxECxfoj314Pw0bOaIpZ3SGhQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 04/11] libibverbs: Document ECE API
Date:   Thu,  5 Mar 2020 17:03:49 +0200
Message-Id: <20200305150356.208843-5-leon@kernel.org>
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

Add manual pages for libibverbs part of ECE.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 libibverbs/man/CMakeLists.txt     |  2 +
 libibverbs/man/ibv_query_ece.3.md | 56 ++++++++++++++++++++++++++++
 libibverbs/man/ibv_set_ece.3.md   | 61 +++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 libibverbs/man/ibv_query_ece.3.md
 create mode 100644 libibverbs/man/ibv_set_ece.3.md

diff --git a/libibverbs/man/CMakeLists.txt b/libibverbs/man/CMakeLists.txt
index e1d5edf8..c0ff7a25 100644
--- a/libibverbs/man/CMakeLists.txt
+++ b/libibverbs/man/CMakeLists.txt
@@ -51,6 +51,7 @@ rdma_man_pages(
   ibv_post_srq_recv.3
   ibv_query_device.3
   ibv_query_device_ex.3
+  ibv_query_ece.3.md
   ibv_query_gid.3.md
   ibv_query_pkey.3.md
   ibv_query_port.3
@@ -65,6 +66,7 @@ rdma_man_pages(
   ibv_req_notify_cq.3.md
   ibv_rereg_mr.3.md
   ibv_resize_cq.3.md
+  ibv_set_ece.3.md
   ibv_srq_pingpong.1
   ibv_uc_pingpong.1
   ibv_ud_pingpong.1
diff --git a/libibverbs/man/ibv_query_ece.3.md b/libibverbs/man/ibv_query_ece.3.md
new file mode 100644
index 00000000..b9eee699
--- /dev/null
+++ b/libibverbs/man/ibv_query_ece.3.md
@@ -0,0 +1,56 @@
+---
+date: 2020-01-22
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: IBV_QUERY_ECE
+---
+
+# NAME
+
+ibv_query_ece - query ECE options.
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+int ibv_query_ece(struct ibv_qp *qp, struct ibv_ece *ece);
+```
+
+# DESCRIPTION
+
+**ibv_query_ece()** query ECE options.
+
+Return to the user current ECE state for the QP.
+
+# ARGUMENTS
+*qp*
+:	The queue pair (QP) associated with the ECE options.
+
+*ece*
+:	The ECE values.
+
+# RETURN VALUE
+
+**ibv_query_ece()** returns 0 when the call was successful, or the negative
+		    value with errno which indicates the failure reason.
+
+*EOPNOTSUPP*
+:	libibverbs or provider driver doesn't support the ibv_set_ece() verb.
+
+*EINVAL*
+:	In one of the following:
+	o The QP is invalid.
+	o The ECE options are invalid.
+
+# SEE ALSO
+
+**ibv_set_ece**(3),
+
+# AUTHOR
+
+Leon Romanovsky <leonro@mellanox.com>
+
diff --git a/libibverbs/man/ibv_set_ece.3.md b/libibverbs/man/ibv_set_ece.3.md
new file mode 100644
index 00000000..52d5f8f8
--- /dev/null
+++ b/libibverbs/man/ibv_set_ece.3.md
@@ -0,0 +1,61 @@
+---
+date: 2020-01-22
+footer: libibverbs
+header: "Libibverbs Programmer's Manual"
+layout: page
+license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
+section: 3
+title: IBV_COMMIT_ECE
+---
+
+# NAME
+
+ibv_set_ece - set ECE options and use them for QP configuration stage.
+
+# SYNOPSIS
+
+```c
+#include <infiniband/verbs.h>
+
+int ibv_set_ece(struct ibv_qp *qp, struct ibv_ece *ece);
+```
+
+# DESCRIPTION
+
+**ibv_set_ece()** set ECE options and use them for QP configuration stage.
+
+The desired ECE options will be used during various modify QP stages
+based on supported options in relevant QP state.
+
+# ARGUMENTS
+*qp*
+:	The queue pair (QP) associated with the ECE options.
+
+*ece*
+:	The requested ECE values. This is IN/OUT field, the accepted options
+        will be returned in this field.
+
+# RETURN VALUE
+
+**ibv_set_ece()** returns 0 when the call was successful, or the negative
+		    value with errno which indicates the failure reason.
+
+*EOPNOTSUPP*
+:	libibverbs or provider driver doesn't support the ibv_set_ece() verb.
+
+*ECONNREFUSED*
+:	Connection refused, provider doesn't want those options.
+
+*EINVAL*
+:	In one of the following:
+	o The QP is invalid.
+	o The ECE options are invalid.
+
+# SEE ALSO
+
+**ibv_query_ece**(3),
+
+# AUTHOR
+
+Leon Romanovsky <leonro@mellanox.com>
+
--
2.24.1

