Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5627A784048
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjHVMFH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjHVMFH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 08:05:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28355CD4;
        Tue, 22 Aug 2023 05:04:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc0d39b52cso28085535ad.2;
        Tue, 22 Aug 2023 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692705898; x=1693310698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvfV4sNcedKbrcD0SnLOeZFVwOPJ1CwCKV0j+YWXPWk=;
        b=erlG13cXSUZsHyddjOxA5DPr1xyeHWiciPdWihXKuYhBwtBw/oya2buDxPsMKL4mf3
         V25zpjhjnMc14SHehPDPwk7mTA+uBblaIQV6gwIfHS+ww6AZMx+ItP8OSaTgPvS/HPa3
         JH3lU6ueuzNt/mIsnNbfZmpsPe6gXxul12z0hrbVY+y4rkiNmoWps4E/k3jGGqTmOzTR
         qn0ApXdlZHq/bO3hYI/Eqo/fRLh9e2QPLo3u+vG38ZZAkg0UdwoMmCcg3B398Z9BRGAO
         aYkz0KaRwsV6aa32UyKJ2McVCRvgr7WHSKY1DsmvUtcJbTRZtaONMBJUtJ7szp5bAfK5
         riYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692705898; x=1693310698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvfV4sNcedKbrcD0SnLOeZFVwOPJ1CwCKV0j+YWXPWk=;
        b=EWLo/YWu9qiddMXzBGtQkvktYGs+8ItLJ6QoSW1hG9xfEMY9f02moppktP3UtgaWqt
         o2dDB8DAV86KMiYppAxFSdxc+WQVqYQekjXEyjhjwDfZHjYaoAdfMpiEM24HGhlYw2z6
         +m6Yjj7Mw64fz48RMJkKjqJDr0qmGkF2rW8qKrCiy9sbzGZtd3ghYhgpYQtdJeGRphLI
         Rz0Sy73YJh98jtg8/hVbtOl2A0vgliBI3wJ40bBuNknSXVbRfwrkKiO+JYNwNjdDVoan
         a/PiWeBxY8p+1jpbaMrOSKJR3Htt+C+3ylibbne5A+vKU95rwIa3JWHsY5eIc2BysGlT
         KdTw==
X-Gm-Message-State: AOJu0Yx4gR/zLTpNSd6tw69fUyBIi0/YkAfKEVapo/cU/pBWQOOxv9Xq
        52AFMWivGCI04BY++1byETs=
X-Google-Smtp-Source: AGHT+IE9oAdteaIQVQx4X5+HR5GwLtaBrpTyIDwHWarxy6VlwUQ6co2UcBz0oikTmo4Ux16gFXiDpw==
X-Received: by 2002:a17:902:e5d2:b0:1bc:81f2:ddf0 with SMTP id u18-20020a170902e5d200b001bc81f2ddf0mr7657410plf.67.1692705898295;
        Tue, 22 Aug 2023 05:04:58 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([149.199.50.128])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902740300b001bdc50316c3sm2927353pll.232.2023.08.22.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 05:04:57 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/mlx5: Fix trailing */ formatting in block comment
Date:   Tue, 22 Aug 2023 17:34:51 +0530
Message-Id: <20230822120451.8215-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Resolved a formatting issue where the trailing */ in a block comment
was placed on a same line instead of separate line.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2017ede100a6..2e3d00c62380 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1235,7 +1235,8 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 	}

 	/* The pg_access bit allows setting the access flags
-	 * in the page list submitted with the command. */
+	 * in the page list submitted with the command.
+	 */
 	MLX5_SET(create_mkey_in, in, pg_access, !!(pg_cap));

 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
--
2.30.2

