Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D233DB936
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhG3NSs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbhG3NSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A7C06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r2so11342023wrl.1
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiDrtsKqJ+K23w0j/JTQkz/7+Ff/23dlUuakahMZLKM=;
        b=MalitphDqQA608tDuDJ9JDEwHR6O0GF2ey+qF+y51VV7q0WpSClD3/I1RTg2Xk7k9r
         J/ibM6JiTNybKdVUZA3VA6qBudCwFJsp3H1lqCo3njrKrW9j2+42T+qAgy9X0pB3r55K
         97Fe8iwpWdPDPQxHB+KhrryH/8496yqgeGfWfTGKIAZn9RwiV8emSYAZ34bLIhTdTmed
         i80lOFG0wWxI4zF7p/KXVnptdUY6o6a+o9/C4vDoIfbcoeedMcNUACJUXXCNvxH+Hx8n
         BjRE4N5TK5j/mkk6quN3/VSSLHekQ3uJUK5bcthYCWAw+ajoI2S2KhJWnXxsYD6bPgkC
         J2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiDrtsKqJ+K23w0j/JTQkz/7+Ff/23dlUuakahMZLKM=;
        b=YeHVfAbuJi2qHQhTQU2D0GMW+mimLSE37G7TMJMH9XSLRdkZ81Jk9Vh3RrgFyLHrJk
         I0al/x+UfL4hC6IKV6A2h+abmtsjU97tDzDHxI2gzcnl0pv1O5h0vUtf1LRbDCcHivFS
         eNXIje1EGkkqMmbeyU070iYhMO2HcZi67zlCjTRqTEw+POL+I5TJpcXSjCL2SyGw8DWE
         XDTjBy5kGqDKXsSN2IUou3HuH6rqVSRIQpH252AkOCQx38tH2aN9qj8klxwEAnlQl01X
         hMxpct7kvKf9ciXA2RLqJICoAk8Ie5WPKlh8DrVpMz+HZrhzFsxrxvYdsEfLxjjxhk7N
         u77g==
X-Gm-Message-State: AOAM533v8z3o3/IMoUQ9L8qyYPNoqDdK3wnIsA9ouX/3A71jxFgOzM52
        9+rz/t/uqsiLUX8oOiEQ/2tvogC6467+lw==
X-Google-Smtp-Source: ABdhPJzasaHcMHSCGNMj07op6jexJ8E5LEIsOwSpTOpYXD0Ke4+e2U0I8nS5F8pGAVkwrOiFyydW0g==
X-Received: by 2002:a05:6000:1818:: with SMTP id m24mr3040878wrh.49.1627651121678;
        Fri, 30 Jul 2021 06:18:41 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:41 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 10/10] RDMA/rtrs: remove (void) casting for functions
Date:   Fri, 30 Jul 2021 15:18:32 +0200
Message-Id: <20210730131832.118865-11-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

As recommended by Leon
https://www.spinics.net/lists/linux-rdma/msg102200.html
this patch removes (void) casting because that does nothing.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 90d833041ccf..7d6df83eb636 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1918,7 +1918,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	err = create_con(sess, cm_id, cid);
 	if (err) {
 		rtrs_err((&sess->s), "create_con(), error %d\n", err);
-		(void)rtrs_rdma_do_reject(cm_id, err);
+		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since session has other connections we follow normal way
 		 * through workqueue, but still return an error to tell cma.c
@@ -1929,7 +1929,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	err = rtrs_rdma_do_accept(sess, cm_id);
 	if (err) {
 		rtrs_err((&sess->s), "rtrs_rdma_do_accept(), error %d\n", err);
-		(void)rtrs_rdma_do_reject(cm_id, err);
+		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since current connection was successfully added to the
 		 * session we follow normal way through workqueue to close the
-- 
2.25.1

