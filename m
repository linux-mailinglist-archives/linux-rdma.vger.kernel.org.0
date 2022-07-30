Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D1585A1F
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jul 2022 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiG3Kc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jul 2022 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiG3Kc4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jul 2022 06:32:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AA64ED;
        Sat, 30 Jul 2022 03:32:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so7423483pjf.2;
        Sat, 30 Jul 2022 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Hy0u2dmUd0JC0VbYDqshLv8EWrBK/GXf+nBCSLK25WI=;
        b=DZfqlTGVuJ+7cwcyFeDEx1LrKuUHfc6OhJ6Rb/EvBBJyVBHSVk2OMWbJ7Avuep+4VK
         HaY1YfJncVDs8b9Oit+0eBpr/EoXkmcKiewkQDTLz0HjexGa2ntrlLJAJAAb/hvLElk6
         TYuwuU9lj7ingA/rnAAAlyYD0qVU+9S7mKNHAxxZKFRVzRqYJxUkoAWqassR9zcp3A23
         mV6PnBGi/EG6IClz+ZVPjE5N48XTEhcZdQGV2DQ2njtDA8TtH+Xl0Lac8FdUCp4QNh3n
         fIJtsKmD9DClTfYudys3ojA0/7M1xBJz3IikGcRThtj1pwvNywpJHO0wrazUqpD2aGIf
         O+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Hy0u2dmUd0JC0VbYDqshLv8EWrBK/GXf+nBCSLK25WI=;
        b=KzulLaLefRsSmfpSJ7ALRMUv3Ml5sb6JvorGhE+Oz9+betd4Blyx78QxMmWDZ5x+60
         iI3sFp/L3bAME1ueqveCglUuvGLHB9u/9QW9ve/+9aBXVdEX1ebFx5vYo9rh4MEj/gjf
         6p7Bn5ut3a2HhFvEWtaE9tjduRMvQBBm4em62t2OhAzhj4JTm5Lu7FHYJNQEmuA+Mt7f
         M3yAcopEuxvG4I9bdP7G1fczb1Q9E9RSay0pvLUQVySpXofpnwVJOg3sNr33xyLqqi7j
         XvijCdVZTVkTbQa0mzNwfUAljAUB58zQVkO8NqMah6/wrRQs0lEIzHvgZTR3EklMzUkP
         4PUg==
X-Gm-Message-State: ACgBeo3ZCM7yt5RzuSKvmFYGQv9+BPAgD65JeRs6BGf+ngTGHEd+sI0Q
        CRRp6SKUG4WoK+8BOdUFPug=
X-Google-Smtp-Source: AA6agR7WJq/gQCrLWzOM3wJjdKuiHHpUqNZGYRowAIPcCnotUCtqCxEK1DZa+53jt7NRTTO56LV9FA==
X-Received: by 2002:a17:90a:5d05:b0:1ef:91ab:de15 with SMTP id s5-20020a17090a5d0500b001ef91abde15mr8414773pji.85.1659177175310;
        Sat, 30 Jul 2022 03:32:55 -0700 (PDT)
Received: from localhost.localdomain ([103.160.194.175])
        by smtp.gmail.com with ESMTPSA id p185-20020a6229c2000000b005251f4596f0sm4494462pfp.107.2022.07.30.03.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 03:32:54 -0700 (PDT)
From:   Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next] RDMA/mlx5: unchecked return value
Date:   Sat, 30 Jul 2022 16:02:42 +0530
Message-Id: <20220730103242.48612-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Unchecked return value warning as reported by Coverity static analyzer
tool. check the return value of mlx5_ib_ft_type_to_namespace().

Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 691d00c89f33..617e0e9c0c8e 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2079,9 +2079,12 @@ static int mlx5_ib_matcher_ns(struct uverbs_attr_bundle *attrs,
 			return err;
 
 		if (flags) {
-			mlx5_ib_ft_type_to_namespace(
+			err = mlx5_ib_ft_type_to_namespace(
 				MLX5_IB_UAPI_FLOW_TABLE_TYPE_NIC_TX,
 				&obj->ns_type);
+			if (err)
+				return err;
+
 			return 0;
 		}
 	}
-- 
2.34.1

