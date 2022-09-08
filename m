Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0B5B19A9
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIHKJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiIHKJU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 06:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600AE42C3
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 03:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72D9761C2C
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 10:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9A9C433D6;
        Thu,  8 Sep 2022 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662631757;
        bh=hthYFoxpV7MoukQBL/zDU1mnzoBmnktytSXg0FlRTpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WP6aj6eHOmSgMDzc+jFeBTLi1DfgyxQunBYd87qEoh5gS5/cs7trVQzgJvHmnY3WC
         kE6UkctgwFR2Q3iQeTMExwhrOHFm08ZF3FTbQ0EaNTxhgrL9D26K9QrZEoZugxkN1z
         kgOO5qtc98WjQ8F/xLxSBLcd2PkNt7WBpo9xKGw0HP9majuq6VFFZUWxXqhsTnJJ3k
         KI52KUSYg23wTtOXfLY+1uXSJJqi9v9LHsKMuliQSpRozsIzxfBhp3c2nH/pnXp9sy
         kVFt+60fm6ZIB1wF7GyCsggsyg3gikgeDtMaEdz34GnoDn/EoolbnUAIJfxBArKys7
         FCkCWIhlBilxA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 2/4] RDMA/cma: Multiple path records support with netlink channel
Date:   Thu,  8 Sep 2022 13:09:01 +0300
Message-Id: <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662631201.git.leonro@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Support receiving inbound and outbound IB path records (along with GMP
PathRecord) from user-space service through the RDMA netlink channel.
The LIDs in these 3 PRs can be used in this way:
1. GMP PR: used as the standard local/remote LIDs;
2. DLID of outbound PR: Used as the "dlid" field for outbound traffic;
3. DLID of inbound PR: Used as the "dlid" field for outbound traffic in
   responder side.

This is aimed to support adaptive routing. With current IB routing
solution when a packet goes out it's assigned with a fixed DLID per
target, meaning a fixed router will be used.
The LIDs in inbound/outbound path records can be used to identify group
of routers that allow communication with another subnet's entity. With
them packets from an inter-subnet connection may travel through any
router in the set to reach the target.

As confirmed with Jason, when sending a netlink request, kernel uses
LS_RESOLVE_PATH_USE_ALL so that the service knows kernel supports
multiple PRs.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c             |  70 ++++++-
 drivers/infiniband/core/sa_query.c        | 235 +++++++++++++++-------
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c       |   2 +-
 include/rdma/ib_sa.h                      |   3 +-
 include/rdma/rdma_cm.h                    |   6 +
 6 files changed, 231 insertions(+), 87 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 91e72a76d95e..a3efc462305d 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2026,6 +2026,8 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 		cma_id_put(id_priv->id.context);
 
 	kfree(id_priv->id.route.path_rec);
+	kfree(id_priv->id.route.path_rec_inbound);
+	kfree(id_priv->id.route.path_rec_outbound);
 
 	put_net(id_priv->id.route.addr.dev_addr.net);
 	kfree(id_priv);
@@ -2817,26 +2819,72 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 }
 EXPORT_SYMBOL(rdma_set_min_rnr_timer);
 
+static void route_set_path_rec_inbound(struct cma_work *work,
+				       struct sa_path_rec *path_rec)
+{
+	struct rdma_route *route = &work->id->id.route;
+
+	if (!route->path_rec_inbound) {
+		route->path_rec_inbound =
+			kzalloc(sizeof(*route->path_rec_inbound), GFP_KERNEL);
+		if (!route->path_rec_inbound)
+			return;
+	}
+
+	*route->path_rec_inbound = *path_rec;
+}
+
+static void route_set_path_rec_outbound(struct cma_work *work,
+					struct sa_path_rec *path_rec)
+{
+	struct rdma_route *route = &work->id->id.route;
+
+	if (!route->path_rec_outbound) {
+		route->path_rec_outbound =
+			kzalloc(sizeof(*route->path_rec_outbound), GFP_KERNEL);
+		if (!route->path_rec_outbound)
+			return;
+	}
+
+	*route->path_rec_outbound = *path_rec;
+}
+
 static void cma_query_handler(int status, struct sa_path_rec *path_rec,
-			      void *context)
+			      int num_prs, void *context)
 {
 	struct cma_work *work = context;
 	struct rdma_route *route;
+	int i;
 
 	route = &work->id->id.route;
 
-	if (!status) {
-		route->num_pri_alt_paths = 1;
-		*route->path_rec = *path_rec;
-	} else {
-		work->old_state = RDMA_CM_ROUTE_QUERY;
-		work->new_state = RDMA_CM_ADDR_RESOLVED;
-		work->event.event = RDMA_CM_EVENT_ROUTE_ERROR;
-		work->event.status = status;
-		pr_debug_ratelimited("RDMA CM: ROUTE_ERROR: failed to query path. status %d\n",
-				     status);
+	if (status)
+		goto fail;
+
+	for (i = 0; i < num_prs; i++) {
+		if (!path_rec[i].flags || (path_rec[i].flags & IB_PATH_GMP))
+			*route->path_rec = path_rec[i];
+		else if (path_rec[i].flags & IB_PATH_INBOUND)
+			route_set_path_rec_inbound(work, &path_rec[i]);
+		else if (path_rec[i].flags & IB_PATH_OUTBOUND)
+			route_set_path_rec_outbound(work, &path_rec[i]);
+	}
+	if (!route->path_rec) {
+		status = -EINVAL;
+		goto fail;
 	}
 
+	route->num_pri_alt_paths = 1;
+	queue_work(cma_wq, &work->work);
+	return;
+
+fail:
+	work->old_state = RDMA_CM_ROUTE_QUERY;
+	work->new_state = RDMA_CM_ADDR_RESOLVED;
+	work->event.event = RDMA_CM_EVENT_ROUTE_ERROR;
+	work->event.status = status;
+	pr_debug_ratelimited("RDMA CM: ROUTE_ERROR: failed to query path. status %d\n",
+			     status);
 	queue_work(cma_wq, &work->work);
 }
 
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 003e504feca2..0de83d9a4985 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -50,6 +50,7 @@
 #include <rdma/ib_marshall.h>
 #include <rdma/ib_addr.h>
 #include <rdma/opa_addr.h>
+#include <rdma/rdma_cm.h>
 #include "sa.h"
 #include "core_priv.h"
 
@@ -104,7 +105,8 @@ struct ib_sa_device {
 };
 
 struct ib_sa_query {
-	void (*callback)(struct ib_sa_query *, int, struct ib_sa_mad *);
+	void (*callback)(struct ib_sa_query *sa_query, int status,
+			 int num_prs, struct ib_sa_mad *mad);
 	void (*release)(struct ib_sa_query *);
 	struct ib_sa_client    *client;
 	struct ib_sa_port      *port;
@@ -116,6 +118,12 @@ struct ib_sa_query {
 	u32			seq; /* Local svc request sequence number */
 	unsigned long		timeout; /* Local svc timeout */
 	u8			path_use; /* How will the pathrecord be used */
+
+	/* A separate buffer to save pathrecords of a response, as in cases
+	 * like IB/netlink, mulptiple pathrecords are supported, so that
+	 * mad->data is not large enough to hold them
+	 */
+	void			*resp_pr_data;
 };
 
 #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
@@ -123,7 +131,8 @@ struct ib_sa_query {
 #define IB_SA_QUERY_OPA			0x00000004
 
 struct ib_sa_path_query {
-	void (*callback)(int, struct sa_path_rec *, void *);
+	void (*callback)(int status, struct sa_path_rec *rec,
+			 int num_paths, void *context);
 	void *context;
 	struct ib_sa_query sa_query;
 	struct sa_path_rec *conv_pr;
@@ -712,7 +721,7 @@ static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
 
 	if ((comp_mask & IB_SA_PATH_REC_REVERSIBLE) &&
 	    sa_rec->reversible != 0)
-		query->path_use = LS_RESOLVE_PATH_USE_GMP;
+		query->path_use = LS_RESOLVE_PATH_USE_ALL;
 	else
 		query->path_use = LS_RESOLVE_PATH_USE_UNIDIRECTIONAL;
 	header->path_use = query->path_use;
@@ -865,50 +874,81 @@ static void send_handler(struct ib_mad_agent *agent,
 static void ib_nl_process_good_resolve_rsp(struct ib_sa_query *query,
 					   const struct nlmsghdr *nlh)
 {
+	struct ib_path_rec_data *srec, *drec;
+	struct ib_sa_path_query *path_query;
 	struct ib_mad_send_wc mad_send_wc;
-	struct ib_sa_mad *mad = NULL;
 	const struct nlattr *head, *curr;
-	struct ib_path_rec_data  *rec;
-	int len, rem;
+	struct ib_sa_mad *mad = NULL;
+	int len, rem, num_prs = 0;
 	u32 mask = 0;
 	int status = -EIO;
 
-	if (query->callback) {
-		head = (const struct nlattr *) nlmsg_data(nlh);
-		len = nlmsg_len(nlh);
-		switch (query->path_use) {
-		case LS_RESOLVE_PATH_USE_UNIDIRECTIONAL:
-			mask = IB_PATH_PRIMARY | IB_PATH_OUTBOUND;
-			break;
+	if (!query->callback)
+		goto out;
 
-		case LS_RESOLVE_PATH_USE_ALL:
-		case LS_RESOLVE_PATH_USE_GMP:
-		default:
-			mask = IB_PATH_PRIMARY | IB_PATH_GMP |
-				IB_PATH_BIDIRECTIONAL;
-			break;
+	path_query = container_of(query, struct ib_sa_path_query, sa_query);
+	mad = query->mad_buf->mad;
+	if (!path_query->conv_pr &&
+	    (be16_to_cpu(mad->mad_hdr.attr_id) == IB_SA_ATTR_PATH_REC)) {
+		/* Need a larger buffer for possible multiple PRs */
+		query->resp_pr_data = kvcalloc(RDMA_PRIMARY_PATH_MAX_REC_NUM,
+					       sizeof(*drec), GFP_KERNEL);
+		if (!query->resp_pr_data) {
+			query->callback(query, -ENOMEM, 0, NULL);
+			return;
 		}
-		nla_for_each_attr(curr, head, len, rem) {
-			if (curr->nla_type == LS_NLA_TYPE_PATH_RECORD) {
-				rec = nla_data(curr);
-				/*
-				 * Get the first one. In the future, we may
-				 * need to get up to 6 pathrecords.
-				 */
-				if ((rec->flags & mask) == mask) {
-					mad = query->mad_buf->mad;
-					mad->mad_hdr.method |=
-						IB_MGMT_METHOD_RESP;
-					memcpy(mad->data, rec->path_rec,
-					       sizeof(rec->path_rec));
-					status = 0;
-					break;
-				}
-			}
+	}
+
+	head = (const struct nlattr *) nlmsg_data(nlh);
+	len = nlmsg_len(nlh);
+	switch (query->path_use) {
+	case LS_RESOLVE_PATH_USE_UNIDIRECTIONAL:
+		mask = IB_PATH_PRIMARY | IB_PATH_OUTBOUND;
+		break;
+
+	case LS_RESOLVE_PATH_USE_ALL:
+		mask = IB_PATH_PRIMARY;
+		break;
+
+	case LS_RESOLVE_PATH_USE_GMP:
+	default:
+		mask = IB_PATH_PRIMARY | IB_PATH_GMP |
+			IB_PATH_BIDIRECTIONAL;
+		break;
+	}
+
+	drec = (struct ib_path_rec_data *)query->resp_pr_data;
+	nla_for_each_attr(curr, head, len, rem) {
+		if (curr->nla_type != LS_NLA_TYPE_PATH_RECORD)
+			continue;
+
+		srec = nla_data(curr);
+		if ((srec->flags & mask) != mask)
+			continue;
+
+		status = 0;
+		if (!drec) {
+			memcpy(mad->data, srec->path_rec,
+			       sizeof(srec->path_rec));
+			num_prs = 1;
+			break;
 		}
-		query->callback(query, status, mad);
+
+		memcpy(drec, srec, sizeof(*drec));
+		drec++;
+		num_prs++;
+		if (num_prs >= RDMA_PRIMARY_PATH_MAX_REC_NUM)
+			break;
 	}
 
+	if (!status)
+		mad->mad_hdr.method |= IB_MGMT_METHOD_RESP;
+
+	query->callback(query, status, num_prs, mad);
+	kvfree(query->resp_pr_data);
+	query->resp_pr_data = NULL;
+
+out:
 	mad_send_wc.send_buf = query->mad_buf;
 	mad_send_wc.status = IB_WC_SUCCESS;
 	send_handler(query->mad_buf->mad_agent, &mad_send_wc);
@@ -1411,41 +1451,90 @@ static int opa_pr_query_possible(struct ib_sa_client *client,
 		return PR_IB_SUPPORTED;
 }
 
+static void ib_sa_pr_callback_single(struct ib_sa_path_query *query,
+				     int status, struct ib_sa_mad *mad)
+{
+	struct sa_path_rec rec = {};
+
+	ib_unpack(path_rec_table, ARRAY_SIZE(path_rec_table),
+		  mad->data, &rec);
+	rec.rec_type = SA_PATH_REC_TYPE_IB;
+	sa_path_set_dmac_zero(&rec);
+
+	if (query->conv_pr) {
+		struct sa_path_rec opa;
+
+		memset(&opa, 0, sizeof(struct sa_path_rec));
+		sa_convert_path_ib_to_opa(&opa, &rec);
+		query->callback(status, &opa, 1, query->context);
+	} else {
+		query->callback(status, &rec, 1, query->context);
+	}
+}
+
+/**
+ * ib_sa_pr_callback_multiple() - Parse path records then do callback.
+ *
+ * In a multiple-PR case the PRs are saved in "query->resp_pr_data"
+ * (instead of"mad->data") and with "ib_path_rec_data" structure format,
+ * so that rec->flags can be set to indicate the type of PR.
+ * This is valid only in IB fabric.
+ */
+static void ib_sa_pr_callback_multiple(struct ib_sa_path_query *query,
+				       int status, int num_prs,
+				       struct ib_path_rec_data *rec_data)
+{
+	struct sa_path_rec *rec;
+	int i;
+
+	rec = kvcalloc(num_prs, sizeof(*rec), GFP_KERNEL);
+	if (!rec) {
+		query->callback(-ENOMEM, NULL, 0, query->context);
+		return;
+	}
+
+	for (i = 0; i < num_prs; i++) {
+		ib_unpack(path_rec_table, ARRAY_SIZE(path_rec_table),
+			  rec_data[i].path_rec, rec + i);
+		rec[i].rec_type = SA_PATH_REC_TYPE_IB;
+		sa_path_set_dmac_zero(rec + i);
+		rec[i].flags = rec_data[i].flags;
+	}
+
+	query->callback(status, rec, num_prs, query->context);
+	kvfree(rec);
+}
+
 static void ib_sa_path_rec_callback(struct ib_sa_query *sa_query,
-				    int status,
+				    int status, int num_prs,
 				    struct ib_sa_mad *mad)
 {
 	struct ib_sa_path_query *query =
 		container_of(sa_query, struct ib_sa_path_query, sa_query);
+	struct sa_path_rec rec;
 
-	if (mad) {
-		struct sa_path_rec rec;
-
-		if (sa_query->flags & IB_SA_QUERY_OPA) {
-			ib_unpack(opa_path_rec_table,
-				  ARRAY_SIZE(opa_path_rec_table),
-				  mad->data, &rec);
-			rec.rec_type = SA_PATH_REC_TYPE_OPA;
-			query->callback(status, &rec, query->context);
-		} else {
-			ib_unpack(path_rec_table,
-				  ARRAY_SIZE(path_rec_table),
-				  mad->data, &rec);
-			rec.rec_type = SA_PATH_REC_TYPE_IB;
-			sa_path_set_dmac_zero(&rec);
-
-			if (query->conv_pr) {
-				struct sa_path_rec opa;
+	if (!mad || !num_prs) {
+		query->callback(status, NULL, 0, query->context);
+		return;
+	}
 
-				memset(&opa, 0, sizeof(struct sa_path_rec));
-				sa_convert_path_ib_to_opa(&opa, &rec);
-				query->callback(status, &opa, query->context);
-			} else {
-				query->callback(status, &rec, query->context);
-			}
+	if (sa_query->flags & IB_SA_QUERY_OPA) {
+		if (num_prs != 1) {
+			query->callback(-EINVAL, NULL, 0, query->context);
+			return;
 		}
-	} else
-		query->callback(status, NULL, query->context);
+
+		ib_unpack(opa_path_rec_table, ARRAY_SIZE(opa_path_rec_table),
+			  mad->data, &rec);
+		rec.rec_type = SA_PATH_REC_TYPE_OPA;
+		query->callback(status, &rec, num_prs, query->context);
+	} else {
+		if (!sa_query->resp_pr_data)
+			ib_sa_pr_callback_single(query, status, mad);
+		else
+			ib_sa_pr_callback_multiple(query, status, num_prs,
+						   sa_query->resp_pr_data);
+	}
 }
 
 static void ib_sa_path_rec_release(struct ib_sa_query *sa_query)
@@ -1489,7 +1578,7 @@ int ib_sa_path_rec_get(struct ib_sa_client *client,
 		       unsigned long timeout_ms, gfp_t gfp_mask,
 		       void (*callback)(int status,
 					struct sa_path_rec *resp,
-					void *context),
+					int num_paths, void *context),
 		       void *context,
 		       struct ib_sa_query **sa_query)
 {
@@ -1588,7 +1677,7 @@ int ib_sa_path_rec_get(struct ib_sa_client *client,
 EXPORT_SYMBOL(ib_sa_path_rec_get);
 
 static void ib_sa_mcmember_rec_callback(struct ib_sa_query *sa_query,
-					int status,
+					int status, int num_prs,
 					struct ib_sa_mad *mad)
 {
 	struct ib_sa_mcmember_query *query =
@@ -1680,7 +1769,7 @@ int ib_sa_mcmember_rec_query(struct ib_sa_client *client,
 
 /* Support GuidInfoRecord */
 static void ib_sa_guidinfo_rec_callback(struct ib_sa_query *sa_query,
-					int status,
+					int status, int num_paths,
 					struct ib_sa_mad *mad)
 {
 	struct ib_sa_guidinfo_query *query =
@@ -1790,7 +1879,7 @@ static void ib_classportinfo_cb(void *context)
 }
 
 static void ib_sa_classport_info_rec_callback(struct ib_sa_query *sa_query,
-					      int status,
+					      int status, int num_prs,
 					      struct ib_sa_mad *mad)
 {
 	unsigned long flags;
@@ -1966,13 +2055,13 @@ static void send_handler(struct ib_mad_agent *agent,
 			/* No callback -- already got recv */
 			break;
 		case IB_WC_RESP_TIMEOUT_ERR:
-			query->callback(query, -ETIMEDOUT, NULL);
+			query->callback(query, -ETIMEDOUT, 0, NULL);
 			break;
 		case IB_WC_WR_FLUSH_ERR:
-			query->callback(query, -EINTR, NULL);
+			query->callback(query, -EINTR, 0, NULL);
 			break;
 		default:
-			query->callback(query, -EIO, NULL);
+			query->callback(query, -EIO, 0, NULL);
 			break;
 		}
 
@@ -2000,10 +2089,10 @@ static void recv_handler(struct ib_mad_agent *mad_agent,
 		if (mad_recv_wc->wc->status == IB_WC_SUCCESS)
 			query->callback(query,
 					mad_recv_wc->recv_buf.mad->mad_hdr.status ?
-					-EINVAL : 0,
+					-EINVAL : 0, 1,
 					(struct ib_sa_mad *) mad_recv_wc->recv_buf.mad);
 		else
-			query->callback(query, -EIO, NULL);
+			query->callback(query, -EIO, 0, NULL);
 	}
 
 	ib_free_recv_mad(mad_recv_wc);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index a4904371e2db..ac25fc80fb33 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -742,7 +742,7 @@ void ipoib_flush_paths(struct net_device *dev)
 
 static void path_rec_completion(int status,
 				struct sa_path_rec *pathrec,
-				void *path_ptr)
+				int num_prs, void *path_ptr)
 {
 	struct ipoib_path *path = path_ptr;
 	struct net_device *dev = path->dev;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1e777b2043d6..e5ec5444b662 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -699,7 +699,7 @@ static void srp_free_ch_ib(struct srp_target_port *target,
 
 static void srp_path_rec_completion(int status,
 				    struct sa_path_rec *pathrec,
-				    void *ch_ptr)
+				    int num_paths, void *ch_ptr)
 {
 	struct srp_rdma_ch *ch = ch_ptr;
 	struct srp_target_port *target = ch->target;
diff --git a/include/rdma/ib_sa.h b/include/rdma/ib_sa.h
index 3634d4cc7a56..e930bec33b31 100644
--- a/include/rdma/ib_sa.h
+++ b/include/rdma/ib_sa.h
@@ -186,6 +186,7 @@ struct sa_path_rec {
 		struct sa_path_rec_opa opa;
 	};
 	enum sa_path_rec_type rec_type;
+	u32 flags;
 };
 
 static inline enum ib_gid_type
@@ -413,7 +414,7 @@ int ib_sa_path_rec_get(struct ib_sa_client *client, struct ib_device *device,
 		       ib_sa_comp_mask comp_mask, unsigned long timeout_ms,
 		       gfp_t gfp_mask,
 		       void (*callback)(int status, struct sa_path_rec *resp,
-					void *context),
+					int num_prs, void *context),
 		       void *context, struct ib_sa_query **query);
 
 struct ib_sa_multicast {
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 81916039ee24..cdc7cafab572 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -49,9 +49,15 @@ struct rdma_addr {
 	struct rdma_dev_addr dev_addr;
 };
 
+#define RDMA_PRIMARY_PATH_MAX_REC_NUM 3
 struct rdma_route {
 	struct rdma_addr addr;
 	struct sa_path_rec *path_rec;
+
+	/* Optional path records of primary path */
+	struct sa_path_rec *path_rec_inbound;
+	struct sa_path_rec *path_rec_outbound;
+
 	/*
 	 * 0 - No primary nor alternate path is available
 	 * 1 - Only primary path is available
-- 
2.37.2

