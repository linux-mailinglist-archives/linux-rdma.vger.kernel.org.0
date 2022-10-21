Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF9607F69
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJUUCm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiJUUCN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:13 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E3B26205F
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:04 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13b103a3e5dso4928839fac.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh+FwTHc00Q0kWWf36fdCBxCjYor7euxP3hgKCKswJg=;
        b=YrAD+5Y2RnKoj8aqhfLJ+pNPVG99vZPrwN+OMkr9v8J/SucdWKQrhVc9exrEoc5tbr
         6lO/2x4fiK01wEaeXi8w8G37X7RaHI7/bUHW1srffDtr0Td8eEgSxMZfQf9VJRUGY0Lu
         Bze72ecsaA+a0Zy+SSlBLiBGJ0eHvLODikOtMf0kIwt0ani2uQes2p5pTAlzpY7e9+tF
         TQJwgadvsCgC9p98818K5DvrPojw5092GvSK5m5ONq5tx1pWDzkHwkg0bsTiFR9sU/ik
         CssAxVgWiVrXpdSCWlvg02X1D/NXKJCnh3/SISN81TebdGIYBuJE65tLLjVVKv32hH6s
         cm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh+FwTHc00Q0kWWf36fdCBxCjYor7euxP3hgKCKswJg=;
        b=wpZ/eSLl4XS45fKxbzuf4d3mtCW9y/jjo9oQL2QmE413YzHcLXqGSzpHsUeHxlWA5B
         8s0NwNgIUiNtsNZuxrKqwDXl9CJRdRCZLa82vBpyJXgGHteeL4KHW7romVj0Rnhe4AmE
         thsw35CxEJJjgbvBsgiGBsLwTznpNs2os5J/78nLSsDszHeQmJKyqyh2p1YSJCL98AXH
         lK2Q+Tyb2iS2uZJOiKwDxCO/stJ3Z+b8BPAJJo1Ez63aWAY0je4nbuXjX79X0Z8YMVcY
         xAX6SfhbG9PbY73ginFh3F6MmQawOPrSbhx3C6aDRIASs7YR/uVZ1boZwO0rZMORdaIJ
         10DA==
X-Gm-Message-State: ACrzQf1Fb5SutKtU1sFifcPSgKLiEewk1MyKJHJXl+pKaUuWR1Xoj5ts
        YZJSPJMtzBTjfXy6mnO2wVg=
X-Google-Smtp-Source: AMsMyM6FXtk9DrySLrDKQXHiOgXeAAVnI6jOLin8jLoYkqcrH6nTzxta4kKuuqM1Hkw4z+tLUJqmhQ==
X-Received: by 2002:a05:6870:3452:b0:127:74a6:365c with SMTP id i18-20020a056870345200b0012774a6365cmr30012330oah.169.1666382523226;
        Fri, 21 Oct 2022 13:02:03 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 02/18] RDMA/rxe: Remove init of task locks from rxe_qp.c
Date:   Fri, 21 Oct 2022 15:01:03 -0500
Message-Id: <20221021200118.2163-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

The calls to spin_lock_init() for the tasklet spinlocks in
rxe_qp_init_misc() are redundant since they are intiialized in
rxe_init_task().  This patch removes them.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index a62bab88415c..57c3f05ad15b 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -172,10 +172,6 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	spin_lock_init(&qp->state_lock);
 
-	spin_lock_init(&qp->req.task.state_lock);
-	spin_lock_init(&qp->resp.task.state_lock);
-	spin_lock_init(&qp->comp.task.state_lock);
-
 	spin_lock_init(&qp->sq.sq_lock);
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
-- 
2.34.1

