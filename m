Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA112FEB73
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 14:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbhAUK24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 05:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbhAUJr3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733DC061382
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:49 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so1069042wry.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN+lfIF9Ruac5w+3RJGLplih0Ni1e9QoQ7rC6Jmgsbs=;
        b=hMoksjVQLU5nEHu9W9aY8QUD6u3DDph2ZjVE8VQjUyMtfH/lCdBJB2JYHH/OkZgvp+
         i2p2r37+btE9jabrt1F/n3hcnuTvJt2jCFNblRusd3sg7XhTiXEogYb0lkzT5bwv01d9
         c1A7EoWZPrOtIDi0v5sEJBzhLQOKBMOloWxu6rv6RH6WIfmtZqLzHHx3ekxt04EVYgZK
         CZO2/Gvm6TUPWjQKXuL5CgWVedFQqaai1awC7Y3JjqFf3kQyk34sUumbRzGRg0QdzemP
         cMFpCFdT6VM/QBcfzWciTxkGeitEqrqVxrI9vKK4LyN3aU4Ef7p2t+cx1wQ9OgP9mlDw
         ihMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN+lfIF9Ruac5w+3RJGLplih0Ni1e9QoQ7rC6Jmgsbs=;
        b=CCAylnaF5jNVm9Wq/PDWKnzO0uBh8K8eiDSqzmHq9Fe77t7mnTL9SnVfXmiHnYunew
         UrTOfd8IFpwfIPui/RzPaqslF3Ya67AUDXBnMt9Yn23bLAfwfk1oUHbNCWEhtGY8F7uT
         t98of/skgACihqxAug9rIyFDSK7rlCZDt+upec2xfjQiqArsG4xAvFTIfGofm12uT6Gj
         BftoyCyYxMi4oOSDG87Pwf4ZO+hkIIggh0bFvA8ypOtS3x1OJ1ouQI5H7uRq6zVAt0WF
         Dg1l57bUgucdEMlm62Wmz1aA6G0vR8UJQKdcj4NkqofeMlmf4VDPVpJmAQUr4Vt0072h
         i7Ng==
X-Gm-Message-State: AOAM5333N7Ed/+z+4RlnGkCO7uNVhb2vok9dIVA90sH2xFC+aO5GwtrS
        cCc0qVNO7wAhBnxcKYKECaChew==
X-Google-Smtp-Source: ABdhPJwBvadl37HLosjSDHe2pRSFbd8z9UuT5CPM5/vCOZPZTmF5U2ApYFZYsdLzgTJ1HHIMICFbhA==
X-Received: by 2002:adf:e705:: with SMTP id c5mr12995825wrm.303.1611222348084;
        Thu, 21 Jan 2021 01:45:48 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 20/30] RDMA/sw/rdmavt/mad: Fix 'rvt_process_mad()'s documentation header
Date:   Thu, 21 Jan 2021 09:45:09 +0000
Message-Id: <20210121094519.2044049-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/mad.c:75: warning: Function parameter or member 'in' not described in 'rvt_process_mad'
 drivers/infiniband/sw/rdmavt/mad.c:75: warning: Function parameter or member 'in_mad_size' not described in 'rvt_process_mad'
 drivers/infiniband/sw/rdmavt/mad.c:75: warning: Function parameter or member 'out' not described in 'rvt_process_mad'
 drivers/infiniband/sw/rdmavt/mad.c:75: warning: Function parameter or member 'out_mad_size' not described in 'rvt_process_mad'
 drivers/infiniband/sw/rdmavt/mad.c:75: warning: Function parameter or member 'out_mad_pkey_index' not described in 'rvt_process_mad'
 drivers/infiniband/sw/rdmavt/mad.c:75: warning: Excess function parameter 'in_mad' description in 'rvt_process_mad'
 drivers/infiniband/sw/rdmavt/mad.c:75: warning: Excess function parameter 'out_mad' description in 'rvt_process_mad'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/mad.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mad.c b/drivers/infiniband/sw/rdmavt/mad.c
index 108c71e3ac233..8cc4de9aa6644 100644
--- a/drivers/infiniband/sw/rdmavt/mad.c
+++ b/drivers/infiniband/sw/rdmavt/mad.c
@@ -56,8 +56,11 @@
  * @port_num: the port number this packet came in on, 1 based from ib core
  * @in_wc: the work completion entry for this packet
  * @in_grh: the global route header for this packet
- * @in_mad: the incoming MAD
- * @out_mad: any outgoing MAD reply
+ * @in: the incoming MAD
+ * @out_mad_size: size of the incoming MAD reply
+ * @out: any outgoing MAD reply
+ * @out_mad_size: size of the outgoing MAD reply
+ * @out_mad_pkey_index: unused
  *
  * Note that the verbs framework has already done the MAD sanity checks,
  * and hop count/pointer updating for IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE
-- 
2.25.1

