Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21CB6FC989
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjEIOw0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjEIOw0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 10:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009930F0
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683643901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEY72ftlX/0eK22QRHkiMePdjKQD2JTUbos9ENwZDyM=;
        b=fz7FRpsvj0RqmoiN3buVsqLrGvEMxizTfUOLoi7AQv8NQl+z+44+X6QZcyb4iDGNR+W99L
        3g/peukeHEvys8GKW99pEUBn6i1tj/o+cVk8BuVxeX0zETUJICzgaP7geuFvIAqyJba9/E
        wilcc0dp3CPPKKReiftaPx8pdenbhL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-ByhJ1Y1cPmCeJ0jRZkmvjg-1; Tue, 09 May 2023 10:51:37 -0400
X-MC-Unique: ByhJ1Y1cPmCeJ0jRZkmvjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1572C18ABFA2;
        Tue,  9 May 2023 14:51:35 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.33.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7AD840C6E6A;
        Tue,  9 May 2023 14:51:34 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH 3/3] RDMA/iRDMA: Move iw device ops initialization
Date:   Tue,  9 May 2023 10:51:27 -0400
Message-Id: <20230509145127.33734-4-kheib@redhat.com>
In-Reply-To: <20230509145127.33734-3-kheib@redhat.com>
References: <20230509145127.33734-1-kheib@redhat.com>
 <20230509145127.33734-2-kheib@redhat.com>
 <20230509145127.33734-3-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
index 771f3abbed63..7f5dd0edd072 100644
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

