Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819C703D65
	for <lists+linux-rdma@lfdr.de>; Mon, 15 May 2023 21:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbjEOTMj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242888AbjEOTMh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 15:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED407DB6
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684177908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OTwGXxvHoIMoQHTgOK3slEEMClcgTfHIk3t6jmuzdk=;
        b=CxB/BR6XLwGbDT4Q5qrIKZ7BvBvul5hxSqVEi3xhW8+R7cHPQd/ZiHtKo4A07TsSPo80Dn
        Bu3bFlcy8WsyE5kxpRYXSJtKgsGFsvhvhYTlXRRHzH7lNqJiysNKWWU+Wsi2/e+68d5zqc
        hLQ7zc5q6xP7bIwo3qvYEv/2eRpOo7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-7TACaditOLyeBc-PqSRJJg-1; Mon, 15 May 2023 15:11:46 -0400
X-MC-Unique: 7TACaditOLyeBc-PqSRJJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0EB685C06D;
        Mon, 15 May 2023 19:11:45 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.32.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8707635453;
        Mon, 15 May 2023 19:11:45 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH v2 2/3] RDMA/irdma: Return void from irdma_init_rdma_device()
Date:   Mon, 15 May 2023 15:11:41 -0400
Message-Id: <20230515191142.413633-3-kheib@redhat.com>
In-Reply-To: <20230515191142.413633-2-kheib@redhat.com>
References: <20230515191142.413633-1-kheib@redhat.com>
 <20230515191142.413633-2-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
index baaef6ce195c..9ff06feda872 100644
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

