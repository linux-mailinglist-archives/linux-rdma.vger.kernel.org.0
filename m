Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C762D432B32
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 02:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhJSA3K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Oct 2021 20:29:10 -0400
Received: from out20-37.mail.aliyun.com ([115.124.20.37]:56583 "EHLO
        out20-37.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhJSA3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Oct 2021 20:29:10 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1764493|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00316141-0.000298427-0.99654;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.LduqRbi_1634603216;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LduqRbi_1634603216)
          by smtp.aliyun-inc.com(10.147.41.121);
          Tue, 19 Oct 2021 08:26:56 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-rdma@vger.kernel.org
Cc:     selvin.xavier@broadcom.com, eddie.wai@broadcom.com,
        wangyugui@e16-tech.com
Subject: [PATCH] infiniband: change some kmalloc to kvmalloc to support CONFIG_PROVE_LOCKING=y
Date:   Tue, 19 Oct 2021 08:26:56 +0800
Message-Id: <20211019002656.17745-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When CONFIG_PROVE_LOCKING=y, one kmalloc of infiniband hit the max alloc size limitation.

WARNING: CPU: 36 PID: 8 at mm/page_alloc.c:5350 __alloc_pages+0x27e/0x3e0
 Call Trace:
  kmalloc_order+0x2a/0xb0
  kmalloc_order_trace+0x19/0xf0
  __kmalloc+0x231/0x270
  ib_setup_port_attrs+0xd8/0x870 [ib_core]
  ib_register_device+0x419/0x4e0 [ib_core]
  bnxt_re_task+0x208/0x2d0 [bnxt_re]

change this kmalloc to kvmalloc to support CONFIG_PROVE_LOCKING=y

Signed-off-by: wangyugui <wangyugui@e16-tech.com>
---
 drivers/infiniband/core/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 6146c3c1cbe5..8d709986b88c 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -757,7 +757,7 @@ static void ib_port_release(struct kobject *kobj)
 	if (port->hw_stats_data)
 		kfree(port->hw_stats_data->stats);
 	kfree(port->hw_stats_data);
-	kfree(port);
+	kvfree(port);
 }
 
 static void ib_port_gid_attr_release(struct kobject *kobj)
@@ -1189,7 +1189,7 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	struct ib_port *p;
 	int ret;
 
-	p = kzalloc(struct_size(p, attrs_list,
+	p = kvzalloc(struct_size(p, attrs_list,
 				attr->gid_tbl_len + attr->pkey_tbl_len),
 		    GFP_KERNEL);
 	if (!p)
-- 
2.32.0

