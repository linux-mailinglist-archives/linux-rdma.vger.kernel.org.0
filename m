Return-Path: <linux-rdma+bounces-2832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2C8FB1E6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73871C22113
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3836145FE4;
	Tue,  4 Jun 2024 12:14:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A1145FE5
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503274; cv=none; b=b7+KseYEGrYNIzgfhG7NlpzJc4GPPOZlK0Bed8IXO/Cvb72O5GZi9NasbLYVnZ4Kz1LDHvPmZc5+XafsHUqfQRwHpa7P1yITLA0PEqIppulI6BT81EgX3aYBdcwzmMhe8rrWIwMGIR3HJ+Ee4FnlB5vhnTs1rSDmZCaQ/WaXoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503274; c=relaxed/simple;
	bh=wo/JZplaXZHrir8uYXIFyhXtEANpu6aX+rZbY6IE3mE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShWOXafhqmeV6wFi0UQQG3LNTVW6ZNsQhgL86vKMlEhkuyo4AFVxULzTFEo5OjwqopWERAoZRbxvfTU5/DkFsv/V8w/8Ft14kDLgK2ItsrYfEyOlEL7l7UXndap7HR1m+xrSDzMDaF0PWAD7dyoh0y1BffUVHzLDWQ1l2s/qm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VtqDg1ybZz355fS;
	Tue,  4 Jun 2024 20:10:43 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A0ED81A0188;
	Tue,  4 Jun 2024 20:14:23 +0800 (CST)
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
Subject: [PATCH 6/6] migration/rdma: support multifd for RDMA migration
Date: Tue, 4 Jun 2024 20:14:12 +0800
Message-ID: <1717503252-51884-7-git-send-email-arei.gonglei@huawei.com>
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
 migration/multifd.c | 10 ++++++++++
 migration/rdma.c    | 27 +++++++++++++++++++++++++++
 migration/rdma.h    |  6 ++++++
 3 files changed, 43 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index f317bff077..cee9858ad1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -32,6 +32,7 @@
 #include "io/channel-file.h"
 #include "io/channel-socket.h"
 #include "yank_functions.h"
+#include "rdma.h"
 
 /* Multiple fd's */
 
@@ -793,6 +794,9 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 static void multifd_send_cleanup_state(void)
 {
     file_cleanup_outgoing_migration();
+#ifdef CONFIG_RDMA
+    rdma_cleanup_outgoing_migration();
+#endif
     socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
@@ -1139,6 +1143,12 @@ static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
         return file_send_channel_create(opaque, errp);
     }
 
+#ifdef CONFIG_RDMA
+    if (rdma_send_channel_create(multifd_new_send_channel_async, opaque)) {
+        return true;
+    }
+#endif
+
     socket_send_channel_create(multifd_new_send_channel_async, opaque);
     return true;
 }
diff --git a/migration/rdma.c b/migration/rdma.c
index 09a4de7f59..af4d2b5a5a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -19,6 +19,7 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "channel.h"
 #include "migration.h"
+#include "options.h"
 #include "rdma.h"
 #include "trace.h"
 #include <stdio.h>
@@ -27,6 +28,28 @@ static struct RDMAOutgoingArgs {
     InetSocketAddress *addr;
 } outgoing_args;
 
+bool rdma_send_channel_create(QIOTaskFunc f, void *data)
+{
+    QIOChannelRDMA *rioc;
+
+    if (!outgoing_args.addr) {
+        return false;
+    }
+
+    rioc = qio_channel_rdma_new();
+    qio_channel_rdma_connect_async(rioc, outgoing_args.addr, f, data, NULL,
+                                   NULL);
+    return true;
+}
+
+void rdma_cleanup_outgoing_migration(void)
+{
+    if (outgoing_args.addr) {
+        qapi_free_InetSocketAddress(outgoing_args.addr);
+        outgoing_args.addr = NULL;
+    }
+}
+
 static void rdma_outgoing_migration(QIOTask *task, gpointer opaque)
 {
     MigrationState *s = opaque;
@@ -74,6 +97,10 @@ void rdma_start_incoming_migration(InetSocketAddress *addr, Error **errp)
 
     qio_channel_set_name(QIO_CHANNEL(rioc), "migration-rdma-listener");
 
+    if (migrate_multifd()) {
+        num = migrate_multifd_channels();
+    }
+
     if (qio_channel_rdma_listen_sync(rioc, addr, num, errp) < 0) {
         object_unref(OBJECT(rioc));
         return;
diff --git a/migration/rdma.h b/migration/rdma.h
index 4c3eb9a972..cefccac61c 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -16,6 +16,12 @@
 
 #include "qemu/sockets.h"
 
+#include <stdbool.h>
+
+bool rdma_send_channel_create(QIOTaskFunc f, void *data);
+
+void rdma_cleanup_outgoing_migration(void);
+
 void rdma_start_outgoing_migration(MigrationState *s, InetSocketAddress *addr,
                                    Error **errp);
 
-- 
2.43.0


