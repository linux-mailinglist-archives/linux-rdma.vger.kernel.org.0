Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713C65CDFA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 09:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjADIDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 03:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADIDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 03:03:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FEBD60
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 00:03:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E1AAB810FA
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 08:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA28C433D2;
        Wed,  4 Jan 2023 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672819426;
        bh=MDDKORdMZHzagNyTBj6qoVbeUhEK46rWn6HXCgAuBA4=;
        h=From:To:Cc:Subject:Date:From;
        b=QrB5c0i9lJgMEpfDQkNbjlBZJ8hGbYJD7O9AdWZIKV60NaXZkqTkadcxBFkNYdFVB
         YGTMGy6IAqPts0Dg78hx/JT4ItR0tEIR0vPQGAnFu2Xm41SPOPu5S0Z16X37KPKRfB
         ixwRNse9cSOvQbxwAJ8HS03aXtnySJJu2QrDnsO84zEB2DJhC+GRRRSrCjzkwjutpv
         alhTwOAV68mhzJz6yKGfy/r/fFeGR0PhDpkFAeQOO6UvSjdltEWvmHuBfvQ8nZ/LW+
         vpfEDmUoMtcdTgG2PlDJvVIbYUEOnwIKKkuTVmqVjckJhwIBAYVHvi6QjeqnuF4lMX
         kRzQU1JRH/VgA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/cma: Refactor the inbound/outbound path records process flow
Date:   Wed,  4 Jan 2023 10:03:41 +0200
Message-Id: <7610025d57342b8b6da0f19516c9612f9c3fdc37.1672819376.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Refactors based on comments [1] of the multiple path records support
patchset:
- Return failure if not able to set inbound/outbound PRs;
- Simplify the flow when receiving the PRs from netlink channel: When
  a good PR response is received, unpack it and call the path_query
  callback directly. This saves two memory allocations;
- Define RDMA_PRIMARY_PATH_MAX_REC_NUM in a proper place.

[1] https://lore.kernel.org/linux-rdma/Yyxp9E9pJtUids2o@nvidia.com/

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c             |  30 ++--
 drivers/infiniband/core/sa_query.c        | 171 +++++++---------------
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c       |   2 +-
 include/rdma/ib_sa.h                      |   2 +-
 include/rdma/rdma_cm.h                    |   1 -
 6 files changed, 75 insertions(+), 133 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index b9da636fe1fb..1d2bff91d78b 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2819,8 +2819,8 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 }
 EXPORT_SYMBOL(rdma_set_min_rnr_timer);
 
-static void route_set_path_rec_inbound(struct cma_work *work,
-				       struct sa_path_rec *path_rec)
+static int route_set_path_rec_inbound(struct cma_work *work,
+				      struct sa_path_rec *path_rec)
 {
 	struct rdma_route *route = &work->id->id.route;
 
@@ -2828,14 +2828,15 @@ static void route_set_path_rec_inbound(struct cma_work *work,
 		route->path_rec_inbound =
 			kzalloc(sizeof(*route->path_rec_inbound), GFP_KERNEL);
 		if (!route->path_rec_inbound)
-			return;
+			return -ENOMEM;
 	}
 
 	*route->path_rec_inbound = *path_rec;
+	return 0;
 }
 
-static void route_set_path_rec_outbound(struct cma_work *work,
-					struct sa_path_rec *path_rec)
+static int route_set_path_rec_outbound(struct cma_work *work,
+				       struct sa_path_rec *path_rec)
 {
 	struct rdma_route *route = &work->id->id.route;
 
@@ -2843,14 +2844,15 @@ static void route_set_path_rec_outbound(struct cma_work *work,
 		route->path_rec_outbound =
 			kzalloc(sizeof(*route->path_rec_outbound), GFP_KERNEL);
 		if (!route->path_rec_outbound)
-			return;
+			return -ENOMEM;
 	}
 
 	*route->path_rec_outbound = *path_rec;
+	return 0;
 }
 
 static void cma_query_handler(int status, struct sa_path_rec *path_rec,
-			      int num_prs, void *context)
+			      unsigned int num_prs, void *context)
 {
 	struct cma_work *work = context;
 	struct rdma_route *route;
@@ -2865,13 +2867,15 @@ static void cma_query_handler(int status, struct sa_path_rec *path_rec,
 		if (!path_rec[i].flags || (path_rec[i].flags & IB_PATH_GMP))
 			*route->path_rec = path_rec[i];
 		else if (path_rec[i].flags & IB_PATH_INBOUND)
-			route_set_path_rec_inbound(work, &path_rec[i]);
+			status = route_set_path_rec_inbound(work, &path_rec[i]);
 		else if (path_rec[i].flags & IB_PATH_OUTBOUND)
-			route_set_path_rec_outbound(work, &path_rec[i]);
-	}
-	if (!route->path_rec) {
-		status = -EINVAL;
-		goto fail;
+			status = route_set_path_rec_outbound(work,
+							     &path_rec[i]);
+		else
+			status = -EINVAL;
+
+		if (status)
+			goto fail;
 	}
 
 	route->num_pri_alt_paths = 1;
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 0de83d9a4985..59179cfc20ef 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -106,7 +106,7 @@ struct ib_sa_device {
 
 struct ib_sa_query {
 	void (*callback)(struct ib_sa_query *sa_query, int status,
-			 int num_prs, struct ib_sa_mad *mad);
+			 struct ib_sa_mad *mad);
 	void (*release)(struct ib_sa_query *);
 	struct ib_sa_client    *client;
 	struct ib_sa_port      *port;
@@ -118,12 +118,6 @@ struct ib_sa_query {
 	u32			seq; /* Local svc request sequence number */
 	unsigned long		timeout; /* Local svc timeout */
 	u8			path_use; /* How will the pathrecord be used */
-
-	/* A separate buffer to save pathrecords of a response, as in cases
-	 * like IB/netlink, mulptiple pathrecords are supported, so that
-	 * mad->data is not large enough to hold them
-	 */
-	void			*resp_pr_data;
 };
 
 #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
@@ -132,7 +126,7 @@ struct ib_sa_query {
 
 struct ib_sa_path_query {
 	void (*callback)(int status, struct sa_path_rec *rec,
-			 int num_paths, void *context);
+			 unsigned int num_paths, void *context);
 	void *context;
 	struct ib_sa_query sa_query;
 	struct sa_path_rec *conv_pr;
@@ -690,6 +684,8 @@ static const struct ib_field guidinfo_rec_table[] = {
 	  .size_bits    = 512 },
 };
 
+#define RDMA_PRIMARY_PATH_MAX_REC_NUM 3
+
 static inline void ib_sa_disable_local_svc(struct ib_sa_query *query)
 {
 	query->flags &= ~IB_SA_ENABLE_LOCAL_SERVICE;
@@ -874,30 +870,21 @@ static void send_handler(struct ib_mad_agent *agent,
 static void ib_nl_process_good_resolve_rsp(struct ib_sa_query *query,
 					   const struct nlmsghdr *nlh)
 {
-	struct ib_path_rec_data *srec, *drec;
+	struct sa_path_rec recs[RDMA_PRIMARY_PATH_MAX_REC_NUM];
 	struct ib_sa_path_query *path_query;
+	struct ib_path_rec_data *rec_data;
 	struct ib_mad_send_wc mad_send_wc;
 	const struct nlattr *head, *curr;
 	struct ib_sa_mad *mad = NULL;
-	int len, rem, num_prs = 0;
+	int len, rem, status = -EIO;
+	unsigned int num_prs = 0;
 	u32 mask = 0;
-	int status = -EIO;
 
 	if (!query->callback)
 		goto out;
 
 	path_query = container_of(query, struct ib_sa_path_query, sa_query);
 	mad = query->mad_buf->mad;
-	if (!path_query->conv_pr &&
-	    (be16_to_cpu(mad->mad_hdr.attr_id) == IB_SA_ATTR_PATH_REC)) {
-		/* Need a larger buffer for possible multiple PRs */
-		query->resp_pr_data = kvcalloc(RDMA_PRIMARY_PATH_MAX_REC_NUM,
-					       sizeof(*drec), GFP_KERNEL);
-		if (!query->resp_pr_data) {
-			query->callback(query, -ENOMEM, 0, NULL);
-			return;
-		}
-	}
 
 	head = (const struct nlattr *) nlmsg_data(nlh);
 	len = nlmsg_len(nlh);
@@ -917,36 +904,41 @@ static void ib_nl_process_good_resolve_rsp(struct ib_sa_query *query,
 		break;
 	}
 
-	drec = (struct ib_path_rec_data *)query->resp_pr_data;
 	nla_for_each_attr(curr, head, len, rem) {
 		if (curr->nla_type != LS_NLA_TYPE_PATH_RECORD)
 			continue;
 
-		srec = nla_data(curr);
-		if ((srec->flags & mask) != mask)
+		rec_data = nla_data(curr);
+		if ((rec_data->flags & mask) != mask)
 			continue;
 
-		status = 0;
-		if (!drec) {
-			memcpy(mad->data, srec->path_rec,
-			       sizeof(srec->path_rec));
-			num_prs = 1;
-			break;
+		if ((query->flags & IB_SA_QUERY_OPA) ||
+		    path_query->conv_pr) {
+			mad->mad_hdr.method |= IB_MGMT_METHOD_RESP;
+			memcpy(mad->data, rec_data->path_rec,
+			       sizeof(rec_data->path_rec));
+			query->callback(query, 0, mad);
+			goto out;
 		}
 
-		memcpy(drec, srec, sizeof(*drec));
-		drec++;
+		status = 0;
+		ib_unpack(path_rec_table, ARRAY_SIZE(path_rec_table),
+			  rec_data->path_rec, &recs[num_prs]);
+		recs[num_prs].flags = rec_data->flags;
+		recs[num_prs].rec_type = SA_PATH_REC_TYPE_IB;
+		sa_path_set_dmac_zero(&recs[num_prs]);
+
 		num_prs++;
 		if (num_prs >= RDMA_PRIMARY_PATH_MAX_REC_NUM)
 			break;
 	}
 
-	if (!status)
+	if (!status) {
 		mad->mad_hdr.method |= IB_MGMT_METHOD_RESP;
-
-	query->callback(query, status, num_prs, mad);
-	kvfree(query->resp_pr_data);
-	query->resp_pr_data = NULL;
+		path_query->callback(status, recs, num_prs,
+				     path_query->context);
+	} else
+		query->callback(query, status, mad);
 
 out:
 	mad_send_wc.send_buf = query->mad_buf;
@@ -1451,11 +1443,26 @@ static int opa_pr_query_possible(struct ib_sa_client *client,
 		return PR_IB_SUPPORTED;
 }
 
-static void ib_sa_pr_callback_single(struct ib_sa_path_query *query,
-				     int status, struct ib_sa_mad *mad)
+static void ib_sa_path_rec_callback(struct ib_sa_query *sa_query,
+				    int status, struct ib_sa_mad *mad)
 {
+	struct ib_sa_path_query *query =
+		container_of(sa_query, struct ib_sa_path_query, sa_query);
 	struct sa_path_rec rec = {};
 
+	if (!mad) {
+		query->callback(status, NULL, 0, query->context);
+		return;
+	}
+
+	if (sa_query->flags & IB_SA_QUERY_OPA) {
+		ib_unpack(opa_path_rec_table, ARRAY_SIZE(opa_path_rec_table),
+			  mad->data, &rec);
+		rec.rec_type = SA_PATH_REC_TYPE_OPA;
+		query->callback(status, &rec, 1, query->context);
+		return;
+	}
+
 	ib_unpack(path_rec_table, ARRAY_SIZE(path_rec_table),
 		  mad->data, &rec);
 	rec.rec_type = SA_PATH_REC_TYPE_IB;
@@ -1472,71 +1479,6 @@ static void ib_sa_pr_callback_single(struct ib_sa_path_query *query,
 	}
 }
 
-/**
- * ib_sa_pr_callback_multiple() - Parse path records then do callback.
- *
- * In a multiple-PR case the PRs are saved in "query->resp_pr_data"
- * (instead of"mad->data") and with "ib_path_rec_data" structure format,
- * so that rec->flags can be set to indicate the type of PR.
- * This is valid only in IB fabric.
- */
-static void ib_sa_pr_callback_multiple(struct ib_sa_path_query *query,
-				       int status, int num_prs,
-				       struct ib_path_rec_data *rec_data)
-{
-	struct sa_path_rec *rec;
-	int i;
-
-	rec = kvcalloc(num_prs, sizeof(*rec), GFP_KERNEL);
-	if (!rec) {
-		query->callback(-ENOMEM, NULL, 0, query->context);
-		return;
-	}
-
-	for (i = 0; i < num_prs; i++) {
-		ib_unpack(path_rec_table, ARRAY_SIZE(path_rec_table),
-			  rec_data[i].path_rec, rec + i);
-		rec[i].rec_type = SA_PATH_REC_TYPE_IB;
-		sa_path_set_dmac_zero(rec + i);
-		rec[i].flags = rec_data[i].flags;
-	}
-
-	query->callback(status, rec, num_prs, query->context);
-	kvfree(rec);
-}
-
-static void ib_sa_path_rec_callback(struct ib_sa_query *sa_query,
-				    int status, int num_prs,
-				    struct ib_sa_mad *mad)
-{
-	struct ib_sa_path_query *query =
-		container_of(sa_query, struct ib_sa_path_query, sa_query);
-	struct sa_path_rec rec;
-
-	if (!mad || !num_prs) {
-		query->callback(status, NULL, 0, query->context);
-		return;
-	}
-
-	if (sa_query->flags & IB_SA_QUERY_OPA) {
-		if (num_prs != 1) {
-			query->callback(-EINVAL, NULL, 0, query->context);
-			return;
-		}
-
-		ib_unpack(opa_path_rec_table, ARRAY_SIZE(opa_path_rec_table),
-			  mad->data, &rec);
-		rec.rec_type = SA_PATH_REC_TYPE_OPA;
-		query->callback(status, &rec, num_prs, query->context);
-	} else {
-		if (!sa_query->resp_pr_data)
-			ib_sa_pr_callback_single(query, status, mad);
-		else
-			ib_sa_pr_callback_multiple(query, status, num_prs,
-						   sa_query->resp_pr_data);
-	}
-}
-
 static void ib_sa_path_rec_release(struct ib_sa_query *sa_query)
 {
 	struct ib_sa_path_query *query =
@@ -1578,7 +1520,7 @@ int ib_sa_path_rec_get(struct ib_sa_client *client,
 		       unsigned long timeout_ms, gfp_t gfp_mask,
 		       void (*callback)(int status,
 					struct sa_path_rec *resp,
-					int num_paths, void *context),
+					unsigned int num_paths, void *context),
 		       void *context,
 		       struct ib_sa_query **sa_query)
 {
@@ -1677,8 +1619,7 @@ int ib_sa_path_rec_get(struct ib_sa_client *client,
 EXPORT_SYMBOL(ib_sa_path_rec_get);
 
 static void ib_sa_mcmember_rec_callback(struct ib_sa_query *sa_query,
-					int status, int num_prs,
-					struct ib_sa_mad *mad)
+					int status, struct ib_sa_mad *mad)
 {
 	struct ib_sa_mcmember_query *query =
 		container_of(sa_query, struct ib_sa_mcmember_query, sa_query);
@@ -1769,8 +1710,7 @@ int ib_sa_mcmember_rec_query(struct ib_sa_client *client,
 
 /* Support GuidInfoRecord */
 static void ib_sa_guidinfo_rec_callback(struct ib_sa_query *sa_query,
-					int status, int num_paths,
-					struct ib_sa_mad *mad)
+					int status, struct ib_sa_mad *mad)
 {
 	struct ib_sa_guidinfo_query *query =
 		container_of(sa_query, struct ib_sa_guidinfo_query, sa_query);
@@ -1879,8 +1819,7 @@ static void ib_classportinfo_cb(void *context)
 }
 
 static void ib_sa_classport_info_rec_callback(struct ib_sa_query *sa_query,
-					      int status, int num_prs,
-					      struct ib_sa_mad *mad)
+					      int status, struct ib_sa_mad *mad)
 {
 	unsigned long flags;
 	struct ib_sa_classport_info_query *query =
@@ -2055,13 +1994,13 @@ static void send_handler(struct ib_mad_agent *agent,
 			/* No callback -- already got recv */
 			break;
 		case IB_WC_RESP_TIMEOUT_ERR:
-			query->callback(query, -ETIMEDOUT, 0, NULL);
+			query->callback(query, -ETIMEDOUT, NULL);
 			break;
 		case IB_WC_WR_FLUSH_ERR:
-			query->callback(query, -EINTR, 0, NULL);
+			query->callback(query, -EINTR, NULL);
 			break;
 		default:
-			query->callback(query, -EIO, 0, NULL);
+			query->callback(query, -EIO, NULL);
 			break;
 		}
 
@@ -2089,10 +2028,10 @@ static void recv_handler(struct ib_mad_agent *mad_agent,
 		if (mad_recv_wc->wc->status == IB_WC_SUCCESS)
 			query->callback(query,
 					mad_recv_wc->recv_buf.mad->mad_hdr.status ?
-					-EINVAL : 0, 1,
+					-EINVAL : 0,
 					(struct ib_sa_mad *) mad_recv_wc->recv_buf.mad);
 		else
-			query->callback(query, -EIO, 0, NULL);
+			query->callback(query, -EIO, NULL);
 	}
 
 	ib_free_recv_mad(mad_recv_wc);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index ac25fc80fb33..4b3a7dbc21a4 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -742,7 +742,7 @@ void ipoib_flush_paths(struct net_device *dev)
 
 static void path_rec_completion(int status,
 				struct sa_path_rec *pathrec,
-				int num_prs, void *path_ptr)
+				unsigned int num_prs, void *path_ptr)
 {
 	struct ipoib_path *path = path_ptr;
 	struct net_device *dev = path->dev;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b4d6a4a5ae81..df21b30b7735 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -699,7 +699,7 @@ static void srp_free_ch_ib(struct srp_target_port *target,
 
 static void srp_path_rec_completion(int status,
 				    struct sa_path_rec *pathrec,
-				    int num_paths, void *ch_ptr)
+				    unsigned int num_paths, void *ch_ptr)
 {
 	struct srp_rdma_ch *ch = ch_ptr;
 	struct srp_target_port *target = ch->target;
diff --git a/include/rdma/ib_sa.h b/include/rdma/ib_sa.h
index e930bec33b31..b46353fc53bf 100644
--- a/include/rdma/ib_sa.h
+++ b/include/rdma/ib_sa.h
@@ -414,7 +414,7 @@ int ib_sa_path_rec_get(struct ib_sa_client *client, struct ib_device *device,
 		       ib_sa_comp_mask comp_mask, unsigned long timeout_ms,
 		       gfp_t gfp_mask,
 		       void (*callback)(int status, struct sa_path_rec *resp,
-					int num_prs, void *context),
+					unsigned int num_prs, void *context),
 		       void *context, struct ib_sa_query **query);
 
 struct ib_sa_multicast {
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index cdc7cafab572..8a8ab2f793ab 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -49,7 +49,6 @@ struct rdma_addr {
 	struct rdma_dev_addr dev_addr;
 };
 
-#define RDMA_PRIMARY_PATH_MAX_REC_NUM 3
 struct rdma_route {
 	struct rdma_addr addr;
 	struct sa_path_rec *path_rec;
-- 
2.38.1

