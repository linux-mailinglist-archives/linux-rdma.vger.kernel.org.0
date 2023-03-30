Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF066D09D1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjC3Phg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjC3Phd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 11:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE177EC4
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680190574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mb7nuWgkDOaubTvnFO5OdcmmhR8tNP6kd6NFt0+SpiE=;
        b=dgJT2t6QaJFeML5OTRWAFv/neMugeLCUlsQCiWk/ldBU6UZmsDW6sMDG9ofKQJAi/cHCQL
        tx+4TZHMStu+6dciAf1sVoru8eSQTwbYZBEvA/WJkXa9PeCI1BKs4xcxevj4o0b3VetuLb
        H5S6L4zlzZLmzmgPUFpezIAwCVBed2s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-gaoU0dMlPQiyiiaHTl59EQ-1; Thu, 30 Mar 2023 11:36:13 -0400
X-MC-Unique: gaoU0dMlPQiyiiaHTl59EQ-1
Received: by mail-qt1-f197.google.com with SMTP id f2-20020ac87f02000000b003e6372b917dso885594qtk.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 08:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb7nuWgkDOaubTvnFO5OdcmmhR8tNP6kd6NFt0+SpiE=;
        b=lU+8nHGoUcNXicp51ls0chwfpXV+VHZYE/2uQx8GOcGPMQ/QcuF2v2OgEcdIVLh50I
         d/bnHRqqbUKpBeP6KkzXOP7GfSwK+wxOOMx9u5ghyNvPcaMUAj6v+OSAQa18vqkSAlK0
         NFem7eGLhgj36SqrLT1an3aivA7RyW/Pjtu5jsJ6g//tbzmeMGhBJm4Hz6wjlOLGmnka
         OXdT8AGCJvnZXDkmvIxd8NcZqWJG8MjSK07uJQJHnbzt0WZyIz7gghVNBaRFDDWg5XEm
         VQftVHZTp2PVibPt+KBe9fzmsShklbmoiXES4yhC4zrLzAfMNlDWDjOLUnT95aVWwoPw
         /vGQ==
X-Gm-Message-State: AAQBX9f7aXnqph9DUIDZ+CWcyMrPWMbgcd6W42uUQkSmftR01yMYVTl2
        A3+b1DrFQ4MHf7w22b2QadCcQZ10IgYGzkpCpHiETOaVrTeL9TwvG/uhpjiDqOAdhJ9/9Ddw9GU
        MK1Ds2b3HrTZcLjdbXSAyaA==
X-Received: by 2002:a05:6214:3002:b0:5df:5533:6fb3 with SMTP id ke2-20020a056214300200b005df55336fb3mr8308394qvb.5.1680190572558;
        Thu, 30 Mar 2023 08:36:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZxnliOeH26xtjwgD2x1M5kHN0/tinm4772AhLlyfC8256JgzS/09VWGCpsmcHxshLjBJzC+A==
X-Received: by 2002:a05:6214:3002:b0:5df:5533:6fb3 with SMTP id ke2-20020a056214300200b005df55336fb3mr8308365qvb.5.1680190572308;
        Thu, 30 Mar 2023 08:36:12 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id mg18-20020a056214561200b005dd8b93457dsm5456912qvb.21.2023.03.30.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:36:11 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     leon@kernel.org, jgg@ziepe.ca, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/mlx5: remove unused num_alloc_xa_entries variable
Date:   Thu, 30 Mar 2023 11:36:07 -0400
Message-Id: <20230330153607.1838750-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

clang with W=1 reports
drivers/infiniband/hw/mlx5/devx.c:1996:6: error: variable
  'num_alloc_xa_entries' set but not used [-Werror,-Wunused-but-set-variable]
        int num_alloc_xa_entries = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 2211a0be16f3..07037b829c7e 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1993,7 +1993,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 	int redirect_fd;
 	bool use_eventfd = false;
 	int num_events;
-	int num_alloc_xa_entries = 0;
 	u16 obj_type = 0;
 	u64 cookie = 0;
 	u32 obj_id = 0;
@@ -2075,7 +2074,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 		if (err)
 			goto err;
 
-		num_alloc_xa_entries++;
 		event_sub = kzalloc(sizeof(*event_sub), GFP_KERNEL);
 		if (!event_sub) {
 			err = -ENOMEM;
-- 
2.27.0

