Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE19242025
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 21:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgHKTPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 15:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTPB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 15:15:01 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16DC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 12:15:01 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g18so2873147ooa.0
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dt58iV2aiDtn/PAgWplmS49ybu7ZFLQHLMHu8nIAEgI=;
        b=dMj0Ze59smoVeA2fyrZ3z+sgAGvGHF8qa3VceI45mpzYySFSWPS2GlYG4f13Ocev3F
         HQS9R6Y/PXQvETL91gWEomClLJEuS23i7oLKTkcWyHaKrO2xEty+VVsNpaLHs0UAdPaR
         wGIxk4ay6YmjpM7m+GyKaiOCHpYGbf3gZ6ZrQSZXl+0b18GbNHqw575uPQr7ldkf1vCU
         62DVmxipOksyCTqTcdXVTTfMt12551zNGVBqvGIku4OzJxr3eKY7JZJ/URTdGS787Riw
         6+3JnbxjWZHlPl8r507pRQKrXEqKHCMMjtA9ztVUhEbOHa9F4KkK9stcevPjuv+K5xuM
         esSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dt58iV2aiDtn/PAgWplmS49ybu7ZFLQHLMHu8nIAEgI=;
        b=hRb0iuO70bB2deuD6BFlJdfELjQQbiY2cclbPixAWp6fC1Up8wDY/bz/6cMQgwnvOs
         ONFiBpMAdTnvm90ipud9iUG/05nCAZ8ln1xCey/Etx4en3dHoKJUsAZjStjAsB7ltoV/
         suAdUQA6VfgyCAKbiWVESrghgT+x4MGignYOGQfDdTAXDJT5iIKtfgDwlsfkLqGd2Xd3
         xbD+hakuBsbROuWTRhFpSY4XCtlSulL7HNwNZXJvG+2aLX6Uk+nZ7JjXoqeFz7HuXeFx
         eBTkGAcbRvQ7jC0XpK7wRb2xuAtJ6lJEz5B5dA+mDXO7oI3+sFEK1OvU14efJFmlvlZI
         TUOg==
X-Gm-Message-State: AOAM5335U65VD+DtF4axzLBepJxOwhWRRAZi5//qLBKJLpq/LOFgJ+YR
        VW5+fUcUCzCMOIjZMmNTWc7AVtxqt10=
X-Google-Smtp-Source: ABdhPJwZffyIN9eww40pIH0bll8OhJTAhFOykzQ50mdz1lNil4KMvn0jfo4Odu85zZQTzx9oY4Z3Dg==
X-Received: by 2002:a05:6820:457:: with SMTP id p23mr6531169oou.47.1597173300493;
        Tue, 11 Aug 2020 12:15:00 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e4b8:eb35:9686:2a33])
        by smtp.gmail.com with ESMTPSA id b17sm4229093otj.73.2020.08.11.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:15:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 1/1] Address an issue with hardened user copy
Date:   Tue, 11 Aug 2020 14:14:57 -0500
Message-Id: <20200811191457.6309-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

by copying to user space from the stack instead of slab cache.
This affects the rdma_rxe driver causing a warning once per boot.
The alternative is to ifigure out how to whitelist the xxx_qp struct
but this seems simple and clean.

---
 drivers/infiniband/core/uverbs_std_types_qp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index 3bf8dcdfe7eb..2f8b14003b95 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -98,6 +98,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct ib_device *device;
 	u64 user_handle;
 	int ret;
+	int qp_num;
 
 	ret = uverbs_copy_from_or_zero(&cap, attrs,
 			       UVERBS_ATTR_CREATE_QP_CAP);
@@ -293,9 +294,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	if (ret)
 		return ret;
 
+	/* copy from stack to avoid whitelisting issues */
+	qp_num = qp->qp_num;
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
-			     &qp->qp_num,
-			     sizeof(qp->qp_num));
+			     &qp_num, sizeof(qp_num));
 
 	return ret;
 err_put:
-- 
2.25.1

