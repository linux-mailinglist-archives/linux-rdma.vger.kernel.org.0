Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA89B2FE794
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbhAUJrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbhAUJr3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC19AC061388
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j18so864336wmi.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJDsuEDRVCvcahYEPrkVEeJePqFypDnKwf1mJL7+9Q4=;
        b=k+KPDF1sMPR9MbWSWGLgTX1n2t/pUJJtovIraWlWFZqiHEZGXR6Obr9cr+SUOGFlwI
         yf1DHrs8J5H1y6UvVrIe2ld8T3+1hBE2m7/3pIdiO8x8WQlLwIbgLIunMiGMnaQc9OWU
         YRyMxwhMmMmsEBHuM3LFLtHRXxPkZXuLKz5vC+obZaLg3S0PEo52stMPYADifh3/jooR
         vC5IT8S4bSTTHyob8QosD7oHsNEwKFtSG/oCA8AgQPn5LWqXBOlbiw0r6D92gWOY9hXg
         ISJMK+8LWR4VBd/Pa/3Y/mOgtLnQp3JgsHCb/GNeud+3s7yVxYb8VFnlFfGFG/Fx4Uze
         W13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJDsuEDRVCvcahYEPrkVEeJePqFypDnKwf1mJL7+9Q4=;
        b=Y7xNDJwO10eaG+We4s/r5XQwTBvvtZ45Ce3gpMTfr23KMnXlgpLyCl/5+m4n7H7wUF
         Hj2gthA5Z5mT+t/fUw2RYlEtEwd0c4nnYt3e+zvXDa7fc2XadXV+bcf6lST8FQAlit1S
         p/y/p7BlziMFX7UyD4na/+w2NkPviOyVxg8nnde487UL8D+KesvibYPX6Rv143NBkbbg
         EXLg9hR+jVpc6iNCPTBpEEImk/ZXpLOb/jOWj71S2+kVn5LpK8pO7RxrnIYX6Fg9p0sN
         y/Drs+SyXfWoZuSmVJcyxkWHOQJe46yt/OlYdQZXqPbWK7iWQs3cbct3TNi0vHDBzgjs
         2dVg==
X-Gm-Message-State: AOAM532UwdwQY8dAp8fyZxEhmd0Pv5J9Y3cKeOlrSCc9jyDKlB98fTWf
        /vU1lQaRcy63IyXniWW8rbpjpQ==
X-Google-Smtp-Source: ABdhPJxs8JBbfjEoWD2z25WVRMknXxxD8R3+0bCNorKJSqYd63qAxbJP0AwnRloQ+9RveG8OpPFyxQ==
X-Received: by 2002:a1c:5686:: with SMTP id k128mr6996635wmb.189.1611222351717;
        Thu, 21 Jan 2021 01:45:51 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 23/30] RDMA/hw/hfi1/exp_rcv: Fix some kernel-doc formatting issues
Date:   Thu, 21 Jan 2021 09:45:12 +0000
Message-Id: <20210121094519.2044049-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/exp_rcv.c:56: warning: Function parameter or member 'set' not described in 'hfi1_exp_tid_set_init'
 drivers/infiniband/hw/hfi1/exp_rcv.c:66: warning: Function parameter or member 'rcd' not described in 'hfi1_exp_tid_group_init'
 drivers/infiniband/hw/hfi1/exp_rcv.c:77: warning: Function parameter or member 'rcd' not described in 'hfi1_alloc_ctxt_rcv_groups'
 drivers/infiniband/hw/hfi1/exp_rcv.c:114: warning: Function parameter or member 'rcd' not described in 'hfi1_free_ctxt_rcv_groups'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/exp_rcv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/exp_rcv.c b/drivers/infiniband/hw/hfi1/exp_rcv.c
index e9d5cc8b771a2..91f13140ddf21 100644
--- a/drivers/infiniband/hw/hfi1/exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/exp_rcv.c
@@ -50,7 +50,7 @@
 
 /**
  * exp_tid_group_init - initialize exp_tid_set
- * @set - the set
+ * @set: the set
  */
 static void hfi1_exp_tid_set_init(struct exp_tid_set *set)
 {
@@ -60,7 +60,7 @@ static void hfi1_exp_tid_set_init(struct exp_tid_set *set)
 
 /**
  * hfi1_exp_tid_group_init - initialize rcd expected receive
- * @rcd - the rcd
+ * @rcd: the rcd
  */
 void hfi1_exp_tid_group_init(struct hfi1_ctxtdata *rcd)
 {
@@ -71,7 +71,7 @@ void hfi1_exp_tid_group_init(struct hfi1_ctxtdata *rcd)
 
 /**
  * alloc_ctxt_rcv_groups - initialize expected receive groups
- * @rcd - the context to add the groupings to
+ * @rcd: the context to add the groupings to
  */
 int hfi1_alloc_ctxt_rcv_groups(struct hfi1_ctxtdata *rcd)
 {
@@ -101,7 +101,7 @@ int hfi1_alloc_ctxt_rcv_groups(struct hfi1_ctxtdata *rcd)
 
 /**
  * free_ctxt_rcv_groups - free  expected receive groups
- * @rcd - the context to free
+ * @rcd: the context to free
  *
  * The routine dismantles the expect receive linked
  * list and clears any tids associated with the receive
-- 
2.25.1

