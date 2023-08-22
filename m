Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96A783CA0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 11:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjHVJNQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 05:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjHVJNP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 05:13:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02131113;
        Tue, 22 Aug 2023 02:13:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a410316a2so1340607b3a.0;
        Tue, 22 Aug 2023 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692695593; x=1693300393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9yX6cYGBTYDrrw3eT3TNHNu49Hy4xR5qN3oXqk/2ak=;
        b=PSD6sek0w5RTtYlBigo10A3T1rqlWP0D94fcx1z7X6XpPgSMpbfezdq4lgC3PMboro
         RkR23ekgIQMeZ9nIejoUvH3J2cWFi5FmiMh+VGLUMtlkZI76hJW5ilusF64hxvzOvNMf
         0uwrX8CFAexzsFOafwPlXzRAQ9Yebwyn+8EXM1QkKjpmxUS4pLC3CQqcRXFqvAlGsdl2
         v0z0phbjdCT+Lhz//KKKkZhpEOfvNMNjutd6f8l9/x3WpVkA6L3KDe/7RWMa1m6tUcoS
         uU+6umerd2nlt4iTOrdch0pbTXWUzZ6FR3lvoWzaV70L1RHA/+7IDm1G8MHdm2mlmlf/
         emsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692695593; x=1693300393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9yX6cYGBTYDrrw3eT3TNHNu49Hy4xR5qN3oXqk/2ak=;
        b=EH17BysfZ8lP//Fhbda3DYZzcaK/Cb1mTYXZVoWCkeh0SMx+hVd6nCPrw9QHc/ZiXb
         +GD4zfHNTVccrRR56IzHyvIy9VXHO+D1vvYUGIuP+R2ZeMii4LR+JxYQEjb3PXWN0Ei5
         zWte3Yld2C/l4cThFHOtwrVsFAlSEf9iojSG53eOYUveG/ebAu1bBcqCSy7QLsTC1NAW
         em5H96JK7rtkb46fJAhTRbn9/VP9juTyLDcWOW7Ipmc7oPSElr9d5XuDQDuNZtcDsver
         negZsIpCuk2vIl4NYAZ5mIxZtKBXdOl6qwprWhzi3+VtLp+vT7EXdn4YKuZy6FPt1cu0
         PR6A==
X-Gm-Message-State: AOJu0YygkE7Dj/LbnGvOAHxIecAU02Llrp9qY03EAccxd36P0ayoI0Yr
        kFJ9+tCwrviRwE1ejmM8ud4=
X-Google-Smtp-Source: AGHT+IHJ8aNv+4keg5TNv8EzN6pl5nygo6QNTmhnOA3lkaQYnceuyV1udjXtXlHRW0R3n25ebS+qKw==
X-Received: by 2002:a05:6a20:d4:b0:145:8e82:4eec with SMTP id 20-20020a056a2000d400b001458e824eecmr6352807pzh.37.1692695593333;
        Tue, 22 Aug 2023 02:13:13 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([149.199.50.128])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0068892c40253sm7360405pfn.216.2023.08.22.02.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:13:12 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix redundant break statement in switch-case.
Date:   Tue, 22 Aug 2023 14:43:04 +0530
Message-Id: <20230822091304.7312-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Removed unreachable break statement after return.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 903f0b71447e..48f86839d36a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -798,7 +798,6 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			rxe_err_qp(qp, "unsupported wr opcode %d",
 					wr->opcode);
 			return -EINVAL;
-			break;
 		}
 	}

--
2.30.2

