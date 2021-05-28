Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544253941D4
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhE1LcZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1LcN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF20C061763
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gb17so4815145ejc.8
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wf/xwTk8dJcDxIyKJjIrWlgy2XpHIkaxNy3ZNk6imnM=;
        b=IvGXNZLCz27ydYzSo891kzVs80DcluELdSD42ctJmMdwPXg5avxILjjuke4tMaewhd
         PqueOhQYc3dr/9tKuLszFtwKl5J/G0qC6lRwTLM88g06Xj4/nw4l2g3TieCGPJXjAJMy
         sx/j6fh0J+ylngs96Hw/OGA51gw86nVZVzEG00oamzPeyTclR9EBmcCyO2xOSBUKI0HE
         V04pbHp0QvgNfCMbCmq08TGwKXZM+Wea2spGby9vti7oV1Ll2CUrKCt4vOGphQqC2X2C
         TqJRkI5lnhWvYulJENBM2KMSZCwHG3UvF1fXYCmdYcMLUhK4U5torOTRKGTttWQzo6BK
         2XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wf/xwTk8dJcDxIyKJjIrWlgy2XpHIkaxNy3ZNk6imnM=;
        b=mKlMehpCcrzeetw+Myf23j3dxbkjfkveL1GzaEeRUVddJArY1/uXBZTdzBjJcivNT2
         +KlmB2wEI9+5k4XPebz7mVkr5mBFH/28g5KTuat0PuLkZYZTMtBra4ngvg1tzjFVA1il
         jcc+yI3v3MLsdXTiwBLFogKbnfdxaz108ueiS4sr9VhzUIrLyVDYRVPJjk89V+Lc57Gk
         j+Zop5UcRaIHmavHVlw9Yd23k2HtFQkRfAKK72cI651ZXEf4p05KzWLxk5gGcyFjjngp
         wKzQZuA+lMcwb+ofGasEV3YR+BkWOsVnmxPko+z3TGRXQnUP0MZ48IYsmq6O/rYnH6eD
         tXWA==
X-Gm-Message-State: AOAM531RftL+USlEMfMlxRqemR+NUyKqqvQIRSKpG/k8fYb3PsYDzWWR
        o1S8qJF77w3dnGBC/mMuYwmUqXERmRRyRw==
X-Google-Smtp-Source: ABdhPJw8Vmig8BvnJ1FhTY4+W9XCndQl9qnaxdGF5R4S1axXFN1vKJJOfAelsJdWgZwYhTMbsc0xZw==
X-Received: by 2002:a17:907:1117:: with SMTP id qu23mr285228ejb.71.1622201436974;
        Fri, 28 May 2021 04:30:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 20/20] RDMA/rtrs-clt: Fix memory leak of not-freed sess->stats and stats->pcpu_stats
Date:   Fri, 28 May 2021 13:30:18 +0200
Message-Id: <20210528113018.52290-21-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
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
index e4a23c40d4c7..8e05a71d8da1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2765,6 +2765,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		if (err) {
 			list_del_rcu(&sess->s.entry);
 			rtrs_clt_close_conns(sess, true);
+			free_percpu(sess->stats->pcpu_stats);
+			kfree(sess->stats);
 			free_sess(sess);
 			goto close_all_sess;
 		}
@@ -2773,6 +2775,8 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		if (err) {
 			list_del_rcu(&sess->s.entry);
 			rtrs_clt_close_conns(sess, true);
+			free_percpu(sess->stats->pcpu_stats);
+			kfree(sess->stats);
 			free_sess(sess);
 			goto close_all_sess;
 		}
@@ -3048,6 +3052,8 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 close_sess:
 	rtrs_clt_remove_path_from_arr(sess);
 	rtrs_clt_close_conns(sess, true);
+	free_percpu(sess->stats->pcpu_stats);
+	kfree(sess->stats);
 	free_sess(sess);
 
 	return err;
-- 
2.25.1

