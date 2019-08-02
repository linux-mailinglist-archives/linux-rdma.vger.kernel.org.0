Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3387F47A
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 12:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391205AbfHBJc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 05:32:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33954 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390070AbfHBJc2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Aug 2019 05:32:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so76489159wrm.1
        for <linux-rdma@vger.kernel.org>; Fri, 02 Aug 2019 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=Xh2ktqsov2z+HB0X+tUdclgaeNWHaIDnZllV9d1Qyezj3UMQr+RAlxai6X4/Zg1MNp
         Aug+tHfernHsVeQAc1NFVBJwaw16FEVu9Rx7zpRQzTvkwNKySDIgUhhzYrH0borZdP9o
         hurc5FLLRlaQWkABJ1pd6OFr2kIqRrCbTTS6OmsPqjCLYryWF3LBX+BxUZ04b28CnSsq
         Ut2ABFC9rm9BGSMx0RXESRf2qmFLM7kumykLSkEsrXNuJuJuEXLM2renmlryHICHIz9x
         8WbchBfkHmv4KTvgysHdLw8xfLRuc/jCaxuhs/a2vGsioYFP/+fmbxvhTKLGxxIA1C5D
         lA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=BQrhudqZiuMEO2Ldo/JdkZ6SQhpNSahUye8Gre+PCr0POtQbllp3GKmUfum0vS03np
         eYk+f8hQn0wD6/S3/bUeY1OD3HHbZoOeOgS2FMtot56Cs1hdl72nxY3tYb4bfg5kqBHv
         wM5AG/sGoYFio1J21efgO0Vb9U/V2bNQh7nT2Xky21tTOECNG2cgZ5cdlKxFAhRYcX0L
         EiUvQcxLHILWC/RqBrtJyR0g+z2CTIPZMJhQhnFYWqixhDYhgQzgofQTOLfeK1FhJk1s
         nQanqiakhFQveM1HoJIUmzaj4PMR03a3m2JKeNz71gJ8WtyLrSjHiWEbrb2NACpRd0W9
         XDqw==
X-Gm-Message-State: APjAAAVr3j2RweMNt37M9P2XpNgnW4RKJKvXc8AmcYeuOj8luho7cREB
        ZwgGqFlvyswnHJHJacKZiQCAMXs2
X-Google-Smtp-Source: APXvYqwA3R1wysmtUEiIirTn2MgXHm8u+B/IJxesa0Z3b4/EVRFJLiXnS1QK09vv1hRaJFUAHJEvMg==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr17527753wrk.98.1564738346956;
        Fri, 02 Aug 2019 02:32:26 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id w23sm80651404wmi.45.2019.08.02.02.32.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:32:26 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V3 2/4] RDMA/cxgb3: Use ib_device_set_netdev()
Date:   Fri,  2 Aug 2019 12:32:08 +0300
Message-Id: <20190802093210.5705-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802093210.5705-1-kamalheib1@gmail.com>
References: <20190802093210.5705-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This change is required to associate the cxgb3 ib_dev with the
underlying net_device, so in the upcoming patch we can call
ib_device_get_netdev().

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index e775c1a1a450..5848e4727b2e 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1273,8 +1273,24 @@ static const struct ib_device_ops iwch_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, iwch_ucontext, ibucontext),
 };
 
+static int set_netdevs(struct ib_device *ib_dev, struct cxio_rdev *rdev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < rdev->port_info.nports; i++) {
+		ret = ib_device_set_netdev(ib_dev, rdev->port_info.lldevs[i],
+					   i + 1);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int iwch_register_device(struct iwch_dev *dev)
 {
+	int err;
+
 	pr_debug("%s iwch_dev %p\n", __func__, dev);
 	memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
 	memcpy(&dev->ibdev.node_guid, dev->rdev.t3cdev_p->lldev->dev_addr, 6);
@@ -1315,6 +1331,10 @@ int iwch_register_device(struct iwch_dev *dev)
 
 	rdma_set_device_sysfs_group(&dev->ibdev, &iwch_attr_group);
 	ib_set_device_ops(&dev->ibdev, &iwch_dev_ops);
+	err = set_netdevs(&dev->ibdev, &dev->rdev);
+	if (err)
+		return err;
+
 	return ib_register_device(&dev->ibdev, "cxgb3_%d");
 }
 
-- 
2.20.1

