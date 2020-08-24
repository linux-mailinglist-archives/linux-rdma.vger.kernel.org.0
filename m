Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16C250739
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHXSPA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgHXSO7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:14:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49856C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so4734928pjb.2
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Yy4FkpQ4T+NaE4SfG1omiUE5+nqdQKGBttk9E2TkE8=;
        b=g939bglqlxxy3mDy5l51t6XUSULZhBRi0lGruUlKat06zi7FXsjNE63Pkd62ppGTlD
         ctGVyW5dbStKiuDLo2PBvtlAmc3WVt1kOHQMnhfVHoIjfgCRDZQY/CUYWdRkVJsGrWHW
         naZ8EKiLY5634jbjp+6D2leVHnrgOwY89wQCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Yy4FkpQ4T+NaE4SfG1omiUE5+nqdQKGBttk9E2TkE8=;
        b=nsTSo/PGCjOh6pHmiIf7BprriNkzXCbmQ+ftcYNGiMP+PhL26dqurP465WFf83BWZ8
         jHJAhZmAOyXHol/zbSKsYnkH8f7EzPhswUWh4QD6CsG9D+QrlKJHD//VhBkA9Fx8T1L2
         shT4zs/RXRmYKNralTlTGD5lyIfpVe5OfBLioba706ctm129pV31mq/f6+j5bCyF2BvE
         E6F584r9bSuuKVg6eXAcJAqTDdFY/eDEVIHRe7wrnJCqvWG0VKbD1CrJuwY5/zARpMFl
         oEV5cBlpAFKMnYCWcjfA6IQaTHL9swz6MMLHcRoDpWss4KQMSZxuYUhHkVokNgT4xTak
         AljA==
X-Gm-Message-State: AOAM530FzH4Sbe7gLTzWaFDDF8ZWrx6RTxJsSXynYVE1jNgTXV/gDodw
        TwIuVn2w/6v5WMutG6Z4SoDuuw==
X-Google-Smtp-Source: ABdhPJz0avO7UqbhfmrE7qJFcQO+Av6dAdsZuhj2DGEWZ/b6aa9dlupXdgDvvUYIL02YmMNeApss0A==
X-Received: by 2002:a17:90b:1895:: with SMTP id mn21mr417378pjb.173.1598292898678;
        Mon, 24 Aug 2020 11:14:58 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q5sm5027811pfu.16.2020.08.24.11.14.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:14:57 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 4/6] RDMA/bnxt_re: Static NQ depth allocation
Date:   Mon, 24 Aug 2020 11:14:34 -0700
Message-Id: <1598292876-26529-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>

At first, driver allocates memory for NQ
based on qplib_ctx->cq_count and qplib_ctx->srqc_count.
Later when creating ring, it uses a static value of 128K -1.
Fixing this with a static value for now.

Fixes: b08fe048a69d ("RDMA/bnxt_re: Refactor net ring allocation function")
Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 17ac8b7..13bbeb4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1037,8 +1037,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		struct bnxt_qplib_nq *nq;
 
 		nq = &rdev->nq[i];
-		nq->hwq.max_elements = (qplib_ctx->cq_count +
-					qplib_ctx->srqc_count + 2);
+		nq->hwq.max_elements = BNXT_QPLIB_NQE_MAX_CNT;
 		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Alloc Failed NQ%d rc:%#x",
-- 
2.5.5

