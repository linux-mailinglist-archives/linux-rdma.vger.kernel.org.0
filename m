Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65030626D3A
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiKMBIz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiKMBIx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:53 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6030626C2
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:52 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sV+CY13YgHY0UztuLmoBvu3Ttgx3cx33KGSnDdjp2sg=;
        b=qZY6TmgGSKWwSGqGW5ThT2eVWLBttpA6LozS6H9tYwy1weW7/NA1lTnaXEu5H6RodzaEz/
        w4tIbRdtR4N7CpNfd+0ChQ0gZAunhAh49FvpnDWO8BEl/NspN3VJnOoeatCvS6rJ3dCF1k
        pooaX8MKi6YU78URa3faFmakZU/vyhk=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 08/12] RDMA/rtrs: Kill recon_cnt from several structs
Date:   Sun, 13 Nov 2022 09:08:19 +0800
Message-Id: <20221113010823.6436-9-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Seems the only relevant comment about recon_cnt is,

/*
 * On every new session connections increase reconnect counter
 * to avoid clashes with previous sessions not yet closed
 * sessions on a server side.
 */

However, it is not clear how the recon_cnt avoid clashed at these places
in the commit since no where checks it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 --------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 3 ---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 7 +------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5ffc170dae8c..dcc8c041a141 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1802,7 +1802,6 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 		.version = cpu_to_le16(RTRS_PROTO_VER),
 		.cid = cpu_to_le16(con->c.cid),
 		.cid_num = cpu_to_le16(clt_path->s.con_num),
-		.recon_cnt = cpu_to_le16(clt_path->s.recon_cnt),
 	};
 	msg.first_conn = clt_path->for_new_clt ? FIRST_CONN : 0;
 	uuid_copy(&msg.sess_uuid, &clt_path->s.uuid);
@@ -2336,13 +2335,6 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	unsigned int cid;
 	int err;
 
-	/*
-	 * On every new session connections increase reconnect counter
-	 * to avoid clashes with previous sessions not yet closed
-	 * sessions on a server side.
-	 */
-	clt_path->s.recon_cnt++;
-
 	/* Establish all RDMA connections  */
 	for (cid = 0; cid < clt_path->s.con_num; cid++) {
 		err = create_con(clt_path, cid);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index a2420eecaf5a..c4ddaeba1c59 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -109,7 +109,6 @@ struct rtrs_path {
 	struct rtrs_con	**con;
 	unsigned int		con_num;
 	unsigned int		irq_con_num;
-	unsigned int		recon_cnt;
 	unsigned int		signal_interval;
 	struct rtrs_ib_dev	*dev;
 	int			dev_ref;
@@ -177,7 +176,6 @@ struct rtrs_sg_desc {
  * @version:	   RTRS protocol version
  * @cid:	   Current connection id
  * @cid_num:	   Number of connections per session
- * @recon_cnt:	   Reconnections counter
  * @sess_uuid:	   UUID of a session (path)
  * @paths_uuid:	   UUID of a group of sessions (paths)
  *
@@ -196,7 +194,6 @@ struct rtrs_msg_conn_req {
 	__le16		version;
 	__le16		cid;
 	__le16		cid_num;
-	__le16		recon_cnt;
 	uuid_t		sess_uuid;
 	uuid_t		paths_uuid;
 	u8		first_conn : 1;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 4c883c57c2ef..e2ea09a8def7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1712,7 +1712,6 @@ static int create_con(struct rtrs_srv_path *srv_path,
 static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 					   struct rdma_cm_id *cm_id,
 					   unsigned int con_num,
-					   unsigned int recon_cnt,
 					   const uuid_t *uuid)
 {
 	struct rtrs_srv_path *srv_path;
@@ -1768,7 +1767,6 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 
 	srv_path->s.con_num = con_num;
 	srv_path->s.irq_con_num = con_num;
-	srv_path->s.recon_cnt = recon_cnt;
 	uuid_copy(&srv_path->s.uuid, uuid);
 	spin_lock_init(&srv_path->state_lock);
 	INIT_WORK(&srv_path->close_work, rtrs_srv_close_work);
@@ -1818,7 +1816,6 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	struct rtrs_srv_sess *srv;
 
 	u16 version, con_num, cid;
-	u16 recon_cnt;
 	int err = -ECONNRESET;
 	bool alloc_path = false;
 
@@ -1848,7 +1845,6 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 		pr_err("Incorrect cid: %d >= %d\n", cid, con_num);
 		goto reject_w_err;
 	}
-	recon_cnt = le16_to_cpu(msg->recon_cnt);
 	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
 	if (IS_ERR(srv)) {
 		err = PTR_ERR(srv);
@@ -1885,8 +1881,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			goto reject_w_err;
 		}
 	} else {
-		srv_path = __alloc_path(srv, cm_id, con_num, recon_cnt,
-				    &msg->sess_uuid);
+		srv_path = __alloc_path(srv, cm_id, con_num, &msg->sess_uuid);
 		if (IS_ERR(srv_path)) {
 			mutex_unlock(&srv->paths_mutex);
 			put_srv(srv);
-- 
2.31.1

