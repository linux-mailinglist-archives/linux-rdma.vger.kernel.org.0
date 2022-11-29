Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94263B75F
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Nov 2022 02:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiK2BoW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 20:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiK2BoS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 20:44:18 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE553C6D1;
        Mon, 28 Nov 2022 17:44:17 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NLlVJ12SqzmWHj;
        Tue, 29 Nov 2022 09:43:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 09:44:14 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <bvanassche@acm.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <dennis.dalessandro@cornelisnetworks.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <bart.vanassche@wdc.com>,
        <easwar.hariharan@intel.com>, Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH v4 2/2] RDMA/srp: Fix error return code in srp_parse_options()
Date:   Tue, 29 Nov 2022 10:04:19 +0800
Message-ID: <1669687459-14180-2-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669687459-14180-1-git-send-email-wangyufen@huawei.com>
References: <1669687459-14180-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
return code may be incorrectly set to 0 instead of -EINVAL. Alse
investigate each case separately as Andy suggessted.

Fixes: e711f968c49c ("IB/srp: replace custom implementation of hex2bin()")
Fixes: 2a174df0c602 ("IB/srp: Use kstrtoull() instead of simple_strtoull()")
Fixes: 19f313438c77 ("IB/srp: Add RDMA/CM support")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 71 +++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1075c2a..692c69a 100644
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
@@ -3478,8 +3480,12 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_QUEUE_SIZE:
-			if (match_int(args, &token) || token < 1) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1) {
 				pr_warn("bad queue_size parameter '%s'\n", p);
+				ret = -EINVAL;
 				goto out;
 			}
 			target->scsi_host->can_queue = token;
@@ -3490,25 +3496,34 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_MAX_CMD_PER_LUN:
-			if (match_int(args, &token) || token < 1) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1) {
 				pr_warn("bad max cmd_per_lun parameter '%s'\n",
 					p);
+				ret = -EINVAL;
 				goto out;
 			}
 			target->scsi_host->cmd_per_lun = token;
 			break;
 
 		case SRP_OPT_TARGET_CAN_QUEUE:
-			if (match_int(args, &token) || token < 1) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1) {
 				pr_warn("bad max target_can_queue parameter '%s'\n",
 					p);
+				ret = -EINVAL;
 				goto out;
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
@@ -3517,6 +3532,7 @@ static int srp_parse_options(struct net *net, const char *buf,
 				pr_warn("unknown IO class parameter value %x specified (use %x or %x).\n",
 					token, SRP_REV10_IB_IO_CLASS,
 					SRP_REV16A_IB_IO_CLASS);
+				ret = -EINVAL;
 				goto out;
 			}
 			target->io_class = token;
@@ -3539,16 +3555,21 @@ static int srp_parse_options(struct net *net, const char *buf,
 			break;
 
 		case SRP_OPT_CMD_SG_ENTRIES:
-			if (match_int(args, &token) || token < 1 || token > 255) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1 || token > 255) {
 				pr_warn("bad max cmd_sg_entries parameter '%s'\n",
 					p);
+				ret = -EINVAL;
 				goto out;
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
@@ -3556,43 +3577,62 @@ static int srp_parse_options(struct net *net, const char *buf,
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
+				ret = -EINVAL;
 				goto out;
 			}
 			target->sg_tablesize = token;
 			break;
 
 		case SRP_OPT_COMP_VECTOR:
-			if (match_int(args, &token) || token < 0) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 0) {
 				pr_warn("bad comp_vector parameter '%s'\n", p);
+				ret = -EINVAL;
 				goto out;
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
+				ret = -EINVAL;
 				goto out;
 			}
 			target->tl_retry_count = token;
 			break;
 
 		case SRP_OPT_MAX_IT_IU_SIZE:
-			if (match_int(args, &token) || token < 0) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 0) {
 				pr_warn("bad maximum initiator to target IU size '%s'\n", p);
+				ret = -EINVAL;
 				goto out;
 			}
 			target->max_it_iu_size = token;
 			break;
 
 		case SRP_OPT_CH_COUNT:
-			if (match_int(args, &token) || token < 1) {
+			ret = match_int(args, &token);
+			if (ret)
+				goto out;
+			if (token < 1) {
 				pr_warn("bad channel count %s\n", p);
+				ret = -EINVAL;
 				goto out;
 			}
 			target->ch_count = token;
@@ -3601,6 +3641,7 @@ static int srp_parse_options(struct net *net, const char *buf,
 		default:
 			pr_warn("unknown parameter or missing value '%s' in target creation request\n",
 				p);
+			ret = -EINVAL;
 			goto out;
 		}
 	}
-- 
1.8.3.1

