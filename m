Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81EA3495AB
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCYPdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCYPd3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B8C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so3632873ejs.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRmWLkv8SX6ENldan1y6U8vQoMbVk8AiBS45hWK4+Qg=;
        b=Q48pJ41E5nQfplMcC5g8++jjwJbBe1pRTwvKIYJsv7qLty1SLxAai+ZoWlFxRzuP/m
         MG/QdRijA4myZRyQq/K9jd6j11zrpUnsYwk9/QlqT0us3nSDUvh5Z9pZ7vBIxPuf1CNp
         5aFUW3fyCaxyqyjZnSwsp2a5O+U0pJzDQyAvGkJHDMu0A0FZ3Me+E0bncuutN3UHmW1j
         hEfje8NPUv4lWe1ciXcyrQrL8lvm05oQjhH0r5rSy22QTfNOtO5z8paBgCGV5dJcFu1E
         NkmBgcFIaajLEwyS/WRUg9MNjyfuVEL5oe+MOA8KNCs4OrEiJyXj3yrYn7Z6WaKB7fhV
         bUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRmWLkv8SX6ENldan1y6U8vQoMbVk8AiBS45hWK4+Qg=;
        b=GkLiYA22bcZXua4wiJCcQcOlFsdMK8dWqRwwwexRFBUkiZPM/yUloE2kVpi8NhHJak
         kAx6dhXn6rYn7b6miL/pCSik9OIGTZC3bAQNqlL1r0HACkorYZL5ib4EgIdSxdeKPMvL
         pL4bVgXNgy4u5PqQdThdl/hKVUrmM2QELYZtiTOtcIL+a1dD0T/vTiu58/58oz613mki
         SCefiD3MC0HtH+1Fz8Q9LQh4X+jnFfGY0M/NXCuHegny/shMezZof2Tr7iln0soLKz92
         +6m6KUz78qID0r06yc9d9G9IqEJAKEyzOTuCadIUE3ap4xIYy9ZatAVTELxqm+tEFaxk
         KH9w==
X-Gm-Message-State: AOAM531MO5blc5JKt3hJXvd8GiVq3CxXjyQ7RvyHdl9qrBPtt+MUJQLJ
        dDWwtkj5kA4Ca1SQVDYGPGEWNK0PRPOEV8yS
X-Google-Smtp-Source: ABdhPJy9PsIe//ClmbH7DeqQSpTAUshaCe331jQsX0fmwFK3ksJCINBDmg084+dXMGvqvV9WmKBmKg==
X-Received: by 2002:a17:906:71c3:: with SMTP id i3mr10108675ejk.391.1616686407273;
        Thu, 25 Mar 2021 08:33:27 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:27 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 17/22] RDMA/rtrs: cleanup unused variable
Date:   Thu, 25 Mar 2021 16:33:03 +0100
Message-Id: <20210325153308.1214057-18-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 --
 drivers/infiniband/ulp/rtrs/rtrs.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 8ec9c30b9887..e11e91626b41 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1691,7 +1691,6 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
 	struct rtrs_srv_sess *sess;
 	int err = -ENOMEM;
 	char str[NAME_MAX];
-	struct rtrs_sess *s;
 	struct rtrs_addr path;
 
 	if (srv->paths_num >= MAX_PATHS_NUM) {
@@ -1729,7 +1728,6 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
 	sess->s.src_addr = cm_id->route.addr.src_addr;
 
 	/* temporary until receiving session-name from client */
-	s = &sess->s;
 	path.src = &sess->s.src_addr;
 	path.dst = &sess->s.dst_addr;
 	rtrs_addr_to_str(&path, str, sizeof(str));
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 1dd772d84e71..bc08b7f6e5e2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -466,7 +466,7 @@ EXPORT_SYMBOL(sockaddr_to_str);
 /**
  * rtrs_addr_to_str() - convert rtrs_addr to a string "src@dst"
  * @addr:	the rtrs_addr structure to be converted
- * @str:	string containing source and destination addr of a path
+ * @buf:	string containing source and destination addr of a path
  *		separated by '@' I.e. "ip:1.1.1.1@ip:1.1.1.2"
  *		"ip:1.1.1.1@ip:1.1.1.2".
  * @len:	string length
-- 
2.25.1

