Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE55303DD1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392070AbhAZMzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404036AbhAZMta (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8DC061D7F
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m187so2346802wme.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwZHLBV2JS6GWXnvbYJdRkmpIgp0vHY6q4uz5g/IZE8=;
        b=xDf2jLJ9BS5w40h7X7toDBe6lSpyuD18tkLth0biAYEu/jMnh/IHrnN3YEosErZa4V
         Wb/jFaZ4CbEOlf9QH09uP95ZzExw5pmHPpZwC1QRM3YfgUgsaV4vgQeTzahUOMYud4WO
         6hKX6fT5m1+aGPpxFF/s/zY7526Hil5+/S9JdLJre83GlyoiXaB3YZ5o2XzlYC3kR/DF
         tI0Out45E9Xzb+ELsEAMjL2/NtsjkbPBfYbwkXMsy/qntjaXZ5foPisOuqeHby7P7B0e
         coqoc4Q7J4ShMxLzFux29+jMT/o/+yxtggLs/7TqkA6KYknxe2k8V4FxMdM1gSbE/6a2
         ePCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwZHLBV2JS6GWXnvbYJdRkmpIgp0vHY6q4uz5g/IZE8=;
        b=Dz6i9J2BURC6lQ+VzCXQMYBHtlhRx5mWh4E+kuG27YMYcEQcC+Q5nt0uNuQN9Ktzd3
         MOu+mXraz5tsI+Epd9aT7j/3mrTUOiTTWaIeOVypOkHOh4LV4c9z6OL5iUgx1zZiiBvt
         fB19tdfPcaflqWpym1LIeVorpOQJ9BK2GjQ0MNRNcNSshs3jzRdbRjd6atRPFVpk6PPR
         g4YJ/nv51i43kmnuH9KSF8HYnizDFCskTcQZHaiFQnGXvup4/oM+YDv1xSm2kmuh7AW8
         qKqLcrE/tU7KKokoEBni4VC7rqvImNQPbRS2cqaB5CbYWn88/7cIEa2trosDB85vY1/H
         Nw/g==
X-Gm-Message-State: AOAM533guimq5cHuv6auLBfmeJERHpJAkvfyknpjIg3mmP0tSoMHTLwG
        pHC5Wst305CibUUF2sBDg7aPm1BGlV1r2GLd
X-Google-Smtp-Source: ABdhPJxKL3WTgee+lBclj1oNmZ13v21vDISRjfCGYU7SJejUQaKhRSDQZQTya/sJpgPivEVDeh7SFQ==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr4561592wme.53.1611665257845;
        Tue, 26 Jan 2021 04:47:37 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 02/20] RDMA/sw/rdmavt/srq: Fix a couple of kernel-doc issues
Date:   Tue, 26 Jan 2021 12:47:14 +0000
Message-Id: <20210126124732.3320971-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/srq.c:78: warning: Function parameter or member 'ibsrq' not described in 'rvt_create_srq'
 drivers/infiniband/sw/rdmavt/srq.c:78: warning: Excess function parameter 'ibpd' description in 'rvt_create_srq'
 drivers/infiniband/sw/rdmavt/srq.c:336: warning: Function parameter or member 'udata' not described in 'rvt_destroy_srq'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/srq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index 64d98bf238ab0..2a7c2f12d372e 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -67,7 +67,7 @@ void rvt_driver_srq_init(struct rvt_dev_info *rdi)
 
 /**
  * rvt_create_srq - create a shared receive queue
- * @ibpd: the protection domain of the SRQ to create
+ * @ibsrq: the protection domain of the SRQ to create
  * @srq_init_attr: the attributes of the SRQ
  * @udata: data from libibverbs when creating a user SRQ
  *
@@ -311,7 +311,8 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	return ret;
 }
 
-/** rvt_query_srq - query srq data
+/**
+ * rvt_query_srq - query srq data
  * @ibsrq: srq to query
  * @attr: return info in attr
  *
@@ -330,7 +331,7 @@ int rvt_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 /**
  * rvt_destroy_srq - destory an srq
  * @ibsrq: srq object to destroy
- *
+ * @udata: user data for libibverbs.so
  */
 int rvt_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
-- 
2.25.1

