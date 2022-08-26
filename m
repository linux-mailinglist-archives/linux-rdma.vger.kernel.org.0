Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B75A22A5
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiHZILg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiHZILf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 04:11:35 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D00D2B09;
        Fri, 26 Aug 2022 01:11:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661501489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iAM7OlsBY3uZD6DoAcoLFC/wHZG5p2niuF8LSa81N2Q=;
        b=ZCZlbKPEDSUBbTb2utbbFCY5ltdf3tzxPExxqA+uPsc8Ecc2CHLyu+an4VkgKyiOlfZNU1
        1R7GxVg4CeWwtjtWCOfDb2MiCmz/mYOrUJ9nogs/5opRpTUDp+zYTC6syiNAoH4luypMM9
        6Jje6mCqIUnGJPQV3901Nfml9FOQAgA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        jgg@ziepe.ca, leon@kernel.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
Date:   Fri, 26 Aug 2022 16:11:17 +0800
Message-Id: <20220826081117.21687-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since all callers (process_{read,write}) set id->dir, no need to
pass 'dir' again.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
 drivers/block/rnbd/rnbd-srv.h          | 1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 3f6c268e04ef..9600715f1029 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -368,10 +368,9 @@ static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen);
 
-static int rnbd_srv_rdma_ev(void *priv,
-			    struct rtrs_srv_op *id, int dir,
-			    void *data, size_t datalen, const void *usr,
-			    size_t usrlen)
+static int rnbd_srv_rdma_ev(void *priv, struct rtrs_srv_op *id,
+			    void *data, size_t datalen,
+			    const void *usr, size_t usrlen)
 {
 	struct rnbd_srv_session *srv_sess = priv;
 	const struct rnbd_msg_hdr *hdr = usr;
@@ -398,7 +397,7 @@ static int rnbd_srv_rdma_ev(void *priv,
 		break;
 	default:
 		pr_warn("Received unexpected message type %d with dir %d from session %s\n",
-			type, dir, srv_sess->sessname);
+			type, id->dir, srv_sess->sessname);
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 081bceaf4ae9..5a0ef6c2b5c7 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -14,6 +14,7 @@
 #include <linux/kref.h>
 
 #include <rtrs.h>
+#include <rtrs-srv.h>
 #include "rnbd-proto.h"
 #include "rnbd-log.h"
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 34c03bde5064..9dc50ff0e1b9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1024,7 +1024,7 @@ static void process_read(struct rtrs_srv_con *con,
 	usr_len = le16_to_cpu(msg->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
-	ret = ctx->ops.rdma_ev(srv->priv, id, READ, data, data_len,
+	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
 			   data + data_len, usr_len);
 
 	if (ret) {
@@ -1077,7 +1077,7 @@ static void process_write(struct rtrs_srv_con *con,
 	usr_len = le16_to_cpu(req->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
-	ret = ctx->ops.rdma_ev(srv->priv, id, WRITE, data, data_len,
+	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
 			       data + data_len, usr_len);
 	if (ret) {
 		rtrs_err_rl(s,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index 5e57a7ccc7fb..b48b53a7c143 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -139,7 +139,6 @@ struct rtrs_srv_ops {
 
 	 *	@priv:		Private data set by rtrs_srv_set_sess_priv()
 	 *	@id:		internal RTRS operation id
-	 *	@dir:		READ/WRITE
 	 *	@data:		Pointer to (bidirectional) rdma memory area:
 	 *			- in case of %RTRS_SRV_RDMA_EV_RECV contains
 	 *			data sent by the client
@@ -151,7 +150,7 @@ struct rtrs_srv_ops {
 	 *	@usrlen:	Size of the user message
 	 */
 	int (*rdma_ev)(void *priv,
-		       struct rtrs_srv_op *id, int dir,
+		       struct rtrs_srv_op *id,
 		       void *data, size_t datalen, const void *usr,
 		       size_t usrlen);
 	/**
-- 
2.31.1

