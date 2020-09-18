Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E12270800
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRVQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIRVQA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:16:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC033C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 185so8655349oie.11
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M7BIC7Z7C3jI/XKbqemRcZf71vYA9NpYcp+JzUeoZek=;
        b=Aj7XnxWnr2Vh47ORZD/S9XVDX3V0aWFhD77sNOPZoBRGHLv5uwiK4TV/LCbHXR2LQ+
         2/em420vah4p0ute9zIRJmNrADXILrutTmxusa5IuK6O9wWljqpY4LZnaFuroqKaFvTK
         ghkdUHWJGkAiRs8bGrhOOsGliUzrYwpbv+Dst5b+zUdWeZHAEoo8jF3cnuESmwvaUO/I
         PZnJ8bXNPrPXF9SuyV3rNIclb31OF13szwck3MS8Gf2TYMKW12ZUV5BaZ5K/6HYN4+tO
         j7bbIvTi/YJcUJBP6hTWyoxMSP81w9Z3BowUCctEJbOJJkxNd/+lWN0Tqc03s8QmVfmK
         vMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7BIC7Z7C3jI/XKbqemRcZf71vYA9NpYcp+JzUeoZek=;
        b=q6VyrGEDSb4LpsaiMA707uQpTZ+6MZiccISPvItuvk0ZENxaW+IDEu6sjIuR/onrTi
         1sOrOfS/CREs+Q98K16RUrn06T7pPEx7J33+OLCwnelIHERkV9i2kEE+N8xcxbqnVUvu
         NzNlcHG4E+FABK5o02Uznc8RaLWHBQTOdwC7ScyCZ3dsp487gv23HJxRtDQdTysg7nvK
         HxcxVTRpp5K7p/SbTyeE2ULWsj89aU3jcKWqTT4Y9TOaghDbislqDMmpq3dhLuSERtT9
         pgcXGKSEeoo22iy+IryG2BFskn3eBwRVjKhzJ2B14R0724s3edmDKJY3xSb30yPxD+kL
         iIdw==
X-Gm-Message-State: AOAM533n0c3LgpU/MgGgQagTXsCJsuyj3LyeWIa2sDWI44ZRtPFgy7F8
        u8Z7jtBijdcrf8lnRgUjEbo=
X-Google-Smtp-Source: ABdhPJxHbFKw6Ta4qxYkxGw0o8jNwjuAStS0y7sZnJPkb8E0bDyCOK3LJP43d3nXwxCv0daBZBm4cg==
X-Received: by 2002:aca:b2d7:: with SMTP id b206mr10680178oif.110.1600463759397;
        Fri, 18 Sep 2020 14:15:59 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id j16sm3199511ota.1.2020.09.18.14.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:15:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 09/12] rdma_rxe: Add support for extended QP operations
Date:   Fri, 18 Sep 2020 16:15:14 -0500
Message-Id: <20200918211517.5295-10-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918211517.5295-1-rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add bits to user api command bitmask.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 594d8353600a..7849d8d72d4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1187,6 +1187,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	dev->uverbs_ex_cmd_mask =
 	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_QP)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_QP)
 	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ)
 	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ)
 	    ;
-- 
2.25.1

