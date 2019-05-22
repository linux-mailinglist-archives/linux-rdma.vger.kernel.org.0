Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB68263FB
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 14:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfEVMpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 08:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfEVMpm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 May 2019 08:45:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6A246439B;
        Wed, 22 May 2019 12:45:41 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F31286198C;
        Wed, 22 May 2019 12:45:40 +0000 (UTC)
From:   Honggang Li <honli@redhat.com>
To:     haakon.bugge@oracle.com
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [rdma-core patch] ibacm: only open InfiniBand port
Date:   Wed, 22 May 2019 08:45:28 -0400
Message-Id: <20190522124528.5688-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 22 May 2019 12:45:41 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The low 64 bits of cxgb3 and cxgb4 devices' GID are zeros. If the
"provider" was set in the option file, ibacm will failed with
segment fault.

$ sed -i -e 's/# provider ibacmp 0xFE80000000000000/provider ibacmp 0xFE80000000000000/g' /etc/rdma/ibacm_opts.cfg
$ /usr/sbin/ibacm --systemd
Segmentation fault (core dumped)

acm_open_dev function should not open port for IWARP or ROCE devices.

Signed-off-by: Honggang Li <honli@redhat.com>
---
 ibacm/src/acm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
index a21069d4..944cb820 100644
--- a/ibacm/src/acm.c
+++ b/ibacm/src/acm.c
@@ -2587,7 +2587,7 @@ acm_open_port(struct acmc_port *port, struct acmc_device *dev, uint8_t port_num)
 
 	port->mad_agentid = umad_register(port->mad_portid,
 					  IB_MGMT_CLASS_SA, 1, 1, NULL);
-	if (port->mad_agentid < 0) {
+	if (port->mad_agentid < 0 && port->mad_portid > 0) {
 		umad_close_port(port->mad_portid);
 		acm_log(0, "ERROR - unable to register MAD client\n");
 	}
@@ -2600,6 +2600,7 @@ static void acm_open_dev(struct ibv_device *ibdev)
 {
 	struct acmc_device *dev;
 	struct ibv_device_attr attr;
+	struct ibv_port_attr port_attr;
 	struct ibv_context *verbs;
 	size_t size;
 	int i, ret;
@@ -2628,6 +2629,17 @@ static void acm_open_dev(struct ibv_device *ibdev)
 	list_head_init(&dev->prov_dev_context_list);
 
 	for (i = 0; i < dev->port_cnt; i++) {
+		acm_log(1, "%s %d\n", dev->device.verbs->device->name, i);
+		ret = ibv_query_port(dev->device.verbs, i+1, &port_attr);
+		if (ret) {
+			acm_log(0, "ERROR - unable to query an RDMA port's attributes\n");
+			return;
+		}
+		if (port_attr.link_layer != IBV_LINK_LAYER_INFINIBAND) {
+			acm_log(1, "not an InfiniBand port\n");
+			return;
+		}
+
 		acm_open_port(&dev->port[i], dev, i + 1);
 	}
 
-- 
2.20.1

