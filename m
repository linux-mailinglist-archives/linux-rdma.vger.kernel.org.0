Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA5418F1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 01:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405312AbfFKXde (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 19:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405243AbfFKXde (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 19:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81361C18B2C6;
        Tue, 11 Jun 2019 23:33:34 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E46D65D705;
        Tue, 11 Jun 2019 23:33:33 +0000 (UTC)
From:   Honggang Li <honli@redhat.com>
To:     haakon.bugge@oracle.com
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [rdma-core ibacm v3] ibacm: only open InfiniBand port
Date:   Tue, 11 Jun 2019 19:33:25 -0400
Message-Id: <20190611233325.3141-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 11 Jun 2019 23:33:34 +0000 (UTC)
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

acm_open_dev function should not open a umad port for iWARP or RoCE devices.
Signed-off-by: Honggang Li <honli@redhat.com>
---
 ibacm/src/acm.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
index a21069d4..ad313075 100644
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
+			acm_log(0, "ERROR - ibv_query_port (%d)\n", ret);
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
+	if (opened_ib_port_cnt) {
+		list_add(&dev_list, &dev->entry);
+		acm_log(1, "%d InfiniBand %s opened for %s\n",
+				opened_ib_port_cnt,
+				opened_ib_port_cnt == 1 ? "port" : "ports",
+				ibdev->name);
+		return;
+	}
 
 err1:
 	ibv_close_device(verbs);
-- 
2.20.1

