Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0A7A503B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjIRRCk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 13:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjIRRCi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 13:02:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEBC94;
        Mon, 18 Sep 2023 10:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DE8C433CC;
        Mon, 18 Sep 2023 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695043232;
        bh=ShkpHFl+RnjUu34j0dVPCyZMpLLk1xaSBrq///1jfv4=;
        h=Date:From:To:Cc:Subject:From;
        b=Bv9vTdNNfsdCaguRGpM/oEQNdxFOSrxqi3Gh7tsGNqMepcLICp1RrGGF0o0jgkzCF
         Y5+qOUUX+8PcauW0H0WaeVXGB0043zzAW2fwGIE+8BlWsG/wAOWbG1G3egTlydbBHN
         HxjIZjqwPLfFBVuV6fIX5nZ8GYFitAf0M7w1nEHegy0nTdbf2UFf5Y9Zmx6otJ2oeD
         LH3HcQpfzw2fTKRfeN65S85E1G6dFGk+HiWcaexB24UoTFXC9clYxCIrQ+bOIhHbrv
         5Mqxbuey0RjBeS+62gUUvKE4R3w6JzLW1WKs7cczxEl+j9DfK0l4F75O7efwyoyz6Z
         YmhrRIquvurVg==
Date:   Sun, 17 Sep 2023 15:21:36 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] RDMA/core: Use size_{add,sub,mul}() in calls to
 struct_size()
Message-ID: <ZQdt4NsJFwwOYxUR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` provides against potential integer
overflows is defeated. Fix this by hardening calls to `struct_size()`
with `size_add()`, `size_sub()` and `size_mul()`.

Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
Fixes: a4676388e2e2 ("RDMA/core: Simplify how the gid_attrs sysfs is created")
Fixes: e9dd5daf884c ("IB/umad: Refactor code to use cdev_device_add()")
Fixes: 324e227ea7c9 ("RDMA/device: Add ib_device_get_by_netdev()")
Fixes: 5aad26a7eac5 ("IB/core: Use struct_size() in kzalloc()")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Include changes to other files in drivers/infiniband/core/
 - Update changelog text with a more descriptive argument for the
   changes.
 - Add more `Fixes:` tags.

Changes in v2:
 - Update changelog text: remove the part about binary differences (it
   was added by mistake).
   Link: https://lore.kernel.org/linux-hardening/ZP+if342EMhModzZ@work/

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZP+g+KfsEmEBAHmk@work/

 drivers/infiniband/core/device.c   |  2 +-
 drivers/infiniband/core/sa_query.c |  4 +++-
 drivers/infiniband/core/sysfs.c    | 10 +++++-----
 drivers/infiniband/core/user_mad.c |  4 +++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..010718738d04 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -804,7 +804,7 @@ static int alloc_port_data(struct ib_device *device)
 	 * empty slots at the beginning.
 	 */
 	pdata_rcu = kzalloc(struct_size(pdata_rcu, pdata,
-					rdma_end_port(device) + 1),
+					size_add(rdma_end_port(device), 1)),
 			    GFP_KERNEL);
 	if (!pdata_rcu)
 		return -ENOMEM;
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 59179cfc20ef..8175dde60b0a 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -2159,7 +2159,9 @@ static int ib_sa_add_one(struct ib_device *device)
 	s = rdma_start_port(device);
 	e = rdma_end_port(device);
 
-	sa_dev = kzalloc(struct_size(sa_dev, port, e - s + 1), GFP_KERNEL);
+	sa_dev = kzalloc(struct_size(sa_dev, port,
+				     size_add(size_sub(e, s), 1)),
+			 GFP_KERNEL);
 	if (!sa_dev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index ee59d7391568..ec5efdc16660 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -903,7 +903,7 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
@@ -1009,7 +1009,7 @@ alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
@@ -1140,7 +1140,7 @@ static int setup_gid_attrs(struct ib_port *port,
 	int ret;
 
 	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
-					     attr->gid_tbl_len * 2),
+					     size_mul(attr->gid_tbl_len, 2)),
 				 GFP_KERNEL);
 	if (!gid_attr_group)
 		return -ENOMEM;
@@ -1205,8 +1205,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	int ret;
 
 	p = kvzalloc(struct_size(p, attrs_list,
-				attr->gid_tbl_len + attr->pkey_tbl_len),
-		    GFP_KERNEL);
+				size_add(attr->gid_tbl_len, attr->pkey_tbl_len)),
+		     GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 	p->ibdev = device;
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 7e5c33aad161..f5feca7fa9b9 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1378,7 +1378,9 @@ static int ib_umad_add_one(struct ib_device *device)
 	s = rdma_start_port(device);
 	e = rdma_end_port(device);
 
-	umad_dev = kzalloc(struct_size(umad_dev, ports, e - s + 1), GFP_KERNEL);
+	umad_dev = kzalloc(struct_size(umad_dev, ports,
+				       size_add(size_sub(e, s), 1)),
+			   GFP_KERNEL);
 	if (!umad_dev)
 		return -ENOMEM;
 
-- 
2.34.1

