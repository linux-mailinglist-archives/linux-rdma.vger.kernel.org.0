Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29826B45FA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 05:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfIQDYf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 23:24:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46905 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfIQDYf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 23:24:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCE8318CB8E6;
        Tue, 17 Sep 2019 03:24:34 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11ACB5D9DC;
        Tue, 17 Sep 2019 03:24:32 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [patch v2 2/2] RDMA/SRP: calculate max_it_iu_size if remote max_it_iu length available
Date:   Tue, 17 Sep 2019 11:24:21 +0800
Message-Id: <20190917032421.13000-2-honli@redhat.com>
In-Reply-To: <20190917032421.13000-1-honli@redhat.com>
References: <20190917032421.13000-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Tue, 17 Sep 2019 03:24:34 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

The default maximum immediate size is too big for old srp clients,
which without immediate data support.

According to the SRP and SRP-2 specifications, the IOControllerProfile
attributes for SRP target ports contains the maximum initiator to target
iu length.

The maximum initiator to target iu length can be get from the subnet
manager, such as opensm and opafm. We should calculate the
max_it_iu_size instead of the default value, when remote maximum
initiator to target iu length available.

Signed-off-by: Honggang Li <honli@redhat.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2eadb038b257..d8dee5900c08 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -76,6 +76,7 @@ static bool register_always = true;
 static bool never_register;
 static int topspin_workarounds = 1;
 static uint32_t srp_opt_max_it_iu_size;
+static unsigned int srp_max_imm_data;
 
 module_param(srp_sg_tablesize, uint, 0444);
 MODULE_PARM_DESC(srp_sg_tablesize, "Deprecated name for cmd_sg_entries");
@@ -138,9 +139,9 @@ module_param_named(use_imm_data, srp_use_imm_data, bool, 0644);
 MODULE_PARM_DESC(use_imm_data,
 		 "Whether or not to request permission to use immediate data during SRP login.");
 
-static unsigned int srp_max_imm_data = 8 * 1024;
-module_param_named(max_imm_data, srp_max_imm_data, uint, 0644);
-MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size.");
+static unsigned int srp_default_max_imm_data = 8 * 1024;
+module_param_named(max_imm_data, srp_default_max_imm_data, uint, 0644);
+MODULE_PARM_DESC(max_imm_data, "Default maximum immediate data size.");
 
 static unsigned ch_count;
 module_param(ch_count, uint, 0444);
@@ -1369,9 +1370,19 @@ static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
 		sizeof(struct srp_indirect_buf) +
 		cmd_sg_cnt * sizeof(struct srp_direct_buf);
 
-	if (use_imm_data)
-		max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
-				 srp_max_imm_data);
+	if (use_imm_data) {
+		if (srp_opt_max_it_iu_size == 0) {
+			srp_max_imm_data = srp_default_max_imm_data;
+			max_iu_len = max(max_iu_len,
+			   SRP_IMM_DATA_OFFSET + srp_max_imm_data);
+		} else {
+			srp_max_imm_data =
+			   srp_opt_max_it_iu_size - SRP_IMM_DATA_OFFSET;
+			max_iu_len = srp_opt_max_it_iu_size;
+		}
+		pr_debug("srp_max_imm_data = %d, max_iu_len = %d\n",
+			srp_max_imm_data, max_iu_len);
+	}
 
 	return max_iu_len;
 }
@@ -3829,6 +3840,8 @@ static ssize_t srp_create_target(struct device *dev,
 	if (ret < 0)
 		goto put;
 
+	srp_opt_max_it_iu_size = 0;
+
 	ret = srp_parse_options(target->net, buf, target);
 	if (ret)
 		goto out;
-- 
2.21.0

