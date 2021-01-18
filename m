Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6A2FAD6B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbhARWlq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389409AbhARWln (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AD1C0617A3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y187so15071151wmd.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHiJhxMJMTlKf0rwnSY2fvsJQElsTJK9TpSX7iDgS9U=;
        b=c/wzvuGs7H2n2IY5w2J7DUpQ6H/5aj0IhNxht22Kh3XJC8ekmOjvgFNC9UH3S1cqPX
         kpA7gmlOrragpwi/LxDDh7L9I98as16dNbr3ZfA2TEEp76/rDn5RJKp+28mz1JypJ/KE
         uu7WBmoNGTSPta8rTtAyxml3RjhGp6LjHiiKv7jTB8jelN/v845/Qd+oalAl6PjiOqYB
         dVi2xU8NJFxAcLXd4UlxB1+LL21o2p9uAyVJraIM/VmAdrelF/1K2aDFE7puguv4v7jW
         waeoFb4BOBoafcnJhQgKR6PxIsHJbbKYU3qxrKJThGACD6WynCZHcsR9CUG3jz8B6BLB
         8Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHiJhxMJMTlKf0rwnSY2fvsJQElsTJK9TpSX7iDgS9U=;
        b=EyIHizfW6k0oMe72CpNrxqKq4DHnzDyXGItDAj/2oWPJLOdMpBpWRAALm0+Xuc4JB2
         cb2PwBi8R7My6XCNm2s2RBd7uE8UWoiOrDHjuP/RhO8fOksVpA08mCCJjGz3HMrGMZjl
         tpa+ST8Lm2+c03i6ff2oB9r8zXmAQeMsx4X3m3XLpG4bHGm5YKjqLxvg4udtJh/GgPEW
         FF64TQ2D4x5tClHvrL8BLIBW5Zz2VWew7JdjoUrcqjcehThK1oy9MbEUquB+Z8jan8kS
         PZMujKyQsNK7BLPLcdMgsJsZRYfoIKOaS3jwQ4T2OTew0sb8POn4tApSbkX42kNsWoBk
         4VHQ==
X-Gm-Message-State: AOAM530GPNHFG9ZNeWQUbrToimVzfUDOm69c5oscYp+DKXn+CGmkGplg
        doSi+kBe3wxg6hsopj9fyTWVXQ==
X-Google-Smtp-Source: ABdhPJzdlcg52fvz/z4ZD7lsZ+PnpThAHnHstBLslXgw7h+m2r6Bas2FH1QY72pFWP27L7ZRpVV8fQ==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr1361332wmk.14.1611009586380;
        Mon, 18 Jan 2021 14:39:46 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 12/20] RDMA/core/sa_query: Demote non-conformant kernel-doc header
Date:   Mon, 18 Jan 2021 22:39:21 +0000
Message-Id: <20210118223929.512175-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/sa_query.c:1449: warning: Function parameter or member 'client' not described in 'opa_pr_query_possible'
 drivers/infiniband/core/sa_query.c:1449: warning: Function parameter or member 'sa_dev' not described in 'opa_pr_query_possible'
 drivers/infiniband/core/sa_query.c:1449: warning: Function parameter or member 'device' not described in 'opa_pr_query_possible'
 drivers/infiniband/core/sa_query.c:1449: warning: Function parameter or member 'port_num' not described in 'opa_pr_query_possible'
 drivers/infiniband/core/sa_query.c:1449: warning: Function parameter or member 'rec' not described in 'opa_pr_query_possible'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/sa_query.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 89a831fa1885b..5bd047042e686 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1434,7 +1434,7 @@ enum opa_pr_supported {
 	PR_IB_SUPPORTED
 };
 
-/**
+/*
  * opa_pr_query_possible - Check if current PR query can be an OPA query.
  *
  * Retuns PR_NOT_SUPPORTED if a path record query is not
-- 
2.25.1

