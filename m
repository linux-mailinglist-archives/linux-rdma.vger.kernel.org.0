Return-Path: <linux-rdma+bounces-2829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA98FB1E3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94EC28103F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3D145B36;
	Tue,  4 Jun 2024 12:14:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8304145B32
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503271; cv=none; b=KyiHumZ9RD6mxytlxEjP+hgeqgCrjpjkiid9XD/RCMBzyoZCeSyFFNo9wVauHJqADufJj+IH+CwwTzJ3LoSWVzbAR2Q/FN/PGBHWagSO9rvXvU1mM5Z9FFvLYzO1UctW+BHh/a0X/okMs4ql8lvsLu9ReQQho/iPj0p+pQ7/Y9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503271; c=relaxed/simple;
	bh=SLLuHjGxYKkSjPxF2HUtZTCPwcvu64AYYWYC4+E3R5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLvkrOFPC45FWY4orBmLBCOcHYHLJ9kSjnAHsYwSv/uD1E+WxrwIgQeShVErhETYoWOUC0jqKnZ3eianJeC/Wo2vEtcS5rYhsRu+8gYev3f0VfPbPNtVRcRcby1y1rqjX2TCInoBmLyFlQO4/WQexoZMIbO1puV/Zi5QFzi4q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VtqF55KFlzPpNw;
	Tue,  4 Jun 2024 20:11:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 20034180060;
	Tue,  4 Jun 2024 20:14:22 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:21 +0800
From: Gonglei <arei.gonglei@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
	<elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
	<lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
	Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 4/6] tests/unit: add test-io-channel-rdma.c
Date: Tue, 4 Jun 2024 20:14:10 +0800
Message-ID: <1717503252-51884-5-git-send-email-arei.gonglei@huawei.com>
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
 tests/unit/meson.build            |   1 +
 tests/unit/test-io-channel-rdma.c | 276 ++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)
 create mode 100644 tests/unit/test-io-channel-rdma.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 26c109c968..c44020a3b5 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -85,6 +85,7 @@ if have_block
     'test-authz-listfile': [authz],
     'test-io-task': [testblock],
     'test-io-channel-socket': ['socket-helpers.c', 'io-channel-helpers.c', io],
+    'test-io-channel-rdma': ['io-channel-helpers.c', io],
     'test-io-channel-file': ['io-channel-helpers.c', io],
     'test-io-channel-command': ['io-channel-helpers.c', io],
     'test-io-channel-buffer': ['io-channel-helpers.c', io],
diff --git a/tests/unit/test-io-channel-rdma.c b/tests/unit/test-io-channel-rdma.c
new file mode 100644
index 0000000000..e96b55c8c7
--- /dev/null
+++ b/tests/unit/test-io-channel-rdma.c
@@ -0,0 +1,276 @@
+/*
+ * QEMU I/O channel RDMA test
+ *
+ * Copyright (c) 2024 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "io/channel-rdma.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "io-channel-helpers.h"
+#include "qapi-types-sockets.h"
+#include <rdma/rsocket.h>
+
+static SocketAddress *l_addr;
+static SocketAddress *c_addr;
+
+static void test_io_channel_set_rdma_bufs(QIOChannel *src, QIOChannel *dst)
+{
+    int buflen = 64 * 1024;
+
+    /*
+     * Make the socket buffers small so that we see
+     * the effects of partial reads/writes
+     */
+    rsetsockopt(((QIOChannelRDMA *)src)->fd, SOL_SOCKET, SO_SNDBUF,
+                (char *)&buflen, sizeof(buflen));
+
+    rsetsockopt(((QIOChannelRDMA *)dst)->fd, SOL_SOCKET, SO_SNDBUF,
+                (char *)&buflen, sizeof(buflen));
+}
+
+static void test_io_channel_setup_sync(InetSocketAddress *listen_addr,
+                                       InetSocketAddress *connect_addr,
+                                       QIOChannel **srv, QIOChannel **src,
+                                       QIOChannel **dst)
+{
+    QIOChannelRDMA *lioc;
+
+    lioc = qio_channel_rdma_new();
+    qio_channel_rdma_listen_sync(lioc, listen_addr, 1, &error_abort);
+
+    *src = QIO_CHANNEL(qio_channel_rdma_new());
+    qio_channel_rdma_connect_sync(QIO_CHANNEL_RDMA(*src), connect_addr,
+                                  &error_abort);
+    qio_channel_set_delay(*src, false);
+
+    qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
+    *dst = QIO_CHANNEL(qio_channel_rdma_accept(lioc, &error_abort));
+    g_assert(*dst);
+
+    test_io_channel_set_rdma_bufs(*src, *dst);
+
+    *srv = QIO_CHANNEL(lioc);
+}
+
+struct TestIOChannelData {
+    bool err;
+    GMainLoop *loop;
+};
+
+static void test_io_channel_complete(QIOTask *task, gpointer opaque)
+{
+    struct TestIOChannelData *data = opaque;
+    data->err = qio_task_propagate_error(task, NULL);
+    g_main_loop_quit(data->loop);
+}
+
+static void test_io_channel_setup_async(InetSocketAddress *listen_addr,
+                                        InetSocketAddress *connect_addr,
+                                        QIOChannel **srv, QIOChannel **src,
+                                        QIOChannel **dst)
+{
+    QIOChannelRDMA *lioc;
+    struct TestIOChannelData data;
+
+    data.loop = g_main_loop_new(g_main_context_default(), TRUE);
+
+    lioc = qio_channel_rdma_new();
+    qio_channel_rdma_listen_async(lioc, listen_addr, 1,
+                                  test_io_channel_complete, &data, NULL, NULL);
+
+    g_main_loop_run(data.loop);
+    g_main_context_iteration(g_main_context_default(), FALSE);
+
+    g_assert(!data.err);
+
+    *src = QIO_CHANNEL(qio_channel_rdma_new());
+
+    qio_channel_rdma_connect_async(QIO_CHANNEL_RDMA(*src), connect_addr,
+                                   test_io_channel_complete, &data, NULL, NULL);
+
+    g_main_loop_run(data.loop);
+    g_main_context_iteration(g_main_context_default(), FALSE);
+
+    g_assert(!data.err);
+
+    if (qemu_in_coroutine()) {
+        qio_channel_yield(QIO_CHANNEL(lioc), G_IO_IN);
+    } else {
+        qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
+    }
+    *dst = QIO_CHANNEL(qio_channel_rdma_accept(lioc, &error_abort));
+    g_assert(*dst);
+
+    qio_channel_set_delay(*src, false);
+    test_io_channel_set_rdma_bufs(*src, *dst);
+
+    *srv = QIO_CHANNEL(lioc);
+
+    g_main_loop_unref(data.loop);
+}
+
+static void test_io_channel(bool async, InetSocketAddress *listen_addr,
+                            InetSocketAddress *connect_addr)
+{
+    QIOChannel *src, *dst, *srv;
+    QIOChannelTest *test;
+
+    if (async) {
+        /* async + blocking */
+
+        test_io_channel_setup_async(listen_addr, connect_addr, &srv, &src,
+                                    &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, true, src, dst);
+        qio_channel_test_validate(test);
+
+        /* unref without close, to ensure finalize() cleans up */
+
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+        object_unref(OBJECT(srv));
+
+        /* async + non-blocking */
+
+        test_io_channel_setup_async(listen_addr, connect_addr, &srv, &src,
+                                    &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, false, src, dst);
+        qio_channel_test_validate(test);
+
+        /* close before unref, to ensure finalize copes with already closed */
+
+        qio_channel_close(src, &error_abort);
+        qio_channel_close(dst, &error_abort);
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+
+        qio_channel_close(srv, &error_abort);
+        object_unref(OBJECT(srv));
+    } else {
+        /* sync + blocking */
+
+        test_io_channel_setup_sync(listen_addr, connect_addr, &srv, &src, &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, true, src, dst);
+        qio_channel_test_validate(test);
+
+        /* unref without close, to ensure finalize() cleans up */
+
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+        object_unref(OBJECT(srv));
+
+        /* sync + non-blocking */
+
+        test_io_channel_setup_sync(listen_addr, connect_addr, &srv, &src, &dst);
+
+        g_assert(qio_channel_has_feature(src, QIO_CHANNEL_FEATURE_SHUTDOWN));
+        g_assert(qio_channel_has_feature(dst, QIO_CHANNEL_FEATURE_SHUTDOWN));
+
+        test = qio_channel_test_new();
+        qio_channel_test_run_threads(test, false, src, dst);
+        qio_channel_test_validate(test);
+
+        /* close before unref, to ensure finalize copes with already closed */
+
+        qio_channel_close(src, &error_abort);
+        qio_channel_close(dst, &error_abort);
+        object_unref(OBJECT(src));
+        object_unref(OBJECT(dst));
+
+        qio_channel_close(srv, &error_abort);
+        object_unref(OBJECT(srv));
+    }
+}
+
+static void test_io_channel_rdma(bool async)
+{
+    InetSocketAddress *listen_addr;
+    InetSocketAddress *connect_addr;
+
+    listen_addr = &l_addr->u.inet;
+    connect_addr = &l_addr->u.inet;
+
+    test_io_channel(async, listen_addr, connect_addr);
+}
+
+static void test_io_channel_rdma_sync(void)
+{
+    test_io_channel_rdma(false);
+}
+
+static void test_io_channel_rdma_async(void)
+{
+    test_io_channel_rdma(true);
+}
+
+static void test_io_channel_rdma_co(void *opaque)
+{
+    test_io_channel_rdma(true);
+}
+
+static void test_io_channel_rdma_coroutine(void)
+{
+    Coroutine *coroutine;
+
+    coroutine = qemu_coroutine_create(test_io_channel_rdma_co, NULL);
+    qemu_coroutine_enter(coroutine);
+}
+
+int main(int argc, char **argv)
+{
+    module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
+
+    if (argc != 3) {
+        fprintf(stderr, "Usage: %s listen_addr connect_addr\n", argv[0]);
+        exit(-1);
+    }
+
+    l_addr = socket_parse(argv[1], NULL);
+    c_addr = socket_parse(argv[2], NULL);
+    if (l_addr == NULL || c_addr == NULL ||
+        l_addr->type != SOCKET_ADDRESS_TYPE_INET ||
+        c_addr->type != SOCKET_ADDRESS_TYPE_INET) {
+        fprintf(stderr, "Only socket address types 'inet' is supported\n");
+        exit(-1);
+    }
+
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/io/channel/rdma/sync", test_io_channel_rdma_sync);
+    g_test_add_func("/io/channel/rdma/async", test_io_channel_rdma_async);
+    g_test_add_func("/io/channel/rdma/coroutine",
+                    test_io_channel_rdma_coroutine);
+
+    return g_test_run();
+}
-- 
2.43.0


