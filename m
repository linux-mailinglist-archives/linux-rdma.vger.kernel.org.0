Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAE7BF0A
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfGaLPd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 07:15:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46685 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfGaLPc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 07:15:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so69198986wru.13
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=ITf9kC4WRfh52jGugLEKyqC83N+7rMF53Ii44Ka3qTrLmRgJBrfwQZ6E1TeQWUpkJF
         k4kTpGdZ/d3DKiV/Xt9W/w5URUEHgluLjNWJwLsRKKg4llHBxGa3pgEccmRNMjFIwAAb
         KQrR41l23fRLRmDrCyXpAucxMLUh/K6rNKEoh/mYEK6JyY2t/7OmJii7oHM5wfDncUJ6
         kKS6Au5FllSqeX3vs5vfendUKXHk26GNIlOfs1i6jJ9swpxXpm+qKNTy0dYEWEbU8CrG
         XSmPBxl2g8q1QxanQHZ31eS4Adah3lP7Tn+TCP8Scf2yQsFuUqA4xgRLLOhnGsuHsJja
         sZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJ8lWXhH5FN5zVWUDgS/ZjpIZ9jEHMtpHfW5T1E6xr0=;
        b=JWWtvJTx3JOmRhnpCOVlpnJb/CmG79fmrhBaeUwZcuN73mjlAl6ftjcfecZcezwhrS
         61oQuXauG/+huNSrERN4HXDvPEkbYadiH4zuJzKqI5USoMYNHPv4ucbYLwG4N4bfXxaQ
         X6IJZhkETl716Os0erqTSwMHq2D8MrN+GKZig8hQ1IsTgJMc2p5QIaeE69FLjj9uMnWQ
         SXpupNJMofmCr11dVhGvEchSVEVlb48imkxqe4nikKiQxP9ug28pQmSjSd3a4uW0Y3lb
         y91LUwEr4iuNFh7K0U6a39Rj3/izyJM+q/xqtyQKKcrWs3r+wSeC3+rlMfp6mpoduAuL
         Fo2Q==
X-Gm-Message-State: APjAAAXowkm/l0u4epJBgl7C9dsoSGwKc18c9iJiDZqdKM6lclacZxbA
        fmJsKxXtJF7kzGLdIZLYGl4uT2E5
X-Google-Smtp-Source: APXvYqyrjRfC1vjPICJ2/cyr57kHegdB31YAN196FbY+U6+ri3ERTmBeJJqVOQnSK53kQipetEROtg==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr97061429wrm.351.1564571730074;
        Wed, 31 Jul 2019 04:15:30 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id h133sm73133732wme.28.2019.07.31.04.15.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 04:15:29 -0700 (PDT)
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
Subject: [PATCH for-next 2/4] RDMA/cxgb3: Use ib_device_set_netdev()
Date:   Wed, 31 Jul 2019 14:15:01 +0300
Message-Id: <20190731111503.8872-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731111503.8872-1-kamalheib1@gmail.com>
References: <20190731111503.8872-1-kamalheib1@gmail.com>
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

