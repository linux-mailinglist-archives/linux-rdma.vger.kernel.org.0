Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624D96FC98B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjEIOwb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjEIOwa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 10:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D935BC
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683643900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrThUzG88gic+eopX3B40n+I0Q9HC+C08x3d8PrWGPE=;
        b=KbO4h+y36nWt23scIbNB9VJDYz4H2IPb53OTJtT01GhnVtEOPLBO4zSBIkkh6JIebyvVnv
        TJvrX3ImtK/7EDYUA5lorJWqvNDBPQ3IFhoGatxDb+2RuAa7NQMWzr+g86O4Aye9PxP6B1
        c3batZeagooa7nkhOu77flislpUFlNQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-xiKlFGPTPXaEM4y0wrh2ww-1; Tue, 09 May 2023 10:51:36 -0400
X-MC-Unique: xiKlFGPTPXaEM4y0wrh2ww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F3B5381551B;
        Tue,  9 May 2023 14:51:34 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.33.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AA7D40C6E6A;
        Tue,  9 May 2023 14:51:34 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH 2/3] RDMA/iRDMA: Return void from irdma_init_rdma_device()
Date:   Tue,  9 May 2023 10:51:26 -0400
Message-Id: <20230509145127.33734-3-kheib@redhat.com>
In-Reply-To: <20230509145127.33734-2-kheib@redhat.com>
References: <20230509145127.33734-1-kheib@redhat.com>
 <20230509145127.33734-2-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value from irdma_init_rdma_device() is always 0 - change it to
be void.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b405cc961187..771f3abbed63 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4539,7 +4539,7 @@ static void irdma_init_iw_device(struct irdma_device *iwdev)
  * irdma_init_rdma_device - initialization of rdma device
  * @iwdev: irdma device
  */
-static int irdma_init_rdma_device(struct irdma_device *iwdev)
+static void irdma_init_rdma_device(struct irdma_device *iwdev)
 {
 	struct pci_dev *pcidev = iwdev->rf->pcidev;
 
@@ -4552,8 +4552,6 @@ static int irdma_init_rdma_device(struct irdma_device *iwdev)
 	iwdev->ibdev.num_comp_vectors = iwdev->rf->ceqs_count;
 	iwdev->ibdev.dev.parent = &pcidev->dev;
 	ib_set_device_ops(&iwdev->ibdev, &irdma_dev_ops);
-
-	return 0;
 }
 
 /**
@@ -4591,9 +4589,7 @@ int irdma_ib_register_device(struct irdma_device *iwdev)
 {
 	int ret;
 
-	ret = irdma_init_rdma_device(iwdev);
-	if (ret)
-		return ret;
+	irdma_init_rdma_device(iwdev);
 
 	ret = ib_device_set_netdev(&iwdev->ibdev, iwdev->netdev, 1);
 	if (ret)
-- 
2.40.1

