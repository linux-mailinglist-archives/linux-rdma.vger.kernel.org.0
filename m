Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF33941D1
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhE1LcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhE1LcK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF5C0613ED
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h20so4890112ejg.1
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrwBwRyV/dgjPl2sDnRgTh6UPcWjl8bJANqc538yFec=;
        b=FfJlDuRjtk6zWTQPpprS0E/rQdubvyAwgamb72Bhz036F/1mZbFOcHCUd7VW7CBm3M
         H+IHnp7O1Nx6L4EO8utzfdmjo7fvqS/HpG/+eWoZ2UKUA3v/wRkacMZx/0jnLfTw2xFQ
         qB9vjz4ufAbRWIAJyikbD7etMigVk1qfDdDTjIm8HWC7N7fq2+VsPjIuSHbrnmdKkrXk
         0tftzNnumblJa+9oaRDi0BYLP0mmauMGDvmgVG4QLN84vkx3It1ApdmYF0xW2AUJQgJv
         icow/plqKjMALdIdhvJhF/cfnZBkzGIZ3QusrBlZWl1geVfm+UzUIm8wQJAiqJ6jYe7F
         Vi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrwBwRyV/dgjPl2sDnRgTh6UPcWjl8bJANqc538yFec=;
        b=gzFC2jC5lHJsmpQKJoFwUpR5yoap6CSSrIrwWiXwXpbTonavuR6y1OjW4AnuQ51HLa
         f+YQTC+/old0mG1VbTliWqDyvpXvFlse/eYiWzBQ7Yxl5pmQpkxFrfHtOAbm/p1HXrtq
         08N8qo+Yx9+lUtIXcmzG16zchvhypfFR/UPyBUyETLcxZZSI+omVhcguYtk0zXCPjfvm
         KznDHwJd6cKUy3gB3oN/vEI6AzAi71c31lbnkIJTMhCY+M3m+GZ7wMRGD8P4r0gH/3H3
         ieKbzqT8LMNHblrLNmjhS2ANKbqY2k8dcfW2u048WcTWi+l+FEvjxiSivHqWrApbbgM3
         Qujw==
X-Gm-Message-State: AOAM5333dVo7hfU7Onn0+7MD3PZiNkGQ2Gj56yeue4a4SnOzXSBIR1ro
        1jvuH8qhvGhvG8NUF8FMqnADFg1H2lan+A==
X-Google-Smtp-Source: ABdhPJxdzCJSQ4WX0ubrVs6jCmmIh3KBt8J70lSqa3JsjeAvSAsSfjWlhkWXbepcFluni8aXjupEiQ==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr8656804ejg.110.1622201433539;
        Fri, 28 May 2021 04:30:33 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:33 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCHv3 for-next 16/20] RDMA/rtrs-srv: Duplicated session name is not allowed
Date:   Fri, 28 May 2021 13:30:14 +0200
Message-Id: <20210528113018.52290-17-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
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
index 631d37976518..78a861843705 100644
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

