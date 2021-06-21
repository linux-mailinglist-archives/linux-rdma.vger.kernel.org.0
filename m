Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381B83AE2EB
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 07:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFUF4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 01:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhFUF4D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 01:56:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF3C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c7so16280373edn.6
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qIwM8BQzLXVBphhd1xgyT5qd1pdYkylXZZiAHrlnIY=;
        b=AsgvvBz4my9DfKBwf8mzHxNgGZndodV6Dsa9NixkcnQMvlsfxr5Ubeq0WWpW/h+rP5
         OuQLTd2Z8oDztzJ35cpsux+yoykZwnazt58BAavABlxqMi1YK9KqWhcyNhypZWSTFzf9
         MrwYBsC5tWffYMBjpHYtPNHmk9oUZOmzFYYgaY3+0K3DcJXHWmx7jXMrJ19fX3xcVD5a
         ojAUh/kqX9mhAjArOch+pH/3OLPexAfPew7Mg0OQECs7NhkTf06uJouubpB55EB4nvGB
         +Jtj0ENwFQtNrJr/wICWYbXgrhA+UJH7V7oanacqB08y1fBJ0djmRO2V7/zsruvLYYAC
         P6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qIwM8BQzLXVBphhd1xgyT5qd1pdYkylXZZiAHrlnIY=;
        b=oToo3Yk9KrcvS6AKeocF2zaejExCTkkg4BujQsLpjQtl+vJdrwvVxqC2htnGXEo9X3
         amtkryIibFzXhHsPAE3kNmmheh49uEypL2LaFpvW0kbuPNlpLMEpnmo8KZUPaRt8hXzZ
         Cxu35RK1ZXj6GxZSy7sc58sXNwCThqfKAhXtzbe7NYn6YD4imj3Lr+9bAYsu/Vm88XXE
         CNlm8hX4lQTXajxy0wthbnMiRT1bTDCjeikWSWUk8/WWG02+qTeJuD2MApbjmqOwLRwd
         JvFj6PFbZeDSNhNSH0qHoWShwMZasEneWFSWFOLpSAi7mJ3KfhtpsGDqsVrK9Uj8D4qA
         PgCQ==
X-Gm-Message-State: AOAM531N7g9nNb5BhHfH9v/cBt43l0buxzYGPjYum1aYg3kPVzoZDtOx
        menX9p0gDlWUo+vntrK3d6ca52/62ZXPBA==
X-Google-Smtp-Source: ABdhPJyEAfUpYG4ekanQ89v40oRQCzFHmQ92jGa21zJlRaFqgVMdnB21XiFP0OlDqIFflQ1copu3Iw==
X-Received: by 2002:aa7:cf0a:: with SMTP id a10mr19158554edy.329.1624254827796;
        Sun, 20 Jun 2021 22:53:47 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49f3:be00:dc22:f90e:1d6c:a47])
        by smtp.gmail.com with ESMTPSA id i18sm1919617edc.7.2021.06.20.22.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:53:47 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH resend for-next 4/5] RDMA/rtrs-clt: Raise MAX_SEGMENTS
Date:   Mon, 21 Jun 2021 07:53:39 +0200
Message-Id: <20210621055340.11789-5-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621055340.11789-1-jinpu.wang@ionos.com>
References: <20210621055340.11789-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

As we can do fast memory registration on write, we can increase
the max_segments, default to 512K.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 3b25a375afc3..042110739941 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -32,6 +32,8 @@
 #define RTRS_RECONNECT_SEED 8
 
 #define FIRST_CONN 0x01
+/* limit to 128 * 4k = 512k max IO */
+#define RTRS_MAX_SEGMENTS          128
 
 MODULE_DESCRIPTION("RDMA Transport Client");
 MODULE_LICENSE("GPL");
@@ -1545,7 +1547,7 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 		       rdma_addr_size((struct sockaddr *)path->src));
 	strscpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
 	sess->clt = clt;
-	sess->max_pages_per_mr = max_segments;
+	sess->max_pages_per_mr = RTRS_MAX_SEGMENTS;
 	init_waitqueue_head(&sess->state_wq);
 	sess->state = RTRS_CLT_CONNECTING;
 	atomic_set(&sess->connected_cnt, 0);
@@ -2695,7 +2697,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	clt->paths_up = MAX_PATHS_NUM;
 	clt->port = port;
 	clt->pdu_sz = pdu_sz;
-	clt->max_segments = max_segments;
+	clt->max_segments = RTRS_MAX_SEGMENTS;
 	clt->reconnect_delay_sec = reconnect_delay_sec;
 	clt->max_reconnect_attempts = max_reconnect_attempts;
 	clt->priv = priv;
-- 
2.25.1

