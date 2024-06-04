Return-Path: <linux-rdma+bounces-2828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6108FB1E2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DBFB210A9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFA145B35;
	Tue,  4 Jun 2024 12:14:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83916145A1D
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503268; cv=none; b=FAAY5k+Z/5+KuMGtE64Awhhc4OlqE7d6iQIk3bud9bHEIdnPYvhnHiLusB8vYKy724sLBBljH2Qq7Rqi2Z5mpF1j9knJNUR8x+zCqqaZsKpDwj/+tx5uDwS+EN/t6E/Nn35n+bjvnBKCRKSrAAmXyaS3Uz/s6fU0gSu7VJa5EZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503268; c=relaxed/simple;
	bh=i+tm43gU1GDaBgDaHS/R6JgXWnPvo6Va3UlyNZ2td9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtjOqCBOvBBt1vKNvbWor5D3mjt9KE1VMpgxX6qLUIzszWoJ+U22/YnYje+ZKIS6LWs8bUx2gbFCtlLRHquumMs1d+f0wG2yQS3G8q4kAiJsqRUNXLXh+qib4Yl1HhRnFN/Kj6WviN0ceH1NKK0Y5lcNTjYFoRAyspfhAWMqR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VtqDf2DGjz2Cjml;
	Tue,  4 Jun 2024 20:10:42 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DA27A1A016F;
	Tue,  4 Jun 2024 20:14:22 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:22 +0800
From: Gonglei <arei.gonglei@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
	<elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
	<lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
	Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 5/6] migration: introduce new RDMA live migration
Date: Tue, 4 Jun 2024 20:14:11 +0800
Message-ID: <1717503252-51884-6-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

From: Jialin Wang <wangjialin23@huawei.com>

Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 migration/meson.build |  2 +
 migration/migration.c | 11 +++++-
 migration/rdma.c      | 88 +++++++++++++++++++++++++++++++++++++++++++
 migration/rdma.h      | 24 ++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 migration/rdma.c
 create mode 100644 migration/rdma.h

diff --git a/migration/meson.build b/migration/meson.build
index 4e8a9ccf3e..04e2e16239 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -42,3 +42,5 @@ system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
                                'target.c'))
+
+system_ss.add(when: rdma, if_true: files('rdma.c'))
diff --git a/migration/migration.c b/migration/migration.c
index 6b9ad4ff5f..77c301d351 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -25,6 +25,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpu-throttle.h"
+#include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
@@ -145,7 +146,7 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
         return migrate_mapped_ram();
     } else {
-        return false;
+        return addr->transport == MIGRATION_ADDRESS_TYPE_RDMA;
     }
 }
 
@@ -644,6 +645,10 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
+#endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_incoming_migration(addr->u.exec.args, errp);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
@@ -2046,6 +2051,10 @@ void qmp_migrate(const char *uri, bool has_channels,
         } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
+#endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
         exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
diff --git a/migration/rdma.c b/migration/rdma.c
new file mode 100644
index 0000000000..09a4de7f59
--- /dev/null
+++ b/migration/rdma.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU live migration via RDMA
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *  Jialin Wang <wangjialin23@huawei.com>
+ *  Gonglei <arei.gonglei@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "io/channel-rdma.h"
+#include "io/channel.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-types-sockets.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "channel.h"
+#include "migration.h"
+#include "rdma.h"
+#include "trace.h"
+#include <stdio.h>
+
+static struct RDMAOutgoingArgs {
+    InetSocketAddress *addr;
+} outgoing_args;
+
+static void rdma_outgoing_migration(QIOTask *task, gpointer opaque)
+{
+    MigrationState *s = opaque;
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qio_task_get_source(task));
+
+    migration_channel_connect(s, QIO_CHANNEL(rioc), outgoing_args.addr->host,
+                              NULL);
+    object_unref(OBJECT(rioc));
+}
+
+void rdma_start_outgoing_migration(MigrationState *s, InetSocketAddress *iaddr,
+                                   Error **errp)
+{
+    QIOChannelRDMA *rioc = qio_channel_rdma_new();
+
+    /* in case previous migration leaked it */
+    qapi_free_InetSocketAddress(outgoing_args.addr);
+    outgoing_args.addr = QAPI_CLONE(InetSocketAddress, iaddr);
+
+    qio_channel_set_name(QIO_CHANNEL(rioc), "migration-rdma-outgoing");
+    qio_channel_rdma_connect_async(rioc, iaddr, rdma_outgoing_migration, s,
+                                   NULL, NULL);
+}
+
+static void coroutine_fn rdma_accept_incoming_migration(void *opaque)
+{
+    QIOChannelRDMA *rioc = opaque;
+    QIOChannelRDMA *cioc;
+
+    while (!migration_has_all_channels()) {
+        cioc = qio_channel_rdma_accept(rioc, NULL);
+
+        qio_channel_set_name(QIO_CHANNEL(cioc), "migration-rdma-incoming");
+        migration_channel_process_incoming(QIO_CHANNEL(cioc));
+        object_unref(OBJECT(cioc));
+    }
+}
+
+void rdma_start_incoming_migration(InetSocketAddress *addr, Error **errp)
+{
+    QIOChannelRDMA *rioc = qio_channel_rdma_new();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    Coroutine *co;
+    int num = 1;
+
+    qio_channel_set_name(QIO_CHANNEL(rioc), "migration-rdma-listener");
+
+    if (qio_channel_rdma_listen_sync(rioc, addr, num, errp) < 0) {
+        object_unref(OBJECT(rioc));
+        return;
+    }
+
+    mis->transport_data = rioc;
+    mis->transport_cleanup = object_unref;
+
+    qio_channel_set_blocking(QIO_CHANNEL(rioc), false, NULL);
+    co = qemu_coroutine_create(rdma_accept_incoming_migration, rioc);
+    aio_co_schedule(qemu_get_current_aio_context(), co);
+}
diff --git a/migration/rdma.h b/migration/rdma.h
new file mode 100644
index 0000000000..4c3eb9a972
--- /dev/null
+++ b/migration/rdma.h
@@ -0,0 +1,24 @@
+/*
+ * QEMU live migration via RDMA
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *  Jialin Wang <wangjialin23@huawei.com>
+ *  Gonglei <arei.gonglei@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_RDMA_H
+#define QEMU_MIGRATION_RDMA_H
+
+#include "qemu/sockets.h"
+
+void rdma_start_outgoing_migration(MigrationState *s, InetSocketAddress *addr,
+                                   Error **errp);
+
+void rdma_start_incoming_migration(InetSocketAddress *addr, Error **errp);
+
+#endif /* QEMU_MIGRATION_RDMA_H */
-- 
2.43.0


