Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C6831A006
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhBLNqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhBLNqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:46:10 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5EC0613D6
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hs11so15746106ejc.1
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqgjm/44pTjB7bk1jjk4ULd06LY0GKxoXjhfITjUNKM=;
        b=KbSXqAPn2etQ8ce4JzY6/XAJJNOP4aTtH2TbW1T7KfBSr9IhDY3kdKAshchE8Ary2r
         8M0R5l4Z4UXfW2A8/ZuFQVx/vpQ9+B6EeX20Dd5YeOSx2x0vmIk2XtTKw/5uW/YlOwuw
         /SvcvOcoVSuW08rKOmG8ea5WN7GKqcuxWueDuUlI7kEPD3zWz/IM6LgZBWIs6+NMtFF0
         XPjqR1k+GIHhqOOtFkZ1zOnHbjSSw6HBBeYof5oXwysYVf2sROCs/+FmNnbw3Xfrr8EQ
         EktNwRAbfrkxZ8wxLC2T1vL9Jg45FzgYBnOoDdb2/ptDNm9rpLb6ll2+z6w5KweopNnR
         5zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqgjm/44pTjB7bk1jjk4ULd06LY0GKxoXjhfITjUNKM=;
        b=ekIwu0uOGj8K/l4P+Dt7HYO7nQAxakqxjAg5smQ6dNpa/TjcQtD98qk7wYLCmULf5j
         FBU5Kn1X4manLDKZFernjb+IsCqzvLy1eiV3AaduhbnLsUiJX9UqYmalDYxc7o+2eFUV
         6dOlWfiz07KIUwRGqYu3POKRSlwlQLsF1kxDketjWga268E7X8WwBc29rsQIpb6yYl61
         OlO12qHXgrCHW+LrdS2iF0QIr7qFrik69RjCkLyWtvy4K1QO8NXM+UE27gxxJ+d+H+vf
         WcoReq4kVtzB2JOykDKM5Yz22a97M3VILeSnaYBLNqrUw+eMonQE63UuZEjwEqF892n9
         KPiA==
X-Gm-Message-State: AOAM5318dtgtSvxCE+lq4CDLOGB64sUqtt8OUWGVyX+cGdkvL/1OHe/0
        h+ZumBUckj4xnzYXGgz+dVZKRGCLnygYmw==
X-Google-Smtp-Source: ABdhPJycD5nTJVc3FdrcRq3vlTUbxKx5Uc5h+1kw2zZXS1z/xcW99z/AQaeoH1opAvc/pHQ+u7NF/Q==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr3041660ejb.533.1613137528193;
        Fri, 12 Feb 2021 05:45:28 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49fe:3100:e80f:dbb4:eac5:c974])
        by smtp.gmail.com with ESMTPSA id o4sm5856197edw.78.2021.02.12.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:45:27 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: [PATCHv2 for-next 2/4] RDMA/rtrs: Only allow addition of path to an already established session
Date:   Fri, 12 Feb 2021 14:45:23 +0100
Message-Id: <20210212134525.103456-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
References: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  7 +++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  4 +++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 21 +++++++++++++++------
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7644c3f627ca..0a08b4b742a3 100644
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
+	msg.first_conn = sess->for_new_clt ? FIRST_CONN : 0;
 	uuid_copy(&msg.sess_uuid, &sess->s.uuid);
 	uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
 
@@ -1745,6 +1748,8 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 		scnprintf(sess->hca_name, sizeof(sess->hca_name),
 			  sess->s.dev->ib_dev->name);
 		sess->s.src_addr = con->c.cm_id->route.addr.src_addr;
+		/* set for_new_clt, to allow future reconnect on any path */
+		sess->for_new_clt = 1;
 	}
 
 	return 0;
@@ -2662,6 +2667,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 			err = PTR_ERR(sess);
 			goto close_all_sess;
 		}
+		if (!i)
+			sess->for_new_clt = 1;
 		list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
 
 		err = init_sess(sess);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index a97a068c4c28..692bc83e1f09 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -143,6 +143,7 @@ struct rtrs_clt_sess {
 	int			max_send_sge;
 	u32			flags;
 	struct kobject		kobj;
+	u8			for_new_clt;
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
index e13e91c2a44a..fbe39360ff12 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1333,7 +1333,8 @@ static void free_srv(struct rtrs_srv *srv)
 }
 
 static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
-					   const uuid_t *paths_uuid)
+					  const uuid_t *paths_uuid,
+					  bool first_conn)
 {
 	struct rtrs_srv *srv;
 	int i;
@@ -1346,12 +1347,20 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 			return srv;
 		}
 	}
+	/*
+	 * If this request is not the first connection request from the
+	 * client for this session then fail and return error.
+	 */
+	if (!first_conn) {
+		mutex_unlock(&ctx->srv_mutex);
+		return ERR_PTR(-ENXIO);
+	}
 
 	/* need to allocate a new srv */
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
 	if  (!srv) {
 		mutex_unlock(&ctx->srv_mutex);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	INIT_LIST_HEAD(&srv->paths_list);
@@ -1386,7 +1395,7 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 
 err_free_srv:
 	kfree(srv);
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 static void put_srv(struct rtrs_srv *srv)
@@ -1787,13 +1796,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
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
-		err = -ENOMEM;
+	if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
+		err = PTR_ERR(srv);
 		goto reject_w_err;
 	}
 	mutex_lock(&srv->paths_mutex);
-- 
2.25.1

