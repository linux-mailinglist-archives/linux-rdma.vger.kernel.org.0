Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF51F79C367
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 04:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbjILC5S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 22:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240895AbjILC5J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 22:57:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C62110ADC;
        Mon, 11 Sep 2023 19:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29624C116A8;
        Mon, 11 Sep 2023 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694474432;
        bh=l1cAuCAFNIz6Fl5qFBOVmXB/EWQK3m8dwpuLOKjgIEI=;
        h=Date:From:To:Cc:Subject:From;
        b=aa3DyupXG32KVn0mp2BehxxtZGA8gqdDxOWHLZNORvS4j0w9CEsBrRhf83s2XJah8
         iKdbsKWj6T4eGKCMiSCVFZCvwLbXiuIxShnus0WM+gPHKRK48O3oRu3PCpnAAhVO63
         9G2lTXDg5gyQO8JxT6dVDmQzqeskbcCVQK4Ir92FKTJt50tcuOVb1uHk8LvEhSfI2+
         S2FBJKHUgMvoL7CdL1j4hq3Jayy1sZfGBOwhqWxtRoHL06UgIu1eHguKS5StEIUwV0
         QCbYtF9aPa0nKBQUd602HTJ5UsJ6O+N+ClncpSc3XdxFBXGMpbYr7EuD0G9A3go+Ct
         YvfyqBPrjTXRg==
Date:   Mon, 11 Sep 2023 17:21:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] RDMA/core: Use size_{add,mul}() in calls to
 struct_size()
Message-ID: <ZP+g+KfsEmEBAHmk@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Harden calls to struct_size() with size_add() and size_mul().

This results in no differences in binary output.

Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
Fixes: a4676388e2e2 ("RDMA/core: Simplify how the gid_attrs sysfs is created")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/core/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
-- 
2.34.1

