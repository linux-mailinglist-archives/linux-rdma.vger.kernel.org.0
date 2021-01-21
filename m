Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305742FE6A9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbhAUJqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbhAUJqd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73ABC06179B
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e15so939539wme.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8pCMAUEP/8sjzyOaRZr85LSq4Lc0g21mTMMeuXpfhQ=;
        b=f5JSIX6TPhgmEnjLUD7rLdFt36UBUiJ8I1xpDjS6VfNIfRL/z/tIomK78Zkf0S/Vh3
         HWUDJ/VY5L+jNeu30E/26qXvpsMVKkeYQ/CZejfOcBqwR+33GCDh3pAHDdi5E561B3cG
         k6jUALYY+4X4q2L0X55kMcxoNoAOS33Ltp6KUB3e2wt/eHMV29tVXGdCpFPHJVQJm/lS
         QFmnDCjiJBjDzFb9Jf2ZgMfhjBtM9RAeNFztBe2+KkzUKBrAmAipqmIsQ6XoH8PNoqL8
         IQD3hjA+3bt6XTCXSS4hvHokhwndyqUvRa0c5cCK6oLI/bYXQTPPJmx39AQIeRThNv1o
         hfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8pCMAUEP/8sjzyOaRZr85LSq4Lc0g21mTMMeuXpfhQ=;
        b=ICEHP/VIMmVurykOmzei7xe2q8lDczSJ3oxeami3E3o5yqDek8FOPa46hWzXePiFTA
         6f/pPSfjLpTJoer4vGpBM31MXck1d1px7FeLyxanUtHFu3TQtfuzbYwjA9HW7GZtpiS5
         1+1I8zF8Q6m+l/wdLxqDjJm9mMNrrgik1D70drphHW2gnq5QwPBSV3K0t+bsgPfGqBZK
         I6XIeT6Rh+Ji9GWcaXyYLZxoHVkRkkh1T2G325ee3QMEOpdQe6GdOQOXrWwivm1Tgrm5
         R24nSVE+FzjVP1y5nzomlx5MQMc2Q6S59L568TK0hgKpUEHnQW6LEvf5Ff09VpV452ds
         ZHew==
X-Gm-Message-State: AOAM5301V8RseFCA+Aao+ZllYsO+Q8IbtmGeX2tU1CkarBpRG1cP832e
        vt76b6AiO6/gv6tuUe2wvOrjLg==
X-Google-Smtp-Source: ABdhPJzH6LLBqgEy08SoInzP9sd4tJ8ceZnoEnKBEuvsFHdCOcGw5Yex7rHPBdHgylszB+SlbJqxlQ==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr8189605wma.177.1611222330475;
        Thu, 21 Jan 2021 01:45:30 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 07/30] RDMA/sw/rdmavt/vt: Fix formatting issue and update description for 'context'
Date:   Thu, 21 Jan 2021 09:44:56 +0000
Message-Id: <20210121094519.2044049-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/vt.c:300: warning: Function parameter or member 'context' not described in 'rvt_dealloc_ucontext'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 49cec85a372a9..8fd0128a93360 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -294,7 +294,7 @@ static int rvt_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 
 /**
  * rvt_dealloc_ucontext - Free a user context
- * @context - Free this
+ * @context: Unused
  */
 static void rvt_dealloc_ucontext(struct ib_ucontext *context)
 {
-- 
2.25.1

