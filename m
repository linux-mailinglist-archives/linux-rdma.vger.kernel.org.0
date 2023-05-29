Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA978714D3D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE2PlC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjE2PlB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 11:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227179C
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685374810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RjIXtoGGMuPapDVretDHgEF+TSGR7979KIVqJsY7Ta0=;
        b=ELAzfUNV2Il3b188iFgqzjOyPRUorCErwmReGWf7bWf3Cb5QP1+KFjSeKGcx5/0TVq1Cox
        +WkWAglixRUg6+hjVSC3zprUXch1Jm69GSi1kn329VvujDn9BM3uitMbPK/DdsBb+g52yV
        +SOXDH3NjsaAKG3pgtUoiK4zcysLroA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221--_e8JlwzOr2IS3l4FgbGLA-1; Mon, 29 May 2023 11:40:05 -0400
X-MC-Unique: -_e8JlwzOr2IS3l4FgbGLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01DBE85A5A8;
        Mon, 29 May 2023 15:40:05 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F3FC3543C;
        Mon, 29 May 2023 15:40:04 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH for-rc] RDMA/bnxt_re: Fix reporting active_{speed,width} attributes
Date:   Mon, 29 May 2023 11:35:26 -0400
Message-Id: <20230529153525.87254-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After commit 6d758147c7b8 ("RDMA/bnxt_re: Use auxiliary driver interface")
the active_{speed, width} attributes are reported incorrectly, This is
happening because ib_get_eth_speed() is called only once from
bnxt_re_ib_init() - Fix this issue by calling ib_get_eth_speed() from
bnxt_re_query_port().

Fixes: 6d758147c7b8 ("RDMA/bnxt_re: Use auxiliary driver interface")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 2 --
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++++---
 drivers/infiniband/hw/bnxt_re/main.c     | 2 --
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 5a2baf49ecaa..2c95e6f3d47a 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -135,8 +135,6 @@ struct bnxt_re_dev {
 
 	struct delayed_work		worker;
 	u8				cur_prio_map;
-	u16				active_speed;
-	u8				active_width;
 
 	/* FP Notification Queue (CQ & SRQ) */
 	struct tasklet_struct		nq_task;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e86afecfbe46..8967e9aed14d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -199,6 +199,7 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	int rc;
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
@@ -228,10 +229,10 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 	port_attr->sm_sl = 0;
 	port_attr->subnet_timeout = 0;
 	port_attr->init_type_reply = 0;
-	port_attr->active_speed = rdev->active_speed;
-	port_attr->active_width = rdev->active_width;
+	rc = ib_get_eth_speed(&rdev->ibdev, port_num, &port_attr->active_speed,
+			      &port_attr->active_width);
 
-	return 0;
+	return rc;
 }
 
 int bnxt_re_get_port_immutable(struct ib_device *ibdev, u32 port_num,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b9e2f89337e8..dff50c152477 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1077,8 +1077,6 @@ static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 		return rc;
 	}
 	dev_info(rdev_to_dev(rdev), "Device registered with IB successfully");
-	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
-			 &rdev->active_width);
 	set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
 
 	event = netif_running(rdev->netdev) && netif_carrier_ok(rdev->netdev) ?
-- 
2.40.1

