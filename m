Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740278498D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfHGKbz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:31:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53677 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfHGKby (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 06:31:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so2163877wmp.3
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=T3eZLtkU1+Cqk/BEYdDMt88lFoUuMnz7Ao4Rwzb2BxBtGrxRXPprfZIsC+sI2tUbDQ
         FYkmKLUJh03mOGe+9QvH07WfiMSl0QGi4dc/FaVSihVN5BdU1FKxD2ga+ahKbH7eIUxg
         TASOzzirDx5/xbMLRFEb0s3TlD0qpTyScyEsk1VtxIoCZL88ZvVxyjBB4qxXG+vWmAGM
         gKhoKLiOl9GO8TVO3Bc02g4ZRxeyAmI+E4rsYo45SNvbdRGvSufmOp5r9lwpLZDGacFO
         9AL5KsOKuHT2fnvClV6IuYrqOK3YtrRXHxhyxHD2+pzQweBeh5xcwmQfPeOK1QSuzZia
         JFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=uYtX6pPVo96THFGvJDQNaOVEsr09eh/RMXdkuVLHosxyBXFHl/UqWkKgMAGYJWH8Zd
         Ic4siZJysL/3EORWrOhS/XFBtxVEQdl0rVHVUJMvC2e7KB17dLEguDBP6/ss+rKQJKLQ
         D5lW0Wg1vpMS4fCNAGEVbMOHouN+mnkILzsBd+knqc8j3GZFqwlLgGnd1Xm06ufno8kw
         cqI83uEW4dFIxRq8/nAXY7qo82u1HHqLZ7la6Itab5SK2eZHor18WTlrdYa/qSFUmuWY
         DSu6WkwfPZ2nBGciLJLXOCgGcZTF7Z81Bhw/qAIdwJ5BuvR1G+1rqAh8R1iWvi/lCnux
         vczw==
X-Gm-Message-State: APjAAAXAbPGBM4EhHLDd6AmDE3R9lBiioFWTWetESp2zpGyvKh5urQbH
        LievjguEMYaZE1olapL6ifTP/rxhy00=
X-Google-Smtp-Source: APXvYqwdeGvAdJws02jHkMr9j5IvLttIGt7aaw0Sl8pGdXtvo420bidgDH0s8wzrUr53qwW3S1lg7w==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr10265238wme.93.1565173912228;
        Wed, 07 Aug 2019 03:31:52 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-66-104-187.red.bezeqint.net. [109.66.104.187])
        by smtp.gmail.com with ESMTPSA id o3sm79713845wrs.59.2019.08.07.03.31.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:31:51 -0700 (PDT)
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
Subject: [PATCH for-next V4 2/4] RDMA/cxgb3: Use ib_device_set_netdev()
Date:   Wed,  7 Aug 2019 13:31:36 +0300
Message-Id: <20190807103138.17219-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807103138.17219-1-kamalheib1@gmail.com>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
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

