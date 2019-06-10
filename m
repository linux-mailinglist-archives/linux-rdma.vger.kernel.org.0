Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE03B68A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 15:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbfFJNzx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 09:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389373AbfFJNzx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 09:55:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AE67309B146;
        Mon, 10 Jun 2019 13:55:48 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7637760A9F;
        Mon, 10 Jun 2019 13:55:46 +0000 (UTC)
From:   Honggang Li <honli@redhat.com>
To:     haakon.bugge@oracle.com
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [rdma-core ibacm v2] ibacm: only open InfiniBand port
Date:   Mon, 10 Jun 2019 09:55:27 -0400
Message-Id: <20190610135527.2638-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 10 Jun 2019 13:55:53 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The low 64 bits of cxgb3 and cxgb4 devices' GID are zeros. If the
"provider" was set in the option file, ibacm will fail with
segment fault.

$ sed -i -e 's/# provider ibacmp 0xFE80000000000000/provider ibacmp 0xFE80000000000000/g' /etc/rdma/ibacm_opts.cfg
$ /usr/sbin/ibacm --systemd
Segmentation fault (core dumped)
$ gdb /usr/sbin/ibacm core.ibacm
(gdb) bt
0  0x00005625a4809217 in acm_assign_provider (port=0x5625a4bc6f28) at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2285
1  acm_port_up (port=0x5625a4bc6f28) at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2372
2  0x00005625a48073d2 in acm_activate_devices () at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:2564
3  main (argc=<optimized out>, argv=<optimized out>) at /usr/src/debug/rdma-core-25.0-1.el8.x86_64/ibacm/src/acm.c:3270

Note: The rpm was built with tarball generated from upstream repo. The last
commit is aa41a65ec86bdb9c1c86e57885ee588b39558238.

acm_open_dev function should not open an umad port for iWARP or RoCE devices.
Signed-off-by: Honggang Li <honli@redhat.com>
---
 ibacm/src/acm.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
index a21069d4..5c8a5d3c 100644
--- a/ibacm/src/acm.c
+++ b/ibacm/src/acm.c
@@ -2600,9 +2600,11 @@ static void acm_open_dev(struct ibv_device *ibdev)
 {
 	struct acmc_device *dev;
 	struct ibv_device_attr attr;
+	struct ibv_port_attr port_attr;
 	struct ibv_context *verbs;
 	size_t size;
 	int i, ret;
+	unsigned int opened_ib_port_cnt = 0;
 
 	acm_log(1, "%s\n", ibdev->name);
 	verbs = ibv_open_device(ibdev);
@@ -2628,13 +2630,29 @@ static void acm_open_dev(struct ibv_device *ibdev)
 	list_head_init(&dev->prov_dev_context_list);
 
 	for (i = 0; i < dev->port_cnt; i++) {
+		acm_log(1, "%s port %d\n", ibdev->name, i + 1);
+		ret = ibv_query_port(dev->device.verbs, i + 1, &port_attr);
+		if (ret) {
+			acm_log(0, "ERROR - ibv_query_port failed\n");
+			continue;
+		}
+		if (port_attr.link_layer != IBV_LINK_LAYER_INFINIBAND) {
+			acm_log(1, "not an InfiniBand port\n");
+			continue;
+		}
+
 		acm_open_port(&dev->port[i], dev, i + 1);
+		opened_ib_port_cnt++;
 	}
 
-	list_add(&dev_list, &dev->entry);
-
-	acm_log(1, "%s opened\n", ibdev->name);
-	return;
+	if (opened_ib_port_cnt > 0) {
+		list_add(&dev_list, &dev->entry);
+		acm_log(1, "%d InfiniBand %s opened for %s\n",
+				opened_ib_port_cnt,
+				opened_ib_port_cnt == 1 ? "port":"ports",
+				ibdev->name);
+		return;
+	}
 
 err1:
 	ibv_close_device(verbs);
-- 
2.20.1

