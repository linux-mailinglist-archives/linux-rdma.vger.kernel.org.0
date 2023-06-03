Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0075720CAD
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jun 2023 02:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbjFCAqZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 20:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCAqY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 20:46:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E47E40
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685753182; x=1717289182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mnXhvkSu7YtUpkcwZlpIz2Nl16u/rmfY17OgK7N9U60=;
  b=Iqd/kVd+IRzqY/vPn3cA1zVPaLUAcEZgQLq6Fasidk1QU/sC/HOaFlND
   vsQTr7ZkswnVsBcBVW6H+I19YG+d8F0id0EWqf4ehyzgNOcTQknchZVUH
   cmSPvUj/oPpteVlAidtFLVRLE7cmDY0BJ7NC1WJxI47tgdKUPLs8wbP8d
   FGqaG9kqNIq3JcdzT4fcMc3JFxX8cNG7naQxO8EOLX/2FVL8HePZlYajW
   +7SeTy5m3caHiGC7VdMRpJ88BBdGRAgxa0WUToren0NbstNkU/a3kJ/ki
   vtK8PW4fFJbbOYgyk5ybM4xJAqpC0vIWgVMHQK7VU5eGCSS7GQKJMxZli
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,214,1681142400"; 
   d="scan'208";a="336831789"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2023 08:46:22 +0800
IronPort-SDR: Irbvbx1DbJUm3gapongPq6hYvZnWfRjtIk8LJ/D/bMfvCxs4u/dZMI1F6bV6UU/dN7e3CoILIa
 qRs0HBs2NvFqGyxc5jlRf9tUzGTzwXYGhFq97HwR4tOxNCJmdLjowuWvNsEQ6PiUOD1zsL1xaU
 eE3clzlXg9EObttg7bmGA64BbBx+OJM66yKHPJrZNgGIqGoTGlvEdXxakrsQzls4JVkXWsnGRm
 S1bqoBUCy7ctsAqI10AqMjC5hqmGPn4f81u8bUlC6t0IGnMlFFpINA05gm1aRLiyf4IbPveVRI
 3j8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2023 16:55:30 -0700
IronPort-SDR: G0ZCcpwbbnl16w4y5I9v3ESkhJrpI0qc46twDkhVx+q5g6JEuSaZbQzMrh0BUeQisJAMQKFhbK
 9FEzW0J7FQh/yLhRKsx1UQ2XxFFI19SyV5uIDF092as7aiXOeTGV3W0FTboyGCPH9wXUfZ8wCu
 rG0NWS0kQmOm3d60F5/5fsO0MuVCx2wq11Qz5ZRwD1oy6gHmDwOcbAWdIGeP9CpLCDoa65+TFi
 o27jSCpfIn0tVl7xm3pqEHqxKKVnkVRXE/sBCpyrYkQ5cInu1r934yzAlkcQ+y/Sl//LYj4JVq
 ZZ4=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jun 2023 17:46:21 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Date:   Sat,  3 Jun 2023 09:46:20 +0900
Message-Id: <20230603004620.906089-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
*id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler().
To prevent the destroy of id_priv, keep its reference count by calling
cma_id_get() and cma_id_put() at start and end of cma_iw_handler().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org
---
The BUG KASAN was observed with blktests at test cases nvme/030 or nvme/031,
using SIW transport [1]. To reproduce it, it is required to repeat the test
cases from 30 to 50 times on my test system.

[1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/

 drivers/infiniband/core/cma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 93a1c48d0c32..c5267d9bb184 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2477,6 +2477,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	struct sockaddr *laddr = (struct sockaddr *)&iw_event->local_addr;
 	struct sockaddr *raddr = (struct sockaddr *)&iw_event->remote_addr;
 
+	cma_id_get(id_priv);
 	mutex_lock(&id_priv->handler_mutex);
 	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		goto out;
@@ -2524,12 +2525,14 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
+		cma_id_put(id_priv);
 		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
 
 out:
 	mutex_unlock(&id_priv->handler_mutex);
+	cma_id_put(id_priv);
 	return ret;
 }
 
-- 
2.40.1

