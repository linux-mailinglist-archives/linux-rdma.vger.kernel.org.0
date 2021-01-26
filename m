Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD9303E12
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbhAZMzd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404081AbhAZMtd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC7C0698C7
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so16314248wry.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqnwtQpR7zRjxIxGO7OfabuwI6zTkwI4IUC4xHbde+s=;
        b=cvBHhXkuxzLiX4OWL+cfWzUSDdd4nPQDjG7e6O1QSdyaTPN7Yt35vJ9pbIvvuVUdfp
         KM5HmyTi7kZjfI9KbsyBD9kJY2TGHCPIQ9AuVvkCyGyPf5EF52V0RnWi2Akf0/3Z8yQi
         +/aw38tTxASeKdQcOyvftC9hve/tcgnAw6k0yAAIY1Mh3pjyMRIg+AwpM/jvl9Xc8Jao
         pDF2MkqQLJ517MBxidBsH+ri6DTNvZZfTLRJUzvoTJ1ovH/W0fTAef8t2SOW8Qs1O4Kp
         GAUVCTTAvY4jxK7gZUZb0PVaHjsapSFM68bSTZi6exaViaHjAgjkplPbjJaBnPphTewQ
         bXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqnwtQpR7zRjxIxGO7OfabuwI6zTkwI4IUC4xHbde+s=;
        b=MgfsV2tyY38q0On9GFEZLtQqVtkbr6fgq1ImticQMslJiB2ndA/g+l6DRmtraAZ2id
         cKrbFabUf30tzTSUSSgt2dGE+qVoiCjtVYG+q+AynQfMUvTHQdgpPnNh9LURXFUtZdEN
         HgMoYITGUAFCEyCYJwuFb0/829oEgvjIVR8Q6Ek7DdrynbiRYdjnMF/USucMMGXU+WGj
         XfCRugSqjsj+nsG126IIlWslIIvLFPrAmROqbUWdEtwD8DRkdFGDL4HmH+ygiGkRAfVX
         kCaa/RCyFAWHnF0IieSJ5KPFMt7L2fnH51qungRAu7WzlD9D8p/UPyKY0/jPZ5xHYP5J
         NZkw==
X-Gm-Message-State: AOAM532u8xywF3r+BDh3GyND+je9B6/Vs5/PxfLAxi4+OnJSBCWV8VKX
        nHuP9iBOeHNhsOjUoNgwBMiubw==
X-Google-Smtp-Source: ABdhPJypSWwMtVwU6H4CcatzRF+WbHG464YrhUgYvMZYokv2g6bW06791dituSqjsOiwOz40Kp6DMg==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr5944354wrw.216.1611665262428;
        Tue, 26 Jan 2021 04:47:42 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 06/20] RDMA/sw/rdmavt/mad: Fix misspelling of 'rvt_process_mad()'s 'in_mad_size' param
Date:   Tue, 26 Jan 2021 12:47:18 +0000
Message-Id: <20210126124732.3320971-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/mad.c:78: warning: Function parameter or member 'in_mad_size' not described in 'rvt_process_mad'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/mad.c b/drivers/infiniband/sw/rdmavt/mad.c
index 8cc4de9aa6644..fa5be13a43944 100644
--- a/drivers/infiniband/sw/rdmavt/mad.c
+++ b/drivers/infiniband/sw/rdmavt/mad.c
@@ -57,7 +57,7 @@
  * @in_wc: the work completion entry for this packet
  * @in_grh: the global route header for this packet
  * @in: the incoming MAD
- * @out_mad_size: size of the incoming MAD reply
+ * @in_mad_size: size of the incoming MAD reply
  * @out: any outgoing MAD reply
  * @out_mad_size: size of the outgoing MAD reply
  * @out_mad_pkey_index: unused
-- 
2.25.1

