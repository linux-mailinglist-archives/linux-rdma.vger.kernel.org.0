Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D02FAD65
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbhARWlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388988AbhARWlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66943C0617A0
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e15so8652147wme.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wNCEKXSovrgDcg/eymskQwC0/mm+MKrGvoBfPJUQt0=;
        b=P/cRXjIXkqCzwdQPKm+lw89m4nei/klZZcPENBNA6i+oROmqLZrEd49470LIOAu5wZ
         zGjIZiD2PnMlzePE+CgTKz4Ntlws8tuauVJNX6RUWRVBvC92gHuQty4Zpp6qixgCEm2f
         /8CBBU5izhqOnJ1Vt3Y2g6ltjpRQ2jrLAgaRQeZjb1oqkxMDlbtqYN0vgRdR5u7H9kKz
         98rrngFqUJdd5GwCVWDtbSlAmU3dPsmslI/rm9iynd7v7ZzKvWKh8dRSwE85LKw6azNx
         pshmvdTd/6zZVOlfHbt2o9rEfEAjRNkuymXBm+wk8mZY3St7PRKjiccjzfUAe2oJZyy2
         uMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wNCEKXSovrgDcg/eymskQwC0/mm+MKrGvoBfPJUQt0=;
        b=iL9vRahcsTH0awydY4lkdZCGlH6jQJ8Yr+Vclul3/smZp4r1d2z9QwBV5hB2I1s5rr
         gSHrxOTwqXCPRTsKvMzvP+OXCJP01BClISagtnBNs86D1iD3db5Z1cQ9bXYFRH3dcOV7
         TQalceYZJqVgnK3oIC7IuoBseB+pGl24eRbviftJl25VUqJIfcKdyRvKk6azvv/MYQ6m
         HFxNhTMSizRYz982jt+cUx6AuT5U+TPTYoq7ci8mrX6S9eEzbfBEZbjc0aKQ3+Q3jgNt
         1eKNFBz64SiZqoM1P/Czja6lHuYPU1Mteo62EOWDFv9MQIxgW797D6JLff0/bqxl5rCh
         x3yw==
X-Gm-Message-State: AOAM5319n4/jDQCyYmKYE1/AVLsOOe7Uerbb1mIMTw1vH/p02TZhxFqz
        GfmZYJ43oIiczJi1coVqgDzUfQ==
X-Google-Smtp-Source: ABdhPJzM1pEz5Fy5M6FAKs8Lx2eEYfMI1Dfk/J4XW9ajHHf4mJATxMpAzXP9cK2DtoskVJL4vaO7qQ==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr1286178wmb.45.1611009584143;
        Mon, 18 Jan 2021 14:39:44 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 10/20] RDMA/hw/i40iw/i40iw_puda: Fix some misspellings and provide missing descriptions
Date:   Mon, 18 Jan 2021 22:39:19 +0000
Message-Id: <20210118223929.512175-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_puda.c:517: warning: Function parameter or member 'dev' not described in 'i40iw_puda_qp_wqe'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:517: warning: Function parameter or member 'qp' not described in 'i40iw_puda_qp_wqe'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:517: warning: Excess function parameter 'rsrc' description in 'i40iw_puda_qp_wqe'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:629: warning: Function parameter or member 'dev' not described in 'i40iw_puda_cq_wqe'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:629: warning: Function parameter or member 'cq' not described in 'i40iw_puda_cq_wqe'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:629: warning: Excess function parameter 'rsrc' description in 'i40iw_puda_cq_wqe'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:792: warning: Function parameter or member 'vsi' not described in 'i40iw_puda_dele_resources'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:792: warning: Excess function parameter 'dev' description in 'i40iw_puda_dele_resources'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:884: warning: Function parameter or member 'vsi' not described in 'i40iw_puda_create_rsrc'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:884: warning: Excess function parameter 'dev' description in 'i40iw_puda_create_rsrc'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:1135: warning: Function parameter or member 'pfpdu' not described in 'i40iw_ieq_create_pbufl'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:1442: warning: Function parameter or member 'vsi' not described in 'i40iw_ieq_receive'
 drivers/infiniband/hw/i40iw/i40iw_puda.c:1442: warning: Excess function parameter 'dev' description in 'i40iw_ieq_receive'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_puda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.c b/drivers/infiniband/hw/i40iw/i40iw_puda.c
index 924be4b03c9a0..d1c8cc0a62365 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -511,7 +511,8 @@ static void i40iw_puda_qp_setctx(struct i40iw_puda_rsrc *rsrc)
 
 /**
  * i40iw_puda_qp_wqe - setup wqe for qp create
- * @rsrc: resource for qp
+ * @dev: iwarp device
+ * @qp: resource for qp
  */
 static enum i40iw_status_code i40iw_puda_qp_wqe(struct i40iw_sc_dev *dev, struct i40iw_sc_qp *qp)
 {
@@ -623,7 +624,8 @@ static enum i40iw_status_code i40iw_puda_qp_create(struct i40iw_puda_rsrc *rsrc)
 
 /**
  * i40iw_puda_cq_wqe - setup wqe for cq create
- * @rsrc: resource for cq
+ * @dev: iwarp device
+ * @cq: cq to setup
  */
 static enum i40iw_status_code i40iw_puda_cq_wqe(struct i40iw_sc_dev *dev, struct i40iw_sc_cq *cq)
 {
@@ -782,7 +784,7 @@ static void i40iw_puda_free_cq(struct i40iw_puda_rsrc *rsrc)
 
 /**
  * i40iw_puda_dele_resources - delete all resources during close
- * @dev: iwarp device
+ * @vsi: pointer to vsi structure
  * @type: type of resource to dele
  * @reset: true if reset chip
  */
@@ -876,7 +878,7 @@ static enum i40iw_status_code i40iw_puda_allocbufs(struct i40iw_puda_rsrc *rsrc,
 
 /**
  * i40iw_puda_create_rsrc - create resouce (ilq or ieq)
- * @dev: iwarp device
+ * @vsi: pointer to vsi structure
  * @info: resource information
  */
 enum i40iw_status_code i40iw_puda_create_rsrc(struct i40iw_sc_vsi *vsi,
@@ -1121,6 +1123,7 @@ static void  i40iw_ieq_compl_pfpdu(struct i40iw_puda_rsrc *ieq,
 
 /**
  * i40iw_ieq_create_pbufl - create buffer list for single fpdu
+ * @pfpdu: partial management per user qp
  * @rxlist: resource list for receive ieq buffes
  * @pbufl: temp. list for buffers for fpddu
  * @buf: first receive buffer
@@ -1434,7 +1437,7 @@ static void i40iw_ieq_handle_exception(struct i40iw_puda_rsrc *ieq,
 
 /**
  * i40iw_ieq_receive - received exception buffer
- * @dev: iwarp device
+ * @vsi: pointer to vsi structure
  * @buf: exception buffer received
  */
 static void i40iw_ieq_receive(struct i40iw_sc_vsi *vsi,
-- 
2.25.1

