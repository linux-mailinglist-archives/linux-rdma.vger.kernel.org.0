Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1B6FC98A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 16:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjEIOw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 10:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbjEIOw1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 10:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD73A85
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683643902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6m8f4/FeIsC3ejHzhZF9/7Cy8cbzPz9q/41O/gjIsk=;
        b=O5Yg/MvDU1m9GtXc6KNAlI8bGM+tK84x1JB5fRKu/01aDav94f1FKjHWH1IPj4LhtBQSt0
        4/OWjdjLCUOHmejYtbN4FsW7t04jlCTEgnQDXZNfEx/GCjLJTlLnYfLAKzt2I7dNebrhZl
        RnMiq9gPUJocwX5n5kcGziZ0TuKf3VI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-_kIH7e2YNcawNfjAHNzvtg-1; Tue, 09 May 2023 10:51:40 -0400
X-MC-Unique: _kIH7e2YNcawNfjAHNzvtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13AAC871BD4;
        Tue,  9 May 2023 14:51:34 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.33.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A337340C6E67;
        Tue,  9 May 2023 14:51:33 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH 1/3] RDMA/iRDMA: Return void from irdma_init_iw_device()
Date:   Tue,  9 May 2023 10:51:25 -0400
Message-Id: <20230509145127.33734-2-kheib@redhat.com>
In-Reply-To: <20230509145127.33734-1-kheib@redhat.com>
References: <20230509145127.33734-1-kheib@redhat.com>
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

The return value from irdma_init_iw_device() is always 0 - change it to be
void.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index ab5cdf782785..b405cc961187 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4515,7 +4515,7 @@ static void irdma_init_roce_device(struct irdma_device *iwdev)
  * irdma_init_iw_device - initialization of iwarp rdma device
  * @iwdev: irdma device
  */
-static int irdma_init_iw_device(struct irdma_device *iwdev)
+static void irdma_init_iw_device(struct irdma_device *iwdev)
 {
 	struct net_device *netdev = iwdev->netdev;
 
@@ -4533,8 +4533,6 @@ static int irdma_init_iw_device(struct irdma_device *iwdev)
 	memcpy(iwdev->ibdev.iw_ifname, netdev->name,
 	       sizeof(iwdev->ibdev.iw_ifname));
 	ib_set_device_ops(&iwdev->ibdev, &irdma_iw_dev_ops);
-
-	return 0;
 }
 
 /**
@@ -4544,14 +4542,11 @@ static int irdma_init_iw_device(struct irdma_device *iwdev)
 static int irdma_init_rdma_device(struct irdma_device *iwdev)
 {
 	struct pci_dev *pcidev = iwdev->rf->pcidev;
-	int ret;
 
 	if (iwdev->roce_mode) {
 		irdma_init_roce_device(iwdev);
 	} else {
-		ret = irdma_init_iw_device(iwdev);
-		if (ret)
-			return ret;
+		irdma_init_iw_device(iwdev);
 	}
 	iwdev->ibdev.phys_port_cnt = 1;
 	iwdev->ibdev.num_comp_vectors = iwdev->rf->ceqs_count;
-- 
2.40.1

