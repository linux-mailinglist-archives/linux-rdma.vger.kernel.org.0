Return-Path: <linux-rdma+bounces-11761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B6AEDA4D
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83EB188FFEA
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58B258CFF;
	Mon, 30 Jun 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp4fOUxd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A8248F55
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280781; cv=none; b=gs9jxrtu6Tz25sCmtwuId/ZlrBGamr2l7QSxr6Z4TVOsA3q032Xery+7eARzD8Z25reBD42sba/ZUNeP8VDSpKUC4avH8FboRYdzxME2lYxvr0FhmeK91oBY/eqUSRavVXI21kwfQmPz6hNd11bj5zJ3L9Kt/OX4WXGYe1pcMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280781; c=relaxed/simple;
	bh=oWsF2EGHjVyVxk0JicQRr0//THLKt5N0TH6afCh8UjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+gIDVH7OYZJoGR2lY16KDfC1mEnAI3lUw3N7bWcgMbVBEpJIzkjOtTu5tItN1Me4uGJUFiKsbE8ihrdand3z/aNntU/xT2V4NhIxvIDSa0v7sw+HJomMKTg19JuR1T6mxAGAjCF1EMWzPOZ+G8/Z/x4QR5DRxyClEkLsXhezk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp4fOUxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0DAC4CEE3;
	Mon, 30 Jun 2025 10:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751280781;
	bh=oWsF2EGHjVyVxk0JicQRr0//THLKt5N0TH6afCh8UjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tp4fOUxdhj/EYILw8ZGlqlJN1Yhr5YGn+RfgRHA28vxnUVPs43dwqNl3TQL83KV2Z
	 wkkicYSp4xYG2gpZaDdSBW4JsO4hzisDxqybn09G2+z5p+BvlMRUUUdAxucoRdF9TU
	 /MhraaAuzvvsOberzDGc7gDZz0zs09I0m+Jq4/zrpA+zKLBu5UJQOzSoOHxyVtqiTS
	 zPbtQKZEJHFtmTe4uhZSJrWmplKVkzqZj90vg6XFKWQzNHGbVhKF+AWViAEgSmu4QI
	 u7MUo9i9DvuSrQncdB/N+9NV1gIWr74qm7yIiPKw6/4TGwyilbKcZjHZieGQm7pYo9
	 NHUSsPHhhCJgA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 1/5] RDMA/sa_query: Add RMPP support for SA queries
Date: Mon, 30 Jun 2025 13:52:31 +0300
Message-ID: <81dbcb48682e1838dc40f381cdcc0dc63f25f0f1.1751279793.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751279793.git.leonro@nvidia.com>
References: <cover.1751279793.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Register GSI mad agent with RMPP support and add rmpp_callback for
SA queries. This is needed for querying more than one service record
in one query.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sa_query.c | 39 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 53571e6b3162..770e9f18349b 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -107,6 +107,8 @@ struct ib_sa_device {
 struct ib_sa_query {
 	void (*callback)(struct ib_sa_query *sa_query, int status,
 			 struct ib_sa_mad *mad);
+	void (*rmpp_callback)(struct ib_sa_query *sa_query, int status,
+			      struct ib_mad_recv_wc *mad);
 	void (*release)(struct ib_sa_query *);
 	struct ib_sa_client    *client;
 	struct ib_sa_port      *port;
@@ -1987,23 +1989,29 @@ static void send_handler(struct ib_mad_agent *agent,
 {
 	struct ib_sa_query *query = mad_send_wc->send_buf->context[0];
 	unsigned long flags;
+	int status = 0;
 
-	if (query->callback)
+	if (query->callback || query->rmpp_callback) {
 		switch (mad_send_wc->status) {
 		case IB_WC_SUCCESS:
 			/* No callback -- already got recv */
 			break;
 		case IB_WC_RESP_TIMEOUT_ERR:
-			query->callback(query, -ETIMEDOUT, NULL);
+			status = -ETIMEDOUT;
 			break;
 		case IB_WC_WR_FLUSH_ERR:
-			query->callback(query, -EINTR, NULL);
+			status = -EINTR;
 			break;
 		default:
-			query->callback(query, -EIO, NULL);
+			status = -EIO;
 			break;
 		}
 
+		if (status)
+			query->callback ? query->callback(query, status, NULL) :
+				query->rmpp_callback(query, status, NULL);
+	}
+
 	xa_lock_irqsave(&queries, flags);
 	__xa_erase(&queries, query->id);
 	xa_unlock_irqrestore(&queries, flags);
@@ -2019,17 +2027,25 @@ static void recv_handler(struct ib_mad_agent *mad_agent,
 			 struct ib_mad_recv_wc *mad_recv_wc)
 {
 	struct ib_sa_query *query;
+	struct ib_mad *mad;
+
 
 	if (!send_buf)
 		return;
 
 	query = send_buf->context[0];
-	if (query->callback) {
+	mad = mad_recv_wc->recv_buf.mad;
+
+	if (query->rmpp_callback) {
+		if (mad_recv_wc->wc->status == IB_WC_SUCCESS)
+			query->rmpp_callback(query, mad->mad_hdr.status ?
+					     -EINVAL : 0, mad_recv_wc);
+		else
+			query->rmpp_callback(query, -EIO, NULL);
+	} else if (query->callback) {
 		if (mad_recv_wc->wc->status == IB_WC_SUCCESS)
-			query->callback(query,
-					mad_recv_wc->recv_buf.mad->mad_hdr.status ?
-					-EINVAL : 0,
-					(struct ib_sa_mad *) mad_recv_wc->recv_buf.mad);
+			query->callback(query, mad->mad_hdr.status ?
+					-EINVAL : 0, (struct ib_sa_mad *)mad);
 		else
 			query->callback(query, -EIO, NULL);
 	}
@@ -2181,8 +2197,9 @@ static int ib_sa_add_one(struct ib_device *device)
 
 		sa_dev->port[i].agent =
 			ib_register_mad_agent(device, i + s, IB_QPT_GSI,
-					      NULL, 0, send_handler,
-					      recv_handler, sa_dev, 0);
+					      NULL, IB_MGMT_RMPP_VERSION,
+					      send_handler, recv_handler,
+					      sa_dev, 0);
 		if (IS_ERR(sa_dev->port[i].agent)) {
 			ret = PTR_ERR(sa_dev->port[i].agent);
 			goto err;
-- 
2.50.0


