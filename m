Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2663939D
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 04:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKZDPC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Nov 2022 22:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiKZDPB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Nov 2022 22:15:01 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED055C83;
        Fri, 25 Nov 2022 19:15:00 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NJxbH49B5zJntj;
        Sat, 26 Nov 2022 11:11:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 11:14:58 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <bvanassche@acm.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <dennis.dalessandro@cornelisnetworks.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <bart.vanassche@wdc.com>,
        <easwar.hariharan@intel.com>, Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH v2 2/2] RDMA/srp: Fix error return code in srp_parse_options()
Date:   Sat, 26 Nov 2022 11:35:04 +0800
Message-ID: <1669433704-2254-2-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669433704-2254-1-git-send-email-wangyufen@huawei.com>
References: <1669433704-2254-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the previous while loop, "ret" may be assigned zero, , so the error
return code may be incorrectly set to 0 instead of -EINVAL.
Add out_with_einval goto label and covert all "goto out;" to "goto
out_with_einval:" where it's appropriate, alse investigate each case
separately as Andy suggessted.

Fixes: e711f968c49c ("IB/srp: replace custom implementation of hex2bin()")
Fixes: 2a174df0c602 ("IB/srp: Use kstrtoull() instead of simple_strtoull()")
Fixes: 19f313438c77 ("IB/srp: Add RDMA/CM support")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 82 +++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1075c2a..865ceb1 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3343,7 +3343,7 @@ static int srp_parse_options(struct net *net, const char *buf,
 	bool has_port;
 	int opt_mask = 0;
 	int token;
-	int ret = -EINVAL;
+	int ret;
 	int i;
 
 	options = kstrdup(buf, GFP_KERNEL);
@@ -3410,7 +3410,8 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_PKEY:
-			if (match_hex(args, &token)) {
+			ret = match_hex(args, &token);
+			if (ret) {
 				pr_warn("bad P_Key parameter '%s'\n", p);
 				goto out;
 			}
@@ -3470,7 +3471,8 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_MAX_SECT:
-			if (match_int(args, &token)) {
+			ret = match_int(args, &token);
+			if (ret) {
 				pr_warn("bad max sect parameter '%s'\n", p);
 				goto out;
 			}
@@ -3478,9 +3480,12 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_QUEUE_SIZE:
-			if (match_int(args, &token) || token < 1) {
-				pr_warn("bad queue_size parameter '%s'\n", p);
+			ret = match_int(args, &token);
+			if (ret)
 				goto out;
+			if (token < 1) {
+				pr_warn("bad queue_size parameter '%s'\n", p);
+				goto out_with_einval;
 			}
 			target->scsi_host->can_queue = token;
 			target->queue_size = token + SRP_RSP_SQ_SIZE +
@@ -3490,25 +3495,30 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_MAX_CMD_PER_LUN:
-			if (match_int(args, &token) || token < 1) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1) {
 				pr_warn("bad max cmd_per_lun parameter '%s'\n",
 					p);
-				goto out;
+				goto out_with_einval;
 			}
 			target->scsi_host->cmd_per_lun = token;
 			break;
 
 		case SRP_OPT_TARGET_CAN_QUEUE:
-			if (match_int(args, &token) || token < 1) {
+			ret = match_int(args, &token);
+			if (token < 1) {
 				pr_warn("bad max target_can_queue parameter '%s'\n",
 					p);
-				goto out;
+				goto out_with_einval;
 			}
 			target->target_can_queue = token;
 			break;
 
 		case SRP_OPT_IO_CLASS:
-			if (match_hex(args, &token)) {
+			ret = match_hex(args, &token);
+			if (ret) {
 				pr_warn("bad IO class parameter '%s'\n", p);
 				goto out;
 			}
@@ -3517,7 +3527,7 @@ static int srp_parse_options(struct net *net, const char *buf,
 				pr_warn("unknown IO class parameter value %x specified (use %x or %x).\n",
 					token, SRP_REV10_IB_IO_CLASS,
 					SRP_REV16A_IB_IO_CLASS);
-				goto out;
+				goto out_with_einval;
 			}
 			target->io_class = token;
 			break;
@@ -3539,16 +3549,20 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_CMD_SG_ENTRIES:
-			if (match_int(args, &token) || token < 1 || token > 255) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1 || token > 255) {
 				pr_warn("bad max cmd_sg_entries parameter '%s'\n",
 					p);
-				goto out;
+				goto out_with_einval;
 			}
 			target->cmd_sg_cnt = token;
 			break;
 
 		case SRP_OPT_ALLOW_EXT_SG:
-			if (match_int(args, &token)) {
+			ret = match_int(args, &token);
+			if (ret) {
 				pr_warn("bad allow_ext_sg parameter '%s'\n", p);
 				goto out;
 			}
@@ -3556,44 +3570,58 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_SG_TABLESIZE:
-			if (match_int(args, &token) || token < 1 ||
-					token > SG_MAX_SEGMENTS) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1 || token > SG_MAX_SEGMENTS) {
 				pr_warn("bad max sg_tablesize parameter '%s'\n",
 					p);
-				goto out;
+				goto out_with_einval;
 			}
 			target->sg_tablesize = token;
 			break;
 
 		case SRP_OPT_COMP_VECTOR:
-			if (match_int(args, &token) || token < 0) {
-				pr_warn("bad comp_vector parameter '%s'\n", p);
+			ret = match_int(args, &token);
+			if (ret)
 				goto out;
+			if (token < 0) {
+				pr_warn("bad comp_vector parameter '%s'\n", p);
+				goto out_with_einval;
 			}
 			target->comp_vector = token;
 			break;
 
 		case SRP_OPT_TL_RETRY_COUNT:
-			if (match_int(args, &token) || token < 2 || token > 7) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 2 || token > 7) {
 				pr_warn("bad tl_retry_count parameter '%s' (must be a number between 2 and 7)\n",
 					p);
-				goto out;
+				goto out_with_einval;
 			}
 			target->tl_retry_count = token;
 			break;
 
 		case SRP_OPT_MAX_IT_IU_SIZE:
-			if (match_int(args, &token) || token < 0) {
-				pr_warn("bad maximum initiator to target IU size '%s'\n", p);
+			ret = match_int(args, &token);
+			if (ret)
 				goto out;
+			if (token < 0) {
+				pr_warn("bad maximum initiator to target IU size '%s'\n", p);
+				goto out_with_einval;
 			}
 			target->max_it_iu_size = token;
 			break;
 
 		case SRP_OPT_CH_COUNT:
-			if (match_int(args, &token) || token < 1) {
-				pr_warn("bad channel count %s\n", p);
+			ret = match_int(args, &token);
+			if (ret)
 				goto out;
+			if (token < 1) {
+				pr_warn("bad channel count %s\n", p);
+				goto out_with_einval;
 			}
 			target->ch_count = token;
 			break;
@@ -3601,7 +3629,7 @@ static int srp_parse_options(struct net *net, const char *buf,
 		default:
 			pr_warn("unknown parameter or missing value '%s' in target creation request\n",
 				p);
-			goto out;
+			goto out_with_einval;
 		}
 	}
 
@@ -3620,6 +3648,8 @@ static int srp_parse_options(struct net *net, const char *buf,
 			target->scsi_host->cmd_per_lun,
 			target->scsi_host->can_queue);
 
+out_with_einval:
+	ret = -EINVAL;
 out:
 	kfree(options);
 	return ret;
-- 
1.8.3.1

