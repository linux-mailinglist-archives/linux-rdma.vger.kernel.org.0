Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6B4AF4E4
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 16:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiBIPO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 10:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiBIPO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 10:14:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98DC0613C9
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 07:14:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cn6so5726217edb.5
        for <linux-rdma@vger.kernel.org>; Wed, 09 Feb 2022 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPSFTnfkA+uHLTt8GkYnmDTnYwo3KQIglF++8T4llSU=;
        b=CaLf9PcHO4I17YUsqfP4Mxkq9gcpml8aF8ca1QMpa1RLex0qn7kGzve+/LKetdddUY
         DS4JWig979n4F+wMlzsk2OCu3RHFB2YiUrDAAB8qJclqnkbcc0wvi/sCysALNj7VZu1N
         gGZcwyVneWeG67ujWTalRR1JvvftrvqdjbUM769zebqy7f1gdpZmKxpNns/bOrW0BnUt
         gvP2Y7q0SlLeQgf7MLILOYKvAHIwMw7H5UohrKNA390g+FB5ZN1HANLpACq0B0YCZECI
         oMLHG+yPOIF1Qdfpv5VcQOGZA7SEo9Yqdkk3gOpVGebejzrn58aE/6puc28xVI/0ZuqO
         Exng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPSFTnfkA+uHLTt8GkYnmDTnYwo3KQIglF++8T4llSU=;
        b=iQXjYQEXFXa6DCClLdDc7UNv1VtKyPHdre9bdNN3rM7e6vDLqt4iHS/Ckcej/52N+M
         GtkXSboR+kcju5JVOvSPxMx0FfADKnjqSudR2vgHJ956cktpSg1Uez3xkvsQIVI/WCLl
         RrFT/iWqXjvzMibVMaEOqPdztMUyuTdmI8ef/my95y7JUxy3/OD/Rc0ZtfMKOXOFLd4Y
         S+3w8lX++G2Y8SHYkTblufQdY2LHOexsaLV0q7KH7VXAc0n7niJkS7PTYIVvd6tkzEaw
         5wSx2yHGVudZ3KyAR3HxPHv0/9YjteiO6lP8769az8XYE+pYM9ShgLRzeIDn0ecM5el+
         P9Yw==
X-Gm-Message-State: AOAM533tt45E05oT7jTBiqr3llYj/3zLXU3qukAaBRCsiSUKJ3fHg92O
        y1o0F0MSpMxCCQwWPkCvljkJhm42csXoxg==
X-Google-Smtp-Source: ABdhPJz5/khpZdrDyLjxXxQX9WyRFNQzcPfp2SlTGZV8Td8BQU7FdGMclR4D/0SYZWRS9MY5gqs1dg==
X-Received: by 2002:a05:6402:3d3:: with SMTP id t19mr2946282edw.356.1644419668160;
        Wed, 09 Feb 2022 07:14:28 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id z6sm6114967ejd.96.2022.02.09.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:14:27 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH 2/2] RDMA/rtrs-clt: Move free_permit from free_clt to rtrs_clt_close
Date:   Wed,  9 Feb 2022 16:14:25 +0100
Message-Id: <20220209151425.142448-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209151425.142448-1-haris.iqbal@ionos.com>
References: <20220209151425.142448-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Error path of rtrs_clt_open calls free_clt, where free_permit is called.
This is wrong since error path of rtrs_clt_open does not need to call
free_permit.

Also, moving free_permits call to rtrs_clt_close, makes it more aligned
with the call to alloc_permit in rtrs_clt_open.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d20bad345eff..c2c860d0c56e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2774,7 +2774,6 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 
 static void free_clt(struct rtrs_clt_sess *clt)
 {
-	free_permits(clt);
 	free_percpu(clt->pcpu_path);
 
 	/*
@@ -2896,6 +2895,7 @@ void rtrs_clt_close(struct rtrs_clt_sess *clt)
 		rtrs_clt_destroy_path_files(clt_path, NULL);
 		kobject_put(&clt_path->kobj);
 	}
+	free_permits(clt);
 	free_clt(clt);
 }
 EXPORT_SYMBOL(rtrs_clt_close);
-- 
2.25.1

