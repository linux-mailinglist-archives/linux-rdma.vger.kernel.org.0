Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DDF5BF88E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 10:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIUIDP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Sep 2022 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIUIDO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Sep 2022 04:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F32A8689A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 01:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73B86247D
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 08:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA920C433C1;
        Wed, 21 Sep 2022 08:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663747392;
        bh=GfPafFpYZRr4UoL0L+baH6hzWG8EqcbOB0f/Eemtpjk=;
        h=From:To:Cc:Subject:Date:From;
        b=mNqBNUMiYbpvstvvi6GopvJPjN4MBaoc9gPQNf+na8vWwx0QOCfSiHQI9TQrBA2A6
         jmLd6pVOcgMQoJgj/ezwpUYlANDGPrK3GdtoMK6COpuyb1YFYQKTbWn8gp2ejIa/nY
         F/5O0+jLdkA0t66qHkf1+8API1/w4xEb4Q5KJZEM2JV+rEtjwtq7FHXWzUq2Aof35A
         K2lW7D7GPaaA6abubKZth3eFdiheIwP/1ihDQmlJdvhysg5i50cEonoQYZJLvlM9Ij
         bkFteDQRXM28m0GDXqxNBVWzb+paVKYk7UjmFDyqSiFDau+L6ioJKPOF1wUkQ4tQrM
         aHihfApPRsPeA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mikhael Goikhman <migo@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next] RDMA/srp: Support more than 255 rdma ports
Date:   Wed, 21 Sep 2022 11:03:07 +0300
Message-Id: <7d80d8844f1abb3a54170b7259f0a02be38080a6.1663747327.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mikhael Goikhman <migo@nvidia.com>

Currently ib_srp module does not support devices with more than 256
ports. Switch from u8 to u32 to fix the problem.

Fixes: 1fb7f8973f51 ("RDMA: Support more than 255 rdma ports")
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Mikhael Goikhman <migo@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 12 ++++++------
 drivers/infiniband/ulp/srp/ib_srp.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index d01102db4fd4..66ff61e54fa9 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2988,7 +2988,7 @@ static ssize_t local_ib_port_show(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sysfs_emit(buf, "%d\n", target->srp_host->port);
+	return sysfs_emit(buf, "%u\n", target->srp_host->port);
 }
 
 static DEVICE_ATTR_RO(local_ib_port);
@@ -3886,7 +3886,7 @@ static ssize_t port_show(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_host *host = container_of(dev, struct srp_host, dev);
 
-	return sysfs_emit(buf, "%d\n", host->port);
+	return sysfs_emit(buf, "%u\n", host->port);
 }
 
 static DEVICE_ATTR_RO(port);
@@ -3898,7 +3898,7 @@ static struct attribute *srp_class_attrs[] = {
 	NULL
 };
 
-static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
+static struct srp_host *srp_add_port(struct srp_device *device, u32 port)
 {
 	struct srp_host *host;
 
@@ -3915,7 +3915,7 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 	device_initialize(&host->dev);
 	host->dev.class = &srp_class;
 	host->dev.parent = device->dev->dev.parent;
-	if (dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
+	if (dev_set_name(&host->dev, "srp-%s-%u", dev_name(&device->dev->dev),
 			 port))
 		goto put_host;
 	if (device_add(&host->dev))
@@ -3937,7 +3937,7 @@ static void srp_rename_dev(struct ib_device *device, void *client_data)
 	list_for_each_entry_safe(host, tmp_host, &srp_dev->dev_list, list) {
 		char name[IB_DEVICE_NAME_MAX + 8];
 
-		snprintf(name, sizeof(name), "srp-%s-%d",
+		snprintf(name, sizeof(name), "srp-%s-%u",
 			 dev_name(&device->dev), host->port);
 		device_rename(&host->dev, name);
 	}
@@ -3949,7 +3949,7 @@ static int srp_add_one(struct ib_device *device)
 	struct ib_device_attr *attr = &device->attrs;
 	struct srp_host *host;
 	int mr_page_shift;
-	unsigned int p;
+	u32 p;
 	u64 max_pages_per_mr;
 	unsigned int flags = 0;
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 493e7fd1913e..00b0068fda20 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -120,7 +120,7 @@ struct srp_device {
  */
 struct srp_host {
 	struct srp_device      *srp_dev;
-	u8			port;
+	u32			port;
 	struct device		dev;
 	struct list_head	target_list;
 	spinlock_t		target_lock;
-- 
2.37.3

