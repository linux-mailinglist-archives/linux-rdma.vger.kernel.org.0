Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB20DE1ED
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 04:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfJUCKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 22:10:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34137 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJUCKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 22:10:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so7411098pfa.1
        for <linux-rdma@vger.kernel.org>; Sun, 20 Oct 2019 19:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnLq77cUzeET9qFjSSafFg8rd0sMDKKDrKhz/JXtqJs=;
        b=ICv1K2YNCfesD2FqCMuU60pItseTs/hoJTVryRBvyQlOICLrJnj8KUDLKzshKITywy
         ZMyWQG9k95tCtmWIFXGflOKja2OPfKL9Pajvc4quXF9h+uI/vCa7oAFfU7zqVgl1XFyv
         kL850lgAqypOrbJBz6tSa7Jbw+/IsDmMuq3RGffxUf5snVnxTnN1wiJpKMgBvfCiybRy
         V4BF815CprCDYyXGcUs0dNzwXfzxe2L5/SvktJkArWuEek/azBBwOf7+R8YpjT2kSXj+
         K8j41sLEvIOyZ6yksB2QJNkufvoA+hh/Dtz73AIGbrNSKaTvFfBgIKZzRq1fHBcZGP1I
         I7DA==
X-Gm-Message-State: APjAAAUnHLwcaU9mRK9tyLaMPjsFn0fH87YUprbyMWhjofyi9FUl/4H7
        q/e/XdqAua0ypueNAvfZlSo=
X-Google-Smtp-Source: APXvYqy6PRYPXwatSD2dL+IQtbDk+t9CXT6nil/m1BS63Cjp1NDrUznqtqXvehkVlWTRgopW4pikZQ==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr26119570pja.100.1571623844271;
        Sun, 20 Oct 2019 19:10:44 -0700 (PDT)
Received: from localhost.net ([2601:647:4000:ce:256c:d417:b24b:327f])
        by smtp.gmail.com with ESMTPSA id k23sm12559333pgi.49.2019.10.20.19.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 19:10:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] rdma_rxe: Increase DMA max_segment_size parameter
Date:   Sun, 20 Oct 2019 19:10:29 -0700
Message-Id: <20191021021030.1037-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021021030.1037-1-bvanassche@acm.org>
References: <20191021021030.1037-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Increase the DMA max_segment_size parameter from 64 KB to UINT_MAX.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 3 +++
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fa47bdcc7f54..2ec085b53907 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1175,6 +1175,9 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
 	dev->dev.dma_ops = &dma_virt_ops;
+	dev->dev.dma_parms = &rxe->dma_parms;
+	rxe->dma_parms = (struct device_dma_parameters)
+		{ .max_segment_size = UINT_MAX };
 	dma_coerce_mask_and_coherent(&dev->dev,
 				     dma_get_required_mask(&dev->dev));
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5c4b2239129c..95834206c80c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -384,6 +384,7 @@ struct rxe_port {
 struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
+	struct device_dma_parameters dma_parms;
 	int			max_ucontext;
 	int			max_inline_data;
 	struct mutex	usdev_lock;
-- 
2.23.0

