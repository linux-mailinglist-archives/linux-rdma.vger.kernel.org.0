Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3D2FB8A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfE3M0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 08:26:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54554 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfE3M0U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 08:26:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UCIdVY069490;
        Thu, 30 May 2019 12:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=5788nnRGWEdXEn99z6bDiGmBQxivFLSBkjktvxXTd6s=;
 b=FQu36S63Hwgf1t8Nd2sVUOn0GIlVEhHMRxajC3kvlrWmDoLh3towoTTdi+aiwUmFx0/6
 r6fQN13h/bvEG8WHSaiM1ws44R8WbefuF2PDVEMymExJO4ACA+MIoiVZfX1W4iPkHVtP
 fWNZAbep3R4s+vmOXSSMw1wG4My5OE4/OzV1vxyewhkswDHDoFDHJUvc9icA3m6oc/Ya
 02vox836IbmZKuk9ywQlSbZZcEIV50OD2QLzDhA7AZoFb1JhLnHAv9/J++AJGity2T96
 q4H6gBBpZCBpO424bYc4wpI3Pb9RMAb4fFGvQPm380OaD1UkJwbm0tpEX4cKXm0Lg9TD Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2spu7dqxaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 12:26:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UCPPvh079782;
        Thu, 30 May 2019 12:25:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ss1fp1g3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 12:25:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4UCPwAE019618;
        Thu, 30 May 2019 12:25:58 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.32.156)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 05:25:57 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     dledford@redhat.com, jgg@mellanox.com,
        shamir.rabinovitch@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH for-next v3 3/4] RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
Date:   Thu, 30 May 2019 15:24:08 +0300
Message-Id: <20190530122422.32283-4-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In shared object model ib_pd can belong to 1 or more ib_ucontext.
Fix the nldev code so it could report multiple context ids.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 drivers/infiniband/core/nldev.c  | 129 +++++++++++++++++++++++++++++--
 include/uapi/rdma/rdma_netlink.h |   3 +
 2 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 69188cbbd99b..31b1a955c4c9 100644
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
@@ -120,6 +123,8 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type = NLA_NUL_STRING,
 				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
 	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_RES_CTX]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_RES_CTX_ENTRY]		= { .type = NLA_NESTED },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -585,11 +590,84 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
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
@@ -607,10 +685,38 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
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
@@ -618,9 +724,22 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
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
 
 static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 41db51367efa..d399e8422b3e 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -479,6 +479,9 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_NET_NS_FD,			/* u32 */
 
+	RDMA_NLDEV_ATTR_RES_CTX,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_CTX_ENTRY,		/* nested table */
+
 	/*
 	 * Always the end
 	 */
-- 
2.20.1

