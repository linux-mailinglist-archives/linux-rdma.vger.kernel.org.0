Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D17CE36
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 22:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfGaUZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 16:25:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36899 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbfGaUZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 16:25:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so45984855wrr.4
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=RbD5NK9ux4si+za+9Iw6iGmDVyCwG+yaLug0C6tHmDxXA7SIUv7EcEVbnaUecJRUrL
         NgPaz2jw2BC9hTK3jDJNaND4W0/sNh2Gd05FHxo8LWzVehYz1lZHX7lwwnyZJzKfT7NH
         k/z+v7lhxcgOJwLZHo+DA3YuIFzDQWCX+gVQK4Ceto5sskkQ1XA5qAlhtLZngOonAAIy
         pYOIw42rqHN9i2YkSc6gELryZhQRUXJlT/u03Jv06QWT4wpDwXtwrcmZjlQMUwjWrSFn
         CS3mwm4kadTu/QtBqRDQXLzauLpOKsS2O8xiTakKB4LkiHY+Ojxg8gbivflTO/Nl6E3H
         oS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=Sf/Ur7sDJvhVMEmP1smtaGzagWL0RcKvYtGqgw8Evk88CvA6tASohoQ/peEPf61L8Z
         +jLAatJ+rml8wgXYlDMXpos4dz4I6QZoBY1jOxKHKiCa7t3+WXrpl1tQWH0+4jx9xFtv
         o+g/oW0eL1ctTrD96W7hUK0G/xnIoScA6TfAxBnkyfsThP741p3dSjCqs9NaZm+ptCV3
         2Kdi9d0V8ConjVjDS/YkAsDz2mbLrMfs1abTsSbNM3FRpPx91uyrGL0f+25HmOALBRV9
         uLHIz8cu4IzvhrB2hldDnehtkE8CXN3Usr1SQaIZiyuZfBgAbO1vPiG8d0IEFxnS8f1B
         DC9Q==
X-Gm-Message-State: APjAAAUzItZSfDNY/0zQJ6qcVZRWZjBkiZhcbz/GbIeRde4F8zxHaU3N
        GRHgK9TuDvPIQbiJWPJbaTv1MQ02
X-Google-Smtp-Source: APXvYqwWhr9g2IexTVGsW63oDLse8moQuMz50nUOuw2XhPaTneKy68FqN/PsB8nscOPN//9rfnEEww==
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr56170098wrx.208.1564604714092;
        Wed, 31 Jul 2019 13:25:14 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id c4sm54496930wrt.86.2019.07.31.13.25.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 13:25:13 -0700 (PDT)
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
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V2 2/4] RDMA/cxgb3: Use ib_device_set_netdev()
Date:   Wed, 31 Jul 2019 23:24:57 +0300
Message-Id: <20190731202459.19570-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731202459.19570-1-kamalheib1@gmail.com>
References: <20190731202459.19570-1-kamalheib1@gmail.com>
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

