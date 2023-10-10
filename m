Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B807BF50A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 09:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442662AbjJJH6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 03:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442653AbjJJH6j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 03:58:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0229F;
        Tue, 10 Oct 2023 00:58:38 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4Sq34TDvzNnxh;
        Tue, 10 Oct 2023 15:54:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 15:58:34 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 iproute2-next 2/2] rdma: Add support to dump SRQ resource in raw format
Date:   Tue, 10 Oct 2023 15:55:26 +0800
Message-ID: <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: wenglianfa <wenglianfa@huawei.com>

Add support to dump SRQ resource in raw format.

This patch relies on the corresponding kernel commit aebf8145e11a
("RDMA/core: Add support to dump SRQ resource in RAW format")

Example:
$ rdma res show srq -r
dev hns3 149000...

$ rdma res show srq -j -r
[{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
---
 rdma/res-srq.c | 20 ++++++++++++++++++--
 rdma/res.h     |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/rdma/res-srq.c b/rdma/res-srq.c
index 186ae281..cf9209d7 100644
--- a/rdma/res-srq.c
+++ b/rdma/res-srq.c
@@ -162,6 +162,20 @@ out:
 	return -EINVAL;
 }
 
+static int res_srq_line_raw(struct rd *rd, const char *name, int idx,
+			    struct nlattr **nla_line)
+{
+	if (!nla_line[RDMA_NLDEV_ATTR_RES_RAW])
+		return MNL_CB_ERROR;
+
+	open_json_object(NULL);
+	print_dev(rd, idx, name);
+	print_raw_data(rd, nla_line);
+	newline(rd);
+
+	return MNL_CB_OK;
+}
+
 static int res_srq_line(struct rd *rd, const char *name, int idx,
 			struct nlattr **nla_line)
 {
@@ -248,7 +262,8 @@ int res_srq_idx_parse_cb(const struct nlmsghdr *nlh, void *data)
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
 	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
 
-	return res_srq_line(rd, name, idx, tb);
+	return (rd->show_raw) ? res_srq_line_raw(rd, name, idx, tb) :
+		res_srq_line(rd, name, idx, tb);
 }
 
 int res_srq_parse_cb(const struct nlmsghdr *nlh, void *data)
@@ -276,7 +291,8 @@ int res_srq_parse_cb(const struct nlmsghdr *nlh, void *data)
 		if (ret != MNL_CB_OK)
 			break;
 
-		ret = res_srq_line(rd, name, idx, nla_line);
+		ret = (rd->show_raw) ? res_srq_line_raw(rd, name, idx, nla_line) :
+		       res_srq_line(rd, name, idx, nla_line);
 		if (ret != MNL_CB_OK)
 			break;
 	}
diff --git a/rdma/res.h b/rdma/res.h
index 70e51acd..e880c28b 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -39,6 +39,8 @@ static inline uint32_t res_get_command(uint32_t command, struct rd *rd)
 		return RDMA_NLDEV_CMD_RES_CQ_GET_RAW;
 	case RDMA_NLDEV_CMD_RES_MR_GET:
 		return RDMA_NLDEV_CMD_RES_MR_GET_RAW;
+	case RDMA_NLDEV_CMD_RES_SRQ_GET:
+		return RDMA_NLDEV_CMD_RES_SRQ_GET_RAW;
 	default:
 		return command;
 	}
-- 
2.30.0

