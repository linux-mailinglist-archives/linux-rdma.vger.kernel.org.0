Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B237148A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhECLta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhECLt1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA28C061763
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j28so5890681edy.9
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AFssk4vYn87Je19kU9X+lMnM4szgEIphFe9y5zVq/iY=;
        b=LurMAMBeH9qeS0Z6tJMoPZGA1H81NV8EzMKg0JNnn/j6ngvQj0FMZb9SGl5n8xsksc
         +zJUl5HkZspewTQQfJakDvO2s2YhDmfJbsGba/dXpeWpIh2BIvPhjrD8OXoZoHvSr4RI
         zY+DZq212UINJH4a2advb2ZAG2V+p5LNcvJKn3XQ3w9FlNuvEUn2C4NxbOKJSkKYlHT2
         00wK66BRWNnZuJsay+dbGW6too/LFxXoF23kqqG7LcM5RAishk7SpjV8AzlwSp5ESyAF
         CJLsq02HfEUi0T/Y7/Of+PkJxuefj5V5wTHyhqtmGLBCfOx7IZN5aHHhVECeON4en/fU
         8SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFssk4vYn87Je19kU9X+lMnM4szgEIphFe9y5zVq/iY=;
        b=I36z2mYHhBBNuKg8wUBqWra+JGcj1bclIay2SKfnJduShUONx5HOR+rzkG7GHvR9w+
         w8bsvUterHwrVsYnPCvigfwDy9lqwVOTkm6VKQN9TwMnFYLUHiG39DdV2e4f0Fp7Qi6F
         fGbFwb3jmVXhUOqazJFPtRE1NZCbVUlQ54ERSKSmhAtXtqjsiiDtjhQWz8/OqeMzPpAk
         8b7yDMgRcWT413sFZrsNUIaAdtDrZFa2K7LHCuNvyUVbNI0ngZVbzvK/KbaIAw9s5F5j
         fEZVv3Kq81gv+kGaJ4nGy7/A5hdK7jpFjt97nWwUO9JRSB3dJW2EZb3Zwpyjr9Fy2COR
         rs3w==
X-Gm-Message-State: AOAM531R7H+Tls1MGBisrAGDHwti937VW8dPeLKznXxKHNqFHRhUr1r4
        TqdD2SpJecUr4U+yutFQ3N9+1XtTDW0cvg==
X-Google-Smtp-Source: ABdhPJz8T/2jcc07pGPjLU4wZJ5p50I6IFadUQfyBFUqBw/Lif/K+WU+dRVPYz9O1TD8WbAVpD8v+A==
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr19675673edv.87.1620042512519;
        Mon, 03 May 2021 04:48:32 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:32 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 16/20] RDMA/rtrs-srv: Duplicated session name is not allowed
Date:   Mon,  3 May 2021 13:48:14 +0200
Message-Id: <20210503114818.288896-17-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

If two clients try to use the same session name, rtrs-server generates a
kernel error that it failed to create the sysfs because the filename
is duplicated.

This patch adds code to check if there already exists the same session
name with the different UUID. If a client tries to add more session,
it sends the UUID and the session name. Therefore it is ok if there is
already same session name with the same UUID. The rtrs-server must fail
only-if there is the same session name with the different UUID.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 42 +++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index f66f2be9f519..0e1e303dcbee 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -753,7 +753,40 @@ static void rtrs_srv_sess_down(struct rtrs_srv_sess *sess)
 	mutex_unlock(&srv->paths_ev_mutex);
 }
 
+static bool exist_sessname(struct rtrs_srv_ctx *ctx,
+			   const char *sessname, const uuid_t *path_uuid)
+{
+	struct rtrs_srv *srv;
+	struct rtrs_srv_sess *sess;
+	bool found = false;
+
+	mutex_lock(&ctx->srv_mutex);
+	list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
+		mutex_lock(&srv->paths_mutex);
+
+		/* when a client with same uuid and same sessname tried to add a path */
+		if (uuid_equal(&srv->paths_uuid, path_uuid)) {
+			mutex_unlock(&srv->paths_mutex);
+			continue;
+		}
+
+		list_for_each_entry(sess, &srv->paths_list, s.entry) {
+			if (strlen(sess->s.sessname) == strlen(sessname) &&
+			    !strcmp(sess->s.sessname, sessname)) {
+				found = true;
+				break;
+			}
+		}
+		mutex_unlock(&srv->paths_mutex);
+		if (found)
+			break;
+	}
+	mutex_unlock(&ctx->srv_mutex);
+	return found;
+}
+
 static int post_recv_sess(struct rtrs_srv_sess *sess);
+static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno);
 
 static int process_info_req(struct rtrs_srv_con *con,
 			    struct rtrs_msg_info_req *msg)
@@ -772,10 +805,17 @@ static int process_info_req(struct rtrs_srv_con *con,
 		rtrs_err(s, "post_recv_sess(), err: %d\n", err);
 		return err;
 	}
+
+	if (exist_sessname(sess->srv->ctx,
+			   msg->sessname, &sess->srv->paths_uuid)) {
+		rtrs_err(s, "sessname is duplicated: %s\n", msg->sessname);
+		return -EPERM;
+	}
+	strscpy(sess->s.sessname, msg->sessname, sizeof(sess->s.sessname));
+
 	rwr = kcalloc(sess->mrs_num, sizeof(*rwr), GFP_KERNEL);
 	if (unlikely(!rwr))
 		return -ENOMEM;
-	strscpy(sess->s.sessname, msg->sessname, sizeof(sess->s.sessname));
 
 	tx_sz  = sizeof(*rsp);
 	tx_sz += sizeof(rsp->desc[0]) * sess->mrs_num;
-- 
2.25.1

