Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47D59F4B5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiHXIFQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 04:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiHXIFP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 04:05:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A13CBF8;
        Wed, 24 Aug 2022 01:05:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x19so12982068pfq.1;
        Wed, 24 Aug 2022 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1vKgNm6BRFVeZ7Pdv+a4C7Ti+m9SsZu4s1UQ5Y46htk=;
        b=Yy0w9y1//Bgd7r4+OGNU18as32pSRUhuzqra+9fP202lb5VUPLhHjmi85mLeMqvqD5
         6AfpAmcpypr+g5tZlGenfK1E0NcwNmUyqQtqiVvAQtj1kMZ4Cf8kD33HMpqnkTgShndT
         IYWP1dlWBSyzQ1QuNstaqCnLvOvmt0vHco24o78ea7LuH1yHNvJeP2YfYSY1QtZB2Hg7
         kcTAK1SGx78Jv/xej8Oe4vgNU5sMlRYtUpo7j2/9ujKvzFkWKF/2En5py9OF1JLs323E
         wBFAJ0TSfgmpLx3Xc8as+V1HhP4VOUYCqS5rnWZCCbDqMTd6s63Tma4Ub3rvuJ4552ED
         AE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1vKgNm6BRFVeZ7Pdv+a4C7Ti+m9SsZu4s1UQ5Y46htk=;
        b=raX5xDQH1jGDiVPTOtCgJ1qIQgr99GN3FNCf7HjztT4VzpBZWQkhsorMLoCtW/Pjgz
         LZlIR05uilU4URYmEr2gu00+xqt8KCfpNGHQ9L0Rm6KFmmqFqdSJ/sjEsAw/IS8SmbRw
         x8KlvbAunp00MWK9bRSmrE+Gcx0BvpbAyGJnsC/cwwiOZjHnmIz/8+5bxyOCqfnrfz08
         ZJVK+a+uo3TYGoXhs6Z22oRIdE9hUdEpa5TF2Z8CDeyrRgp6/5I/M6EV+4dayoAhPYqN
         eyZ4jAk9WJOVk2F7V8ViMNPRgLOuBESvs5GaEi3rWqscA2jzancXJcg5wU6+Xt4qF0Rc
         PUmA==
X-Gm-Message-State: ACgBeo1omITjRD7G2bTrXoeiL32IELWCFojtb0sigBkES7NzH6BmwgBK
        mGXXtrdZiqyumyGNSzJvyqM=
X-Google-Smtp-Source: AA6agR6CvOkBYkfHfOXB2ElEMv6qNkwhEwpCMxenFuZOFA0G8mbhD4yWFJ1to9fLn7fROybZOJ5Rrg==
X-Received: by 2002:a63:da13:0:b0:42a:7f03:a00e with SMTP id c19-20020a63da13000000b0042a7f03a00emr14362124pgh.332.1661328307440;
        Wed, 24 Aug 2022 01:05:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902ebc700b00172b27404a2sm8028805plg.120.2022.08.24.01.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:05:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] infiniband: remove unnecessary null check
Date:   Wed, 24 Aug 2022 08:05:03 +0000
Message-Id: <20220824080503.221680-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

container_of is never null, so this null check is
unnecessary.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/infiniband/sw/rdmavt/vt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 59481ae39505..b2d83b4958fc 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -50,8 +50,6 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
 	struct rvt_dev_info *rdi;
 
 	rdi = container_of(_ib_alloc_device(size), struct rvt_dev_info, ibdev);
-	if (!rdi)
-		return rdi;
 
 	rdi->ports = kcalloc(nports, sizeof(*rdi->ports), GFP_KERNEL);
 	if (!rdi->ports)
-- 
2.25.1
