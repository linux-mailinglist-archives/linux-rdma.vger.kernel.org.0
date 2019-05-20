Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CDF22D73
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfETHzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 03:55:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETHzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 03:55:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7mm0n161009;
        Mon, 20 May 2019 07:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=qeJysiaf176btiGa5xS0yTwEyoNbRVDz+0r2sa72GZ4=;
 b=KmTBf3bmX9JrTj4eNRnafKJhgcMSZ8Hd0VMfU5axbHUKxG5BQgjCc2QBG20KNGX983o5
 jmHyIo1M2gQw28aVQCRiXUyjoVfTTq+2rm9l+1IEVK1EB2friLdkqTOrZ3P59kDPZ8FK
 lX5lTbLLmfgyfPk1fosiN5tpE4/m3Ll5VBXdtx1kxKM8P2Sm0/I+urZLhtvZVkboV5Si
 E9mCqRjxARKzG/K5tf1dUlHHm/jeb2fAbJIU9BA4SEt1pxWa9D0k5FaGP4KCOnsda11Z
 MrvPeARzcIwh9zUJWvyK4NOAkMKAa1bdlCfeQMH66gZr34zWQOenHj3yEDRIoyWBkysF 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2sjapq52sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:55:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7rXNS119271;
        Mon, 20 May 2019 07:55:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2skbphnhjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:55:12 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4K7tBB2028609;
        Mon, 20 May 2019 07:55:11 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.35.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 07:55:11 +0000
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     shamir.rabinovitch@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
Date:   Mon, 20 May 2019 10:53:20 +0300
Message-Id: <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200057
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200057
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In shared object model ib_pd can belong to 1 or more ib_ucontext.
Fix the nldev code so it could report multiple context ids.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 drivers/infiniband/core/nldev.c | 93 +++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index cbd712f5f8b2..f4cc92b897ff 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -41,6 +41,9 @@
 #include "core_priv.h"
 #include "cma_priv.h"
 #include "restrack.h"
+#include "uverbs.h"
+
+static bool is_visible_in_pid_ns(struct rdma_restrack_entry *res);
 
 static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_INDEX]     = { .type = NLA_U32 },
@@ -584,11 +587,80 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 err:	return -EMSGSIZE;
 }
 
+struct context_id {
+	struct list_head list;
+	u32 id;
+};
+
+static void pd_context(struct ib_pd *pd, struct list_head *list)
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
+		if (!is_visible_in_pid_ns(res))
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
+	struct context_id *ctx_id;
+	struct context_id *tmp;
+	LIST_HEAD(pd_context_ids);
 
 	if (has_cap_net_admin) {
 		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
@@ -606,10 +678,14 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
 		goto err;
 
-	if (!rdma_is_kernel_res(res) &&
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
-			pd->uobject->context->res.id))
-		goto err;
+	if (!rdma_is_kernel_res(res)) {
+		pd_context(pd, &pd_context_ids);
+		list_for_each_entry(ctx_id, &pd_context_ids, list) {
+			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
+				ctx_id->id))
+				goto err;
+		}
+	}
 
 	if (fill_res_name_pid(msg, res))
 		goto err;
@@ -617,9 +693,16 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_entry(dev, msg, res))
 		goto err;
 
+	list_for_each_entry_safe(ctx_id, tmp, &pd_context_ids, list)
+		kfree(ctx_id);
+
 	return 0;
 
-err:	return -EMSGSIZE;
+err:
+	list_for_each_entry_safe(ctx_id, tmp, &pd_context_ids, list)
+		kfree(ctx_id);
+
+	return -EMSGSIZE;
 }
 
 static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.20.1

