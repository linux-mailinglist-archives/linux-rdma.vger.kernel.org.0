Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390DC2D471B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgLIQrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgLIQrr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:47 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EFFC0611CF
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:46:07 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ce23so3058114ejb.8
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWpXk/5XKmoU4V5l78k0MQE8DoOGpWuFgtB9vCnVr8s=;
        b=IhObAFrMLBtJG7jUEvY7mCt5Vdjr+8tZhlUBZbxd4zNpNQJ4pbtA+5wVIDfeSVPAuK
         acu6zWsI2N/ZeIpCSNa32UmCFHBJaaauAZRjmBXxU2mhwJsxAyTWl89twGJYrR4nUwhz
         sq0TU5cC+9ZCsGYFQY0h/x2RYSiRZrJWBy3WqoKO0Y6ogUjbvBTrskNzk4deiGzwjjVe
         50D+0QPvbfoJGD0iSDyYxxo4disRT9WVRwvKS76GzN0+JwMFDxg70clNn6btRxkH+1gL
         GDnBw9i5VlYFnA+1KG8Hoh9udu+ZgiHm4SzbBnYn2REEqq5ExM6LTTyxNE+J6WsCV9CN
         xGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWpXk/5XKmoU4V5l78k0MQE8DoOGpWuFgtB9vCnVr8s=;
        b=oM94Mqm1qs8YWKK5CLuEp1aopluM0mqKd216GMJ9/1YPwE37+Ffog9WZcAkluaivoR
         gNF1x0T/0ih1nZ9VAezMth3OLQFNeYS8f8rsVYFbx5ehUL52Tlok6NgP9ZRiiJz4h/jg
         dO6r6nr9e21A1R0IZC8eW14ADWZrAl1uj/BUss56J2QNtg4pzy7y9WNTJt2PBFVj0gzD
         SzKU9JbpkLyJxayGDRd4B/DkEEtHeZGxps9Ri/bAI0X4FgWy5+W70flb2EPis0QcuLOX
         SFEGiZb8LvrYL0xU+JreHEtsUBs4a72BIP3IZC1iuq8kCR3VKFMjxSrg+LE7ADOOzj1A
         4mow==
X-Gm-Message-State: AOAM533ywIYN4m1ZFFLd5ytf5xqBTzp8ra3uq7msoV907u/aoNEA9x84
        MZVBIAlPV2H9l+UvqmO5hmricd7n2fNSdQ==
X-Google-Smtp-Source: ABdhPJyYpaE2xzOa9FCsJGLbwZkzneeK3de8n9iyH8rbOkgvSc5cMYUf5HP0M+dYkK41Yo99NpcpeA==
X-Received: by 2002:a17:906:d10f:: with SMTP id b15mr2721962ejz.268.1607532366349;
        Wed, 09 Dec 2020 08:46:06 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:46:05 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 18/18] RDMA/rtrs-srv: Init wr_cnt as 1
Date:   Wed,  9 Dec 2020 17:45:42 +0100
Message-Id: <20201209164542.61387-19-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix up wr_avail accounting. if wr_cnt is 0, then we do SIGNAL for first
wr, in completion we add queue_depth back, which is not right in the
sense of tracking for available wr.

So fix it by init wr_cnt to 1.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 8363c407ab4b..e1907c10c7e7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1603,7 +1603,7 @@ static int create_con(struct rtrs_srv_sess *sess,
 	con->c.cm_id = cm_id;
 	con->c.sess = &sess->s;
 	con->c.cid = cid;
-	atomic_set(&con->wr_cnt, 0);
+	atomic_set(&con->wr_cnt, 1);
 
 	if (con->c.cid == 0) {
 		/*
-- 
2.25.1

