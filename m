Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D92FF2D7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbhAUSHW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbhAUJrT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16238C061381
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v184so939866wma.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmIU7Hx0pkyEcx/3o0WhDyQYZMQPyc4u6z7mHc/BEGk=;
        b=W2U5NYMURcYEfi5ItscagZ3XbR3KUn3NejODcNDGd9GGFAGN4o0zTppEo4rhafYLWe
         SuwBlJ5zK6okyN6LB/V9uNfTiOab6kqx/F/L9QfeFs+eK6+vvGjf5Jda5pjGBNSK82sG
         zFQZ0E/w2S4Rlxrj5fv39FuyF73iO9TMOQinfRlNUWHvkQzwk8HKSYhbQ56OZh2Ogp4J
         86zRyke2tfC6+10MvbrkxzKE4GYQ+otnmNRHkK2GZmNG3BixJ/kO2Qi/s0Bhft+v8IDU
         Fpr73Od7A7Jme+kP+n7KyJR5FhMIRkaLPQpplv17ancvFLioyeASK8wc9JK2KJyozTbH
         eyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmIU7Hx0pkyEcx/3o0WhDyQYZMQPyc4u6z7mHc/BEGk=;
        b=COqtqo8uhy5P3Jx1Fsx+64pfpBP2D08fVpOr//axq5uOkFamIH3uS6V6AK8dTqkO1V
         TqsrIcRleT5UnVESlC0UlZVLcvkRHrE6CuGRrppdoeVQTOkZJ0Q/ARSGO+V+arxvNyaR
         StxSIFeClIxE6iPUI+mxlQ09SrbpNcRs/TQTe5/oH65CTy/XHmUEqT4zYHOANMJEuVTo
         EYVfj8sgLQ5ZHfKZ7HOl/qBV58+tau/5pIUDj9B77Uw5zEItaH/tena8leSLjrpaxJCn
         0dCQcePp41ptOeJD3+BifHsagFIEdcnvThQmR2yTWHcCc0Lb3Knsqa6doXguJpKAPym5
         qz0Q==
X-Gm-Message-State: AOAM532vcehgy9moRef0rYBoRy136VoPjtaICdxYFiwWm8V+gJhr23lD
        eb6Z0MnJL+r5KWeiLGA5i3QCtg==
X-Google-Smtp-Source: ABdhPJxz48wWMCXURTZGOMFkGBBixGQ0C0+9Ej4xgco1ek+rzYnYc+5272A+DPVgnMKnuIZf3tC7jw==
X-Received: by 2002:a05:600c:2249:: with SMTP id a9mr8318923wmm.169.1611222346891;
        Thu, 21 Jan 2021 01:45:46 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 19/30] RDMA/hw/qib/qib_ud: Provide description for 'qib_make_ud_req's 'flags' param
Date:   Thu, 21 Jan 2021 09:45:08 +0000
Message-Id: <20210121094519.2044049-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_ud.c:231: warning: Function parameter or member 'flags' not described in 'qib_make_ud_req'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_ud.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index 93ca21347959f..81eda94bd2799 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -222,6 +222,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 /**
  * qib_make_ud_req - construct a UD request packet
  * @qp: the QP
+ * @flags: flags to modify and pass back to caller
  *
  * Assumes the s_lock is held.
  *
-- 
2.25.1

