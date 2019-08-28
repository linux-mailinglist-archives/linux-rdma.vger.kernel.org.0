Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058FDA0A6A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 21:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfH1TYc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 15:24:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfH1TYc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 15:24:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SJMRFH172110;
        Wed, 28 Aug 2019 19:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=viZ0rpJhtreNNatRCsPHwnK5It+ZresIydLMQiXle/U=;
 b=Hd1sufkiGm+aD01X8ZIy0CDApFpKPTQYt992hRPaU7wS68vxELr6JE984lsPShf0ROg4
 s48dihi6yvXSPWwUHEo3MKXdZ2ZvNNfr13ai2kBuMMS24HQb1rOpuhasqao8Km9KVOLc
 +d5mbwDisVunuqFmbq/W6DxmEiKzkCEy4EAb98eDFtpU1pBO7rbcIS69ILfROxtdno9t
 jpdDCx0LF3ZyNVSEwG32w/xVuzEV4pHaoRisVsGvRKpboGwsC+Es00zHq7M2pfPMX+88
 0zi5zv2nY1CiYBVvM2D7csVW2l3PsQarOfgJnxs0ZYIJTB3jJQ+rb6HIn/I5gIQSJJoB Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2unyq3r093-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 19:24:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SJNw8F163970;
        Wed, 28 Aug 2019 19:24:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2untetrr3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 19:24:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SJNVMK008114;
        Wed, 28 Aug 2019 19:23:31 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 12:23:31 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, oulijun@huawei.com,
        xavier.huwei@huawei.com, leon@kernel.org, parav@mellanox.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        galpress@amazon.com, israelr@mellanox.com, monis@mellanox.com,
        maxg@mellanox.com, kamalheib1@gmail.com, yuval.shaia@oracle.com,
        denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, ereza@mellanox.com, will@kernel.org,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, srabinov7@gmail.com,
        santosh.shilimkar@oracle.com
Cc:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: [PATCH v2 5/5] RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
Date:   Wed, 28 Aug 2019 22:22:45 +0300
Message-Id: <20190828192245.11003-6-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828192245.11003-1-yuval.shaia@oracle.com>
References: <20190828192245.11003-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280187
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

In shared object model ib_pd can belong to 1 or more ib_ucontext.
Fix the nldev code so it could report multiple context ids.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/nldev.c  | 127 +++++++++++++++++++++++++++++--
 include/uapi/rdma/rdma_netlink.h |   3 +
 2 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e287b71a1cfd..7ad23a6607f7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -41,6 +41,7 @@
 #include "core_priv.h"
 #include "cma_priv.h"
 #include "restrack.h"
+#include "uverbs.h"
 
 /*
  * Sort array elements by the netlink attribute name
@@ -141,6 +142,8 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
 	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_RES_CTX]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_RES_CTX_ENTRY]		= { .type = NLA_NESTED },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -611,11 +614,84 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 err:	return -EMSGSIZE;
 }
 
+struct context_id {
+	struct list_head list;
+	u32 id;
+};
+
+static void pd_context(struct ib_pd *pd, struct list_head *list, int *count)
+{
+	struct ib_device *device = pd->device;
+	struct rdma_restrack_entry *res;
+	struct rdma_restrack_root *rt;
+	struct ib_uverbs_file *ufile;
+	struct ib_ucontext *ucontext;
+	struct ib_uobject *uobj;
+	unsigned long flags;
+	unsigned long id;
+	bool found;
+
+	rt = &device->res[RDMA_RESTRACK_CTX];
+
+	xa_lock(&rt->xa);
+
+	xa_for_each(&rt->xa, id, res) {
+		if (!rdma_is_visible_in_pid_ns(res))
+			continue;
+
+		if (!rdma_restrack_get(res))
+			continue;
+
+		xa_unlock(&rt->xa);
+
+		ucontext = container_of(res, struct ib_ucontext, res);
+		ufile = ucontext->ufile;
+		found = false;
+
+		/* See locking requirements in struct ib_uverbs_file */
+		down_read(&ufile->hw_destroy_rwsem);
+		spin_lock_irqsave(&ufile->uobjects_lock, flags);
+
+		list_for_each_entry(uobj, &ufile->uobjects, list) {
+			if (uobj->object == pd) {
+				found = true;
+				goto found;
+			}
+		}
+
+found:		spin_unlock_irqrestore(&ufile->uobjects_lock, flags);
+		up_read(&ufile->hw_destroy_rwsem);
+
+		if (found) {
+			struct context_id *ctx_id =
+				kmalloc(sizeof(*ctx_id), GFP_KERNEL);
+
+			if (WARN_ON_ONCE(!ctx_id))
+				goto next;
+
+			ctx_id->id = ucontext->res.id;
+			list_add(&ctx_id->list, list);
+			(*count)++;
+		}
+
+next:		rdma_restrack_put(res);
+		xa_lock(&rt->xa);
+	}
+
+	xa_unlock(&rt->xa);
+}
+
 static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			     struct rdma_restrack_entry *res, uint32_t port)
 {
 	struct ib_pd *pd = container_of(res, struct ib_pd, res);
 	struct ib_device *dev = pd->device;
+	struct nlattr *table_attr = NULL;
+	struct nlattr *entry_attr = NULL;
+	struct context_id *ctx_id;
+	struct context_id *tmp;
+	LIST_HEAD(pd_context_ids);
+	int ctx_count = 0;
 
 	if (has_cap_net_admin) {
 		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
@@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
 		goto err;
 
-	if (!rdma_is_kernel_res(res) &&
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
-			pd->uobject->context->res.id))
-		goto err;
+	if (!rdma_is_kernel_res(res)) {
+		pd_context(pd, &pd_context_ids, &ctx_count);
+		if (ctx_count == 1) {
+			/* user pd, not shared */
+			ctx_id = list_first_entry(&pd_context_ids,
+						  struct context_id, list);
+			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
+					ctx_id->id))
+				goto err;
+		} else if (ctx_count > 1) {
+			/* user pd, shared */
+			table_attr = nla_nest_start(msg,
+					RDMA_NLDEV_ATTR_RES_CTX);
+			if (!table_attr)
+				goto err;
+
+			list_for_each_entry(ctx_id, &pd_context_ids, list) {
+				entry_attr = nla_nest_start(msg,
+						RDMA_NLDEV_ATTR_RES_CTX_ENTRY);
+				if (!entry_attr)
+					goto err;
+				if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
+						ctx_id->id))
+					goto err;
+				nla_nest_end(msg, entry_attr);
+				entry_attr = NULL;
+			}
+
+			nla_nest_end(msg, table_attr);
+			table_attr = NULL;
+		}
+	}
 
 	if (fill_res_name_pid(msg, res))
 		goto err;
@@ -644,9 +748,22 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_entry(dev, msg, res))
 		goto err;
 
+	list_for_each_entry_safe(ctx_id, tmp, &pd_context_ids, list)
+		kfree(ctx_id);
+
 	return 0;
 
-err:	return -EMSGSIZE;
+err:
+	if (entry_attr)
+		nla_nest_end(msg, entry_attr);
+
+	if (table_attr)
+		nla_nest_end(msg, table_attr);
+
+	list_for_each_entry_safe(ctx_id, tmp, &pd_context_ids, list)
+		kfree(ctx_id);
+
+	return -EMSGSIZE;
 }
 
 static int fill_stat_counter_mode(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8e277783fa96..7fbbfb07f071 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -525,6 +525,9 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_DEV_DIM,                /* u8 */
 
+	RDMA_NLDEV_ATTR_RES_CTX,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_CTX_ENTRY,		/* nested table */
+
 	/*
 	 * Always the end
 	 */
-- 
2.20.1

