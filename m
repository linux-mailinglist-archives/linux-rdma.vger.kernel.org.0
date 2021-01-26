Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2844303DD6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403768AbhAZMzc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404083AbhAZMtd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC8FC0698C8
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:44 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so2336677wml.4
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFF2QQVIxFNp90Nwp9Ycl+uVfrjIiAZ/XTfl8r5ymZw=;
        b=NXFo+MjsuwTE93TK1DXo22fdhXCsOJIX5os6D2un8k+TfF0W44WoEx8MopsRfuCdFP
         pIn3+whREwoX42q32xde47Zzi8jcBHeSBj8KhF2hGXRuY5TEnqgNLP0pz2qmZx54wzbZ
         0jOPdZxcPF1X0mEDAY0EGa5YheyaWiwkhkftdIx2p2j49lsQFhd7j95rIxZ4XCYnzuZe
         7DRDSVMUa3Fvj1LwXMU1aIp04wUxnyoO2kKVMylJrKaa+ZhJM3tGMyXKRN0xlU/p88r2
         Go7KHM9PALmv9xdbU5dG1UiG9BTBIqz+vpu5ohnoNfBrFNOWNlEZzZ6S3RUdSgKQLe5j
         gx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFF2QQVIxFNp90Nwp9Ycl+uVfrjIiAZ/XTfl8r5ymZw=;
        b=Q5EcBOVLtJSNOJCdIOkd+YXrvYr1W0Yl8hBGkULVZpdYmXNcDhXV16VvN+cP0fUt9q
         d9u/ziBxtz27Zr5fl1U1ht3YjjzIe1D3LECaq69KaI0+k6GX6SUAzYjptellXUsh1Ko+
         hjuZX+ZzsLo0r8YShEHLTjS5u0TrlT+k3hdcM0JzA7RnT033PuLm6KbgTn1ZxxEKcSZh
         II6VJgxjoh35N8S6IAxwKW+5bhp4GET90a7OV2ewrL3Vuw6TEWo9VF8gZ8tPTavPV8oO
         ckexSchc3l+3L+BXXvAMO2BY1hM1X3uw4o9rDCt+QtE/rsnBV7MEwt84rfV87iv/milA
         0/uw==
X-Gm-Message-State: AOAM531pXIeQT+bWmKP7PBo5g4/nOLahFQmV4x9pYv52RublB09dNgrL
        fbp5Jv7K2Yh9PmeK/gW9ZZQmJA==
X-Google-Smtp-Source: ABdhPJxtqqXwmCwTwN6bwBokU5s+qmzfaQug5nE09DpjSUdLE2Dv+s4i9mbjVL986WtG7WXLmHmm4Q==
X-Received: by 2002:a1c:2c0b:: with SMTP id s11mr4371432wms.13.1611665263563;
        Tue, 26 Jan 2021 04:47:43 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 07/20] RDMA/sw/rdmavt/qp: Fix kernel-doc formatting problem
Date:   Tue, 26 Jan 2021 12:47:19 +0000
Message-Id: <20210126124732.3320971-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/qp.c:1929: warning: Function parameter or member 'post_parms' not described in 'rvt_qp_valid_operation'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 76d6bbfbec50c..9d13db68283c2 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1907,7 +1907,7 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 /**
  * rvt_qp_valid_operation - validate post send wr request
  * @qp: the qp
- * @post_parms_ the post send table for the driver
+ * @post_parms: the post send table for the driver
  * @wr: the work request
  *
  * The routine validates the operation based on the
-- 
2.25.1

