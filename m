Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25F382822
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhEQJVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbhEQJUx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C2C06138A
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i13so5980273edb.9
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfIr32D4aP9beM3IFNh0hR55n7jDBSX/84OOnjlOM7c=;
        b=iWC9I6uhVXUeIODPlW/Qvq8k3mh4pUIsdgIvanC+dnxTjWVJFSqvBEnENkL0PwC87F
         orV2kbjgUGwNloCMj3eORKYeSMb0L9/vXZn7Q8pki0dSAsTRxuMggBxQB32hfOzge/yP
         YLSKbu6KLvrlyg8ayKQMzwT2lbckBR6SxFZrmjeYgJgbUzX/ZFf6Sn71Xt/3aCenV0c8
         BcdNO/jB0b5rRumurQabz1k+K/Cn6qxCM0OZVgfLSs0h3VbSk2Xl6RGE8K8R8UsDUZ/D
         Rq5otsNYGbaODvBGS2FHd1lv/F5DDKP1qkC4kxHUTXO4M5CbyfbetJtvASRFt2Z2Abf9
         16jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfIr32D4aP9beM3IFNh0hR55n7jDBSX/84OOnjlOM7c=;
        b=trKyVAXwOWAZ432saM6wYpR8/d/Ezgb/etnowBeG7bs+9dd5xqpasqSKxp0L1hymhI
         dL3JHJo2l9aSv4VGCa5lcpUSegrE2V+WAVn6o9IE0Loi+8+issNSuNJCP2AGbx0olP6i
         JTaFoDp456tSEul+MTlKFMnPfO0c4nqCvclubsiYpJMVfGavSqtO2oCA83St4jBkW1b+
         eQ+ms8gXZ/X9T3hzC2sA0xiKSiKvwmzeYZuc5ki0Vx9cuGlN6wW5ny/8zALkkFK6TjFd
         8dwNm7xqge6KSO1FlDYMRV1gnTUGgfXgl7zl6XcA2CDKr8mbwH+pU0kXtlcO3/+LUrgn
         ST5A==
X-Gm-Message-State: AOAM530ZAqlDy3yQxnfnFy/Rf0Ot34G1+b1sEzO7FQpsdVr2and52Npx
        KuWqBrMc6UyBVagGNJI7SMzxpCU3UnF/SQ==
X-Google-Smtp-Source: ABdhPJyw1n1/rXHMqx13czbjZPnbjnnv4CmMX0igpBDp4dqAczSMN3mbvA84aKq+9eTxBf8zqdpWig==
X-Received: by 2002:a05:6402:2750:: with SMTP id z16mr72958337edd.355.1621243170002;
        Mon, 17 May 2021 02:19:30 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:29 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 19/19] RDMA/rtrs-clt: Fix memory leak of not-freed sess->stats and stats->pcpu_stats
Date:   Mon, 17 May 2021 11:18:43 +0200
Message-Id: <20210517091844.260810-20-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

sess->stats and sess->stats->pcpu_stats objects are freed
when sysfs entry is removed. If something wrong happens and
session is closed before sysfs entry is created,
sess->stats and sess->stats->pcpu_stats objects are not freed.

This patch adds freeing of them at three places:
1. When client uses wrong address and session creation fails.
2. When client fails to create a sysfs entry.
3. When client adds wrong address via sysfs add_path.

Fixes: 215378b838df0 ("RDMA/rtrs: client: sysfs interface functions")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 1bfa3f86c430..2323c9ddae97 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2759,6 +2759,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		if (err) {
 			list_del_rcu(&sess->s.entry);
 			rtrs_clt_close_conns(sess, true);
+			free_percpu(sess->stats->pcpu_stats);
+			kfree(sess->stats);
 			free_sess(sess);
 			goto close_all_sess;
 		}
@@ -2767,6 +2769,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		if (err) {
 			list_del_rcu(&sess->s.entry);
 			rtrs_clt_close_conns(sess, true);
+			free_percpu(sess->stats->pcpu_stats);
+			kfree(sess->stats);
 			free_sess(sess);
 			goto close_all_sess;
 		}
@@ -3017,6 +3021,8 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 close_sess:
 	rtrs_clt_remove_path_from_arr(sess);
 	rtrs_clt_close_conns(sess, true);
+	free_percpu(sess->stats->pcpu_stats);
+	kfree(sess->stats);
 	free_sess(sess);
 
 	return err;
-- 
2.25.1

