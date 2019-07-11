Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40265823
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 15:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfGKN4e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 09:56:34 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44719 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfGKN4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 09:56:34 -0400
Received: by mail-vs1-f67.google.com with SMTP id v129so4160333vsb.11
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DIifMe08x8eilcy1pGdEQr7vj93MJAS94cacN+ktuZE=;
        b=j1zS6BR8MtPh61Y5lEvY4Edmo+sE5Cl6d1luMjyHSLvhQEuYZJkQcO3hwFJY3r6kK2
         Rhe3Wm6SIPofvjyWBvMwym880XWXw09AEAwffsQm4SbCaTLyksIKnQBL/tWOd+yj/zSq
         CTU4Ajuqjka+Bt76W6qf3th1GqRinHe3FCMRaRaIhC0Sc9M40B4qIZsnLwqbpfUMcMA+
         yRx4R5XWN3PVxCOxWzMsP9X0vdfilM29WKI3kf0mPPAbXhRCen/Z0bjw8JOLC+f6nncn
         Rhc1jeP+q4SydcfW2c8gS/cKtvv8qfsdQnDZ5slDXws/NlTcawR1VuhWgIJlD6wCPbnK
         jJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DIifMe08x8eilcy1pGdEQr7vj93MJAS94cacN+ktuZE=;
        b=UzCWTZBVD9klZhw1TWRgYhJPtRiBzky7B8bteEtF6PwTnebAwhcjd1R/zQe1djyXoB
         KAPP8GOGXwKqKecFxvP2hkBFCl2GE9KdA8u0Mt2DuR7u5+af39le+D6TDUthIA31uVSq
         qwb8rJzdoPPm20jtJup2wRmjlHDBn3OnDHpM0ctynqxZ6eY+f/YXESrX4HnH9sWfV5nU
         vldz54HOvBVVvVR3q22k1Z1sbcrY9u9nYLTuKnMYmj94Fw7OzJlO37IdUEc8czupEEEC
         FvnFPPJif2y4zBcFC374WW79OtF+I9SKDfXYIej3fIYzetWIkjNK/CO+ZlGLJcvSZg3/
         5wRQ==
X-Gm-Message-State: APjAAAWCQ03j2b3RqnfI8jTKEfL1gowwBw6t9kn6GRaI6jpzzhjN5+8/
        +Yf5c6mCiWoC4IeeRtpBelGjwQ==
X-Google-Smtp-Source: APXvYqzhRLrHsyhqQfYxXeO1oYFXv12ANL2/vUtIveAijoErnkQ94q/E70Kf4SEI3EmBX3ENowaO0g==
X-Received: by 2002:a67:a44b:: with SMTP id p11mr4344603vsh.237.1562853393451;
        Thu, 11 Jul 2019 06:56:33 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u189sm2148602vkb.50.2019.07.11.06.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 06:56:32 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jgg@mellanox.com
Cc:     leonro@mellanox.com, saeedm@mellanox.com, talgi@mellanox.com,
        yaminf@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] RDMA/core: fix -Wunused-const-variable warnings
Date:   Thu, 11 Jul 2019 09:55:56 -0400
Message-Id: <1562853356-11595-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The linux-next commit "linux/dim: Implement RDMA adaptive moderation
(DIM)" [1] introduced a few compilation warnings.

In file included from ./include/rdma/ib_verbs.h:64,
                 from ./include/linux/mlx5/device.h:37,
                 from ./include/linux/mlx5/driver.h:51,
                 from drivers/net/ethernet/mellanox/mlx5/core/uar.c:36:
./include/linux/dim.h:378:1: warning: 'rdma_dim_prof' defined but not
used [-Wunused-const-variable=]
 rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
 ^~~~~~~~~~~~~
In file included from ./include/rdma/ib_verbs.h:64,
                 from ./include/linux/mlx5/device.h:37,
                 from ./include/linux/mlx5/driver.h:51,
                 from
drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c:37:
./include/linux/dim.h:378:1: warning: 'rdma_dim_prof' defined but not
used [-Wunused-const-variable=]
 rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
 ^~~~~~~~~~~~~

Since only ib_cq_rdma_dim_work() in drivers/infiniband/core/cq.c uses
it, just move the definition over there.

[1] https://patchwork.kernel.org/patch/11031455/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/infiniband/core/cq.c | 13 +++++++++++++
 include/linux/dim.h          | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index ffd6e24109d5..7c599878ccf7 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -18,6 +18,19 @@
 #define IB_POLL_FLAGS \
 	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
 
+static const struct dim_cq_moder
+rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
+	{1,   0, 1,  0},
+	{1,   0, 4,  0},
+	{2,   0, 4,  0},
+	{2,   0, 8,  0},
+	{4,   0, 8,  0},
+	{16,  0, 8,  0},
+	{16,  0, 16, 0},
+	{32,  0, 16, 0},
+	{32,  0, 32, 0},
+};
+
 static void ib_cq_rdma_dim_work(struct work_struct *w)
 {
 	struct dim *dim = container_of(w, struct dim, work);
diff --git a/include/linux/dim.h b/include/linux/dim.h
index aa69730c3b8d..d3a0fbfff2bb 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -374,19 +374,6 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 #define RDMA_DIM_PARAMS_NUM_PROFILES 9
 #define RDMA_DIM_START_PROFILE 0
 
-static const struct dim_cq_moder
-rdma_dim_prof[RDMA_DIM_PARAMS_NUM_PROFILES] = {
-	{1,   0, 1,  0},
-	{1,   0, 4,  0},
-	{2,   0, 4,  0},
-	{2,   0, 8,  0},
-	{4,   0, 8,  0},
-	{16,  0, 8,  0},
-	{16,  0, 16, 0},
-	{32,  0, 16, 0},
-	{32,  0, 32, 0},
-};
-
 /**
  * rdma_dim - Runs the adaptive moderation.
  * @dim: The moderation struct.
-- 
1.8.3.1

