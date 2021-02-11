Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72735318573
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 07:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhBKG4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 01:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhBKG4L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 01:56:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674AC061756
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jj19so8407916ejc.4
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijWmNBgdVqV2aikZKyuWUCOGIDslRVULqYr5gV77ad8=;
        b=hYUkO2hyQY7ATofvDCYz5Uyxwy6yb9iTVwXgrMB5eLGKLJNbXCBIF9FE8pNlSjDfzk
         ph8gLHKvTz+m2oJMNz7jOWSQoafluf/26L78JvDMroE7Vqh8F1Xv3KC4n9OAcd/dhrFF
         4HROssiKkVgemfLwBocvhHCEysXaPzAo0kf3iVKnS/kSebYboVqUZvS1AfAK7iwBkOQS
         aDuE4IGWAr2ULshiBF7pzOaDjQ9Sr3UD7YdFA+lyeVEdCGTrzMFc9h7oJn71UUtTV3el
         HxemL4ABEgUeM0Xw/B3sCJn5n6g1gYUKoRauc9Dr5aNJxe/WrSn2onKwvaRl9EERbT3V
         DWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijWmNBgdVqV2aikZKyuWUCOGIDslRVULqYr5gV77ad8=;
        b=iy8vyODTcTfWGcTT39ZTOacAdlq9ZQ4TCYqR9lhs/oX1PczACFYpY8kLLaFgrRC1dG
         76zp78rWUaNZwG8PZkccU2zfOymFyo8Rgat07S5EP33cZ9hQSBMtmDPeKMQ4vKBN3t/v
         EkjXRisco3vU+V+A+K0VFqN8V159Fgg/SMSzeCZOr/rhdcxDLgmHmptTWw5rzNN/7Fy5
         r7/I+Oau0j4Ga/NL964AthZwrqAoxwBtfKy596jtE8719JyUEJSTTJ4Yep+PWrtajLTH
         bMSyZMqdCpt77JmtG7RgSsi+aPyhnJ5xoUMlEMiyaHawm2L0A1m7boNGPWwd3I3ats9H
         j1Lg==
X-Gm-Message-State: AOAM530Ngf0bl/ByIjptxC1hO+iuZf3w+ocvUL28rqB/SUvM1qkbnKUH
        vQoQ3wFJ/CNld8TAI7cXF11N3sYxEgq+GQ==
X-Google-Smtp-Source: ABdhPJyF8tj2UgOfvukupgofvu48FnMw2AP4kpizz5aRV4TnXEAXc5K71krb6amV5vs+9qzghT7eiA==
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr6731094ejd.449.1613026529152;
        Wed, 10 Feb 2021 22:55:29 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49a6:4a00:4d27:617f:73f7:3a8b])
        by smtp.gmail.com with ESMTPSA id v9sm3241486ejd.92.2021.02.10.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 22:55:28 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: [PATCH for-next 2/4] RDMA/rtrs: Only allow addition of path to an already established session
Date:   Thu, 11 Feb 2021 07:55:24 +0100
Message-Id: <20210211065526.7510-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

While adding a path from the client side to an already established
session, it was possible to provide the destination IP to a different
server. This is dangerous.

This commit adds an extra member to the rtrs_msg_conn_req structure, named
first_conn; which is supposed to notify if the connection request is the
first for that session or not.

On the server side, if a session does not exist but the first_conn
received inside the rtrs_msg_conn_req structure is 1, the connection
request is failed. This signifies that the connection request is for an
already existing session, and since the server did not find one, it is an
wrong connection request.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  5 +++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  4 +++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 21 ++++++++++++++++-----
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7644c3f627ca..a110e520b0a4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -31,6 +31,8 @@
  */
 #define RTRS_RECONNECT_SEED 8
 
+#define FIRST_CONN 0x01
+
 MODULE_DESCRIPTION("RDMA Transport Client");
 MODULE_LICENSE("GPL");
 
@@ -1660,6 +1662,7 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 		.cid_num = cpu_to_le16(sess->s.con_num),
 		.recon_cnt = cpu_to_le16(sess->s.recon_cnt),
 	};
+	msg.first_conn = sess->for_new_clt ? (FIRST_CONN & 0xff) : 0;
 	uuid_copy(&msg.sess_uuid, &sess->s.uuid);
 	uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
 
@@ -2662,6 +2665,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 			err = PTR_ERR(sess);
 			goto close_all_sess;
 		}
+		sess->for_new_clt = true;
 		list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
 
 		err = init_sess(sess);
@@ -2913,6 +2917,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	if (IS_ERR(sess))
 		return PTR_ERR(sess);
 
+	sess->for_new_clt = false;
 	/*
 	 * It is totally safe to add path in CONNECTING state: coming
 	 * IO will never grab it.  Also it is very important to add
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index a97a068c4c28..3f1a05373470 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -143,6 +143,7 @@ struct rtrs_clt_sess {
 	int			max_send_sge;
 	u32			flags;
 	struct kobject		kobj;
+	bool			for_new_clt;
 	struct rtrs_clt_stats	*stats;
 	/* cache hca_port and hca_name to display in sysfs */
 	u8			hca_port;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index d5621e6fad1b..8caad0a2322b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -188,7 +188,9 @@ struct rtrs_msg_conn_req {
 	__le16		recon_cnt;
 	uuid_t		sess_uuid;
 	uuid_t		paths_uuid;
-	u8		reserved[12];
+	u8		first_conn : 1;
+	u8		reserved_bits : 7;
+	u8		reserved[11];
 };
 
 /**
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index e13e91c2a44a..2538a84fe5fc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1333,10 +1333,12 @@ static void free_srv(struct rtrs_srv *srv)
 }
 
 static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
-					   const uuid_t *paths_uuid)
+					  const uuid_t *paths_uuid,
+					  bool first_conn)
 {
 	struct rtrs_srv *srv;
 	int i;
+	int err = -ENOMEM;
 
 	mutex_lock(&ctx->srv_mutex);
 	list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
@@ -1346,12 +1348,20 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 			return srv;
 		}
 	}
+	/*
+	 * If this request is not the first connection request from the
+	 * client for this session then fail and return error.
+	 */
+	if (!first_conn) {
+		err = -ENXIO;
+		goto err;
+	}
 
 	/* need to allocate a new srv */
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
 	if  (!srv) {
 		mutex_unlock(&ctx->srv_mutex);
-		return NULL;
+		goto err;
 	}
 
 	INIT_LIST_HEAD(&srv->paths_list);
@@ -1386,7 +1396,8 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 
 err_free_srv:
 	kfree(srv);
-	return NULL;
+err:
+	return ERR_PTR(err);
 }
 
 static void put_srv(struct rtrs_srv *srv)
@@ -1787,12 +1798,12 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 		goto reject_w_econnreset;
 	}
 	recon_cnt = le16_to_cpu(msg->recon_cnt);
-	srv = get_or_create_srv(ctx, &msg->paths_uuid);
+	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
 	/*
 	 * "refcount == 0" happens if a previous thread calls get_or_create_srv
 	 * allocate srv, but chunks of srv are not allocated yet.
 	 */
-	if (!srv || refcount_read(&srv->refcount) == 0) {
+	if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
 		err = -ENOMEM;
 		goto reject_w_err;
 	}
-- 
2.25.1

