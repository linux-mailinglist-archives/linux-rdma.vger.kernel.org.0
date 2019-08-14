Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0248D707
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHNPPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 11:15:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHNPPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Aug 2019 11:15:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so2931121pgb.9
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2019 08:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZT2Rb5jqEnrY1TrUznGG2jQAHpa+++Zks8UdTPLFg8o=;
        b=UOBaSH8ARoLauuYM4wP71V8fGSbRzxgRmaipg8EWWMwF51HgxRXRkbK3ODtio3uf9m
         MyqZZImxPZ5/P1aeTCdv0U/3wvgJsAOC9hC/xHLIw4e+okBPS3UKD5Nk5J+XgiLkpJp2
         KcQTdU1/+o+NerMcjYQQqKTYw/aqaMELkSKvwCFZZ0V1LSbVQ5VKHhmSY5ZxWB8Ew81g
         eCRrL06VwSbNNEHWb8LPkJpOwlKkYNW8LNTxdbpwf4hODezLIoXzyr3en1MpyAfD7c9i
         r1CdcVNMypZLuYK39RZDUmRWhaCFf7Da86QsSrFMy6cd4twX8saAEcwBfw9wC5+652k/
         04YA==
X-Gm-Message-State: APjAAAUqp6nDJlqlZ8kfs3iD2DXjV2lCSlVCEcKrcwLYjOp7ZFQj990D
        Oyu8vZHDS3JjhuOKSqCLe0ef0E33
X-Google-Smtp-Source: APXvYqzXI01SRdN2fvvJoax5+lzwkzuFrejyT6OjFniMLzQdQ+k0Ypk815g+0Zk0EJ3I6ZnlVk1YPg==
X-Received: by 2002:a63:7709:: with SMTP id s9mr38178146pgc.296.1565795716512;
        Wed, 14 Aug 2019 08:15:16 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c70sm70634pfb.163.2019.08.14.08.15.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 08:15:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        oulijun <oulijun@huawei.com>
Subject: [PATCH] RDMA/srpt: Filter out AGN bits
Date:   Wed, 14 Aug 2019 08:15:07 -0700
Message-Id: <20190814151507.140572-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ib_srpt driver derives its default service GUID from the node GUID
of the first encountered HCA. Since that service GUID is passed to
ib_cm_listen(), the AGN bits must not be set. Since the AGN bits can
be set in the node GUID of RoCE HCAs, filter these bits out. This
patch avoids that loading the ib_srpt driver fails as follows for the
hns driver:

  ib_srpt srpt_add_one(hns_0) failed.

Cc: oulijun <oulijun@huawei.com>
Reported-by: oulijun <oulijun@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index e25c70a56be6..114bf8d6c82b 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
 	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
 
 	if (!srpt_service_guid)
-		srpt_service_guid = be64_to_cpu(device->node_guid);
+		srpt_service_guid = be64_to_cpu(device->node_guid) &
+			~IB_SERVICE_ID_AGN_MASK;
 
 	if (rdma_port_get_link_layer(device, 1) == IB_LINK_LAYER_INFINIBAND)
 		sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
-- 
2.23.0.rc1.153.gdeed80330f-goog

