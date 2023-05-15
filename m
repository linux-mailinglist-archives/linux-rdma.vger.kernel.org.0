Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C9703D67
	for <lists+linux-rdma@lfdr.de>; Mon, 15 May 2023 21:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjEOTMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 15:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243021AbjEOTMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 15:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037727DB2
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684177908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlLGF3e0GotZbUDAK+ZiXqGWgkcG4W/tdhm3LcD3Wv0=;
        b=QD8FCS5kRHnWWSv93wa0M0ayZzN/YJ01728mL7rQxDs+Vd2SeaeoBdxjXfn0+fGNDUbDXF
        ewoqQ+zJMLGOVgzyq4/vnwrJ4o9UyfQ1nHoDyvcjSfunQ2++e+gIA7fwLeJ2igOa1haqLS
        Fi26ah3DSuUmt78TWUAZk5wvAgspmMw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-soR4S2qIP9CUaYmKOV-pQw-1; Mon, 15 May 2023 15:11:46 -0400
X-MC-Unique: soR4S2qIP9CUaYmKOV-pQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E9093C0F199;
        Mon, 15 May 2023 19:11:46 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.32.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 177E363F3D;
        Mon, 15 May 2023 19:11:46 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH v2 3/3] RDMA/irdma: Move iw device ops initialization
Date:   Mon, 15 May 2023 15:11:42 -0400
Message-Id: <20230515191142.413633-4-kheib@redhat.com>
In-Reply-To: <20230515191142.413633-3-kheib@redhat.com>
References: <20230515191142.413633-1-kheib@redhat.com>
 <20230515191142.413633-2-kheib@redhat.com>
 <20230515191142.413633-3-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the initialization of the iw device ops to be under the declaration
of the irdma_iw_dev_ops.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9ff06feda872..6242ab6af77f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4450,8 +4450,16 @@ static const struct ib_device_ops irdma_roce_dev_ops = {
 };
 
 static const struct ib_device_ops irdma_iw_dev_ops = {
-	.modify_qp = irdma_modify_qp,
 	.get_port_immutable = irdma_iw_port_immutable,
+	.iw_accept = irdma_accept,
+	.iw_add_ref = irdma_qp_add_ref,
+	.iw_connect = irdma_connect,
+	.iw_create_listen = irdma_create_listen,
+	.iw_destroy_listen = irdma_destroy_listen,
+	.iw_get_qp = irdma_get_qp,
+	.iw_reject = irdma_reject,
+	.iw_rem_ref = irdma_qp_rem_ref,
+	.modify_qp = irdma_modify_qp,
 	.query_gid = irdma_query_gid,
 };
 
@@ -4522,14 +4530,6 @@ static void irdma_init_iw_device(struct irdma_device *iwdev)
 	iwdev->ibdev.node_type = RDMA_NODE_RNIC;
 	addrconf_addr_eui48((u8 *)&iwdev->ibdev.node_guid,
 			    netdev->dev_addr);
-	iwdev->ibdev.ops.iw_add_ref = irdma_qp_add_ref;
-	iwdev->ibdev.ops.iw_rem_ref = irdma_qp_rem_ref;
-	iwdev->ibdev.ops.iw_get_qp = irdma_get_qp;
-	iwdev->ibdev.ops.iw_connect = irdma_connect;
-	iwdev->ibdev.ops.iw_accept = irdma_accept;
-	iwdev->ibdev.ops.iw_reject = irdma_reject;
-	iwdev->ibdev.ops.iw_create_listen = irdma_create_listen;
-	iwdev->ibdev.ops.iw_destroy_listen = irdma_destroy_listen;
 	memcpy(iwdev->ibdev.iw_ifname, netdev->name,
 	       sizeof(iwdev->ibdev.iw_ifname));
 	ib_set_device_ops(&iwdev->ibdev, &irdma_iw_dev_ops);
-- 
2.40.1

