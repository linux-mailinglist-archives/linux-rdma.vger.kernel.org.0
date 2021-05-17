Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE538281E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbhEQJVF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhEQJUq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA2BC061756
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l1so8119938ejb.6
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AFssk4vYn87Je19kU9X+lMnM4szgEIphFe9y5zVq/iY=;
        b=M5HnIie45Fk67PiYjVv1n07D23/2m/7ZbN7iG6sfU4Hr9ekgJEqegBp/2BH81TOBqb
         pZH2j4Dd3bES47UVx2b78wpPbUUhCo0KzRE1f2zihiEonOC8NQKwrcm3QEQ8WbgYsdR1
         LMzmkqYoX3L9SQSjSLmx9J/FCF1KQb3ZOZ6LBbSPJz2DkJ6cBtETRtH34qKl/7SFUtys
         +gffZNt+kNePbMiXJsHy6NNr7Dr2xTQzwO6O35mJVvu0oHhmr82ce5SEHXo92AdKd7Rt
         0+9zpMMDIU1wYVtNzGg6byZzCIrxRVqtYRsMUZBXngQA8K/LcePVTLDLReeGzFQlzP6F
         SOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFssk4vYn87Je19kU9X+lMnM4szgEIphFe9y5zVq/iY=;
        b=pfnPikotH34uqruf6BHFSdR5hFJl+YPpLKTTePVej3CDm3u5eLT9w7ipw+6yzGVSca
         1yPrC4aWm1qNaS2BzbUVeLx7+1Ilmjlzm2zHKFMRtUFoTXIpe26lhv1Dq/s+mmKeKfDd
         YvpTt5TR8I/b5hcGOyrIkN+epyqiZl8uKNLJGqv6bZMydNw3INRSgVqtKUs78/3UTArH
         aEyBoaOOMG7N6s6E4BNBvxIU6rd16EyWl1TevheeIppjRtCdi46CWmo0DPeAzEL3VXWg
         KOpjb6D7NgwMu/n7Wk9OP4/KPh/8yq+KMT0AHAXRHM7rIqqm58GuJp6ImPTb0DqUmItb
         nfDw==
X-Gm-Message-State: AOAM533dI85Tlj2ZConNooao9b3Ez3vKdyv/vJMc6GfkV1jnCQHL55lv
        WAZmBswbYo6iGoE7QYXVE0PVhjykyBtYNA==
X-Google-Smtp-Source: ABdhPJxzv4dhKhCSUji6tB8HaCyNUggHPNGQ51KlWSZwznJZjiSik/v6Dz1TFOZJO8yfyjiSM2goOw==
X-Received: by 2002:a17:906:170f:: with SMTP id c15mr60385477eje.358.1621243167169;
        Mon, 17 May 2021 02:19:27 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:27 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCHv2 for-next 15/19] RDMA/rtrs-srv: Duplicated session name is not allowed
Date:   Mon, 17 May 2021 11:18:39 +0200
Message-Id: <20210517091844.260810-16-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
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

